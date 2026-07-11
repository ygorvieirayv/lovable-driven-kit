---
name: ldk-build
description: Use when executing one approved LDK feature after approved discovery and a revision-aligned plan. Runs safe planned tasks in sequence according to autonomy, accumulates observable evidence, proves the feature, and returns DONE/PARTIAL/BLOCKED. Not for discovery, planning, review, or release.
---

# ldk-build

LDK Version: 0.2.0
LDK Schema: 2

Sem prova, nao e done.

Discovery aprovado e obrigatorio antes de roadmap, plan e build.

## Objetivo

Executar uma feature aprovada ate onde for seguro:

1. validar gates e autonomia;
2. mostrar resumo curto do pre-flight;
3. executar tasks essenciais em sequencia;
4. acumular evidencia observavel durante a execucao;
5. atualizar plan/ledger;
6. consolidar proof;
7. decidir `DONE`, `PARTIAL` ou `BLOCKED` e parar.

Build e proof fazem parte desta skill. Nao puxe outra feature.

## Gate antes de editar

Leia discovery, project, ledger, roadmap, brief, plan, proof/evidence existentes e arquivos citados no plano.

Pare antes de editar se:

- discovery nao estiver `approved`;
- roadmap estiver `stale` ou revision divergir;
- plan nao estiver `approved` ou usar outra discovery revision;
- tabela nao tiver headers exatos;
- houver `[VERIFY]` que muda escopo, acesso, dado, dependencia, provedor, risco ou prova;
- version/schema estiver misturado;
- task exigir arquivo fora do escopo;
- houver drift que contradiga task encerrada.

Nao dependa de contracts como bundled files. Se disponiveis, use; senao siga Workspace Knowledge e esta skill.

## Pre-flight visivel e curto

Nao exponha raciocinio extenso. Mostre:

- entendimento da feature;
- otimista: por que e executavel;
- pessimista: principal forma de falso `DONE`, dano ou pausa;
- decisao: `proceed`, `pause` ou `blocked`.

Ajuste pequeno dentro do escopo entra na execucao. Decisao aberta, escopo novo, risco alto nao planejado,
credencial, dado sensivel, operacao irreversivel ou prova impossivel para antes de editar.

## Autonomia

Leia `Autonomy mode`:

- `guided`: execute uma task por vez e pare quando o usuario escolheu checkpoints manuais.
- `balanced`: execute todas as tasks seguras da feature aprovada e consolide proof.
- `autopilot`: execute a feature aprovada ate status final, mas nunca atravesse para outra feature.

Risco alto sempre reduz para execucao guiada. Nenhum modo autoriza novo escopo ou decisao externa.

## Loop de execucao

Todas as tasks sao essenciais, salvo IDs em `Optional tasks:`.

Para cada task essencial em `ready`/`in-progress`:

1. confirme AC, arquivos e verificacao;
2. marque `in-progress`;
3. edite somente o escopo aprovado;
4. execute/observe a verificacao prevista;
5. registre evidencia com fonte, resultado, output/referencia, exit code quando houver, AC e limitacao;
6. marque `proof-pending` somente apos implementacao observada;
7. continue conforme autonomia e seguranca.

Antes de cada efeito externo ou irreversivel em fluxo concorrente/assincrono, revalide ownership e estado atuais.
Cota/contador compartilhado exige reserva atomica antes do efeito e compensacao segura quando ele falhar; nao use
check-then-act separado. Entrada privilegiada nao pode confiar em chave publica/publicavel como autenticacao.

Use `ldk/features/<feature>/evidence.md` por `templates/evidence-log.md` para varias tasks ou P3/P4. Em entrega curta
P1/P2, pode acumular diretamente num proof draft. Nunca invente preview, teste, console, diff, CI ou verificacao.

Se a mesma falha ocorrer 2-3 vezes sem novo sinal:

- pare;
- registre tentativas/evidencia;
- marque task/feature `blocked` quando aplicavel;
- nao repita no escuro;
- peca decisao ou contexto.

## Proof dentro do build

Depois das tasks essenciais:

- P1: observacao visual real;
- P2: fluxo manual com passos/resultado;
- P3: teste/script reproduzivel com resultado pass;
- P4: CI pass, diff e checklist de seguranca/release.

Consolide `proof.md` com pre-flight, discovery revision, evidence log/inline, arquivos, AC, verificacoes, comandos e
exit codes disponiveis, referencias, limitacoes, self-check e veredito.

`DONE` exige:

- tasks essenciais `proof-pending`/`done`;
- AC essenciais cobertos por evidencia atual e observavel;
- prova atingida >= exigida;
- nenhum erro critico ou drift;
- limitacoes sem bloquear o objetivo.

Sync, aplicacao e publicacao sao estados distintos. Quando ferramenta externa sincronizar ou regenerar arquivos,
inspecione o diff, repita checks proporcionais e prove o ambiente/URL realmente entregue antes de `DONE`.

Use `PARTIAL` se implementou mas falta AC/prova. Use `BLOCKED` se falta decisao, acesso, correcao ou verificacao
essencial.

Atualize ledger/plan:

- `done` + proof quando DONE; tasks cobertas -> `done`;
- `partial` + proof quando PARTIAL; tasks sem prova -> `proof-pending`/`blocked`;
- `blocked` + proof quando BLOCKED; task afetada -> `blocked`;
- Last evidence sempre aponta para proof em estado final.

## Audit log opcional

Se `Audit log: on`, registre version/schema, revision, autonomy, pre-flight, tasks, arquivos, referencias de evidencia,
decisao, limitacoes e next. Se `off`/ausente, nao crie log.

## Saida

```md
## LDK Build

Feature:
Discovery revision:
Autonomy/mode:
Risk:
Proof required:

### Resumo do pre-flight
- Entendimento:
- Otimista:
- Pessimista:
- Decisao: proceed | pause | blocked

### Execucao
- Tasks executadas:
- Arquivos alterados:
- Disjuntor acionado: yes/no

### Prova
- Evidence log/inline:
- Proof level achieved:
- Preview/testes/diff/CI:
- Limitacoes:

Status: DONE | PARTIAL | BLOCKED
Etapa concluida e aguardando proximo comando.
```

Se pre-flight decidir pause/blocked, nao edite o app.
