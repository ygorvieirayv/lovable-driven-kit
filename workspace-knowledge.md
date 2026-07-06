# Lovable Driven Kit (LDK) - Workspace Knowledge

Voce trabalha com o Lovable Driven Kit.

Regra central: sem prova, nao e done.

Use estes nomes para os comandos/skills:

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

## Regras sempre aplicaveis

O usuario nao precisa codar. O Lovable implementa. O papel do LDK e guiar escopo, risco, tarefas e prova,
para que o usuario acompanhe e aprove com evidencia.

1. Antes de construir mudancas relevantes, use Plan mode.
2. Defina escopo, risco, criterios de aceite e prova minima.
3. Para feature aprovada e segura, use `ldk-build` para executar as tasks planejadas em sequencia e provar a feature.
4. Use `ldk-build-task` apenas quando quiser uma task especifica, checkpoint manual ou risco alto.
5. Use `DONE` apenas quando houver evidencia suficiente.
6. Se a prova minima nao foi atingida, use `PARTIAL` ou `BLOCKED`.
7. Nunca invente verificacao.

## Fronteira de comando

Execute apenas a skill/comando invocado pelo usuario.

- `ldk-intake` faz intake e para.
- `ldk-roadmap` faz roadmap e para.
- `ldk-plan` faz plano/aprovacao do plano e para.
- `ldk-build` executa a feature aprovada, registra tasks, prova e para.
- `ldk-build-task` implementa uma task especifica e para em `proof-pending`.
- `ldk-proof` prova/bloqueia e para.
- `ldk-review` revisa e para.

`ldk-build` pode executar varias tasks da mesma feature aprovada porque esse e o escopo dele. `ldk-build-task`
continua sendo manual e executa uma task por vez.

Nao encadeie para a proxima skill na mesma resposta, mesmo que o usuario diga "pode continuar". Essa aprovacao
vale apenas para concluir a etapa atual. Excecao: dentro de `ldk-build`, build e proof fazem parte da mesma etapa.
Ao final, diga que a etapa esta pronta e aguardando o proximo comando. Se o usuario nao souber o que fazer, ele
deve usar `/ldk-next`.

Regras "Sempre":

- Nunca marque `DONE` sem evidencia suficiente.
- Nunca invente preview, teste, console, diff ou CI.
- Nunca coloque segredo em codigo, bundle, log, screenshot ou dado de exemplo.
- Nunca registre PII desnecessaria em logs, analytics, console ou mensagens de erro.
- Auth, permissoes/admin, pagamento real, PII, Supabase RLS, delecao e migracao nunca sao `trivial`.
- Nunca escolha plataforma, provedor ou integracao sem pedido explicito do usuario. Shopify, Stripe, Mercado Pago,
  Supabase, ERP, frete real e gateways devem ficar como `[VERIFY]` ou fora de escopo.
- Mudancas externas ao fluxo LDK, como rollback, sync, outra skill ou prompt solto, nao sao erro por si so.
- Em projeto ja iniciado, nao trate codigo preexistente fora da feature/task LDK ativa como drift.
- Se o codigo atual contradiz uma task LDK ja `proof-pending`/`done`, use `ldk-doctor` antes de proof.
- Nao rode `ldk-proof` final enquanto houver task essencial `ready`, `backlog` ou `in-progress`.
- Se nao puder verificar algo essencial, use `PARTIAL` ou `BLOCKED`.

Use cerimonia proporcional:

- trivial: AC curto, uma mudanca pequena, `ldk-build` leve e prova P1.
- baixo: plano curto, `ldk-build` executa a feature aprovada e prova P1/P2.
- medio: plano completo; `ldk-build` pode seguir se nao houver decisao aberta, dado sensivel ou integracao critica.
- alto: plano completo, risco explicito, prova P4 e revisao antes de release.

Nao force fluxo pesado para copy, cor, padding ou ajuste visual pequeno. Tambem nao simplifique auth,
pagamento, PII, Supabase rules, migracao ou delecao.

Antes de `ldk-build` editar o app, ele deve fazer um pre-flight:

- veredito otimista: por que a execucao parece segura;
- veredito pessimista: o que pode dar errado ou virar falso `DONE`;
- decisao antes de executar: seguir, pausar ou bloquear.

Se o veredito pessimista achar problema simples dentro do escopo, corrija durante o build. Se achar decisao aberta,
risco alto, escopo novo ou prova impossivel, pare antes de editar.

Para loja/e-commerce vaga, o default seguro e vitrine/catalogo/carrinho local/checkout fake. Pagamento real,
checkout real, Shopify, gateway, frete real, auth real e Supabase nao entram no MVP sem pedido explicito.

Se nao abriu preview, diga que nao abriu.
Se nao checou console/logs, diga que nao checou.
Se nao rodou teste, diga que nao rodou.
Se nao viu diff no GitHub, diga que nao viu.

## Mudancas externas e projetos existentes

O LDK pode ser instalado em um projeto ja iniciado, ou o usuario pode alterar o app fora do fluxo LDK usando
rollback, sync, outra skill, edicao manual ou prompt direto. Isso nao e erro automaticamente.

Ao rodar `ldk-next`, `ldk-doctor` ou `ldk-proof`, compare o app atual apenas com a feature/task LDK ativa e seus
arquivos/AC esperados. Nao trate codigo antigo, telas existentes ou arquivos fora desse escopo como drift.

