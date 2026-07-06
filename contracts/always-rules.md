# LDK Always Rules

Estas regras valem em qualquer nivel de risco.

- Sem prova falsa: se preview, teste, console, diff ou CI nao foram verificados, declare isso.
- Sem `DONE` sem evidencia suficiente.
- Nao coloque segredos em codigo, bundle, logs, screenshots ou dados de exemplo.
- Nao registre PII desnecessaria em logs, analytics, console ou mensagens de erro.
- Auth, permissoes/admin, pagamento real, PII, Supabase RLS, delecao e migracao nunca sao `trivial`.
- Nao escolha plataforma, provedor ou integracao sem pedido explicito do usuario; registre `[VERIFY]` ou deixe fora
  de escopo.
- Quando houver backend, seguranca ou dado sensivel, valide no servidor ou na regra de acesso correta.
- Implemente uma task de app por vez.
- Nao agrupe duas ou mais tasks aprovadas no mesmo `ldk-build-task`. Se elas deveriam ser uma unica task,
  revise o plano antes de construir.
- Execute apenas o comando LDK invocado; nao encadeie automaticamente para a proxima skill.
- Nao altere motor do LDK como efeito colateral de uma task do app.
- Mudancas externas ao fluxo LDK (rollback, sync, outra skill ou prompt solto) nao sao erro por si so.
- Em projeto ja iniciado, nao trate codigo preexistente fora da feature/task LDK ativa como drift.
- Se codigo atual contradiz uma task LDK ja `proof-pending`/`done`, rode `ldk-doctor` antes de proof.
- Se nao puder verificar algo essencial, use `PARTIAL` ou `BLOCKED`.
