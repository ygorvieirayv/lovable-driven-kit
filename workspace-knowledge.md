# Lovable Driven Kit (LDK) - Workspace Knowledge

Voce trabalha com o Lovable Driven Kit.

Regra central: sem prova, nao e done.

Comandos/skills:

- `ldk-intake`
- `ldk-next`
- `ldk-roadmap`
- `ldk-plan`
- `ldk-build`
- `ldk-build-task`
- `ldk-proof`
- `ldk-review`
- `ldk-doctor`
- `ldk-release`

## Regras centrais

O usuario nao precisa codar. O Lovable implementa; o LDK guia escopo, risco, tarefas e prova.

- Antes de mudancas relevantes, defina escopo, risco, criterios de aceite e prova minima.
- Use `ldk-build` para feature aprovada e segura; ele pode executar tasks planejadas, provar e fechar status.
- Use `ldk-build-task` apenas para task especifica, checkpoint manual, risco alto ou pedido explicito.
- Use `DONE` somente com evidencia suficiente.
- Se a prova minima nao foi atingida, use `PARTIAL` ou `BLOCKED`.
- Nunca invente preview, teste, console, diff, CI ou verificacao.

## Fronteira de comando

Execute apenas a skill/comando invocado pelo usuario.

- `ldk-intake`: intake e para.
- `ldk-roadmap`: ordena features e para.
- `ldk-plan`: planeja/aprova plano e para.
- `ldk-build`: executa a feature aprovada, registra tasks, prova e para.
- `ldk-build-task`: implementa uma task e para em `proof-pending`.
- `ldk-proof`: prova/bloqueia e para.
- `ldk-review`: revisa e para.
- `ldk-doctor`: diagnostica/corrige drift autorizado e para.

Nao encadeie a proxima skill na mesma resposta. A aprovacao do usuario vale para a etapa atual. Excecao:
em `ldk-build`, build e proof fazem parte da mesma etapa. Ao final, diga que a etapa esta pronta e aguardando o
proximo comando. Se o usuario nao souber o que fazer, recomende `/ldk-next`.

## Regras sempre aplicaveis

- Sem `DONE` sem evidencia.
- Sem segredo em codigo, bundle, log, screenshot ou dado de exemplo.
- Sem PII desnecessaria em logs, analytics, console ou erro.
- Auth, permissoes/admin, pagamento real, PII, Supabase RLS, delecao e migracao nunca sao `trivial`.
- Nunca escolha plataforma, provedor ou integracao sem pedido explicito do usuario.
- Shopify, Stripe, Mercado Pago, Supabase, ERP, frete real e gateways ficam como `[VERIFY]` ou fora de escopo.
- Para e-commerce vago, o default seguro e vitrine, catalogo, carrinho local e checkout fake.
- Pagamento real, checkout real, auth real, frete real e backend real entram depois de decisao explicita.
- Se nao abriu preview, diga que nao abriu.
- Se nao checou console/logs, diga que nao checou.
- Se nao rodou teste, diga que nao rodou.
- Se nao viu diff no GitHub, diga que nao viu.

Use cerimonia proporcional:

- `trivial`: AC curto, mudanca pequena, prova P1.
- `baixo`: plano curto, `ldk-build`, prova P1/P2.
- `medio`: plano completo; `ldk-build` se nao houver decisao critica aberta.
- `alto`: plano explicito, prova P4 e revisao antes de release.

Antes de `ldk-build` editar o app, faca pre-flight:

- veredito otimista: por que parece seguro executar;
- veredito pessimista: o que pode dar errado ou virar falso `DONE`;
- decisao antes de executar: seguir, pausar ou bloquear.

Se o pessimismo achar ajuste simples dentro do escopo, corrija no build. Se achar decisao aberta, risco alto,
escopo novo ou prova impossivel, pare antes de editar.

## Mudancas externas e projetos existentes

O LDK pode entrar em projeto ja iniciado. Rollback, sync, outra skill, prompt direto ou edicao manual nao sao erro
automaticamente.

Ao rodar `ldk-next`, `ldk-doctor` ou `ldk-proof`, compare o app atual somente com a feature/task LDK ativa e seus
arquivos/AC esperados. Nao trate codigo antigo, telas existentes ou arquivos fora desse escopo como drift.

Classifique mudancas externas:

- dentro da task ativa: registre como implementacao;
- muda escopo/decisao visual da task ativa: reconcilie plano com `ldk-doctor` antes de proof;
- cria nova feature: registre no ledger/roadmap antes de construir mais;
- remove/contradiz task `proof-pending` ou `done`: rode `ldk-doctor`;
- toca motor do LDK: drift critico de motor.

Nao reverta nem sobrescreva mudanca externa sem aprovacao explicita. Nao use proof antigo sem revalidar.

## Audit log opcional

O audit log vem desligado. O Project Knowledge padrao deve ficar:

```md
- Audit log: off
```

So crie/atualize `ldk/audit/log.md` se o usuario trocar explicitamente para:

```md
- Audit log: on
```

Se estiver `off` ou ausente, nao crie log e nao mencione auditoria no fluxo normal.

Quando estiver `on`, ao fim de comandos LDK que alteram estado ou arquivos, adicione entrada compacta.
Se `ldk/audit/log.md` nao existir, crie o arquivo antes da entrada com titulo e nota curta:

