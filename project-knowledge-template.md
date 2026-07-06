# Project Knowledge - Lovable Driven Kit

## Produto
- Nome:
- Objetivo:
- Usuario principal:
- Resultado de negocio:

## Plataforma
- Lovable project:
- GitHub repo:
- Backend:
- Banco:
- Auth:
- Pagamentos:

## Fonte da verdade
- Contexto do produto: `ldk/project.md`
- Ledger: `ldk/ledger.md`
- Roadmap: `ldk/roadmap.md`
- Features: `ldk/features/`
- Decisoes: `ldk/decisions/`
- Provas: `ldk/features/*/proof.md`
- Issues: `ldk/issues/`
- Releases: `ldk/releases/`

## Riscos
- Dados pessoais:
- Pagamentos:
- Permissoes/admin:
- Integracoes externas:
- Supabase/RLS:
- Compliance:

## Regras do projeto
- 

## Auditoria LDK
- Audit log: off
- Audit log file: `ldk/audit/log.md`
- Para habilitar, troque para `Audit log: on`.
- Para desabilitar, volte para `Audit log: off`.

## Cerimonia proporcional
- trivial: AC curto, uma mudanca pequena e prova P1.
- baixo: plano curto e prova P1/P2.
- medio: plano completo e prova P2/P3.
- alto: plano completo, risco explicito, prova P4 e revisao antes de release.

## Regras sempre
- Sem prova falsa.
- Sem segredo no bundle/log.
- Sem PII desnecessaria em log/analytics/console.
- Auth, pagamento real, RLS, delecao e migracao nunca sao triviais.
- Nao assumir Shopify, gateway, frete real, Supabase ou integracao externa sem pedido explicito.
- `ldk-build` pode executar e provar uma feature aprovada. Fora dele, cada comando LDK executa uma etapa e para.
  Para continuar, use `/ldk-next`.

## Pendencias [VERIFY]
- 

## Comandos LDK

Use:

- `ldk-intake` para organizar ideia e contexto.
- `ldk-next` para descobrir o proximo passo seguro.
- `ldk-roadmap` para ordenar features por dependencia.
- `ldk-plan` para planejar uma feature.
- `ldk-build` para executar e provar uma feature aprovada.
- `ldk-build-task` para implementar uma task especifica.
- `ldk-proof` para provar ou bloquear a conclusao.
- `ldk-review` para revisar diff, risco e testes.
- `ldk-doctor` para diagnosticar drift.
- `ldk-release` antes de publicar.
