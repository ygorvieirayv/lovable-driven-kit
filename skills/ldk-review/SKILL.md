# ldk-review

Use esta skill para revisar uma feature depois do proof, com foco em bugs, riscos, drift e testes.

## Objetivo

Revisar o diff contra:

- `ldk/features/<feature>/brief.md`
- `ldk/features/<feature>/plan.md`
- `ldk/features/<feature>/proof.md`
- `ldk/ledger.md`
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

## Severidade

- Critical: seguranca, perda de dados, PII/segredo exposto, proof falso, diff de app alterando motor LDK.
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

Next safe step:
```

Nao corrija em silencio durante review. Reporte primeiro.