```md
# LDK Audit Log - <projeto>

Registro compacto iniciado quando `Audit log: on` foi habilitado. Historico anterior nao foi reconstruido.
```

Nao faca backfill automatico. Se o usuario pedir backfill, marque claramente como `BACKFILL reconstruido` e trate
como resumo inferido de ledger/proofs, nao como log original.

```md
## <data/hora> - <comando> - <feature/projeto>
- Command: <ldk-command>
- User intent: <resumo curto>
- State before: <estado anterior>
- Actions: <decisoes/criacoes/alteracoes>
- Files changed: <paths ou none>
- Evidence: preview yes/no/na; manual yes/no/na; tests pass/fail/not run/na; console yes/no/na; diff yes/no/na
- Decision: DONE | PARTIAL | BLOCKED | planned | approved | roadmap-updated | diagnosis-only | other
- Known limitations: <limitacoes ou none>
- Next: <proximo passo seguro>
```

Nao registre segredos, tokens, chaves, dados pessoais ou prompt completo sensivel. Skills read-only como
`ldk-next` e `ldk-review` nao escrevem audit log, salvo pedido explicito.

## Artefatos do projeto

O Lovable cria e mantem os artefatos; o usuario nao deve criar arquivos manualmente.

```txt
ldk/
  project.md
  ledger.md
  roadmap.md
  decisions/
  features/<feature>/brief.md
  features/<feature>/plan.md
  features/<feature>/proof.md
  issues/
  releases/
  audit/ (opcional)
```

`ldk/project.md`, `ldk/ledger.md`, `ldk/roadmap.md`, plans, proofs e decisions sao fonte da verdade do fluxo.
Conversa aprova, arquivo registra. Se `ldk/` nao existir quando uma skill LDK for usada, crie a estrutura necessaria.

## Artefatos machine-readable

Alguns headers e vocabularios sao contrato. Nao traduza, renomeie ou mude ordem.

Ledger:

```md
| ID | Feature | Risk | State | Proof required | Last evidence |
|----|---------|------|-------|----------------|---------------|
| F1 | <feature> | baixo | idea | P2 | |
```

- `ID` deve ser somente `F1`, `F2`, etc.
- O nome fica em `Feature`, nao junto do ID.
- `Proof required` deve ser unico: `P1`, `P2`, `P3` ou `P4`.
- Nao use headers traduzidos como `Estado`, `Risco`, `Prova minima`.
- `Last evidence` fica vazio em `idea`, `planned`, `approved`, `building` e `proof-pending`.
- `Last evidence` nunca aponta para `plan.md` ou `brief.md`.
- `Last evidence` aponta para proof/report apenas em `done`, `partial` ou `blocked`.

Plano de feature: a tabela de tasks e obrigatoria.

```md
| ID | Descricao | AC | Arquivos esperados | Verificacao | State |
|----|-----------|----|--------------------|-------------|-------|
| T1 | <task> | AC1 | `src/...` | <preview/teste> | ready |
```

`Arquivos` nao e valido; o header correto e `Arquivos esperados`.

Estados de task: `backlog`, `ready`, `in-progress`, `proof-pending`, `done`, `blocked`.

Estados de feature:

```txt
idea
planned
approved
building
proof-pending
done
partial
blocked
reopened
```

## Risco e prova

Risco:

- `trivial`: copy, cor, padding, ajuste visual pequeno.
- `baixo`: secao simples, componente estatico, comportamento isolado.
- `medio`: CRUD, formulario, filtro, dashboard, admin simples.
- `alto`: auth, permissao, dados pessoais, pagamento, Supabase rules, migracao, delecao.

Na duvida, suba um nivel.

Prova:

- P1: visual, screenshot ou observacao precisa do preview.
- P2: fluxo manual com passos e resultado observado.
- P3: teste automatizado ou script reproduzivel.
- P4: CI/release, GitHub diff e checklist de seguranca.

`ldk-proof` so fecha feature quando todas as tasks essenciais estiverem `proof-pending` ou `done`, salvo checkpoint
parcial pedido pelo usuario. Checkpoint parcial nao pode virar `DONE`.

`ldk-build` tambem pode escrever o proof da feature se executou/validou as tasks essenciais e atingiu a prova minima.

Para alto risco, o Lovable pode implementar, mas `DONE` exige prova forte. Sem prova, use `PARTIAL` ou `BLOCKED`.

## Roadmap

Use `ldk-roadmap` quando houver varias features, dependencias ou duvida sobre a ordem.
`ldk-next` deve consultar `ldk/roadmap.md`; se ausente ou desatualizado, recomende `ldk-roadmap`.

Readiness no roadmap:

```txt
ready
blocked
later
done
verify
```

## Fronteira do kit

Nao altere o motor do LDK como efeito colateral de task do app: Knowledge, Skills, templates, scripts, workflows
e regras do kit. Se diff de produto tocar o motor do LDK, trate como drift critico, nao marque `DONE` e rode
`ldk-doctor`.

## Saida obrigatoria apos build/proof

Toda resposta final apos build/proof deve conter:

1. O que mudou
2. Arquivos alterados
3. AC cobertos
4. Prova executada
5. Veredito otimista
6. Veredito pessimista
7. Status: DONE/PARTIAL/BLOCKED
8. Etapa concluida e aguardando proximo comando
