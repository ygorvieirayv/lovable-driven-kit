# Lovable Driven Kit (LDK)

Construa apps no Lovable com plano, tarefas pequenas e prova real de conclusão.

Regra central:

> Sem prova, não é done.

O LDK é para quem usa Lovable e quer evitar o problema clássico: a IA diz que "está pronto", mas ninguém
abriu o preview, testou o fluxo, conferiu o diff ou registrou evidência. O kit transforma a conversa em um
processo simples:

1. você descreve o que quer;
2. o Lovable organiza o escopo;
3. ele ordena as features por dependência;
4. ele planeja antes de construir;
5. ele executa a feature aprovada quando for seguro;
6. ele só marca `DONE` quando existe prova suficiente.

Para tarefas pequenas, o LDK deve ser leve. Ajustes de texto, cor, padding ou detalhe visual podem usar um
plano curto e uma prova P1. O rigor aumenta quando o risco aumenta.

Repositório oficial:

```txt
https://github.com/ygorvieirayv/lovable-driven-kit
```

## Para quem é

- Usuários não técnicos que querem criar uma loja, landing page, SaaS simples, dashboard ou app interno no
  Lovable sem aceitar entrega "no olho".
- Devs que usam Lovable como acelerador, mas querem diff, critério de aceite, prova e menos retrabalho.

## E quando tem login, pagamento ou dados?

O LDK não espera que o usuário programe. O Lovable pode implementar login, pagamento, Supabase, RLS e outras
partes técnicas.

O papel do LDK é outro: impedir que algo arriscado seja tratado como pronto sem evidência. Em features de
alto risco, como auth, permissões, dados pessoais, pagamento real ou regras de Supabase, o kit pode pedir
GitHub, CI, revisão ou outro tipo de prova forte antes de aceitar `DONE`.

Isso é intencional. Se a prova ainda não existe, o resultado correto é `PARTIAL` ou `BLOCKED`, com o próximo
passo explicado pelo Lovable. O bloqueio não é uma falha do kit; é a proteção que evita publicar algo sensível
no escuro.

## O que você precisa lembrar

Só dois comandos importam no dia a dia:

```txt
/ldk-intake
/ldk-next
```

Use `/ldk-intake` no começo do projeto.

Use `/ldk-next` sempre que não souber o próximo passo. Ele deve ler o estado salvo e dizer o que fazer.

Cada comando executa uma etapa. A exceção é `/ldk-build`: quando a feature já foi planejada e aprovada, ele pode
executar as tasks planejadas, registrar a prova e devolver `DONE`, `PARTIAL` ou `BLOCKED`. Se você não souber o
próximo comando, use `/ldk-next`.

Os outros comandos aparecem quando o próprio LDK pedir:

```txt
/ldk-roadmap
/ldk-plan
/ldk-build
/ldk-build-task
/ldk-proof
/ldk-review
/ldk-doctor
/ldk-release
```

## Como instalar no Lovable

O Lovable importa **uma skill por vez**. Não use a URL do repo inteiro para instalar o LDK completo. Como o
LDK tem várias skills, importe os links abaixo um por um.

### 1. Abrir Skills

Na tela inicial do Lovable:

1. Clique em **Settings** ou **Configuração**.
2. Abra **Skills**.
3. Clique em **Add**.
4. Escolha **Import from GitHub**.

### 2. Importar cada skill

Copie um link, cole em **Repository URL**, clique em **Import from GitHub** e repita para o próximo.

1. `ldk-intake`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-intake
```

2. `ldk-next`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-next
```

3. `ldk-roadmap`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-roadmap
```

4. `ldk-plan`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-plan
```

5. `ldk-build`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-build
```

6. `ldk-build-task`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-build-task
```

7. `ldk-proof`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-proof
```

8. `ldk-review`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-review
```

9. `ldk-doctor`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-doctor
```

10. `ldk-release`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-release
```

### 3. O que cada skill faz

Uso:

- **manual**: você chama pelo comando quando quiser aquela etapa.
- **auto + manual**: o fluxo do LDK pode recomendar ou encaixar essa etapa, mas você também pode chamar pelo comando.
- **externa**: não é para importar no Lovable.

