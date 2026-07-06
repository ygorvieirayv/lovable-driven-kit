---
name: ldk-plan
description: 'Use when planning a single Lovable app feature before implementation: define scope, acceptance criteria, risk, proof level, and small tasks. Not for building the feature.'
---

# ldk-plan

Use esta skill em Plan mode para planejar uma feature antes de construir.

## Objetivo

Criar ou atualizar:

- `ldk/features/<feature>/brief.md`
- `ldk/features/<feature>/plan.md`
- linha correspondente em `ldk/ledger.md`

## Regras

- Use Plan mode.
- Planeje uma feature por vez.
- Criterios de aceite precisam ser binarios e verificaveis.
- Cada task precisa apontar AC, arquivos esperados, verificacao e estado.
- Defina risco e prova minima antes de construir.
- Nao liste arquivos de motor LDK como alvo de task de produto.
- Confirme o plano antes de mudar estado para `approved`.
- Use cerimonia proporcional: trivial/baixo nao deve virar burocracia maior que a mudanca.

## Risco

- trivial: copy, cor, padding, ajuste visual pequeno.
- baixo: secao simples, componente estatico, comportamento isolado.
- medio: CRUD, formulario, filtro, dashboard, admin simples.
- alto: auth, permissao, dados pessoais, pagamento, Supabase RLS, migracao, delecao.

Na duvida, suba um nivel.

## Prova minima

- P1: visual.
- P2: fluxo manual.
- P3: teste automatizado.
- P4: CI/release.

Mapeamento recomendado:

- trivial -> P1
- baixo -> P1/P2
- medio -> P2/P3
- alto -> P4

## Cerimonia proporcional

- trivial: se o pedido ja esta claro, nao crie plano formal longo. Registre objetivo, AC de uma linha, risco `trivial`,
  prova `P1` e recomende `ldk-build-task`.
- baixo: use plano curto com objetivo, ACs, fora de escopo, uma ou poucas tasks e prova P1/P2.
- medio: use o plano completo com tasks pequenas, verificacao por task e estrategia de prova.
- alto: use plano completo, liste riscos, dependencias, seguranca, rollback e prova P4.

Se o usuario pedir apenas copy, cor, padding ou ajuste visual pequeno, diga explicitamente que o plano sera leve.

## Roteiro

1. Leia `ldk/project.md` e `ldk/ledger.md`.
2. Confirme o nome/slug da feature.
3. Escreva objetivo, usuario, escopo e fora de escopo.
4. Escreva ACs no formato observavel.
5. Defina risco e prova minima.
6. Quebre em tasks pequenas.
7. Defina como cada task sera verificada.
8. Atualize o ledger:
   - nova feature: `planned`;
   - feature aprovada pelo usuario: `approved`.

## Saida

```md
## LDK Plan

Feature:
Risk:
Proof required:

Acceptance criteria:
- AC1:

Tasks:
- T1:

Arquivos criados/alterados:
- ...

Status no ledger:
Cerimonia usada: trivial curta | baixo curta | medio completa | alto completa

Proximo passo seguro:
```

Nao implemente nada nesta skill.
