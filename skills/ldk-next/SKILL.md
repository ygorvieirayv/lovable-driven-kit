---
name: ldk-next
description: Use when resuming a Lovable Driven Kit project and deciding the next safe step from the saved ldk/ state. This skill is read-only and should not implement changes.
---

# ldk-next

Use esta skill para retomar um projeto LDK e recomendar o proximo passo seguro.

## Objetivo

Ler o estado gravado em `ldk/` e responder:

- onde estamos;
- qual feature/task esta ativa;
- se o roadmap esta presente e coerente;
- qual risco e prova se aplicam;
- qual comando/skill rodar agora;
- se ha drift que exige `ldk-doctor`.

Esta skill e read-only. Nao altere arquivos.

## O que ler

Leia somente o necessario:

1. `ldk/project.md`
2. `ldk/ledger.md`
3. `ldk/roadmap.md`, se existir
4. feature ativa em `ldk/features/<feature>/`
5. proof da feature, se existir
6. GitHub diff ou lista de arquivos alterados, se disponivel

Se houver diff em arquivos de motor LDK, leia `contracts/engine-boundary.md` e recomende `ldk-doctor`.

## Como decidir

Escolha sempre o caminho mais leve que ainda preserve a regra "sem prova, nao e done".

Rollback, sync, outra skill ou prompt direto podem alterar o app sem aparecer como etapa LDK. Em projeto ja
iniciado, seja cauteloso: nao trate codigo preexistente ou arquivos fora da feature/task ativa como drift.
Compare somente os arquivos/AC esperados da feature ativa. Se uma task `proof-pending` ou `done` parece ter sido
removida ou contradita pelo codigo atual, chame isso de possivel drift externo e recomende `ldk-doctor`.

Prefira `ldk-build` para feature aprovada e segura. Ele pode executar as tasks planejadas em sequencia e provar a
feature. Use `ldk-build-task` apenas para task especifica, checkpoint manual, risco alto ou quando o usuario pedir
granularidade.

Regua de cerimonia:

- trivial: ajuste pequeno e reversivel; use `ldk-build` leve com AC de uma linha e proof P1.
- baixo: plano curto com objetivo, AC, fora de escopo e prova P1/P2; depois use `ldk-build`.
- medio: plano normal com tasks pequenas e proof P2/P3; use `ldk-build` se nao houver decisao aberta critica.
- alto: plano explicito, risco claro, proof forte P4 e revisao antes de release.

Se ja houver feature ativa em `approved`, `building` ou `proof-pending`, resolva essa feature antes de puxar
uma nova do roadmap.

Enquanto houver task essencial `ready`, `backlog` ou `in-progress`, nao recomende `ldk-proof` como proximo passo
nem como alternativa consciente. O proximo passo deve ser `ldk-build` para continuar a feature, `ldk-build-task`
se o usuario quiser granularidade, ou `ldk-doctor` se o plano/estado estiver incoerente. `ldk-proof` so entra
isoladamente depois que todas as tasks essenciais estiverem `proof-pending` ou `done`.

| Situacao | Proximo passo |
|---|---|
| Nao existe `ldk/project.md` ou `ldk/ledger.md` | `ldk-intake` |
| Ledger/proof/app divergentes | `ldk-doctor` |
| Task `proof-pending`/`done` contradita pelo codigo atual | `ldk-doctor` |
| Feature em `proof-pending` | `ldk-proof` |
| Feature `approved`/`building` com risco trivial/baixo | `ldk-build` |
| Feature `approved`/`building` com risco medio sem bloqueio critico | `ldk-build` |
| Feature `approved`/`building` com risco alto ou decisao critica aberta | `ldk-build-task` ou resolver bloqueio |
| Feature em `building` com todas as tasks `proof-pending` | `ldk-build` para finalizar prova, ou `ldk-proof` se o usuario pedir proof isolado |
| Feature em `planned` | pedir aprovacao do plano ou continuar `ldk-plan` |
| Projeto tem varias features e nao existe `ldk/roadmap.md` | `ldk-roadmap` |
| Roadmap ausente, desatualizado ou divergente do ledger | `ldk-roadmap` |
| Roadmap indica feature `blocked` como proxima | resolver bloqueio ou `ldk-roadmap` |
| Roadmap indica feature `ready` | `ldk-plan` da feature indicada |
| Feature em `idea` trivial e bem definida | `ldk-build` com AC curto e proof P1 |
| Feature em `idea` baixo/medio/alto ou vaga | `ldk-plan` |
| Feature em `partial` ou `blocked` | tratar limitacao ou `ldk-doctor` |
| Feature em `done` | `ldk-review` ou proxima feature |

## Saida

Use formato curto:

```md
## LDK Next

Onde estamos:
Risco:
Prova minima:
Roadmap:
Proximo passo:
Por que:
Alternativa consciente:
```

Termine perguntando se o usuario quer seguir com o passo recomendado. Nao execute automaticamente. Se recomendar
`ldk-build`, deixe claro que ele pode concluir a feature aprovada e trazer proof no mesmo comando.
