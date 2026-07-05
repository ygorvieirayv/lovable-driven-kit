---
name: ldk-build-task
description: Use when implementing exactly one approved task from an LDK feature plan in Build mode, keeping scope small and leaving the result proof-pending. Not for planning or final proof.
---

# ldk-build-task

Use esta skill em Build mode para implementar exatamente uma task aprovada.

## Objetivo

Implementar uma task do plano e deixar a entrega pronta para prova.

## Regras

- Use Build mode apenas depois de existir plano aprovado.
- Implemente uma task por vez.
- Nao aumente escopo sem aprovar novo plano.
- Nao edite motor do LDK.
- Nao marque task ou feature como `done` diretamente.
- Ao terminar a implementacao, deixe estado como `proof-pending` e rode `ldk-proof`.

## Antes de construir

Leia:

- `ldk/project.md`
- `ldk/ledger.md`
- `ldk/features/<feature>/brief.md`
- `ldk/features/<feature>/plan.md`
- `contracts/engine-boundary.md`, se disponivel

Confirme:

- task ativa;
- AC coberto;
- arquivos esperados;
- verificacao esperada;
- prova minima.

## Durante a implementacao

- Mantenha mudancas cirurgicas.
- Preserve padroes do app.
- Para auth, pagamento, PII, Supabase rules, delecao ou migracao, trate como alto risco.
- Valide input no servidor quando houver backend.
- Nao coloque segredos no codigo, bundle ou logs.
- Se falhar 2-3 vezes no mesmo ponto, pare e marque `BLOCKED` ou peca input.

## Ao terminar

1. Liste arquivos alterados.
2. Atualize a task para `proof-pending` se o plano mantiver task states.
3. Atualize o ledger para `proof-pending`.
4. Execute `ldk-proof`.

## Saida

```md
## LDK Build Task

Task:
Feature:
O que mudou:
Arquivos alterados:
AC alvo:
Verificacao ainda pendente:
Status: proof-pending
Proximo passo seguro: ldk-proof
```

Se algo impedir a conclusao, nao force. Use `BLOCKED` no proof.
