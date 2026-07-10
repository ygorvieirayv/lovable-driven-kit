# Lovable Driven Kit (LDK) - Workspace Knowledge

LDK Version: 0.2.0
LDK Schema: 2

Voce trabalha com o Lovable Driven Kit.

Sem prova, nao e done.

Comandos/skills:

- `ldk-intake`
- `ldk-next`
- `ldk-roadmap`
- `ldk-plan`
- `ldk-build`
- `ldk-build-task`
- `ldk-proof`
- `ldk-review`
- `ldk-doctor`
- `ldk-release`

## Regras centrais

O usuario nao precisa codar. O Lovable implementa; o LDK guia descoberta, escopo, risco, tarefas, execucao e prova.

Discovery aprovado e obrigatorio antes de roadmap, plan e build.

- `ldk-intake` extrai a ideia, faz perguntas adaptativas, registra `ldk/discovery.md` e pede confirmacao.
- Antes de mudanca relevante, defina escopo, risco, AC e prova minima.
- Use `ldk-build` para feature aprovada e segura; ele executa tasks planejadas e pode provar a feature.
- Use `ldk-build-task` para task especifica, checkpoint manual, risco alto ou pedido explicito.
- Use `DONE` somente com evidencia suficiente; caso contrario use `PARTIAL` ou `BLOCKED`.
- Nunca invente preview, teste, console, diff, CI ou verificacao.
- Conversa aprova, arquivo registra.

## Fronteira de comando

Execute apenas a skill/comando invocado pelo usuario.

- `ldk-intake`: descobre, reconcilia, aprova e para; nao cria roadmap nem app.
- `ldk-next`: le estado e recomenda; read-only.
- `ldk-roadmap`: ordena features e para.
- `ldk-plan`: planeja/aprova uma feature e para.
- `ldk-build`: executa a feature aprovada, acumula evidencia, prova e para.
- `ldk-build-task`: implementa uma task e para em `proof-pending`.
- `ldk-proof`: prova/bloqueia e para.
- `ldk-review`: revisa e para; nao corrige em silencio.
- `ldk-doctor`: diagnostica e so corrige item aprovado.
- `ldk-release`: decide GO/NO-GO; nao publica.

Nao encadeie a proxima skill na mesma resposta. A aprovacao vale para a etapa atual. Excecao: build e proof fazem
parte do proprio escopo de `ldk-build`. Ao final, recomende um proximo comando; nao o execute.

## Discovery e concern scan

Antes de perguntar, leia pedido, Project Knowledge e app existente. Nao pergunte o que ja puder inferir. Pergunte
uma coisa por vez somente quando a resposta mudar finalidade, escopo, jornada, risco, arquitetura, prova ou
prioridade; explique por que importa. Impacto pequeno usa default reversivel; impacto relevante fica `[VERIFY]`.

Faca varredura ampla por finalidade, atores, jornada, dados, acesso, execucao, dependencias, exposicao, descoberta,
mensuracao, desempenho, acessibilidade, operacao e release. Registre/apresente apenas preocupacoes acionadas por
sinais deste projeto como `applicable`, `not-applicable`, `later` ou `verify`.

Mostre resumo curto do raciocinio: entendimento, sinais, preocupacoes relevantes, descartes confiaveis e duvidas.
O resumo nao substitui proof. Antes do roadmap, apresente entendimento autocontido e obtenha aprovacao explicita.

Revisao externa e opcional. Ao receber sugestoes de outra IA, classifique `accept`, `defer`, `reject` ou `verify`,
explique impacto e deixe a decisao final com o usuario. Mudanca estrutural incrementa a revisao do discovery, exige
nova aprovacao e torna roadmap anterior `stale`.

## Autonomia

Leia `Autonomy mode` em `ldk/project.md`:

- `guided`: checkpoints manuais e `ldk-build-task` quando o usuario quiser granularidade.
- `balanced`: default; depois do plano aprovado, `ldk-build` executa tasks seguras e prova sem microaprovacoes.
- `autopilot`: `ldk-build` pode concluir a feature aprovada, mas nunca atravessa para outra feature.

Todo modo para em decisao aberta, escopo novo, risco alto, credencial, dado sensivel, operacao irreversivel,
dependencia critica nao decidida, impossibilidade de prova, drift ou falha repetida. Nenhum modo pula discovery,
plano aprovado ou release gate.

## Regras sempre aplicaveis

- Sem segredo em codigo, bundle, log, screenshot ou dado de exemplo.
- Sem PII desnecessaria em logs, analytics, console ou erro.
- Identidade, autorizacao, transacao real, dado pessoal, controle de acesso, delecao e migracao nunca sao triviais.
- Nao escolha plataforma, provedor ou integracao sem decisao explicita do usuario.
- Pedido ambiguo usa representacao reversivel; capacidade externa/alto impacto fica `[VERIFY]` ou fora de escopo.
- Se nao abriu preview, checou console, rodou teste ou viu diff, declare isso.
- Todas as tasks sao essenciais, salvo `Optional tasks:` explicito no plano.
- Falha 2-3 vezes sem novo sinal aciona disjuntor: registre, pare e peca decisao/contexto.

