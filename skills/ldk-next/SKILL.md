---
name: ldk-next
description: Use when the user says continuar, prossiga, proximo, retomar, onde paramos, or asks what to do now in an LDK project. Reads saved state and recommends one safe next command. Read-only; not for implementation.
---

# ldk-next

LDK Version: 0.2.2
LDK Schema: 2

Use esta skill para retomar um projeto e recomendar um proximo passo seguro. Esta skill e read-only.

## O que ler

Leia somente o necessario:

1. `ldk/discovery.md`, se existir: status/revision;
2. `ldk/project.md`: version/schema, autonomy mode e contexto;
3. `ldk/ledger.md`;
4. `ldk/roadmap.md`, se existir: status/revision;
5. feature ativa: markers do brief/plan/evidence/proof;
6. diff/lista de arquivos alterados, se disponivel.

Nao crie audit log nesta skill. Se o motor LDK aparecer no diff, recomende `ldk-doctor`.

## Gate de discovery

- Sem `ldk/discovery.md`: recomende `ldk-intake`.
- Discovery diferente de `approved`: recomende continuar `ldk-intake`.
- Discovery aprovado sem project/ledger: recomende `ldk-doctor` ou concluir `ldk-intake`.
- Roadmap `stale` ou com revision diferente: recomende `ldk-roadmap`.
- Plan com revision diferente do discovery: recomende `ldk-doctor`/`ldk-plan`, nunca build.

## Autonomia

Leia `Autonomy mode`:

- `guided`: prefira `ldk-build-task` quando o usuario quer checkpoint por task.
- `balanced`: prefira `ldk-build` para feature aprovada e segura.
- `autopilot`: `ldk-build` pode concluir a feature aprovada; nunca puxa outra feature.

Risco alto, decisao critica, `[VERIFY]` bloqueante, credencial, operacao irreversivel, drift ou prova impossivel
sempre exigem granularidade/decisao, independentemente do modo.

## Como decidir

Escolha o caminho mais leve que preserve discovery, plano, escopo e prova.

- Codigo preexistente fora da feature ativa nao e drift.
- Mudanca externa dentro da task pode ser registrada; mudanca que altera escopo exige reconciliacao.
- Resolva feature ativa antes de puxar outra.
- Todas as tasks sao essenciais, salvo `Optional tasks:` explicito.
- Enquanto task essencial estiver `backlog`, `ready` ou `in-progress`, nao recomende proof final.
- Feature em `idea`, inclusive trivial, passa por `ldk-plan`; o plano pode ser minimo, mas precisa ser aprovado.

| Situacao | Proximo passo |
|---|---|
| Discovery ausente/incompleto | `ldk-intake` |
| Discovery mudou ou aguarda confirmacao | `ldk-intake` |
| Estado/version/schema divergente | `ldk-doctor` |
| Roadmap ausente quando ha dependencias | `ldk-roadmap` |
| Roadmap stale/revision divergente | `ldk-roadmap` |
| Feature `idea` | `ldk-plan` proporcional ao risco |
| Feature `planned` | concluir/aprovar `ldk-plan` |
| Feature `approved`/`building`, segura | `ldk-build` conforme autonomia |
| Feature de alto risco ou checkpoint manual | `ldk-build-task` |
| Tasks essenciais ainda abertas | `ldk-build` ou `ldk-build-task` |
| Todas essenciais `proof-pending`/`done` | `ldk-build` para consolidar ou `ldk-proof` isolado |
| Feature `proof-pending` | `ldk-proof` |
| Feature `partial`/`blocked` | tratar limitacao ou `ldk-doctor` |
| Feature `done` | `ldk-review` ou `ldk-roadmap` |

## Saida

```md
## LDK Next

Onde estamos:
Discovery/revision:
Autonomia:
Risco e prova:
Roadmap:
Proximo passo:
Comando pronto:
Por que:
Alternativa consciente:
```

Recomende um comando e pare. Nao execute automaticamente. Se o usuario responder apenas "continuar", esta skill
pode ser selecionada novamente para reler o estado e recomendar a etapa atual.
