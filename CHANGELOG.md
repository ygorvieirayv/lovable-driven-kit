# Changelog

## [0.1.0] - 2026-07-05

### Added

- Primeiro MVP do Lovable Driven Kit (LDK).
- Workspace Knowledge e Project Knowledge template.
- Contratos `state-markers.md` e `engine-boundary.md`.
- Skills `ldk-intake`, `ldk-next`, `ldk-roadmap`, `ldk-plan`, `ldk-build-task`, `ldk-proof`, `ldk-review`,
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
