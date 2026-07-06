# Lovable Driven Kit (LDK)

Construa apps no Lovable com plano, tarefas pequenas e prova real de conclusão.

Regra central:

> Sem prova, não é done.

O LDK é para quem usa Lovable e quer evitar o problema clássico: a IA diz que "está pronto", mas ninguém
abriu o preview, testou o fluxo, conferiu o diff ou registrou evidência. O kit transforma a conversa em um
processo simples:

1. você descreve o que quer;
2. o Lovable organiza o escopo;
3. ele planeja antes de construir;
4. ele implementa uma task por vez;
5. ele só marca `DONE` quando existe prova suficiente.

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

Os outros comandos aparecem quando o próprio LDK pedir:

```txt
/ldk-plan
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

3. `ldk-plan`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-plan
```

4. `ldk-build-task`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-build-task
```

5. `ldk-proof`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-proof
```

6. `ldk-review`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-review
```

7. `ldk-doctor`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-doctor
```

8. `ldk-release`

```txt
https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-release
```

### 3. Adicionar Knowledge

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
  -> /ldk-plan         planeja uma feature
  -> /ldk-build-task   constrói uma task aprovada
  -> /ldk-proof        prova ou bloqueia a conclusão
  -> /ldk-review       revisa risco, diff e evidência
  -> /ldk-next         recomenda o próximo passo
```

Comandos de apoio:

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

O LDK usa três resultados no fim de uma task:

- `DONE`: tudo essencial foi coberto e a prova mínima foi atingida.
- `PARTIAL`: algo foi feito, mas falta critério, teste, preview, diff ou evidência.
- `BLOCKED`: não dá para concluir sem acesso, decisão, credencial ou correção prévia.

`DONE` não é permitido quando o Lovable não verificou.

Todo proof também deve incluir um auto-check do LDK. Esse auto-check força o Lovable a responder, de forma
explícita, se os critérios essenciais foram cobertos, se existe evidência para eles, se a prova atingida é
suficiente e se há algum erro crítico conhecido.

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

## GitHub

Conectar o app Lovable ao GitHub é recomendado. O GitHub ajuda a verificar:

- arquivos alterados;
- diff real;
- CI;
- checks do LDK;
- se a prova bate com o código.

O arquivo `github/workflows/proof.yml` é um workflow opcional para copiar para `.github/workflows/proof.yml`
no repo do app. Ele roda `ldk-check` e, quando existir `package.json`, tenta rodar install, test e build.

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
