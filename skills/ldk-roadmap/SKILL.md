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
- Nao escolha plataforma, provedor ou integracao sem pedido explicito do usuario.
- Auth, pagamento real, PII, Supabase RLS, delecao e migracao nunca sao triviais.
- Se uma feature depende de decisao do usuario, marque `[VERIFY]`.
- Se uma feature nova entrar no roadmap, registre ou recomende registrar no ledger.
- Ao registrar no ledger, preserve exatamente o formato de `templates/task-ledger.md`.
- Nao altere motor do LDK.
- Execute somente roadmap. Nao rode `ldk-plan` nem `ldk-build-task` nesta skill.

## Ledger contract

Se precisar adicionar linhas em `ldk/ledger.md`, nao traduza nem reestruture a tabela:

```md
| ID | Feature | Risk | State | Proof required | Last evidence |
|----|---------|------|-------|----------------|---------------|
| F1 | <feature> | baixo | idea | P2 | |
```

- `ID`: apenas `F1`, `F2`, etc.
- `Feature`: nome da feature.
- `Risk`: `trivial`, `baixo`, `medio` ou `alto`.
- `State`: valor canonico como `idea`, `planned`, `blocked`.
- `Proof required`: um unico valor `P1`/`P2`/`P3`/`P4`, nao intervalo.

## Heuristicas de dependencia

Loja:

- se plataforma/provedor nao foi escolhido, manter loja generica no Lovable e marcar provedor como `[VERIFY]`;
- catalogo, produto e preco antes de carrinho;
- carrinho antes de checkout;
- checkout fake antes de checkout real;
- frete/taxas antes de checkout real;
- pagamento real, gateway, Shopify ou frete real ficam `later` ou `verify` ate pedido/decisao explicita;
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

Etapa concluida:
- Roadmap pronto e aguardando proximo comando.
```

Nao execute a proxima etapa nesta skill. Se o usuario nao souber como continuar, ele deve usar `ldk-next`.
