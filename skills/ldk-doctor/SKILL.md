---
name: ldk-doctor
description: 'Use when LDK project state may have drifted: ledger, proof, app code, GitHub diff, or LDK engine files disagree. Starts read-only and reconciles only with explicit approval.'
---

# ldk-doctor

LDK Version: 0.2.2
LDK Schema: 2

Use esta skill para diagnosticar drift entre Knowledge, arquivos `ldk/`, app e GitHub.

## Objetivo

Encontrar inconsistencias e propor recuperacao segura.

Esta skill comeca read-only. Nao corrija nada sem aprovacao explicita, um item por vez.

Diagnostico nao e autorizacao para inferir regra nova. Diferencie violacao confirmada, evidencia historica e
hipotese `[VERIFY]`. Achado confirmado cita arquivo/linha, regra e fato observavel.

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

Compare a versao desta skill com Workspace Knowledge, Project Knowledge e `ldk/project.md`. Workspace, Project
Knowledge e skills instaladas devem usar a mesma versao. Artefatos duraveis `ldk/` da patch anterior podem permanecer
na versao em que foram criados quando schema e major/minor forem iguais; reporte `compatible patch history`, nao
drift nem migracao automatica. Schema ou major/minor divergente exige migracao consciente do conjunto.

Se houver acesso ao repo oficial, consulte `VERSION` sem alterar nada e informe update disponivel; nao atualize
automaticamente.

Antes da leitura semantica, registre quando disponivel:

- branch e HEAD atuais;
- worktree limpo/sujo;
- ultimo CI do mesmo HEAD, com status, URL e horario;
- diff desde a ultima evidencia citada.

Evidencia de CI so vale para o commit e branch que ela verificou. Green antigo e historico, nao prova o HEAD atual.
Se nao houver acesso ao GitHub, escreva `current CI: not available`; nao substitua por alegacao antiga.

O check deterministico tem precedencia para regras que ele cobre. Se passou, nao invente violacao oposta sem nova
evidencia objetiva e regra citada; mantenha a hipotese em `[VERIFY]`.

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

Regras de interpretacao obrigatorias:

- Existir `evidence.md` nao autoriza preencher `Last evidence` em estado nao final.
- `Last evidence` fica vazio em `idea`, `planned`, `approved`, `building` e `proof-pending`, mesmo com evidencia
  intermediaria. `done` exige referencia; `partial`/`blocked` podem registrar report/evidence da limitacao.
- `State` do ledger e `Readiness` do roadmap sao dimensoes independentes. `planned + blocked`, `partial + verify` e
  `partial + blocked` podem ser coerentes quando dependencias/decisoes justificam a readiness.
- So reporte discordancia quando texto, dependencia, proximo passo ou readiness contradizer fato atual; nao exija
  igualdade entre State e Readiness.
- `Next recommended feature` e uma prioridade singular, nao lista exaustiva de toda readiness `ready`/`verify`.
  Varias features podem estar `verify`; so ha contradicao se a escolhida estiver inelegivel, violar dependencia ou
  tiver justificativa falsa/obsoleta.
- `brief.md` congela escopo, risco e AC aprovados; ledger e plan registram o ciclo atual. `Status: planned` no brief
  nao precisa acompanhar `building`, `partial`, `blocked` ou `done`, salvo contrato explicito diferente no projeto.
- `evidence.md` e opcional e criado quando existe evidencia para registrar; nunca crie arquivo vazio preventivo.
  Ausencia antes/durante planejamento nao e finding. Durante build, cobre apenas se o plano/proof exigir log separado
  e evidencia observada estiver sendo perdida.
- Antes de alegar arquivo ativo duplicado ou mistura com historico, procure os paths exatos. Conteudo somente sob
  `ldk/history/` e congelado e nao compete com o estado ativo.

### T2 - Proof x realidade

Procure:

- proof diz preview aberto, mas nao ha URL/observacao;
- proof diz teste passou, mas nao ha output;
- proof diz GitHub diff disponivel, mas nao ha link ou commit;
- AC marcado `covered` sem evidencia.
- evidence/proof sem fonte, output/referencia atual ou comando/exit code quando aplicavel;

Para toda evidencia temporal, confira commit/HEAD, branch, ambiente, URL, run, horario e se houve mudanca depois.
Classifique como `current`, `historical` ou `not available`. Nao diga que CI/test runner/fixture nao existe sem
procurar workflow, scripts, package scripts e arquivos atuais. Diferencie `inexistente`, `nao executado`, `falhou`
e `existe mas esta incompleto`.

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

Capture HEAD/worktree novamente ao final da fase read-only. Se HEAD mudar durante o diagnostico, reinicie a leitura no novo estado.
Se arquivos mudarem sem acao desta skill, reporte `external mutation observed`; `Nothing changed by
this skill` nao significa que a plataforma permaneceu imutavel.

## Severidade e incerteza

- Finding descreve violacao atual confirmada, nao problema futuro hipotetico.
- Se o texto diz `aceitavel`, `esperado`, `baixo impacto atual` ou `so vira problema depois`, nao classifique como
  Critical/High/Medium; remova de findings ou registre em Info/Expected.
- Critical/High exigem violacao confirmada e impacto correspondente, nunca apenas inferencia sem fonte.
- Regra machine-readable rejeitada pelo checker pode ser High/Critical conforme impacto.
- Roadmap semanticamente antigo costuma ser Medium, salvo quando autoriza agora uma acao perigosa ou bloqueada.
- Hipotese sem acesso/evidencia suficiente recebe `[VERIFY]` e nao autoriza diff corretivo.
- Nome diferente sem ambiguidade e historico congelado normalmente sao Low/info.

## Saida do diagnostico

```md
## LDK Doctor

Verdict: healthy | drift-found | serious-drift

Installed version/schema:
Latest version checked: yes/no/not available
Discovery status/revision:
Repository snapshot: branch / HEAD / worktree
Current CI: current | historical | failed | not available
External mutation observed: yes/no/not available

Critical:
- arquivo:linha - problema - regra violada

High:
- ...

Medium:
- ...

Low:
- ...

Info/Expected:
- condicao valida que ajuda a interpretar o estado, sem pedir correcao

Nothing changed by this skill.
Repository unchanged during diagnosis: yes | no (external mutation) | not available
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
- Antes de propor diff, releia os arquivos afetados, HEAD e CI; se mudaram, reinicie o diagnostico.
- Corrija primeiro drift de codigo/CI que invalida as premissas; depois reconcilie roadmap/proof dependente.
- Diga explicitamente quais fontes foram preservadas sem alteracao.
- Nao proponha sincronizar brief com ledger/plan nem criar evidence vazio sem contrato explicito.
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