| Skill | O que faz | Uso |
|---|---|---|
| `ldk-intake` | Começa o projeto: organiza ideia, MVP, riscos, decisões abertas e cria a memória inicial em `ldk/`.<br><br>**Dica:** use quando você acabou de criar o app e quer dizer algo simples como "quero uma loja de cosméticos". | manual |
| `ldk-next` | Lê o estado salvo e diz o próximo passo seguro. Não implementa nada.<br><br>**Dica:** use quando você voltou ao projeto depois de uma pausa ou não sabe qual comando vem agora. | manual |
| `ldk-roadmap` | Ordena as features por dependência e decide o que deve vir primeiro.<br><br>**Dica:** use quando já existem várias ideias, como landing, catálogo, carrinho e checkout, e você quer saber a ordem certa. | auto + manual |
| `ldk-plan` | Planeja uma feature: escopo, critérios de aceite, risco, prova esperada e tasks.<br><br>**Dica:** use antes de construir uma feature nova, por exemplo "planeje o catálogo de produtos". | auto + manual |
| `ldk-build` | Executa uma feature aprovada com menos microcerimônia: pensa antes, implementa, prova e retorna `DONE`, `PARTIAL` ou `BLOCKED`.<br><br>**Dica:** use quando o plano já está aprovado e você quer que o Lovable execute a feature até a prova final. | manual para iniciar; auto dentro da feature |
| `ldk-build-task` | Executa uma task específica quando você quer controle manual, checkpoint ou trabalho de risco maior.<br><br>**Dica:** use quando quiser fazer só uma parte, como "implemente apenas os cards de produto". | manual |
| `ldk-proof` | Registra a prova e decide se a entrega pode ser `DONE`, `PARTIAL` ou `BLOCKED`.<br><br>**Dica:** use quando algo já foi implementado e você quer fechar a etapa com evidência real. | auto + manual |
| `ldk-review` | Revisa uma feature implementada contra plano, prova, diff, riscos e evidências.<br><br>**Dica:** use quando você quer uma checagem crítica antes de seguir para a próxima feature. | manual |
| `ldk-doctor` | Diagnostica e corrige drift quando ledger, plano, proof, app ou GitHub parecem incoerentes.<br><br>**Dica:** use quando o Lovable fez algo fora do plano, houve rollback, ou os arquivos `ldk/` parecem desalinhados. | auto + manual |
| `ldk-release` | Faz checklist antes de publicar ou entregar o app.<br><br>**Dica:** use antes de colocar o projeto no ar ou mandar para cliente/testadores. | manual |
| `ldk-evaluate` | Audita o projeto com outra IA usando logs, ledger, planos, proofs e diff.<br><br>**Dica:** use fora do Lovable, depois de avançar o projeto, para avaliar se o processo LDK foi seguido. | externa |

Não importe `ldk-evaluate` no Lovable. Ela é uma skill externa de auditoria, explicada mais abaixo.

### 4. Adicionar Knowledge

No Lovable:

1. Vá em **Settings** ou **Configuração**.
2. Abra **Knowledge**.
3. Em **Workspace Knowledge**, cole o conteúdo de `workspace-knowledge.md`.
4. No projeto do app, abra **Project settings -> Knowledge**.
5. Cole o conteúdo de `project-knowledge-template.md`.

Você não precisa preencher tudo. O LDK deve perguntar o que faltar e marcar dúvidas com `[VERIFY]`.

## Primeiro uso

Depois de instalar as skills e o Knowledge, crie um projeto novo no Lovable e comece com `/ldk-intake`.

Você não precisa chegar com tudo definido. O LDK existe justamente para ajudar o Lovable a transformar uma
ideia vaga em escopo, riscos, decisões, MVP, plano e próximos passos.

Um prompt mínimo já funciona:

```txt
/ldk-intake

Quero criar uma loja online bonita e moderna.

Use o Lovable Driven Kit.
Me ajude a organizar a ideia, decidir o MVP, identificar riscos e definir o próximo passo seguro.
Não implemente ainda.
```

Se você já souber mais detalhes, pode adiantar. O exemplo abaixo é opcional:

