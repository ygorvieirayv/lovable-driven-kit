---
name: ldk-roadmap
description: Use when ordering Lovable app features by dependencies and deciding what should be planned next in an LDK project. Creates or updates ldk/roadmap.md from project context, ledger, risks, blockers, and common LDK lessons. Not for implementation.
---

# ldk-roadmap

Use esta skill em Plan mode para ordenar features por dependencia e escolher o proximo passo seguro.

## Objetivo

Criar ou atualizar:

- `ldk/roadmap.md`
- linhas de `ldk/ledger.md`, apenas quando faltar uma feature descoberta no roadmap

Nao implemente app nesta skill.

## O que ler

Leia somente o necessario:

- `ldk/project.md`
- `ldk/ledger.md`
- `ldk/roadmap.md`, se existir
- plans/briefs em `ldk/features/`, se existirem
- `contracts/always-rules.md`, se disponivel
- `contracts/common-lessons.md`, se disponivel

Se `ldk/project.md` ou `ldk/ledger.md` nao existir, recomende `ldk-intake`.

## Regras

- Ordene por dependencia antes de desejo.
- Marque bloqueios como `blocked`, nao force plano.
- Mantenha o MVP pequeno.
- Auth, pagamento real, PII, Supabase RLS, delecao e migracao nunca sao triviais.
- Se uma feature depende de decisao do usuario, marque `[VERIFY]`.
- Se uma feature nova entrar no roadmap, registre ou recomende registrar no ledger.
- Nao altere motor do LDK.

## Heuristicas de dependencia

Loja:

- catalogo, produto e preco antes de carrinho;
- carrinho antes de checkout;
- frete/taxas antes de checkout real;
- checkout fake antes de pagamento real;
- pedidos antes de admin de pedidos;
- auth/permissoes antes de area admin real.

SaaS/app interno:

- modelo de dados antes de CRUD;
- auth antes de dados pessoais por usuario;
- permissoes antes de admin;
- fluxo principal antes de dashboard avancado;
- auditoria/logs antes de operacoes sensiveis.

Integracoes:

- variaveis/segredos antes de API externa;
- idempotencia antes de webhook em producao;
- fallback/erro antes de fluxo critico.

## Readiness

Use apenas:

- `ready`: pode planejar agora.
- `blocked`: depende de feature, decisao, acesso ou risco nao resolvido.
- `later`: fora do MVP ou baixa prioridade.
- `done`: ja concluida no ledger/proof.
- `verify`: precisa confirmar algo antes de decidir.

## Saida em arquivo

Grave `ldk/roadmap.md` usando `templates/roadmap.md`, se disponivel.

## Saida final

```md
## LDK Roadmap

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

Next safe step:
```

Se houver feature `ready`, o proximo passo normalmente e `ldk-plan`.
Se a proxima mudanca for trivial, bem definida e sem dependencia, o proximo passo pode ser `ldk-build-task`.