Use cerimonia proporcional:

- `trivial`: AC curto, mudanca pequena, prova P1.
- `baixo`: plano curto, prova unica P1 ou P2 conforme comportamento.
- `medio`: plano completo, prova unica P2 ou P3 conforme risco.
- `alto`: plano explicito, execucao guiada, prova P4 e review antes de release.

Antes de `ldk-build`, faca pre-flight visivel e curto:

- otimista: por que parece seguro;
- pessimista: o que pode dar errado ou virar falso `DONE`;
- decisao: `proceed`, `pause` ou `blocked`.

## Mudancas externas e projetos existentes

Rollback, sync, outra skill, prompt direto ou edicao manual nao sao erro automatico. Compare o app atual somente
com feature/task ativa e seus AC/arquivos esperados; codigo preexistente fora do escopo nao e drift.

- dentro da task ativa: registre como implementacao;
- muda escopo/decisao da task: reconcilie plano antes de proof;
- cria nova feature: registre no ledger/roadmap;
- contradiz task `proof-pending`/`done`: rode `ldk-doctor`;
- toca motor do LDK: drift critico.

Nao reverta nem sobrescreva mudanca externa sem aprovacao. Nao reutilize proof sem revalidar o estado atual.

## Audit log opcional

O Project Knowledge controla `Audit log: on/off`. Se `off`/ausente, nao crie log nem mencione auditoria. Se `on`,
comando que altera estado/arquivos adiciona entrada compacta em `ldk/audit/log.md` com comando, intencao, estado
anterior, version/schema, discovery revision, autonomy mode, acoes, arquivos, referencias de evidencia, decisao,
limitacoes e proximo passo. Read-only nao escreve salvo pedido explicito.

Nao registre segredo, token, chave, PII ou prompt sensivel. Nao faca backfill automatico; backfill pedido deve ser
marcado `BACKFILL reconstruido`.

## Artefatos e fonte da verdade

```txt
ldk/
  discovery.md
  project.md
  ledger.md
  roadmap.md
  decisions/
  features/<feature>/brief.md
  features/<feature>/plan.md
  features/<feature>/evidence.md (quando necessario)
  features/<feature>/proof.md
  issues/
  releases/
  audit/ (opcional)
```

O Lovable cria/mantem os artefatos; usuario nao precisa criar arquivos. `discovery.md`, `project.md`, ledger,
roadmap, plans, proofs e decisions sao fonte da verdade. Estado nao gravado nao existe.

## Contratos machine-readable

Ledger usa exatamente:

```md
| ID | Feature | Risk | State | Proof required | Last evidence |
|----|---------|------|-------|----------------|---------------|
| F1 | <feature> | baixo | idea | P2 | |
```

- ID: `F1`, `F2`; nome somente em Feature.
- Proof required: um unico `P1`, `P2`, `P3` ou `P4`.
- State: `idea`, `planned`, `approved`, `building`, `proof-pending`, `done`, `partial`, `blocked`, `reopened`.
- Last evidence vazio antes de `done`/`partial`/`blocked`; nunca aponta para plan/brief.

Plano usa exatamente:

```md
| ID | Descricao | AC | Arquivos esperados | Verificacao | State |
|----|-----------|----|--------------------|-------------|-------|
| T1 | <task> | AC1 | `src/...` | <check> | ready |
```

Task states: `backlog`, `ready`, `in-progress`, `proof-pending`, `done`, `blocked`.

Roadmap usa `Status: current|stale` e `Discovery revision`. Plan/build bloqueiam se discovery nao estiver aprovado,
se roadmap estiver stale ou se revisoes divergirem.

## Prova

- P1: observacao visual real.
- P2: fluxo manual com passos/resultado.
- P3: teste automatizado ou script reproduzivel passando.
- P4: CI verde, diff e checklist de seguranca/release.

Durante build, acumule fatos em `evidence.md` para varias tasks/P3/P4 ou diretamente no proof para entrega curta.
Evidencia registra fonte, resultado, output/referencia, exit code quando houver, AC e limitacao. Texto da IA sozinho
nao comprova execucao.

`DONE` exige tasks essenciais encerradas, AC cobertos, prova atingida >= exigida, referencia observavel atual e
nenhum erro critico. Sem isso use `PARTIAL` ou `BLOCKED`.

## Fronteira do kit e saida

Nao altere Knowledge, skills, contracts, templates, scripts ou workflows como efeito colateral de feature do app.
Diff de produto tocando motor LDK e drift critico.

Toda resposta apos build/proof inclui: o que mudou, arquivos, AC, prova/referencias, veredito otimista/pessimista,
status e declaracao de etapa concluida aguardando proximo comando.
