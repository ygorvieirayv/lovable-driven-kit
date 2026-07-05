# Lovable Driven Kit (LDK)

Um kit de entrega comprovada para construir apps no Lovable com plano, tasks e prova real.

Repo oficial: https://github.com/ygorvieirayv/lovable-driven-kit

Regra central:

> Sem prova, nao e done.

O LDK nasce do que funcionou no `spec-driven-kit`, mas com formato nativo para Lovable:
Workspace Knowledge, Project Knowledge, Skills, Plan mode, Build mode, Preview e GitHub.

## O que vem neste repo

```txt
lovable-driven-kit/
  README.md
  workspace-knowledge.md
  project-knowledge-template.md
  contracts/
    state-markers.md
    engine-boundary.md
  skills/
    ldk-intake/SKILL.md
    ldk-next/SKILL.md
    ldk-plan/SKILL.md
    ldk-build-task/SKILL.md
    ldk-proof/SKILL.md
    ldk-review/SKILL.md
    ldk-doctor/SKILL.md
    ldk-release/SKILL.md
  templates/
    project.md
    task-ledger.md
    feature-brief.md
    feature-plan.md
    proof-report.md
    decision-record.md
    issue-report.md
    release-report.md
  scripts/
    ldk-check.ps1
    ldk-check.sh
  github/
    workflows/proof.yml
    playwright-smoke.spec.ts
  tests/
    fixtures/valid/
    fixtures/broken/
```

## Como usar no Lovable

### Instalacao recomendada

1. Copie `workspace-knowledge.md` para o Workspace Knowledge do Lovable.
2. Copie `project-knowledge-template.md` para o Project Knowledge e preencha o que souber.
3. Importe a skill unica:

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk
```

Depois chame:

```txt
/ldk intake <ideia>
/ldk next
/ldk plan <feature>
/ldk build-task <task>
/ldk proof
/ldk review
/ldk doctor
/ldk release
```

### Instalacao avancada

Se quiser comandos separados no slash menu, importe as skills individuais em `skills/ldk-*`.

4. No projeto conectado ao GitHub, mantenha os artefatos do app em `ldk/`:

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

5. Comece com `ldk-intake` ou, se ja existir estado em `ldk/`, rode `ldk-next`.

## Fluxo

```txt
ideia vaga
  -> ldk-intake
  -> ldk-next
  -> ldk-plan
  -> ldk-build-task
  -> ldk-proof
  -> ldk-review
  -> ldk-next
```

Apoio:

- `ldk-doctor`: diagnostica drift entre Knowledge, `ldk/`, app e GitHub.
- `ldk-release`: checklist antes de publicar.

## Estados

O ledger usa estes estados:

```txt
idea -> planned -> approved -> building -> proof-pending -> done
                                         -> partial
                                         -> blocked
                                         -> reopened
```

`done` so e permitido quando a prova minima foi atingida.

## Risco e prova

| Risco | Exemplos | Fluxo minimo |
|---|---|---|
| trivial | copy, cor, padding | Build + P1 |
| baixo | secao simples, card estatico | Plan curto + Build + P1/P2 |
| medio | CRUD, filtros, formulario, admin simples | Plan + tasks + proof + GitHub diff |
| alto | auth, permissao, PII, pagamento, Supabase rules, delecao/migracao | Plan detalhado + proof forte + review externa |

| Prova | Nome | Evidencia minima |
|---|---|---|
| P1 | Visual | screenshot ou observacao precisa do preview |
| P2 | Fluxo manual | passos executados + resultado observado |
| P3 | Teste automatizado | teste/script reproduzivel com resultado pass |
| P4 | CI/release | CI verde + diff GitHub + checklist de seguranca |

Na duvida, suba o risco e a prova.

## Proof of Done

Toda task termina com um relatorio em `ldk/features/<feature>/proof.md`.

Status possiveis:

- `DONE`: criterios essenciais cobertos, prova minima atingida, sem erro critico conhecido.
- `PARTIAL`: parte funcionou, mas falta evidencia ou criterio.
- `BLOCKED`: nao da para concluir sem input externo, acesso, credencial ou correcao previa.

O Lovable nunca deve afirmar que abriu preview, checou console, rodou teste ou viu diff se isso nao aconteceu.

## Validacao local

PowerShell:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts\ldk-check.ps1 -Root tests\fixtures\valid
```

Bash:

```bash
bash scripts/ldk-check.sh tests/fixtures/valid
```

Fixture quebrado deve falhar:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts\ldk-check.ps1 -Root tests\fixtures\broken
```

## GitHub

`github/workflows/proof.yml` e um workflow opcional para copiar para `.github/workflows/proof.yml` no app
Lovable conectado ao GitHub. Ele roda `ldk-check` e, quando existir `package.json`, tenta rodar install,
test e build.

## Fronteira do kit

Arquivos do processo LDK nao sao codigo do app. Durante uma task do produto, o Lovable nao deve alterar:

- Workspace Knowledge e Project Knowledge do LDK;
- skills `ldk-*`;
- templates do kit;
- scripts `ldk-check.*`;
- workflows/templates do kit.

Se uma task de app alterar o motor do LDK, isso e drift critico: rode `ldk-doctor` e nao marque `DONE`.
