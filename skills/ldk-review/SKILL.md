---
name: ldk-review
description: Use when reviewing an implemented LDK feature against its plan, proof, diff, risk, and test evidence. Reports findings by severity and does not silently fix code.
---

# ldk-review

Use esta skill para revisar uma feature depois do proof, com foco em bugs, riscos, drift e testes.

## Objetivo

Revisar o diff contra:

- `ldk/features/<feature>/brief.md`
- `ldk/features/<feature>/plan.md`
- `ldk/features/<feature>/proof.md`
- `ldk/ledger.md`
- `ldk/roadmap.md`, se existir
- `contracts/always-rules.md`, se disponivel
- `contracts/common-lessons.md`, se disponivel
- regras de risco/prova do LDK

## O que checar

1. ACs do plano realmente aparecem como cobertos no proof?
2. O proof afirma apenas o que foi verificado?
3. O nivel de prova atingido e suficiente?
4. O diff mudou arquivos fora do escopo da task?
5. O diff tocou motor do LDK?
6. Existem riscos de auth, permissao, PII, pagamento, Supabase rules ou delecao?
7. Testes existem onde o risco exige P3/P4?
8. A UI foi verificada no preview quando a prova e visual/manual?
9. A feature respeitou a ordem/dependencias do roadmap?
10. Alguma licao comum do LDK foi violada?

## Severidade

- Critical: seguranca, perda de dados, PII/segredo exposto, proof falso, auth/pagamento/RLS sem prova forte,
  diff de app alterando motor LDK.
- High: AC essencial nao coberto, teste ausente para risco medio/alto, desvio relevante do plano.
- Medium: cobertura fraca, limitacao nao documentada, risco operacional.
- Low: estilo, clareza, melhoria opcional.

## Saida

```md
## LDK Review

Verdict: approved | approved-with-reservations | blocked

Critical:
- ...

High:
- ...

Medium:
- ...

Low:
- ...

AC -> evidence:
- AC1 -> ...

Roadmap/dependencies:
- ...

Next safe step:
```

Nao corrija em silencio durante review. Reporte primeiro.
