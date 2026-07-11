# Changelog

## [0.2.0] - 2026-07-10

### Added

- Discovery obrigatorio e versionado em `ldk/discovery.md`, com confirmacao antes de roadmap/plan/build.
- Concern Scan adaptativo, mapa dinamico de preocupacoes e resumo curto do raciocinio.
- Pacote portatil para revisao externa e reconciliacao `accept/defer/reject/verify`.
- Invalidacao por `Discovery revision` e roadmap `current/stale`.
- Modos de autonomia `guided`, `balanced` e `autopilot`, sem atravessar gates ou features.
- Acumulo de evidencia observavel durante build em `evidence.md` ou proof inline.
- `SCHEMA_VERSION`, version markers e `ldk-instructions-check.mjs` para tratar instrucoes como codigo.
- Contrato deterministico de frases criticas, limites de Knowledge/skill e genericidade do runtime.
- Manifesto e guia canonicos para substituir a instalacao no Lovable sem terminal ou mistura de versoes.

### Changed

- `ldk-intake` virou curadoria obrigatoria e nao cria roadmap.
- `ldk-next` reconhece intencoes naturais de retomada e nunca recomenda build sem plano aprovado.
- Roadmap e lessons passaram de heuristicas de nicho para sinais/dependencias genericos.
- Plans escolhem um unico proof level e declaram `Optional tasks`; as demais tasks sao essenciais.
- `ldk-build` executa loop seguro por task conforme autonomia, acumula evidencia e aciona disjuntor em falha repetida.
- Proof exige referencia atual/observavel alem da alegacao da IA.
- Workflow de proof nao mascara mais falha de `npm test`; ausencia de script e reportada como indisponivel.
- Validators Bash/PowerShell passaram a checar discovery, revision, autonomy, version/schema, IDs numericos e
  coerencia entre roadmap, plans e proofs.
- Regras de confiabilidade agora cobrem ownership de trabalho assincrono, reserva atomica de cotas, autenticacao de
  entradas privilegiadas e a diferenca entre sync, aplicacao e publicacao.

### Migration

- Projetos 0.1.0 precisam rodar `/ldk-intake` para criar/aprovar `ldk/discovery.md` antes de retomar roadmap/plan.
- Atualize os dois Knowledges e todas as skills em conjunto para evitar versoes misturadas.

## [0.1.0] - 2026-07-05

### Added

- Primeiro MVP do Lovable Driven Kit (LDK).
- Workspace Knowledge e Project Knowledge template.
- Contratos `state-markers.md` e `engine-boundary.md`.
- Skills `ldk-intake`, `ldk-next`, `ldk-roadmap`, `ldk-plan`, `ldk-build`, `ldk-build-task`, `ldk-proof`, `ldk-review`,
  `ldk-doctor` e `ldk-release`.
- Templates para projeto, ledger, brief, plan, proof, decisions, issues e releases.
- `scripts/ldk-check.ps1` e `scripts/ldk-check.sh` para validacao deterministica do ledger/proof.
- Fixtures valid/broken para testar o contrato.
- Workflow CI do kit e workflow `github/workflows/proof.yml` para apps Lovable.
- Smoke test Playwright base.

### Changed

- Instalacao documentada como importacao manual de cada skill `ldk-*`, porque o Lovable importa uma skill por
  URL/subdiretorio.
- README reescrito para usuario novo: proposta de valor, instalacao guiada no Lovable e prompt inicial de
  mini loja.
- README voltou a incluir uma dica simples de diagnostico: apos `/ldk-intake`, o Lovable deve criar a pasta
  `ldk/`; se nao criar, o usuario sabe o que pedir.
- README clarifica que o exemplo da mini loja é opcional: o usuário pode iniciar com uma frase simples, e o
  LDK ajuda a descobrir escopo, riscos, MVP e decisões.
- README reconcilia o público leigo com o rigor P4: o Lovable implementa partes técnicas, mas o LDK pode
  bloquear `DONE` em auth, pagamento, PII ou RLS até existir prova forte.
- Workspace Knowledge esclarece que o usuário não precisa codar; o Lovable implementa, e o LDK exige prova.
- `ldk-proof` ganhou `LDK self-check`, e `ldk-check` agora valida esses gates em proofs `DONE`.
- `ldk-check` agora falha linhas de ledger/task sem prefixos `F...`/`T...` e alinha a tolerância de
  indentação entre Bash e PowerShell.
- Skills e Workspace Knowledge agora usam cerimônia proporcional: tarefas triviais/baixas ficam leves, enquanto
  médio/alto risco mantêm plano e prova mais fortes.
- Adicionado `evaluation/mini-store-checklist.md` para medir se o Lovable obedece o fluxo do LDK em um teste
  prático de mini loja.
- Adicionada skill `ldk-roadmap`, template `roadmap.md` e contrato de roadmap para ordenar features por
  dependência antes de planejar.
- Adicionados contratos internos `always-rules.md` e `common-lessons.md` para piso de segurança e lições
  comuns sem criar um loop público de aprendizado.
- Intake/roadmap agora proíbem assumir Shopify, gateways, frete real, Supabase ou pagamento real sem pedido
  explícito do usuário; loja vaga usa default seguro com checkout fake.
- Ledger reforçado como artefato machine-readable: headers não devem ser traduzidos, ID não deve misturar nome da
  feature e `Proof required` deve usar um único nível.
- Reforçada a fronteira de comando: cada skill executa uma etapa e para; `ldk-plan` não inicia build e
  `ldk-build-task` não inicia proof automaticamente.
- `Last evidence` agora é reservado para proof/report: fica vazio antes de `done`/`partial`/`blocked`, e o
  validador falha quando aponta para `plan.md` ou `brief.md`.
- Planos agora exigem tabela de tasks machine-readable com IDs `T...` e `State`; `ldk-build-task` deve atualizar
  a task executada antes de parar.
- `ldk-next` e `ldk-build-task` bloqueiam sugestao de agrupar tasks aprovadas no mesmo `ldk-build-task` manual.
- Regras adicionadas para lidar com rollback, sync, outras skills e projetos ja iniciados sem tratar codigo antigo
  fora da feature ativa como drift.
- `ldk-next` nao deve sugerir `ldk-proof` enquanto houver task essencial `ready`, `backlog` ou `in-progress`.
- Adicionada skill `ldk-build` para executar e provar uma feature aprovada com pre-flight otimista/pessimista,
  reduzindo microaprovacoes em features triviais/baixas e medias seguras.
- Header da tabela de tasks agora e contrato literal: `Arquivos esperados` nao pode ser abreviado para `Arquivos`.
- Adicionado audit log opcional, desligado por padrao, controlado por `Audit log: on/off` no Project Knowledge.
- Adicionada skill externa `ldk-evaluate` para auditoria por outra IA; nao deve ser importada no Lovable.
