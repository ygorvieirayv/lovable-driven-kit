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
- qual risco e prova se aplicam;
- qual comando/skill rodar agora;
- se ha drift que exige `ldk-doctor`.

Esta skill e read-only. Nao altere arquivos.

## O que ler

Leia somente o necessario:

1. `ldk/project.md`
2. `ldk/ledger.md`
3. feature ativa em `ldk/features/<feature>/`
4. proof da feature, se existir
5. GitHub diff ou lista de arquivos alterados, se disponivel

Se houver diff em arquivos de motor LDK, leia `contracts/engine-boundary.md` e recomende `ldk-doctor`.

## Como decidir

Escolha sempre o caminho mais leve que ainda preserve a regra "sem prova, nao e done".

Regua de cerimonia:

- trivial: ajuste pequeno e reversivel; pode ir direto para `ldk-build-task` com AC de uma linha e proof P1.
- baixo: plano curto com objetivo, AC, fora de escopo e prova P1/P2.
- medio: plano normal com tasks pequenas e proof P2/P3.
- alto: plano explicito, risco claro, proof forte P4 e revisao antes de release.

| Situacao | Proximo passo |
|---|---|
| Nao existe `ldk/project.md` ou `ldk/ledger.md` | `ldk-intake` |
| Feature em `idea` trivial e bem definida | `ldk-build-task` com AC curto e proof P1 |
| Feature em `idea` baixo/medio/alto ou vaga | `ldk-plan` |
| Feature em `planned` | pedir aprovacao do plano ou continuar `ldk-plan` |
| Feature em `approved` | `ldk-build-task` |
| Feature em `building` | continuar `ldk-build-task` |
| Feature em `proof-pending` | `ldk-proof` |
| Feature em `partial` ou `blocked` | tratar limitacao ou `ldk-doctor` |
| Feature em `done` | `ldk-review` ou proxima feature |
| Ledger/proof/app divergentes | `ldk-doctor` |

## Saida

Use formato curto:

```md
## LDK Next

Onde estamos:
Risco:
Prova minima:
Proximo passo:
Por que:
Alternativa consciente:
```

Termine perguntando se o usuario quer seguir com o passo recomendado. Nao execute automaticamente.
