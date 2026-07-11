---
name: ldk-build-task
description: Use when implementing exactly one approved LDK task in guided/manual mode, for high-risk work, or when a checkpoint is requested. Requires approved discovery and a revision-aligned approved plan, accumulates evidence, and stops at proof-pending. Not for planning or final proof.
---

# ldk-build-task

LDK Version: 0.2.2
LDK Schema: 2

Use esta skill para implementar exatamente uma task aprovada.

## Gate

Leia discovery, project, ledger, roadmap, brief, plan, evidence/proof existentes e contracts disponiveis.

Pare se discovery nao estiver aprovado, roadmap/plan estiver stale ou com revision divergente, plan nao estiver
approved, version/schema divergir ou tabela de tasks nao usar exatamente:

```md
| ID | Descricao | AC | Arquivos esperados | Verificacao | State |
```

Toda task, inclusive trivial, precisa de registro minimo aprovado no plan: objetivo, AC, fora de escopo, risco,
proof, revision e uma linha de task.

## Regras

- Implemente somente a task indicada ou a proxima `ready`.
- Se o usuario pedir varias, execute uma e deixe as demais; para lote seguro use `ldk-build`.
- Nao aumente escopo, altere motor LDK nem escolha capacidade externa nao decidida.
- Confirme AC, arquivos esperados, verificacao e proof antes de editar.
- Marque `in-progress`, implemente, verifique e deixe `proof-pending`.
- Nao marque task/feature `done` e nao rode proof final.
- Todas as tasks sao essenciais, salvo `Optional tasks:`.
- Risco alto inclui acesso/autoridade, dado sensivel, transacao real, operacao irreversivel ou dependencia critica.
- Valide entrada/autoridade na camada correta; nunca exponha segredo/PII.
- Falha 2-3 vezes sem novo sinal: registre evidencia, bloqueie e pare.

## Evidencia

Acumule em `ldk/features/<feature>/evidence.md` ou proof draft:

- task e AC;
- acao/comando/fonte;
- resultado/observacao;
- exit code quando houver;
- output/artefato/referencia;
- limitacao.

Alegacao da IA sem observacao/fonte nao e evidencia.

## Ao terminar

1. liste arquivos;
2. atualize task para `proof-pending`;
3. mantenha feature `building` se houver essencial aberta;
4. use feature `proof-pending` se todas essenciais estiverem `proof-pending`/`done`;
5. registre audit log se `on`;
6. pare.

## Saida

```md
## LDK Build Task

Task:
Feature:
Discovery revision:
Autonomy: guided
O que mudou:
Arquivos alterados:
AC alvo:
Evidence reference:
Verificacao executada/pendente:
Task status: proof-pending | blocked
Feature status: building | proof-pending | blocked
Etapa concluida e aguardando proximo comando.
```