Classifique mudancas externas com cautela:

- dentro da task ativa: registre como implementacao da task;
- amplia ou muda escopo/decisao visual da task ativa: reconcilie plano com `ldk-doctor` antes de proof;
- cria uma nova feature: registre no ledger/roadmap antes de construir mais;
- remove ou contradiz uma task `proof-pending`/`done`: trate como possivel rollback/drift e rode `ldk-doctor`;
- toca motor do LDK: trate como drift critico de motor.

Nao reverta nem sobrescreva mudanca externa sem aprovacao explicita do usuario. Nao use proof antigo sem
revalidar o preview/codigo atual.

## Artefatos do projeto

O Lovable deve criar e manter automaticamente os artefatos do LDK. O usuario nao deve precisar criar esses
arquivos manualmente.

O estado do produto fica em:

```txt
ldk/
  project.md
  ledger.md
  roadmap.md
  decisions/
  features/
    <feature>/
      brief.md
      plan.md
      proof.md
  issues/
  releases/
```

Trate `ldk/project.md`, `ldk/ledger.md`, `ldk/roadmap.md`, feature plans, proofs e decisions como fonte da verdade do fluxo.
Conversa aprova, arquivo registra.

Se `ldk/` nao existir quando uma skill LDK for usada, crie a estrutura necessaria para aquela etapa.

## Artefatos machine-readable

Alguns artefatos sao contrato, nao prosa. Nao traduza headers, marcadores ou vocabularios.

Para `ldk/ledger.md`, use exatamente:

```md
| ID | Feature | Risk | State | Proof required | Last evidence |
|----|---------|------|-------|----------------|---------------|
| F1 | <feature> | baixo | idea | P2 | |
```

- `ID` deve ser somente `F1`, `F2`, etc.
- O nome fica em `Feature`, nao junto do ID.
- `Proof required` deve ser um unico valor: `P1`, `P2`, `P3` ou `P4`.
- Nao use headers traduzidos como `Estado`, `Risco`, `Prova minima`.
- `Last evidence` fica vazio em `idea`, `planned`, `approved`, `building` e `proof-pending`.
- `Last evidence` nunca aponta para `plan.md` ou `brief.md`; plano nao e prova.
- `Last evidence` aponta para proof/report apenas quando houver `done`, `partial` ou `blocked`.

Para `ldk/features/<feature>/plan.md`, a tabela de tasks e obrigatoria. Nao use apenas bullets.

```md
| ID | Descricao | AC | Arquivos esperados | Verificacao | State |
|----|-----------|----|--------------------|-------------|-------|
| T1 | <task> | AC1 | `src/...` | <preview/teste> | ready |
```

Estados de task permitidos: `backlog`, `ready`, `in-progress`, `proof-pending`, `done`, `blocked`.

## Estados permitidos

Use apenas:

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

## Risco

- trivial: copy, cor, padding, ajuste visual pequeno.
- baixo: secao simples, componente estatico, comportamento isolado.
- medio: CRUD, formulario, filtro, dashboard, admin simples.
- alto: auth, permissao, dados pessoais, pagamento, Supabase rules, migracao, delecao.

Na duvida, suba um nivel.

## Roadmap

Use `ldk-roadmap` quando houver varias features, dependencias ou duvida sobre o que construir primeiro.
`ldk-next` deve consultar `ldk/roadmap.md`; se ele estiver ausente ou desatualizado, recomende `ldk-roadmap`.
Ao planejar ou revisar, consulte `contracts/common-lessons.md` se estiver disponivel. Essas licoes sao internas
do kit e nao exigem manutencao do usuario.

Readiness permitido no roadmap:

```txt
ready
blocked
later
done
verify
```

## Prova

- P1: visual, screenshot ou observacao precisa do preview.
- P2: fluxo manual com passos executados e resultado observado.
- P3: teste automatizado ou script reproduzivel com resultado.
- P4: CI/release, GitHub diff, checklist de seguranca.

`ldk-proof` fecha a feature/entrega planejada. So recomende `ldk-proof` quando todas as tasks essenciais estiverem
`proof-pending` ou `done`, ou quando o usuario pedir conscientemente um checkpoint parcial. Checkpoint parcial nao
pode marcar a feature como `DONE`.

`ldk-build` tambem pode escrever o proof da feature, desde que ele tenha executado ou validado as tasks essenciais
e consiga atingir a prova minima. Isso nao exige um comando separado de `ldk-proof`.

Para alto risco, como auth, permissoes, dados pessoais, pagamento real, delecao, migracao ou Supabase
policies/RLS, o Lovable pode implementar, mas `DONE` exige prova forte. Se a prova nao existir, marque
`PARTIAL` ou `BLOCKED` e explique o proximo passo seguro.

## Fronteira do kit

Nao altere o motor do LDK como efeito colateral de uma task do app. Isso inclui Knowledge, Skills,
templates, scripts, workflows e regras do kit. Se um diff de produto tocar o motor do LDK, trate como drift
critico, nao marque `DONE` e rode `ldk-doctor`.

## Saida obrigatoria ao fim de build/proof

Toda resposta final apos build/proof deve conter:

1. O que mudou
2. Arquivos alterados
3. AC cobertos
4. Prova executada
5. Veredito otimista
6. Veredito pessimista
7. Status: DONE/PARTIAL/BLOCKED
8. Etapa concluida e aguardando proximo comando
