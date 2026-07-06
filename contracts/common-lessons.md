# LDK Common Lessons

Biblioteca interna de licoes comuns para `ldk-roadmap`, `ldk-plan` e `ldk-review`.
Nao e um loop de aprendizado do projeto e nao exige manutencao do usuario.

## Ordem de produto

- Loja: catalogo/produto/preco vem antes de carrinho; carrinho vem antes de checkout; checkout fake vem antes
  de pagamento real; pedidos vem antes de admin de pedidos.
- Frete, taxa, moeda e confirmacao precisam ser decididos antes de checkout real.
- SaaS: modelo de dados e fluxo principal vem antes de dashboard avancado.
- Admin real depende de auth, papeis e permissao clara.

## Segurança e dados

- Segredo no bundle e falha critica. Use env var/secret manager quando houver integracao.
- PII em log, analytics, console ou mensagem de erro e falha critica.
- Validacao apenas no frontend nao protege dado, pagamento, permissao ou operacao sensivel.
- Supabase com dados reais exige RLS/policies coerentes antes de `DONE`/release.
- Operacao de delecao ou migracao exige rollback, backup ou confirmacao forte.

## Integrações

- Webhook precisa de idempotencia antes de producao.
- API externa precisa de tratamento de erro e estado vazio.
- Pagamento real precisa ambiente correto, teste de sucesso/falha e evidencia P4 antes de release.

## IA e escopo

- Escopo inflado aumenta falso done. Se uma task tocar muitas features, quebrar antes de construir.
- Green falso acontece quando teste/build e mencionado sem output. Registrar `not run` quando nao rodou.
- Proof visual fraco nao cobre fluxo com regra de negocio. Subir de P1 para P2/P3 quando houver comportamento.
