---
name: ldk-roadmap
description: Use when ordering project capabilities and features by dependencies after LDK discovery approval. Creates or refreshes ldk/roadmap.md and reconciles candidate ledger rows. Not for discovery, planning a feature, or implementation.
---

# ldk-roadmap

LDK Version: 0.2.0
LDK Schema: 2

Use esta skill para transformar o discovery aprovado em ordem de entrega.

Discovery aprovado e obrigatorio antes de roadmap, plan e build.

## Pre-flight

Leia:

- `ldk/discovery.md`;
- `ldk/project.md`;
- `ldk/ledger.md`;
- `ldk/roadmap.md`, se existir;
- briefs/plans existentes;
- `contracts/always-rules.md` e `contracts/common-lessons.md`, se disponiveis.

Pare e recomende `ldk-intake` se discovery nao existir ou nao estiver `approved`. Se project/ledger/version/schema
divergirem, recomende `ldk-doctor`.

## Objetivo

- criar/atualizar `ldk/roadmap.md` com `Status: current` e a revision aprovada;
- ordenar por dependencia e resultado, nao por desejo ou tipo de app;
- adicionar ao ledger somente features realmente derivadas do discovery aprovado;
- marcar decisoes/bloqueios sem escolher provedor ou inflar escopo.

Nao escolha plataforma, provedor ou integracao sem decisao explicita do usuario.

## Heuristicas genericas

- Finalidade e jornada aprovada orientam o recorte.
- Pre-requisitos vem antes de capacidades que dependem deles.
- Fonte de dados/regras essenciais vem antes das experiencias que as consomem.
- Identidade/autorizacao so entra quando atores, dados ou superficies acionarem essa preocupacao.
- Dependencia externa critica exige decisao, falha/fallback e prova antes de sustentar a jornada.
- Execucao recorrente/demorada so entra quando o comportamento exigir.
- Descoberta, mensuracao e desempenho ganham prioridade quando o objetivo/situacao atual os tornar relevantes.
- Preocupacao `later` nao vira feature do MVP.
- Preocupacao `verify` que muda a ordem torna feature `verify`/`blocked`, nao e resolvida por suposicao.
- Mantenha o menor caminho que entrega o resultado aprovado.

## Readiness

- `ready`: pode planejar agora.
- `blocked`: depende de feature, decisao, acesso ou risco nao resolvido.
- `later`: fora do recorte atual.
- `done`: concluida com proof coerente.
- `verify`: falta confirmar algo antes de ordenar/planejar.

## Ledger

Ao adicionar feature, preserve exatamente:

```md
| ID | Feature | Risk | State | Proof required | Last evidence |
|----|---------|------|-------|----------------|---------------|
| F1 | <feature> | baixo | idea | P2 | |
```

Use ID separado, risco canonico, um unico proof e evidencia vazia antes de estado final.

## Audit log opcional

Se `Audit log: on`, registre revision usada, ordem, bloqueios, linhas adicionadas e proximo passo. Se `off`/ausente,
nao crie log.

## Saida

Grave `ldk/roadmap.md` por `templates/roadmap.md`, com `Status: current` e `Discovery revision` iguais ao discovery.

```md
## LDK Roadmap

Discovery revision:
Next recommended feature:
Why:
Blocked:
- ...

Ready now:
- ...

Later:
- ...

Ledger updates:
- ...

Etapa concluida: roadmap pronto e aguardando proximo comando.
```

Execute somente roadmap. Nao rode plan/build.
