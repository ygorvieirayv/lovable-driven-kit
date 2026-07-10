# Project Knowledge - Lovable Driven Kit

LDK Version: 0.2.0
LDK Schema: 2

## Produto
- Nome:
- Objetivo:
- Usuario principal:
- Resultado esperado:
- Como o sucesso sera observado:

## Plataforma
- Lovable project:
- GitHub repo:
- Stack percebida:
- Backend:
- Dados/estado:
- Identidade e acesso:
- Integracoes externas:

## Fonte da verdade
- Discovery aprovado: `ldk/discovery.md`
- Contexto duravel: `ldk/project.md`
- Ledger: `ldk/ledger.md`
- Roadmap: `ldk/roadmap.md`
- Features: `ldk/features/`
- Decisoes: `ldk/decisions/`
- Provas: `ldk/features/*/proof.md`
- Issues: `ldk/issues/`
- Releases: `ldk/releases/`

## Preocupacoes aplicaveis

Registre somente preocupacoes acionadas por sinais deste projeto.

| Concern | Why it matters | Decision | Proof/validation |
|---------|----------------|----------|------------------|
| | | | |

## Autonomia LDK
- Autonomy mode: balanced

Valores:
- `guided`: checkpoints manuais e execucao granular.
- `balanced`: plano aprovado autoriza build seguro da feature e proof sem microaprovacoes.
- `autopilot`: conclui feature aprovada ate DONE/PARTIAL/BLOCKED, sem puxar outra feature.

Risco alto, decisao aberta, credencial, dado sensivel, operacao irreversivel, drift ou prova impossivel sempre param.

## Regras do projeto
-

## Auditoria LDK
- Audit log: off
- Audit log file: `ldk/audit/log.md`
- Para habilitar, troque para `Audit log: on`.
- Para desabilitar, volte para `Audit log: off`.
- Se habilitar no meio do projeto, o log comeca dali; backfill so com pedido explicito.

## Cerimonia proporcional
- trivial: AC curto, mudanca pequena e P1.
- baixo: plano curto e uma prova P1 ou P2.
- medio: plano completo e uma prova P2 ou P3.
- alto: plano completo, execucao guiada, P4 e review antes de release.

## Regras sempre
- Discovery aprovado e obrigatorio antes de roadmap, plan e build.
- Sem prova falsa e sem `DONE` sem evidencia suficiente.
- Sem segredo em bundle/log e sem PII desnecessaria em log/analytics/console.
- Nao escolha plataforma, provedor ou integracao sem decisao explicita do usuario.
- Capacidade externa, irreversivel ou de alto impacto nao e inferida de exemplo; use `[VERIFY]`.
- `ldk-build` pode executar/provar feature aprovada. Fora dele, cada comando executa uma etapa e para.
- Para continuar ou retomar, use `/ldk-next`.

## Pendencias [VERIFY]
-

## Comandos LDK

- `ldk-intake`: discovery, confirmacao e contexto inicial.
- `ldk-next`: proximo passo seguro.
- `ldk-roadmap`: ordem por dependencia apos discovery aprovado.
- `ldk-plan`: plano de uma feature.
- `ldk-build`: execucao e proof da feature aprovada.
- `ldk-build-task`: uma task especifica.
- `ldk-proof`: prova isolada quando tasks essenciais terminaram.
- `ldk-review`: revisao de diff, risco e evidencia.
- `ldk-doctor`: diagnostico/reconciliacao de drift.
- `ldk-release`: gate antes de publicar.
