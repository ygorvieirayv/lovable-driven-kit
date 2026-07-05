---
name: ldk
description: 'Use when working with the Lovable Driven Kit lifecycle in a Lovable app: intake, next step, planning, building one task, proof of done, review, doctor, or release. Routes subcommands like "intake", "next", "plan", "build-task", "proof", "review", "doctor", and "release".'
---

# ldk

This is the all-in-one Lovable Driven Kit skill.

Use it as:

```txt
/ldk intake <project idea>
/ldk next
/ldk plan <feature>
/ldk build-task <task>
/ldk proof <task or feature>
/ldk review <feature>
/ldk doctor
/ldk release
```

If the user invokes `/ldk` without a subcommand, run the `next` flow.

Core rule:

> No proof, no done.

## Always-on LDK Rules

- Use Plan mode before relevant product changes.
- Implement one task at a time.
- Every task needs acceptance criteria and a proof level.
- Never claim a verification happened unless it actually happened.
- If preview was not opened, say `Preview opened: no`.
- If tests were not run, say `Automated test result: not run`.
- If logs or console are unavailable, say `Console/log errors checked: not available`.
- Use `DONE` only when the required proof level was achieved.
- Otherwise use `PARTIAL` or `BLOCKED`.
- Product tasks must not edit the LDK engine: Knowledge, skills, templates, contracts, scripts, or workflow templates.

## LDK State

The app should keep state in:

```txt
ldk/
  project.md
  ledger.md
  decisions/
  features/
    <feature>/
      brief.md
      plan.md
      proof.md
  issues/
  releases/
```

Ledger states:

```txt
idea
planned
approved
building
proof-pending
done
partial
blocked
reopened
```

Risk values:

```txt
trivial
baixo
medio
alto
```

Proof levels:

```txt
P1 visual
P2 manual flow
P3 automated test
P4 CI/release
```

## Router

Choose the flow from the first word after `/ldk`.

| User intent | Flow |
|---|---|
| `intake`, start project, organize idea | Intake |
| `next`, continue, where are we | Next |
| `plan`, scope, feature plan | Plan |
| `build`, `build-task`, implement | Build Task |
| `proof`, done, verify, evidence | Proof |
| `review`, audit, inspect | Review |
| `doctor`, drift, inconsistent | Doctor |
| `release`, publish, launch | Release |
| unclear | Next |

## Intake

Use when starting a project or when no `ldk/project.md` exists.

1. Ask for the product, audience, goal, and MVP.
2. Identify risk: PII, payments, auth/admin, integrations, Supabase/RLS, deletion/migration.
3. Mark unknowns with `[VERIFY]`.
4. Create or update:
   - `ldk/project.md`
   - `ldk/ledger.md`
   - `ldk/decisions/`
   - `ldk/features/`
   - `ldk/issues/`
   - `ldk/releases/`
5. Do not implement app code.

Final output:

```md
## LDK Intake

Product:
MVP:
Risks:
Files changed:
Open [VERIFY]:
Next safe step:
```

## Next

Use when resuming work. This is read-only.

Read:

- `ldk/project.md`
- `ldk/ledger.md`
- active feature files
- proof files, if relevant
- changed files or GitHub diff, if available

Recommend exactly one next step:

| Situation | Next step |
|---|---|
| no LDK state | `/ldk intake` |
| feature `idea` | `/ldk plan` |
| feature `planned` | approve plan or continue `/ldk plan` |
| feature `approved` | `/ldk build-task` |
| feature `building` | continue `/ldk build-task` |
| feature `proof-pending` | `/ldk proof` |
| feature `partial` or `blocked` | resolve blocker or `/ldk doctor` |
| feature `done` | `/ldk review` or next feature |
| contradictory state | `/ldk doctor` |

Output:

```md
## LDK Next

Where we are:
Risk:
Proof required:
Next step:
Why:
Alternative:
```

Do not execute the next step unless the user asks.

## Plan

Use in Plan mode before building a feature.

1. Read `ldk/project.md` and `ldk/ledger.md`.
2. Define feature slug.
3. Write scope and out of scope.
4. Write acceptance criteria as binary, observable ACs.
5. Classify risk:
   - trivial: copy, color, padding.
   - baixo: simple section/component.
   - medio: CRUD, forms, filters, dashboard, admin.
   - alto: auth, permission, PII, payment, Supabase RLS, deletion, migration.
6. Set proof required:
   - trivial -> P1
   - baixo -> P1/P2
   - medio -> P2/P3
   - alto -> P4
