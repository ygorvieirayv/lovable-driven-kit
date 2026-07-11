---
name: ldk-plan
description: Use when planning one feature after approved LDK discovery and a current roadmap when dependencies exist. Defines scope, AC, applicable concerns, risk, one proof level, tasks, optional tasks, and execution mode. Not for implementation.
---

# ldk-plan

LDK Version: 0.2.2
LDK Schema: 2

Use esta skill para planejar uma feature antes de construir.

Discovery aprovado e obrigatorio antes de roadmap, plan e build.

## Gate

Leia `ldk/discovery.md`, project, ledger e roadmap quando existir.

- Discovery ausente/nao aprovado: pare e recomende `ldk-intake`.
- Roadmap `stale` ou revision divergente: pare e recomende `ldk-roadmap`.
- Feature `blocked`/`verify`: nao planeje sem decisao consciente.
- Version/schema divergente: recomende `ldk-doctor`.

## Objetivo

Criar/atualizar:

- `ldk/features/<feature>/brief.md`;
- `ldk/features/<feature>/plan.md`;
- linha da feature no ledger.

Planeje uma feature por vez e grave a revision aprovada em brief/plan.

## Regras

- ACs binarios e observaveis.
- Escopo deriva do discovery/roadmap; exemplo nao vira requisito.
- Faca concern scan dirigido para a feature e registre somente o aplicavel.
- Nao escolha plataforma, provedor ou integracao sem decisao explicita do usuario.
- Decisao aberta que muda escopo, dado, acesso, dependencia ou prova fica `[VERIFY]` e bloqueia aprovacao.
- Defina risco e um unico proof requerido antes de construir.
- Cada task aponta AC, arquivos esperados, verificacao e State.
- Todas as tasks sao essenciais, salvo IDs em `Optional tasks:`.
- Nao liste motor LDK como alvo de task de produto.
- Confirme o plano antes de `Status: approved`.
- Aprovacao salva/aprova o plano; nunca inicia build nesta skill.
- Aplique contracts/always-rules e common-lessons, se disponiveis.
- Se houver trabalho concorrente/assincrono com efeito externo, planeje ownership duravel, revalidacao antes do
  efeito e liberacao condicional.
- Se houver cota/contador compartilhado, planeje reserva atomica e compensacao; nao use check-then-act separado.
- Entrada privilegiada, worker ou agendamento exige autenticacao de servidor; chave publica/publicavel nao basta.
- Quando a entrega depender de publicacao, separe e prove os estados sincronizado, aplicado e publicado.

Tabela obrigatoria:

```md
| ID | Descricao | AC | Arquivos esperados | Verificacao | State |
|----|-----------|----|--------------------|-------------|-------|
| T1 | <task> | AC1 | `src/...` | <check> | ready |
```

## Risco e prova

- `trivial`: mudanca pequena/reversivel, sem comportamento sensivel -> P1.
- `baixo`: comportamento isolado, baixo impacto -> escolha P1 ou P2.
- `medio`: jornada/regra/integracao com impacto moderado -> escolha P2 ou P3.
- `alto`: acesso, dado sensivel, transacao real, operacao irreversivel ou dependencia critica -> P4.

Nao grave intervalo. Escolha um nivel conforme o AC mais forte e explique.

## Cerimonia proporcional

- trivial: brief/plano minimo, um AC e uma task; ainda exige aprovacao antes do build.
- baixo: plano curto, poucas tasks e prova objetiva.
- medio: plano completo, tasks pequenas, concern scan, rollback e estrategia de prova.
- alto: plano completo, execucao guiada, seguranca/rollback e P4.

## Autonomia

Registre modo recomendado sem executar:

- `guided`/`ldk-build-task`: risco alto, checkpoint pedido ou decisao sensivel.
- `balanced`/`ldk-build`: default para feature aprovada e segura.
- `autopilot`/`ldk-build`: pode fechar a feature aprovada, nunca iniciar outra.

O Project Knowledge define o modo do projeto; risco pode reduzir autonomia, nunca ampliar.

## Audit log opcional

Se `Audit log: on`, registre revision, escopo, AC, concerns, risco/prova, tasks, aprovacao e proximo passo. Evidencia
continua vazia no ledger. Se `off`/ausente, nao crie log.

## Saida

```md
## LDK Plan

Feature:
Discovery revision:
Risk:
Proof required:
Applicable concerns:
- ...

Acceptance criteria:
- AC1:

Tasks:
| ID | Descricao | AC | Arquivos esperados | Verificacao | State |
|----|-----------|----|--------------------|-------------|-------|
| T1 | | AC1 | `src/...` | <check> | ready |

Optional tasks: none | T...
Autonomy/execution mode:
Roadmap/dependencies:
Status no ledger:
Etapa concluida: plano pronto/aprovado e aguardando proximo comando.
```

Nao implemente nada nesta skill, mesmo se o usuario disser "pode continuar".
