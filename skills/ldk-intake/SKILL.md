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
- Marque incertezas com `[VERIFY]`.
- Confirme antes de gravar.
- Aplique `contracts/always-rules.md`, se disponivel.

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

## Proximo passo proporcional

- Se o MVP tiver varias features ou ordem importante, recomende `ldk-roadmap`.
- Se a primeira demanda for vaga, baixa/media/alta ou envolver risco sem dependencias relevantes, recomende `ldk-plan`.
- Se a primeira demanda for trivial e bem definida, registre um AC curto, risco `trivial`, prova `P1` e recomende
  `ldk-build-task` sem plano longo.

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

## Saida final na conversa

Responda com:

1. Produto entendido.
2. Riscos identificados.
3. MVP proposto.
4. Arquivos criados/alterados.
5. Pendencias `[VERIFY]`.
6. Proximo passo seguro: `ldk-roadmap`, `ldk-plan` ou `ldk-build-task`, conforme dependencia, risco e clareza.

Nao implemente nada nesta skill.
