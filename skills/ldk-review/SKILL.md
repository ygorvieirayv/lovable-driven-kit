---
name: ldk-review
description: Use when reviewing an implemented LDK feature against its plan, proof, diff, risk, and test evidence. Reports findings by severity and does not silently fix code.
---

# ldk-review

LDK Version: 0.2.0
LDK Schema: 2

Use esta skill para revisar uma feature depois do proof, com foco em bugs, riscos, drift e testes.

Execute somente review. Nao corrija, nao rode build e nao rode release nesta skill.
Mesmo com `Audit log: on`, nao crie nem atualize `ldk/audit/log.md` nesta skill read-only, salvo pedido explicito.

## Objetivo

Revisar o diff contra:

- `ldk/features/<feature>/brief.md`
- `ldk/features/<feature>/plan.md`
- `ldk/features/<feature>/evidence.md`, se existir
- `ldk/features/<feature>/proof.md`
- `ldk/discovery.md`
- `ldk/ledger.md`
- `ldk/roadmap.md`, se existir
- `contracts/always-rules.md`, se disponivel
- `contracts/common-lessons.md`, se disponivel
- regras de risco/prova do LDK

Se discovery nao estiver approved ou discovery/roadmap/plan/proof divergirem em revision, o review nao pode ser
`approved`; reporte drift e recomende `ldk-doctor`/reconciliacao antes de seguir.

## O que checar

1. ACs do plano realmente aparecem como cobertos no proof?
2. O proof afirma apenas o que foi verificado?
3. O nivel de prova atingido e suficiente?
4. O diff mudou arquivos fora do escopo da task?
5. O diff tocou motor do LDK?
6. Discovery, roadmap, plan e proof usam a mesma revision?
7. As preocupacoes aplicaveis do discovery/plan foram tratadas e provadas?
8. Evidencias citam fonte, resultado atual, output/referencia e limite?
9. Testes existem onde o risco exige P3/P4?
10. A UI foi verificada no preview quando a prova e visual/manual?
11. A feature respeitou a ordem/dependencias do roadmap?
12. Alguma licao comum do LDK foi violada?
13. Fluxo concorrente/assincrono revalida ownership antes de cada efeito e usa operacoes atomicas onde necessario?
14. Entrada privilegiada usa autenticacao de servidor em vez de identificador publico/publicavel?
15. O estado publicado foi provado sem confundir sync ou aplicacao com entrega no ambiente/URL final?

## Severidade

- Critical: seguranca, perda de dados, PII/segredo exposto, proof falso, acesso/transacao/dado sensivel sem prova
  forte, operacao irreversivel insegura ou diff de app alterando motor LDK.
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

Discovery/concerns:
- ...

Etapa concluida:
- Review registrado e aguardando proximo comando.
```

Nao corrija em silencio durante review. Reporte primeiro.