```txt
/ldk-intake

Quero criar uma mini loja moderna, bonita e responsiva.

Escopo do MVP:
- home com visual premium;
- catálogo de produtos;
- cards com imagem, nome, preço e botão;
- carrinho;
- checkout fake, sem pagamento real;
- tela de confirmação de pedido;
- área admin simples para listar pedidos simulados.

Direção visual:
- design limpo, atual e premium;
- responsivo para desktop e mobile;
- boa hierarquia visual;
- cards elegantes;
- cores neutras com um destaque forte.

Por enquanto não quero auth real, pagamento real, Supabase real ou integrações externas.

Use o Lovable Driven Kit.
Organize o projeto, riscos, MVP e próximo passo seguro.
Não implemente ainda.
```

Depois disso, siga o que o LDK recomendar. Se ficar em dúvida ou voltar depois de uma pausa, mande:

```txt
/ldk-next
```

## Fluxo esperado

O usuário não precisa decorar este fluxo. Ele existe para o Lovable seguir:

```txt
ideia
  -> /ldk-intake       organiza produto, riscos e MVP
  -> /ldk-roadmap      ordena features por dependência
  -> /ldk-plan         planeja uma feature
  -> /ldk-build        executa e prova uma feature aprovada
  -> /ldk-review       revisa risco, diff e evidência
  -> /ldk-next         recomenda o próximo passo
```

Comandos de apoio:

- `/ldk-build-task`: constrói uma task específica quando você quiser modo manual ou checkpoint de risco.
- `/ldk-proof`: prova uma feature quando o build já terminou e você quer rodar apenas a prova.
- `/ldk-doctor`: diagnostica quando o projeto parece perdido ou inconsistente.
- `/ldk-release`: checklist antes de publicar.

## Como saber se o LDK está funcionando

Você não precisa criar arquivos manualmente, mas depois do `/ldk-intake` o Lovable deve criar uma pasta
`ldk/` no projeto. Ela é a memória do kit.

Estrutura esperada:

```txt
ldk/
  project.md
  ledger.md
  roadmap.md
  decisions/
  features/
  issues/
  releases/
```

Se essa pasta não aparecer depois do intake, diga ao Lovable:

```txt
Use o LDK corretamente. Crie ou atualize a pasta ldk/ e registre o estado do projeto antes de continuar.
```

## Status de entrega

O LDK usa três resultados no fim de uma feature, proof ou checkpoint:

- `DONE`: tudo essencial foi coberto e a prova mínima foi atingida.
- `PARTIAL`: algo foi feito, mas falta critério, teste, preview, diff ou evidência.
- `BLOCKED`: não dá para concluir sem acesso, decisão, credencial ou correção prévia.

`DONE` não é permitido quando o Lovable não verificou.

Todo proof também deve incluir um auto-check do LDK. Esse auto-check força o Lovable a responder, de forma
explícita, se os critérios essenciais foram cobertos, se existe evidência para eles, se a prova atingida é
suficiente e se há algum erro crítico conhecido.

No `/ldk-build`, antes de editar o app, o Lovable deve fazer um veredito otimista e pessimista:

- otimista: por que o plano parece seguro para executar;
- pessimista: o que pode dar errado, virar falso `DONE` ou exigir pausa.

Se o lado pessimista achar um problema simples dentro do escopo, o Lovable pode corrigir durante o build. Se achar
decisão aberta, risco alto, escopo novo ou prova impossível, ele deve parar antes de mexer no app.

## Risco e prova

| Risco | Exemplos | Prova esperada |
|---|---|---|
| trivial | copy, cor, padding | P1 visual |
| baixo | seção simples, card estático | P1/P2 |
| médio | CRUD, formulário, filtros, admin simples | P2/P3 |
| alto | auth, permissão, PII, pagamento, Supabase rules, deleção/migração | P4 |

| Prova | Evidência mínima |
|---|---|
| P1 | screenshot ou observação precisa do preview |
| P2 | fluxo manual executado com passos e resultado |
| P3 | teste automatizado ou script reproduzível passando |
| P4 | CI verde, diff GitHub e checklist de segurança |

Na dúvida, suba o risco.

