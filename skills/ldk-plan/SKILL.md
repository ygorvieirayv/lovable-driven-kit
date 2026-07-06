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
- Use a tabela machine-readable de tasks de `templates/feature-plan.md`; nao use apenas bullets.
- A tabela de tasks deve usar exatamente estes headers, sem abreviar, traduzir, renomear ou trocar ordem:
  `ID | Descricao | AC | Arquivos esperados | Verificacao | State`.
- `Arquivos` nao e header valido; use sempre `Arquivos esperados`.
- Defina risco e prova minima antes de construir.
- Nao liste arquivos de motor LDK como alvo de task de produto.
- Confirme o plano antes de mudar estado para `approved`.
- Use cerimonia proporcional: trivial/baixo nao deve virar burocracia maior que a mudanca.
- Antes de planejar, respeite `ldk/roadmap.md` quando existir.
- Aplique `contracts/always-rules.md` e consulte `contracts/common-lessons.md`, se disponiveis.
- Ao atualizar `ldk/ledger.md`, mantenha o formato machine-readable de `templates/task-ledger.md`: headers em ingles,
  ID separado do nome e `Proof required` com um unico valor.
- Durante planning/aprovacao, deixe `Last evidence` vazio. Nao use `plan.md` como evidencia no ledger.
- Execute somente planejamento. Aprovacao do plano autoriza salvar/aprovar o plano, nao inicia build nesta skill.
- Mesmo se o usuario disser "pode continuar", nao rode `ldk-build` nem `ldk-build-task` nesta skill.

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
  prova `P1` e pare.
- baixo: use plano curto com objetivo, ACs, fora de escopo, uma ou poucas tasks e prova P1/P2.
- medio: use o plano completo com tasks pequenas, verificacao por task e estrategia de prova.
- alto: use plano completo, liste riscos, dependencias, seguranca, rollback e prova P4.

Se o usuario pedir apenas copy, cor, padding ou ajuste visual pequeno, diga explicitamente que o plano sera leve.

## Roteiro

1. Leia `ldk/project.md`, `ldk/ledger.md` e `ldk/roadmap.md`, se existir.
2. Confirme o nome/slug da feature.
3. Se a feature estiver `blocked` no roadmap, nao planeje sem decisao consciente do usuario.
4. Se o roadmap estiver ausente/desatualizado em projeto com dependencias, recomende `ldk-roadmap`.
5. Escreva objetivo, usuario, escopo e fora de escopo.
6. Escreva ACs no formato observavel.
7. Defina risco e prova minima.
8. Quebre em tasks pequenas.
9. Defina como cada task sera verificada.
10. Defina modo de execucao recomendado:
   - `ldk-build` para trivial/baixo e medio sem bloqueio critico;
   - `ldk-build-task` para alto risco, checkpoint manual ou decisao aberta.
11. Atualize o ledger:
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
| ID | Descricao | AC | Arquivos esperados | Verificacao | State |
|----|-----------|----|--------------------|-------------|-------|
| T1 |  | AC1 | `src/...` | preview | ready |

Arquivos criados/alterados:
- ...

Status no ledger:
Cerimonia usada: trivial curta | baixo curta | medio completa | alto completa
Modo de execucao recomendado: ldk-build | ldk-build-task
Roadmap/dependencias:

Etapa concluida:
- Plano pronto/aprovado e aguardando proximo comando.
```

Nao implemente nada nesta skill.
