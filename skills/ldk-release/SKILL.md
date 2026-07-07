---
name: ldk-release
description: Use before publishing or handing off a Lovable app to run an LDK go/no-go release checklist across proofs, issues, preview, CI, auth, data, and release risks.
---

# ldk-release

Use esta skill antes de publicar ou entregar uma versao.

Execute somente o checklist de release. Nao publique, nao corrija e nao implemente nesta skill.

## Objetivo

Gerar `ldk/releases/<date>.md` com decisao `GO` ou `NO-GO`.

## O que revisar

- `ldk/ledger.md`
- `ldk/roadmap.md`
- proofs das features no escopo
- `contracts/always-rules.md`, se disponivel
- issues abertas
- GitHub diff/CI
- preview desktop/mobile
- console/logs
- auth/admin
- dados pessoais
- pagamentos
- Supabase/RLS
- env vars
- SEO/analytics, quando aplicavel

## Checklist

- Todas as features do release tem proof?
- Alguma feature esta `partial` ou `blocked`?
- Existe Critical/High aberto?
- Build/test/CI estao verdes?
- Preview principal foi aberto?
- Mobile foi checado?
- Fluxo principal foi testado?
- Console/logs foram checados?
- Env vars necessarias existem?
- Auth/admin foram testados com papel correto?
- Dados/pagamentos foram revisados se existirem?
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