O fluxo deve ser proporcional: tarefa trivial não precisa virar plano longo; feature média ou alta não deve ir
direto para construção sem escopo, risco e prova clara.

O fluxo continua controlado: aprovar um plano não inicia build sozinho. Mas quando você chama `/ldk-build`, ele
pode executar a feature planejada e registrar a prova na mesma etapa, desde que o risco permita.

Regras que sempre valem:

- sem prova falsa;
- sem `DONE` sem evidência;
- sem segredo em código, bundle ou logs;
- sem PII desnecessária em logs, analytics, console ou mensagens de erro;
- auth, permissão, pagamento real, RLS, deleção e migração nunca são triviais;
- sem assumir Shopify, gateway, frete real, Supabase ou integração externa sem você pedir.

Se você disser apenas "quero uma loja virtual", o default seguro é vitrine, catálogo, carrinho local e checkout
fake. Pagamento real e provedor externo entram depois, quando forem escolhidos conscientemente.

## Avaliar o LDK

Para testar se o Lovable está obedecendo o fluxo, use o checklist
[evaluation/mini-store-checklist.md](evaluation/mini-store-checklist.md). Ele mede se o Lovable fez intake,
ordenou dependências, planejou quando precisava, executou a feature aprovada sem puxar escopo solto, registrou
proof antes de `DONE` e
manteve a cerimônia proporcional ao risco.

## GitHub

Conectar o app Lovable ao GitHub é recomendado. O GitHub ajuda a verificar:

- arquivos alterados;
- diff real;
- CI;
- checks do LDK;
- se a prova bate com o código.

O arquivo `github/workflows/proof.yml` é um workflow opcional para copiar para `.github/workflows/proof.yml`
no repo do app. Ele roda `ldk-check` e, quando existir `package.json`, tenta rodar install, test e build.

## Auditoria opcional

Por padrão, o LDK não salva log de execução. Isso mantém o fluxo simples.

O `project-knowledge-template.md` já vem assim:

```md
## Auditoria LDK
- Audit log: off
- Audit log file: `ldk/audit/log.md`
```

Deixe `off` se você quer o fluxo normal, sem logs extras.

Se quiser avaliar o projeto depois com outra IA, troque apenas esta linha no **Project Knowledge**:

```md
- Audit log: on
```

Com isso ligado, comandos LDK que alteram estado ou arquivos devem adicionar entradas compactas em
`ldk/audit/log.md`. O log não deve copiar o chat inteiro nem guardar segredos ou dados pessoais.

Para desligar, volte para:

```md
- Audit log: off
```

Esse log é pensado para avaliação externa do processo, não para o Lovable julgar a si mesmo.

### Skill externa de avaliação

O repo também contém:

```txt
skills/ldk-evaluate
```

Essa skill **não é para importar no Lovable**. Ela é para usar em outra IA ou outro agente avaliador depois que o
projeto avançou.

Fluxo recomendado:

1. Habilite `Audit log: on` no Project Knowledge se quiser rastreabilidade melhor.
2. Crie o app normalmente no Lovable.
3. Exporte ou sincronize o projeto no GitHub.
4. Em outra IA, use `ldk-evaluate` para ler `ldk/audit/log.md`, ledger, roadmap, plans, proofs e diff.
5. Peça um relatório de aderência do LDK, qualidade da prova, cerimônia e riscos.

O objetivo é separar executor e avaliador: o Lovable executa; outra IA julga a execução.

## Para devs

Este repo contém:

```txt
workspace-knowledge.md
project-knowledge-template.md
contracts/
skills/
templates/
scripts/
github/
tests/
```

Validação local:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts\ldk-check.ps1 -Root tests\fixtures\valid
```

Fixture quebrado deve falhar:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts\ldk-check.ps1 -Root tests\fixtures\broken
```

## Fronteira do kit

Arquivos do processo LDK não são código do app. Durante uma task do produto, o Lovable não deve alterar:

- Workspace Knowledge e Project Knowledge do LDK;
- skills `ldk-*`;
- templates do kit;
- scripts `ldk-check.*`;
- workflows/templates do kit.

Se uma task de app alterar o motor do LDK, isso é drift crítico: rode `/ldk-doctor` e não marque `DONE`.
