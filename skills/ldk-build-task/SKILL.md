---
name: ldk-build-task
description: Use when implementing exactly one approved LDK task in manual/granular mode, or when high-risk/checkpointed work should not use feature autopilot. Keeps scope small and leaves the task proof-pending. Not for planning or final proof.
---

# ldk-build-task

Use esta skill em Build mode para implementar exatamente uma task aprovada. Para feature aprovada e segura, prefira
`ldk-build`.

## Objetivo

Implementar uma task do plano e deixar a entrega pronta para prova.

## Regras

- Use Build mode depois de existir plano aprovado.
- Excecao: para tarefa `trivial` claramente definida, pode construir sem plano formal longo se houver registro minimo
  com AC explicito, prova P1 e linha no ledger.
- Implemente uma task por vez.
- A task deve existir na tabela de tasks do `plan.md`. Se o plano tiver apenas bullets, pare e rode `ldk-doctor` ou
  `ldk-plan` para normalizar o plano antes de construir.
- Se o usuario pedir duas ou mais tasks aprovadas no mesmo comando, escolha a proxima task `ready` e explique que
  as demais ficam para os proximos comandos. Para fundir tasks, revise o plano antes.
- Nao aumente escopo sem aprovar novo plano.
- Nao edite motor do LDK.
- Aplique `contracts/always-rules.md`, se disponivel.
- Nao marque task ou feature como `done` diretamente.
- Ao terminar a implementacao, deixe a task executada como `proof-pending` e pare. Nao rode `ldk-proof` nesta skill.

## Antes de construir

Leia:

- `ldk/project.md`
- `ldk/ledger.md`
- `ldk/roadmap.md`, se existir
- `ldk/features/<feature>/brief.md`
- `ldk/features/<feature>/plan.md`
- `contracts/engine-boundary.md`, se disponivel
- `contracts/always-rules.md`, se disponivel

Para tarefa trivial sem plano formal longo, leia `ldk/project.md`, `ldk/ledger.md` e confirme que existe registro
minimo antes de construir:

- feature/task;
- AC de uma linha;
- fora de escopo;
- risco `trivial`;
- prova minima `P1`.

Confirme:

- task ativa;
- estado da task (`ready` ou `in-progress`);
- AC coberto;
- arquivos esperados;
- verificacao esperada;
- prova minima.

## Durante a implementacao

- Mantenha mudancas cirurgicas.
- Preserve padroes do app.
- Para trivial/baixo, nao transforme a task em refatoracao ou mudanca de produto maior.
- Para auth, pagamento, PII, Supabase rules, delecao ou migracao, trate como alto risco.
- Valide input no servidor quando houver backend.
- Nao coloque segredos no codigo, bundle ou logs.
- Nao registre PII desnecessaria em logs, console, analytics ou mensagens de erro.
- Se falhar 2-3 vezes no mesmo ponto, registre o bloqueio, pare e peca input. Nao force build nem rode proof.

## Ao terminar

1. Liste arquivos alterados.
2. Atualize a task executada no `plan.md` para `proof-pending`.
3. Se ainda houver tasks `ready`, `in-progress` ou `backlog`, mantenha o ledger da feature como `building`.
4. Se todas as tasks essenciais estiverem `proof-pending` ou `done`, atualize o ledger da feature para `proof-pending`.
5. Pare e aguarde o proximo comando.

## Saida

```md
## LDK Build Task

Task:
Feature:
O que mudou:
Arquivos alterados:
AC alvo:
Verificacao ainda pendente:
Task status: proof-pending
Feature status: building | proof-pending
Etapa concluida: build-task pronta e aguardando proximo comando
```

Se algo impedir a conclusao, nao force. Registre o bloqueio e aguarde o proximo comando.
