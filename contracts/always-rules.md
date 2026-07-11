# LDK Always Rules

Estas regras valem em qualquer nivel de risco.

- Discovery aprovado e obrigatorio antes de roadmap, plan e build.
- Sem prova falsa: se preview, teste, console, diff ou CI nao foram verificados, declare isso.
- Sem `DONE` sem evidencia suficiente.
- Nao coloque segredos em codigo, bundle, logs, screenshots ou dados de exemplo.
- Nao registre PII desnecessaria em logs, analytics, console ou mensagens de erro.
- Identidade, autorizacao, transacao real, dado pessoal, controle de acesso a dados, delecao e migracao nunca sao
  `trivial`.
- Nao escolha plataforma, provedor ou integracao sem decisao explicita do usuario.
- Quando o pedido estiver ambiguo, prefira uma representacao reversivel e marque capacidade externa ou de alto
  impacto como `[VERIFY]` ou fora de escopo.
- Quando houver backend, seguranca ou dado sensivel, valide no servidor ou na regra de acesso correta.
- Trabalho concorrente/assincrono revalida ownership e estado antes de cada efeito externo ou irreversivel.
- Cota/contador compartilhado usa reserva atomica e compensacao segura; nunca check-then-act separado.
- Chave publica/publicavel nao autentica worker, agendamento ou entrada privilegiada.
- `ldk-build` pode executar tasks planejadas da mesma feature em sequencia e provar a feature.
- Fora de `ldk-build`, implemente uma task de app por vez.
- Nao agrupe duas ou mais tasks aprovadas no mesmo `ldk-build-task`. Se elas deveriam ser uma unica task,
  revise o plano antes de construir.
- Execute apenas o comando LDK invocado; nao encadeie automaticamente para a proxima skill.
- Excecao: `ldk-build` inclui build e proof da feature aprovada no proprio escopo.
- Antes de `ldk-build` editar app, faca veredito otimista/pessimista e decida seguir, pausar ou bloquear.
- Nao altere motor do LDK como efeito colateral de uma task do app.
- Mudancas externas ao fluxo LDK (rollback, sync, outra skill ou prompt solto) nao sao erro por si so.
- Sync, aplicacao e publicacao sao estados diferentes; prove o ambiente/URL realmente entregue.
- Em projeto ja iniciado, nao trate codigo preexistente fora da feature/task LDK ativa como drift.
- Se codigo atual contradiz uma task LDK ja `proof-pending`/`done`, rode `ldk-doctor` antes de proof.
- Considere todas as tasks essenciais, salvo lista explicita `Optional tasks:` no plano.
- Nao rode `ldk-proof` final enquanto houver task essencial `ready`, `backlog` ou `in-progress`.
- Se nao puder verificar algo essencial, use `PARTIAL` ou `BLOCKED`.
