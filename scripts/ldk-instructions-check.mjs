#!/usr/bin/env node

import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(scriptDir, '..');
const manifestPath = path.join(root, 'contracts', 'instruction-rules.json');
const errors = [];
const warnings = [];

function rel(file) {
  return path.relative(root, file).replaceAll('\\', '/');
}

function read(relativePath) {
  const absolute = path.join(root, relativePath);
  if (!fs.existsSync(absolute)) {
    errors.push(`missing ${relativePath}`);
    return '';
  }
  return fs.readFileSync(absolute, 'utf8');
}

function error(message) {
  errors.push(message);
}

function warn(message) {
  warnings.push(message);
}

function normalizeRuntimeText(value) {
  return value
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase();
}

function escapeRegex(value) {
  return value.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

if (!fs.existsSync(manifestPath)) {
  console.error('ERROR missing contracts/instruction-rules.json');
  process.exit(1);
}

let manifest;
try {
  manifest = JSON.parse(fs.readFileSync(manifestPath, 'utf8'));
} catch (cause) {
  console.error(`ERROR invalid contracts/instruction-rules.json: ${cause.message}`);
  process.exit(1);
}

const version = read('VERSION').trim();
const schemaText = read('SCHEMA_VERSION').trim();
const schema = Number(schemaText);

if (!/^\d+\.\d+\.\d+$/.test(version)) {
  error(`VERSION '${version}' is not semver`);
}
if (!Number.isInteger(schema) || schema < 1) {
  error(`SCHEMA_VERSION '${schemaText}' must be a positive integer`);
}
if (manifest.version !== version) {
  error(`instruction manifest version '${manifest.version}' differs from VERSION '${version}'`);
}
if (manifest.schema !== schema) {
  error(`instruction manifest schema '${manifest.schema}' differs from SCHEMA_VERSION '${schema}'`);
}

const allManifestFiles = new Set([
  ...(manifest.knowledgeFiles ?? []),
  ...(manifest.skillFiles ?? []),
  ...(manifest.versionedFiles ?? []),
  ...(manifest.runtimeFilesForGenericity ?? []),
  ...((manifest.requiredRules ?? []).flatMap((rule) => rule.files ?? [])),
]);

for (const file of allManifestFiles) {
  read(file);
}

for (const file of manifest.versionedFiles ?? []) {
  const text = read(file);
  if (!text.includes(`LDK Version: ${version}`)) {
    error(`${file}: missing 'LDK Version: ${version}'`);
  }
  if (!text.includes(`LDK Schema: ${schema}`)) {
    error(`${file}: missing 'LDK Schema: ${schema}'`);
  }
}

for (const file of manifest.knowledgeFiles ?? []) {
  const text = read(file);
  if (text.length > 10_000) {
    error(`${file}: ${text.length} characters exceeds Lovable Knowledge limit of 10000`);
  }
}

for (const file of manifest.skillFiles ?? []) {
  const text = read(file);
  if (text.length > 100_000) {
    error(`${file}: ${text.length} characters exceeds Lovable skill limit of 100000`);
  }
  const frontmatter = text.match(/^---\s*\n([\s\S]*?)\n---/);
  if (!frontmatter) {
    error(`${file}: missing YAML frontmatter`);
    continue;
  }
  if (!/^description:\s*['"]?Use when\b/m.test(frontmatter[1])) {
    error(`${file}: description must start with 'Use when'`);
  }
  const nameMatch = frontmatter[1].match(/^name:\s*([^\s]+)\s*$/m);
  const expectedName = path.basename(path.dirname(file));
  if (!nameMatch || nameMatch[1] !== expectedName) {
    error(`${file}: skill name must match folder '${expectedName}'`);
  }
}

for (const rule of manifest.requiredRules ?? []) {
  if (!rule.id || !rule.text || !Array.isArray(rule.files) || rule.files.length === 0) {
    error('instruction manifest has malformed requiredRules entry');
    continue;
  }
  for (const file of rule.files) {
    if (!read(file).includes(rule.text)) {
      error(`${file}: missing required rule ${rule.id}: '${rule.text}'`);
    }
  }
}

for (const file of manifest.runtimeFilesForGenericity ?? []) {
  const text = normalizeRuntimeText(read(file));
  for (const term of manifest.forbiddenRuntimeTerms ?? []) {
    const normalizedTerm = normalizeRuntimeText(String(term));
    const termPattern = new RegExp(`(^|[^a-z0-9])${escapeRegex(normalizedTerm)}($|[^a-z0-9])`);
    if (termPattern.test(text)) {
      error(`${file}: runtime-specific example/provider '${term}' must move to docs or evaluation`);
    }
  }
}

const referenceFiles = new Set([
  ...(manifest.knowledgeFiles ?? []),
  ...(manifest.skillFiles ?? []),
  ...(manifest.runtimeFilesForGenericity ?? []),
]);
for (const file of referenceFiles) {
  const text = read(file);
  for (const match of text.matchAll(/`((?:contracts|templates)\/[^`\s]+)`/g)) {
    const reference = match[1];
    if (reference.includes('*') || reference.endsWith('/')) continue;
    if (!fs.existsSync(path.join(root, reference))) {
      error(`${file}: references missing local file '${reference}'`);
    }
  }
}

const changelog = read('CHANGELOG.md');
if (!new RegExp(`^## \\[${version.replaceAll('.', '\\.')}\\]`, 'm').test(changelog)) {
  error(`CHANGELOG.md has no section for VERSION ${version}`);
}

const powershellCheck = read('scripts/ldk-check.ps1');
if (!powershellCheck.includes(`$expectedVersion = "${version}"`)) {
  error('scripts/ldk-check.ps1 expectedVersion differs from VERSION');
}
if (!powershellCheck.includes(`$expectedSchema = "${schema}"`)) {
  error('scripts/ldk-check.ps1 expectedSchema differs from SCHEMA_VERSION');
}

const bashCheck = read('scripts/ldk-check.sh');
if (!bashCheck.includes(`EXPECTED_VERSION="${version}"`)) {
  error('scripts/ldk-check.sh EXPECTED_VERSION differs from VERSION');
}
if (!bashCheck.includes(`EXPECTED_SCHEMA="${schema}"`)) {
  error('scripts/ldk-check.sh EXPECTED_SCHEMA differs from SCHEMA_VERSION');
}

const trackedFiles = fs
  .readdirSync(path.join(root, 'skills'), { withFileTypes: true })
  .filter((entry) => entry.isDirectory())
  .map((entry) => `skills/${entry.name}/SKILL.md`)
  .sort();
const declaredSkills = [...(manifest.skillFiles ?? [])].sort();
if (JSON.stringify(trackedFiles) !== JSON.stringify(declaredSkills)) {
  error('instruction manifest skillFiles does not match skills/*/SKILL.md');
}

for (const message of warnings) {
  console.log(`WARN  ${message}`);
}
for (const message of errors) {
  console.log(`ERROR ${message}`);
}
console.log('----------------------------------------');
console.log(`ldk-instructions-check: ${errors.length} error(s), ${warnings.length} warning(s).`);

process.exit(errors.length > 0 ? 1 : 0);
