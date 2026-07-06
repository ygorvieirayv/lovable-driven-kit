---
name: ldk-intake
description: Use when starting a Lovable project with the Lovable Driven Kit, turning a vague idea into project context, risks, MVP scope, and the initial LDK ledger. Not for implementing app features.
---

# ldk-intake

Use esta skill para transformar uma ideia vaga em contexto inicial do Lovable Driven Kit.

## Objetivo

Criar ou atualizar:

- `ldk/project.md`
- `ldk/ledger.md`
- `ldk/roadmap.md` inicial, quando houver mais de uma feature ou dependencias claras
- primeiras pendencias `[VERIFY]`

## Regras de conversa

- Uma pergunta por vez.
- Explique o por que antes de perguntar.
- Se o usuario disser "nao sei", sugira um default seguro.
- Nao invente regra de negocio, compliance, pagamento ou permissao.
- Nao escolha plataforma, provedor ou integracao sem o usuario pedir. Exemplos: Shopify, Stripe, Mercado Pago,
  Supabase, ERP, frete ou gateway devem ficar como `[VERIFY]` ou fora de escopo.
- Se o usuario pular uma escolha, nao assuma uma opcao do menu; registre `[VERIFY]` e siga com o caminho generico.
- Marque incertezas com `[VERIFY]`.
- Confirme antes de gravar.
- Aplique `contracts/always-rules.md`, se disponivel.
- Ao criar `ldk/ledger.md`, use exatamente `templates/task-ledger.md`. Nao traduza headers, nao mude colunas e nao
  misture ID com nome da feature.
- Execute somente intake. Nao rode `ldk-roadmap`, `ldk-plan` ou qualquer build nesta skill.

## Roteiro

1. Entenda o produto:
   - nome;
   - publico;
   - objetivo;
   - resultado esperado.
2. Entenda a plataforma:
   - GitHub repo;
   - backend/banco/auth/pagamentos, se existirem;
   - se usa Supabase, quais tabelas/policies importam.
3. Classifique riscos:
   - dados pessoais;
   - pagamento;
   - admin/permissoes;
   - integracoes;
   - migracao/delecao.
4. Defina MVP:
   - essencial;
   - depois do MVP;
   - primeira feature ou tarefa a executar.
5. Crie o ledger inicial.

## Defaults seguros

Para loja/e-commerce sem detalhes tecnicos:

- MVP default: landing/vitrine, catalogo com produtos ficticios, cards, carrinho local, checkout fake e confirmacao
  simulada.
- Fora de escopo default: pagamento real, checkout real, frete real, Shopify, gateway, auth real, Supabase e
  integracoes externas.
- Riscos podem citar pagamento, PII, frete, compliance ou ANVISA como `[VERIFY]`, mas nao transforme esses riscos em
  arquitetura escolhida.
- Nao avance para setup de provedor externo. Registre o estado e pare.

## Classificacao da etapa seguinte

- Se o MVP tiver varias features ou ordem importante, registre que provavelmente precisa de roadmap.
- Se a primeira demanda for vaga, baixa/media/alta ou envolver risco sem dependencias relevantes, registre que
  provavelmente precisa de plano.
- Se a primeira demanda for trivial e bem definida, registre AC curto, risco `trivial` e prova `P1`.

Nao execute a etapa seguinte nesta skill. Ao final, diga que o intake esta pronto e aguardando o proximo comando.

## Saida em arquivo

Se `ldk/` nao existir, crie:

```txt
ldk/
  project.md
  ledger.md
  roadmap.md
  decisions/
  features/
  issues/
  releases/
```

Use `templates/project.md`, `templates/task-ledger.md` e `templates/roadmap.md` como formato.

Para `ldk/ledger.md`, mantenha exatamente:

```md
| ID | Feature | Risk | State | Proof required | Last evidence |
|----|---------|------|-------|----------------|---------------|
| F1 | <feature> | baixo | idea | P2 | |
```

Cada linha deve ter `ID` como `F1`, `F2`, etc.; o nome da feature fica em `Feature`. `Proof required` deve ser um
unico nivel (`P1`, `P2`, `P3` ou `P4`), nunca `P1/P2`.

## Saida final na conversa

Responda com:

1. Produto entendido.
2. Riscos identificados.
3. MVP proposto.
4. Arquivos criados/alterados.
5. Pendencias `[VERIFY]`.
6. Etapa concluida: intake pronto e aguardando proximo comando.

Nao implemente nada nesta skill.
