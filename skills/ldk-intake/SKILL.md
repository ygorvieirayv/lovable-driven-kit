---
name: ldk-intake
description: Use when starting, continuing, externally reviewing, or reconciling the mandatory LDK project discovery before roadmap or implementation. Extracts purpose, users, journey, success, relevant concerns, scope, and an approved portable understanding. Not for roadmap or app implementation.
---

# ldk-intake

LDK Version: 0.2.2
LDK Schema: 2

Use esta skill como porta obrigatoria de curadoria inicial do Lovable Driven Kit.

Discovery aprovado e obrigatorio antes de roadmap, plan e build.

## Objetivo

Criar, continuar, revisar ou aprovar:

- `ldk/discovery.md`;
- `ldk/project.md`, depois da aprovacao;
- `ldk/ledger.md` inicial, depois da aprovacao;
- pendencias `[VERIFY]`;
- pacote portatil para revisao externa, quando pedido.

Execute somente intake. Nao gere `ldk/roadmap.md`, nao planeje feature e nao edite o app.

## Regras de conversa

- Uma pergunta por vez; no maximo duas quando forem inseparaveis.
- Explique em uma frase por que a resposta muda o projeto.
- Leia primeiro o pedido, Project Knowledge e app atual, quando houver; nao repita pergunta ja respondida.
- Se o usuario disser "nao sei", proponha default reversivel e explique a consequencia.
- Pergunte somente se a resposta mudar finalidade, escopo, jornada, risco, arquitetura, prova ou prioridade.
- Nao transforme exemplo do usuario em requisito sem confirmacao.
- Nao invente regra de negocio, obrigacao, capacidade, compliance ou permissao.
- Nao escolha plataforma, provedor ou integracao sem decisao explicita do usuario.
- Impacto pequeno pode usar pressuposto reversivel; impacto relevante fica `[VERIFY]`.
- Confirme antes de aprovar/gravar entendimento estrutural.
- Aplique `contracts/discovery-gate.md` e `contracts/always-rules.md`, se disponiveis.
- Conversa aprova, arquivo registra.

## Fase 1 - Extracao

Extraia do material existente sem desenhar solucao antecipada:

- finalidade e motivacao;
- problema, oportunidade ou situacao atual;
- usuarios e outros atores;
- resultado esperado e como sera observado;
- jornada principal;
- capacidades mencionadas;
- restricoes e decisoes ja tomadas;
- essencial, depois e fora de escopo;
- pressupostos e duvidas.

Para projeto existente, leia o app sem alterar UI, logica, rotas, dados ou integracoes. Diferencie comportamento
observado, alegacao do usuario e melhoria desejada.

## Fase 2 - Concern Scan

Faca uma varredura interna ampla por finalidade, atores, jornada, dados, acesso, execucao, dependencias, exposicao,
descoberta, mensuracao, desempenho, acessibilidade, operacao e release.

Registre somente preocupacoes acionadas por sinais deste projeto:

- `applicable`: influencia roadmap, plan ou proof;
- `not-applicable`: descartada por sinal concreto;
- `later`: valida, mas fora do recorte;
- `verify`: falta resposta que muda decisao.

Nao mostre uma checklist inteira. Na conversa, resuma:

- entendimento;
- sinais relevantes;
- preocupacoes priorizadas;
- descartes confiaveis;
- duvida que precisa ser respondida agora.

## Fase 3 - Discovery draft

Crie/atualize `ldk/discovery.md` usando `templates/discovery.md`.

Enquanto houver descoberta ou reconciliacao:

```md
Status: draft | external-review | awaiting-approval
```

O `Resumo do entendimento` deve ser autocontido: outra pessoa ou IA consegue revisar sem historico do chat.

## Fase 4 - Revisao externa opcional

Se o usuario quiser confrontar a ideia com outra IA:

1. preencha `External review packet` com o resumo atual;
2. grave `Status: external-review`;
3. entregue o bloco copiavel;
4. pare sem aprovar e sem gerar roadmap.

Quando o usuario colar sugestoes externas:

- classifique `accept`, `defer`, `reject` ou `verify`;
- avalie alinhamento, impacto e novo escopo;
- recomende, mas a decisao final e do usuario;
- preencha a tabela de reconciliacao;
- incremente `Revision` se o entendimento mudar;
- use `Status: awaiting-approval`;
- apresente novamente o resumo completo.

## Fase 5 - Aprovacao

Pergunte explicitamente se o entendimento representa o projeto desejado. Aprovacao exige que finalidade, usuario,
resultado, jornada, recorte e preocupacoes estruturais estejam claros. `[VERIFY]` nao bloqueante pode permanecer;
duvida que muda o MVP bloqueia.

Depois do "sim" do usuario:

1. grave `Status: approved`, `Approved at` e `Approved by`;
2. atualize `ldk/project.md` com a mesma versao, schema, revisao e `Autonomy mode`;
3. crie/atualize ledger inicial com features candidatas em `idea`;
4. nao crie roadmap;
5. recomende `ldk-roadmap` quando houver varias features/dependencias, ou `ldk-plan` quando houver uma unica feature
   independente;
6. pare.

## Reabertura e invalidacao

Se finalidade, usuario, jornada, resultado, recorte ou preocupacao estrutural mudar depois:

- incremente `Revision`;
- grave `Status: awaiting-approval`;
- se roadmap existir, grave `Status: stale`;
- nao altere silenciosamente planos existentes;
- exija nova confirmacao antes de retomar roadmap/plan/build.

Mudanca apenas editorial nao invalida.

## Arquivos

Se `ldk/` nao existir, crie apenas o necessario:

```txt
ldk/
  discovery.md
  project.md          # depois da aprovacao
  ledger.md           # depois da aprovacao
  decisions/
  features/
  issues/
  releases/
```

Use `templates/discovery.md`, `templates/project.md` e `templates/task-ledger.md`. Ledger mantem exatamente:

```md
| ID | Feature | Risk | State | Proof required | Last evidence |
|----|---------|------|-------|----------------|---------------|
| F1 | <feature> | baixo | idea | P2 | |
```

ID e `F1`, `F2`; prova e um unico P1/P2/P3/P4; evidencia fica vazia em `idea`.

## Audit log opcional

Se `Audit log: on`, registre intake/reconciliacao/aprovacao com revision, decisoes, arquivos e proximo passo. Crie o
log quando necessario, sem backfill automatico. Se estiver `off`/ausente, nao crie nem mencione.

## Saida final

Durante descoberta:

```md
## LDK Intake

Resumo do raciocinio:
- ...

Entendimento atual:
- ...

Pergunta que muda o projeto:
- ...

Status: draft | external-review | awaiting-approval
```

Depois da aprovacao, inclua produto entendido, preocupacoes relevantes, recorte, arquivos, `[VERIFY]`, revision e:

```txt
Etapa concluida: discovery aprovado e aguardando proximo comando.
```

Nao implemente nem gere roadmap nesta skill.
