# ldk-intake

Use esta skill para transformar uma ideia vaga em contexto inicial do Lovable Driven Kit.

## Objetivo

Criar ou atualizar:

- `ldk/project.md`
- `ldk/ledger.md`
- primeiras pendencias `[VERIFY]`

## Regras de conversa

- Uma pergunta por vez.
- Explique o por que antes de perguntar.
- Se o usuario disser "nao sei", sugira um default seguro.
- Nao invente regra de negocio, compliance, pagamento ou permissao.
- Marque incertezas com `[VERIFY]`.
- Confirme antes de gravar.

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
   - primeira feature a planejar.
5. Crie o ledger inicial.

## Saida em arquivo

Se `ldk/` nao existir, crie:

```txt
ldk/
  project.md
  ledger.md
  decisions/
  features/
  issues/
  releases/
```

Use `templates/project.md` e `templates/task-ledger.md` como formato.

## Saida final na conversa

Responda com:

1. Produto entendido.
2. Riscos identificados.
3. MVP proposto.
4. Arquivos criados/alterados.
5. Pendencias `[VERIFY]`.
6. Proximo passo seguro: `ldk-plan` para a primeira feature.

Nao implemente nada nesta skill.