7. Break into small tasks.
8. Create or update:
   - `ldk/features/<feature>/brief.md`
   - `ldk/features/<feature>/plan.md`
   - `ldk/ledger.md`
9. Set ledger to `planned`; after user approval, set `approved`.
10. Do not implement app code.

Output:

```md
## LDK Plan

Feature:
Risk:
Proof required:
Acceptance criteria:
Tasks:
Files changed:
Ledger state:
Next safe step:
```

## Build Task

Use in Build mode after an approved plan exists.

1. Read the feature brief and plan.
2. Pick exactly one approved task.
3. Confirm AC, expected files, and verification.
4. Implement only that task.
5. Do not edit LDK engine files.
6. Update the task/ledger to `proof-pending`.
7. Run `/ldk proof`.

Output:

```md
## LDK Build Task

Task:
Feature:
What changed:
Files changed:
Target AC:
Verification pending:
Status: proof-pending
Next safe step: /ldk proof
```

Do not mark `DONE` in this flow.

## Proof

Use after a task is implemented.

Read:

- ledger;
- brief;
- plan;
- changed files or GitHub diff;
- preview/log/test/CI evidence that is actually available.

Rules:

- `DONE` requires all essential ACs covered and proof achieved >= proof required.
- `PARTIAL` means useful work exists but evidence or criteria are incomplete.
- `BLOCKED` means conclusion needs external access, decision, credential, or prior fix.

Write:

- `ldk/features/<feature>/proof.md`
- update `ldk/ledger.md` to `done`, `partial`, or `blocked`
- set `Last evidence` to the proof path

Proof format:

```md
## Proof of Done

Task:
Feature:
Status: DONE | PARTIAL | BLOCKED
Risk: trivial | baixo | medio | alto
Proof level required: P1 | P2 | P3 | P4
Proof level achieved: P1 | P2 | P3 | P4 | none

### Changed files
- ...

### Acceptance criteria
- AC1: covered | not covered | not applicable

### Verification performed
- Preview opened: yes/no
- Main user flow tested: yes/no
- Responsive/mobile checked: yes/no
- Console/log errors checked: yes/no/not available
- GitHub diff available: yes/no
- Automated test available: yes/no
- Automated test result: pass/fail/not run/not available
- CI result: pass/fail/not run/not available

### Evidence
- Preview URL:
- Screenshot or visual observation:
- Manual steps:
- Test output:
- Commit/diff:

### Known limitations
- ...

### Next safe step
- ...
```

## Review

Use after proof to inspect quality and risk. Do not silently fix.

Check:

- ACs in plan vs proof evidence.
- Proof honesty.
- Required proof level.
- Files changed vs planned scope.
- LDK engine drift.
- Auth, permission, PII, payments, Supabase rules, deletion/migration.
- Test coverage where P3/P4 is required.

Severity:

- Critical: security, data loss, PII/secret exposure, false proof, app task changed LDK engine.
- High: essential AC missing, required test missing, relevant plan deviation.
- Medium: weak coverage, limitation undocumented.
- Low: style or optional cleanup.

Output:

```md
## LDK Review

Verdict: approved | approved-with-reservations | blocked

Critical:
High:
Medium:
Low:

AC -> evidence:
Next safe step:
```

## Doctor

Use when state may have drifted. Start read-only.

Look for:

- ledger says `done`, but proof is missing;
- proof says `DONE`, but proof level is insufficient;
- proof claims preview/test/diff without evidence;
- feature files exist but no ledger row;
- ledger evidence path is broken;
- app task changed LDK engine files;
- `[VERIFY]` remains in a done feature.

Output:

```md
## LDK Doctor

Verdict: healthy | drift-found | serious-drift

Critical:
High:
Medium:
Low:

Nothing changed yet.
```

If the user wants reconciliation, offer:

- A) Fix lower-level artifact/code to obey source of truth.
- B) Change source of truth consciously.
- C) Register debt and continue.

Apply one correction at a time, only with explicit approval.

## Release

Use before publishing or handoff.

Check:

- all release features have proof;
- no critical/high open issues;
- preview checked;
- mobile checked;
- main flow tested;
- console/logs checked or marked unavailable;
- build/test/CI green or marked unavailable;
- env vars checked;
- auth/admin checked if applicable;
- data/payment/Supabase risks checked if applicable.

Write:

- `ldk/releases/<yyyy-mm-dd>.md`

Output:

```md
## LDK Release

Status: GO | NO-GO
Scope:
Evidence:
Blockers:
Known limitations:
Next safe step:
```

Use `NO-GO` if any critical risk lacks proof.
