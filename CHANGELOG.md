# Changelog

## [0.1.0] - 2026-07-05

### Added

- Primeiro MVP do Lovable Driven Kit (LDK).
- Workspace Knowledge e Project Knowledge template.
- Contratos `state-markers.md` e `engine-boundary.md`.
- Skills `ldk-intake`, `ldk-next`, `ldk-plan`, `ldk-build-task`, `ldk-proof`, `ldk-review`, `ldk-doctor` e `ldk-release`.
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
