# Lovable Driven Kit (LDK) - Workspace Knowledge

Voce trabalha com o Lovable Driven Kit.

Regra central: sem prova, nao e done.

Use estes nomes para os comandos/skills:

- `ldk-intake`
- `ldk-next`
- `ldk-roadmap`
- `ldk-plan`
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
3. Implemente uma task por vez.
4. Ao terminar uma task, deixe `proof-pending`; nao execute `ldk-proof` no mesmo comando.
5. Use `DONE` apenas quando houver evidencia suficiente.
6. Se a prova minima nao foi atingida, use `PARTIAL` ou `BLOCKED`.
7. Nunca invente verificacao.

## Fronteira de comando

Execute apenas a skill/comando invocado pelo usuario.

- `ldk-intake` faz intake e para.
- `ldk-roadmap` faz roadmap e para.
- `ldk-plan` faz plano/aprovacao do plano e para.
- `ldk-build-task` implementa uma task e para em `proof-pending`.
- `ldk-proof` prova/bloqueia e para.
- `ldk-review` revisa e para.

Nao encadeie para a proxima skill na mesma resposta, mesmo que o usuario diga "pode continuar". Essa aprovacao
vale apenas para concluir a etapa atual. Ao final, diga que a etapa esta pronta e aguardando o proximo comando.
Se o usuario nao souber o que fazer, ele deve usar `/ldk-next`.

Regras "Sempre":

- Nunca marque `DONE` sem evidencia suficiente.
- Nunca invente preview, teste, console, diff ou CI.
- Nunca coloque segredo em codigo, bundle, log, screenshot ou dado de exemplo.
- Nunca registre PII desnecessaria em logs, analytics, console ou mensagens de erro.
- Auth, permissoes/admin, pagamento real, PII, Supabase RLS, delecao e migracao nunca sao `trivial`.
- Nunca escolha plataforma, provedor ou integracao sem pedido explicito do usuario. Shopify, Stripe, Mercado Pago,
  Supabase, ERP, frete real e gateways devem ficar como `[VERIFY]` ou fora de escopo.
- Se nao puder verificar algo essencial, use `PARTIAL` ou `BLOCKED`.

Use cerimonia proporcional:

- trivial: AC curto, uma mudanca pequena, prova P1 e proof curto.
- baixo: plano curto, uma ou poucas tasks, prova P1/P2.
- medio: plano completo, tasks pequenas, prova P2/P3.
- alto: plano completo, risco explicito, prova P4 e revisao antes de release.

Nao force fluxo pesado para copy, cor, padding ou ajuste visual pequeno. Tambem nao simplifique auth,
pagamento, PII, Supabase rules, migracao ou delecao.

Para loja/e-commerce vaga, o default seguro e vitrine/catalogo/carrinho local/checkout fake. Pagamento real,
checkout real, Shopify, gateway, frete real, auth real e Supabase nao entram no MVP sem pedido explicito.

Se nao abriu preview, diga que nao abriu.
Se nao checou console/logs, diga que nao checou.
Se nao rodou teste, diga que nao rodou.
Se nao viu diff no GitHub, diga que nao viu.

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

Para alto risco, como auth, permissoes, dados pessoais, pagamento real, delecao, migracao ou Supabase
policies/RLS, o Lovable pode implementar, mas `DONE` exige prova forte. Se a prova nao existir, marque
`PARTIAL` ou `BLOCKED` e explique o proximo passo seguro.

## Fronteira do kit

Nao altere o motor do LDK como efeito colateral de uma task do app. Isso inclui Knowledge, Skills,
templates, scripts, workflows e regras do kit. Se um diff de produto tocar o motor do LDK, trate como drift
critico, nao marque `DONE` e rode `ldk-doctor`.

## Saida obrigatoria ao fim de task

Toda resposta final apos uma task deve conter:

1. O que mudou
2. Arquivos alterados
3. AC cobertos
4. Prova executada
5. Status: DONE/PARTIAL/BLOCKED
6. Etapa concluida e aguardando proximo comando
