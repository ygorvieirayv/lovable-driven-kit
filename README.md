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

## Como instalar no Lovable

O Lovable importa **uma skill por vez**. Nao use a URL do repo inteiro para instalar o LDK completo. Repo
inteiro serve quando existe uma unica skill com `SKILL.md` na raiz. Como o LDK tem varias skills, importe os
subdiretorios abaixo um por um.

### 1. Abrir a tela de Skills

Na tela inicial do Lovable:

1. Clique em **Settings** ou **Configuracao**.
2. Abra **Skills**.
3. Clique em **Add**.
4. Escolha **Import from GitHub**.

### 2. Importar as skills uma por uma

Copie um link, cole no campo **Repository URL**, clique em **Import from GitHub** e repita para o proximo.

1. `ldk-intake`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-intake
```

2. `ldk-next`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-next
```

3. `ldk-plan`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-plan
```

4. `ldk-build-task`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-build-task
```

5. `ldk-proof`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-proof
```

6. `ldk-review`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-review
```

7. `ldk-doctor`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-doctor
```

8. `ldk-release`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-release
```

### 3. Configurar Knowledge

No Lovable:

1. Va em **Settings** ou **Configuracao**.
2. Abra **Knowledge**.
3. Em **Workspace Knowledge**, cole o conteudo de `workspace-knowledge.md`.
4. No projeto da loja, abra **Project settings -> Knowledge**.
5. Cole o conteudo de `project-knowledge-template.md` e preencha o que souber.

### 4. Usar no projeto

No projeto conectado ao GitHub, mantenha os artefatos do app em `ldk/`:

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

Comece com:

```txt
/ldk-intake Quero criar uma mini loja moderna, bonita e responsiva.
```

Depois disso, quando nao souber o proximo passo, use:

```txt
/ldk-next
```

## Fluxo

```txt
ideia vaga
  -> /ldk-intake
  -> /ldk-next
  -> /ldk-plan
  -> /ldk-build-task
  -> /ldk-proof
  -> /ldk-review
  -> /ldk-next
```

Apoio:

- `/ldk-doctor`: diagnostica drift entre Knowledge, `ldk/`, app e GitHub.
- `/ldk-release`: checklist antes de publicar.

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
