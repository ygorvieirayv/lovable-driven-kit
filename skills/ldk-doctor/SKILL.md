---
name: ldk-doctor
description: 'Use when LDK project state may have drifted: ledger, proof, app code, GitHub diff, or LDK engine files disagree. Starts read-only and reconciles only with explicit approval.'
---

# ldk-doctor

LDK Version: 0.2.0
LDK Schema: 2

Use esta skill para diagnosticar drift entre Knowledge, arquivos `ldk/`, app e GitHub.

## Objetivo

Encontrar inconsistencias e propor recuperacao segura.

Esta skill comeca read-only. Nao corrija nada sem aprovacao explicita, um item por vez.

## Camadas

### T0 - Check deterministico

Se existir `scripts/ldk-check.*`, rode o script.

Se nao existir, valide manualmente:

- `ldk/ledger.md` existe;
- `ldk/discovery.md` existe e usa status/revision validos;
- `ldk/project.md`, discovery, roadmap e plans usam version/schema/revision coerentes;
- `ldk/roadmap.md` existe quando o projeto tem varias features;
- `ldk/ledger.md` usa headers exatos `ID | Feature | Risk | State | Proof required | Last evidence`;
- estados validos;
- `done` tem proof;
- proof `DONE` tem prova suficiente.

Compare a versao desta skill com Workspace Knowledge, Project Knowledge e `ldk/project.md`. Se houver acesso ao
repo oficial, consulte `VERSION` sem alterar nada e informe update disponivel; nao atualize automaticamente.

### T1 - Ledger x arquivos

Procure:

- ledger diz `done`, mas proof ausente;
- proof diz `DONE`, mas `Proof level achieved` e insuficiente;
- feature com plan/brief mas sem ledger;
- roadmap `current` com discovery revision diferente;
- plan aprovado com discovery revision diferente;
- discovery alterado sem roadmap `stale`;
- arquivos LDK com version/schema misturados;
- ledger aponta evidence quebrada;
- ledger com headers traduzidos ou colunas fora do contrato;
- ledger com ID misturado ao nome da feature;
- ledger com prova em intervalo como `P1/P2`;
- ledger com `Last evidence` apontando para `plan.md` ou `brief.md`;
- ledger com `Last evidence` preenchido em estado `idea`, `planned`, `approved`, `building` ou `proof-pending`;
- plan.md sem tabela de tasks machine-readable;
- plan.md com header de tasks diferente de `ID | Descricao | AC | Arquivos esperados | Verificacao | State`;
- task em bullet sem `State` persistido;
- roadmap aponta proxima feature ja concluida ou bloqueada;
- roadmap e ledger discordam sobre estado/ordem;
- `[VERIFY]` critico aberto em feature `done`;
- task em `done` sem proof correspondente.

### T2 - Proof x realidade

Procure:

- proof diz preview aberto, mas nao ha URL/observacao;
- proof diz teste passou, mas nao ha output;
- proof diz GitHub diff disponivel, mas nao ha link ou commit;
- AC marcado `covered` sem evidencia.
- evidence/proof sem fonte, output/referencia atual ou comando/exit code quando aplicavel;

### T3 - Diff x fronteira

Procure:

- alteracao em skills, Knowledge, templates, scripts ou workflows LDK durante feature do app;
- arquivos fora do escopo planejado;
- mudancas grandes demais para uma task.

### T4 - Mudancas externas x plano ativo

Rollback, sync, outra skill ou prompt direto podem mudar o app sem registrar uma etapa LDK. Diagnostique com
cautela:

- nao trate codigo preexistente de projeto ja iniciado como drift se estiver fora da feature/task LDK ativa;
- se a mudanca externa esta dentro da task ativa, registre/normalize o plano ou task state;
- se amplia escopo, direcao visual ou decisao da task ativa, proponha atualizar o plano antes de proof;
- se cria nova feature, proponha registrar no ledger/roadmap;
- se remove ou contradiz task `proof-pending`/`done`, proponha reabrir a task ou ajustar o ledger;
- se toca motor do LDK, trate como drift critico.
- depois de sync/import/export, procure arquivo regenerado, formatacao alterada, artefato duplicado e evidencia que
  ainda descreve o estado anterior;
- nao trate `sincronizado`, `aplicado` e `publicado` como equivalentes; compare tambem o ambiente/URL entregue quando
  o status depender de publicacao.

## Saida do diagnostico

```md
## LDK Doctor

Verdict: healthy | drift-found | serious-drift

Installed version/schema:
Latest version checked: yes/no/not available
Discovery status/revision:

Critical:
- arquivo:linha - problema - regra violada

High:
- ...

Medium:
- ...

Low:
- ...

Nothing changed yet.
```

## Reconciliacao

Para cada achado, ofereca:

- A) Corrigir o artefato/codigo de baixo para obedecer a fonte de verdade.
- B) Mudar conscientemente a fonte de verdade.
- C) Registrar como debito e seguir.

Para drift de motor LDK, recomende restaurar a partir do repo oficial:

```txt
https://github.com/ygorvieirayv/lovable-driven-kit
```

Regras:

- Uma correcao por vez.
- Mostrar diff.
- Reexecutar check relevante.
- Sem aprovacao explicita, nao alterar nada.
- Reconciliacao estrutural que muda discovery incrementa revision, volta para `awaiting-approval` e marca roadmap
  `stale`.
- Nao reverta nem sobrescreva mudanca externa do usuario sem aprovacao explicita.
- Se o Project Knowledge tiver `Audit log: on` e uma correcao for aplicada, adicione uma entrada compacta em
  `ldk/audit/log.md`. Se o arquivo nao existir, crie com titulo e nota curta de que o log comeca na ativacao.
  Nao faca backfill automatico; se o usuario pedir backfill, marque como `BACKFILL reconstruido`. Se estiver
  `off` ou ausente, nao crie log.
