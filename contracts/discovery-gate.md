# LDK Discovery Gate

Este contrato define a curadoria obrigatoria da ideia antes de roadmap, plan ou build.

Regra central:

> Discovery aprovado e obrigatorio antes de roadmap, plan e build.

## Finalidade

O LDK nao parte de um tipo de app nem de uma checklist fixa. Ele descobre a finalidade, os usuarios, a jornada,
o resultado esperado e as preocupacoes acionadas pelos sinais deste projeto.

O discovery deve impedir que exemplos, plataformas, provedores ou arquiteturas sejam tratados como requisitos sem
evidencia no pedido, no app existente ou em decisao explicita do usuario.

## Estado

Arquivo: `ldk/discovery.md`.

Marcadores obrigatorios:

```md
LDK Version: <semver>
LDK Schema: <inteiro>
Status: draft | external-review | awaiting-approval | approved
Revision: <inteiro positivo>
Approved at: <data/hora ou vazio>
Approved by: <identificacao do usuario ou vazio>
```

Somente `Status: approved` abre o gate para `ldk-roadmap`, `ldk-plan`, `ldk-build` e `ldk-build-task`.
`ldk-next` e `ldk-doctor` podem rodar antes porque sao read-only. `ldk-intake` cria, continua, reconcilia e aprova
o discovery.

## Perguntas adaptativas

Antes de perguntar:

1. Leia o pedido, o Project Knowledge e o app existente, quando houver.
2. Nao pergunte o que ja pode ser inferido com seguranca.
3. Pergunte somente se a resposta muda finalidade, escopo, jornada, risco, arquitetura, prova ou prioridade.
4. Se o impacto de errar for pequeno, proponha um default reversivel e registre o pressuposto.
5. Se o impacto for relevante, pergunte uma coisa por vez e marque `[VERIFY]` ate a confirmacao.
6. Explique em uma frase por que a resposta importa.

## Concern Scan

Faca uma varredura ampla, mas registre e apresente apenas o que for relevante. Use dimensoes genericas:

- finalidade, atores, jornada e resultado;
- dados, estado, privacidade e acesso;
- execucao imediata, recorrente ou em segundo plano;
- dependencias externas e modos de falha;
- exposicao publica, abuso e confiabilidade;
- descoberta, aquisicao, mensuracao e atribuicao;
- desempenho, acessibilidade e experiencia;
- operacao, observabilidade, manutencao e release.

Para cada preocupacao registrada, use um dos estados:

- `applicable`: precisa influenciar roadmap, plano ou prova;
- `not-applicable`: foi descartada por sinal concreto;
- `later`: e valida, mas esta fora do recorte atual;
- `verify`: falta resposta que muda uma decisao.

Nao despeje todas as dimensoes ao usuario. Mostre um resumo curto do entendimento, os sinais relevantes, o que foi
descartado com confianca e as perguntas que realmente mudam o projeto.

## Confirmacao

Antes da aprovacao, apresente um `Resumo do entendimento` autocontido. O usuario precisa conseguir confirmar se o
LDK entendeu o mesmo produto que ele quer criar.

Ao aprovar:

1. grave `Status: approved`;
2. grave data e aprovador;
3. atualize `ldk/project.md` e o ledger inicial sem gerar roadmap;
4. recomende `ldk-roadmap` quando houver mais de uma feature ou dependencia relevante;
5. pare.

## Revisao externa opcional

Quando o usuario quiser confrontar a ideia com outra IA, gere no proprio discovery um pacote portatil que contenha
o entendimento consolidado, sem depender do historico da conversa nem de detalhes internos do LDK.

Ao receber sugestoes externas:

- classifique cada uma como `accept`, `defer`, `reject` ou `verify`;
- explique impacto em escopo, risco, arquitetura ou prova;
- nao aceite autoridade externa automaticamente;
- recomende, mas deixe a decisao final com o usuario;
- incremente `Revision` quando o entendimento mudar;
- apresente o resumo novamente e exija nova aprovacao.

## Invalidacao

Mudanca de finalidade, usuario, jornada, resultado, recorte ou preocupacao estrutural reabre o discovery:

```md
Status: awaiting-approval
Revision: <anterior + 1>
```

Se `ldk/roadmap.md` existir, marque `Status: stale`. Roadmap e planos com `Discovery revision` diferente da revisao
aprovada nao autorizam build ate reconciliacao.

Mudanca apenas editorial, sem efeito no projeto, nao exige invalidacao.
