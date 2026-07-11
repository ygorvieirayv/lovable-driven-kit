---
name: ldk-release
description: Use when preparing to publish or hand off a Lovable app and an LDK go/no-go release checklist must review proofs, issues, preview, CI, applicable concerns, and residual risks.
---

# ldk-release

LDK Version: 0.2.2
LDK Schema: 2

Use esta skill antes de publicar ou entregar uma versao.

Execute somente o checklist de release. Nao publique, nao corrija e nao implemente nesta skill.

## Objetivo

Gerar `ldk/releases/<date>.md` com decisao `GO` ou `NO-GO`.

Discovery precisa estar approved e discovery, roadmap, plans e proofs do escopo precisam usar revision coerente.
Qualquer divergencia produz `NO-GO` ate reconciliacao.

## O que revisar

- `ldk/discovery.md`
- `ldk/ledger.md`
- `ldk/roadmap.md`
- proofs das features no escopo
- `contracts/always-rules.md`, se disponivel
- issues abertas
- GitHub diff/CI
- preview desktop/mobile
- ambiente e URL realmente publicados, sem confundir sync/aplicacao com publicacao
- console/logs
- preocupacoes `applicable` no discovery/project
- acesso, dados, transacoes e operacoes de alto impacto quando aplicaveis
- env vars
- descoberta, mensuracao e desempenho, quando marcados aplicaveis

## Checklist

- Todas as features do release tem proof?
- Alguma feature esta `partial` ou `blocked`?
- Existe Critical/High aberto?
- Build/test/CI estao verdes?
- O estado publicado foi verificado no ambiente/URL de destino?
- Sync/import/export regenerou ou duplicou arquivos que ainda precisam de reconciliacao?
- Preview principal foi aberto?
- Mobile foi checado?
- Fluxo principal foi testado?
- Console/logs foram checados?
- Env vars necessarias existem?
- Todas as preocupacoes aplicaveis tem decisao e prova proporcional?
- Acesso/dados/transacoes foram testados na camada correta, quando aplicaveis?
- Roadmap nao deixou feature fundacional pendente no release?
- Segredos/PII/logs foram checados?

## Saida

Crie:

```txt
ldk/releases/<yyyy-mm-dd>.md
```

Use `templates/release-report.md`.

Na conversa:

```md
## LDK Release

Status: GO | NO-GO
Scope:
Evidence:
Blockers:
Known limitations:
Etapa concluida:
```

Use `NO-GO` se houver risco critico sem prova.

## Audit log opcional

Se o Project Knowledge tiver `Audit log: on`, adicione uma entrada compacta em `ldk/audit/log.md` ao final.
Se `ldk/audit/log.md` nao existir, crie o arquivo com titulo e nota curta de que o log comeca na ativacao.
Nao faca backfill automatico; se o usuario pedir backfill, marque como `BACKFILL reconstruido`.
Se estiver `off` ou ausente, nao crie log.
