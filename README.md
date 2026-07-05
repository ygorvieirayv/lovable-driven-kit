# Lovable Driven Kit (LDK)

Construa apps no Lovable com plano, tarefas pequenas e prova real de conclusao.

Regra central:

> Sem prova, nao e done.

O LDK e para quem usa Lovable e quer evitar o problema classico: a IA diz que "esta pronto", mas ninguem
abriu o preview, testou o fluxo, conferiu o diff ou registrou evidencia. O kit transforma a conversa em um
processo simples:

1. voce descreve o que quer;
2. o Lovable organiza o escopo;
3. ele planeja antes de construir;
4. ele implementa uma task por vez;
5. ele so marca `DONE` quando existe prova suficiente.

Repositorio oficial:

```txt
https://github.com/ygorvieirayv/lovable-driven-kit
```

## Para quem e

- Usuarios nao tecnicos que querem criar uma loja, landing page, SaaS simples, dashboard ou app interno no
  Lovable sem aceitar entrega "no olho".
- Devs que usam Lovable como acelerador, mas querem diff, criterio de aceite, prova e menos retrabalho.

## O que voce precisa lembrar

So dois comandos importam no dia a dia:

```txt
/ldk-intake
/ldk-next
```

Use `/ldk-intake` no comeco do projeto.

Use `/ldk-next` sempre que nao souber o proximo passo. Ele deve ler o estado salvo e dizer o que fazer.

Os outros comandos aparecem quando o proprio LDK pedir:

```txt
/ldk-plan
/ldk-build-task
/ldk-proof
/ldk-review
/ldk-doctor
/ldk-release
```

## Como instalar no Lovable

O Lovable importa **uma skill por vez**. Nao use a URL do repo inteiro para instalar o LDK completo. Como o
LDK tem varias skills, importe os links abaixo um por um.

### 1. Abrir Skills

Na tela inicial do Lovable:

1. Clique em **Settings** ou **Configuracao**.
2. Abra **Skills**.
3. Clique em **Add**.
4. Escolha **Import from GitHub**.

### 2. Importar cada skill

Copie um link, cole em **Repository URL**, clique em **Import from GitHub** e repita para o proximo.

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

1. Va em **Settings** ou **Configuracao**.
2. Abra **Knowledge**.
3. Em **Workspace Knowledge**, cole o conteudo de `workspace-knowledge.md`.
4. No projeto do app, abra **Project settings -> Knowledge**.
5. Cole o conteudo de `project-knowledge-template.md`.

Voce nao precisa preencher tudo. O LDK deve perguntar o que faltar e marcar duvidas com `[VERIFY]`.

## Criando a primeira mini loja

Depois de instalar as skills e o Knowledge, crie um projeto novo no Lovable e envie:

```txt
/ldk-intake

Quero criar uma mini loja moderna, bonita e responsiva.

Escopo do MVP:
- home com visual premium;
- catalogo de produtos;
- cards com imagem, nome, preco e botao;
- carrinho;
- checkout fake, sem pagamento real;
- tela de confirmacao de pedido;
- area admin simples para listar pedidos simulados.

Direcao visual:
- design limpo, atual e premium;
- responsivo para desktop e mobile;
- boa hierarquia visual;
- cards elegantes;
- cores neutras com um destaque forte.

Por enquanto nao quero auth real, pagamento real, Supabase real ou integracoes externas.

Use o Lovable Driven Kit.
Organize o projeto, riscos, MVP e proximo passo seguro.
Nao implemente ainda.
```

Depois disso, siga o que o LDK recomendar. Se ficar em duvida, mande:

```txt
/ldk-next
```

## Fluxo esperado

O usuario nao precisa decorar este fluxo. Ele existe para o Lovable seguir:

```txt
ideia
  -> /ldk-intake       organiza produto, riscos e MVP
  -> /ldk-plan         planeja uma feature
  -> /ldk-build-task   constri uma task aprovada
  -> /ldk-proof        prova ou bloqueia a conclusao
  -> /ldk-review       revisa risco, diff e evidencia
  -> /ldk-next         recomenda o proximo passo
```

Comandos de apoio:

- `/ldk-doctor`: diagnostica quando o projeto parece perdido ou inconsistente.
- `/ldk-release`: checklist antes de publicar.

## Como saber se o LDK esta funcionando

Voce nao precisa criar arquivos manualmente, mas depois do `/ldk-intake` o Lovable deve criar uma pasta
`ldk/` no projeto. Ela e a memoria do kit.

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

Se essa pasta nao aparecer depois do intake, diga ao Lovable:

```txt
Use o LDK corretamente. Crie ou atualize a pasta ldk/ e registre o estado do projeto antes de continuar.
```

## Status de entrega

O LDK usa tres resultados no fim de uma task:

- `DONE`: tudo essencial foi coberto e a prova minima foi atingida.
- `PARTIAL`: algo foi feito, mas falta criterio, teste, preview, diff ou evidencia.
- `BLOCKED`: nao da para concluir sem acesso, decisao, credencial ou correcao previa.

`DONE` nao e permitido quando o Lovable nao verificou.

## Risco e prova

| Risco | Exemplos | Prova esperada |
|---|---|---|
| trivial | copy, cor, padding | P1 visual |
| baixo | secao simples, card estatico | P1/P2 |
| medio | CRUD, formulario, filtros, admin simples | P2/P3 |
| alto | auth, permissao, PII, pagamento, Supabase rules, delecao/migracao | P4 |

| Prova | Evidencia minima |
|---|---|
| P1 | screenshot ou observacao precisa do preview |
| P2 | fluxo manual executado com passos e resultado |
| P3 | teste automatizado ou script reproduzivel passando |
| P4 | CI verde, diff GitHub e checklist de seguranca |

Na duvida, suba o risco.

## GitHub

Conectar o app Lovable ao GitHub e recomendado. O GitHub ajuda a verificar:

- arquivos alterados;
- diff real;
- CI;
- checks do LDK;
- se a prova bate com o codigo.

O arquivo `github/workflows/proof.yml` e um workflow opcional para copiar para `.github/workflows/proof.yml`
no repo do app. Ele roda `ldk-check` e, quando existir `package.json`, tenta rodar install, test e build.

## Para devs

Este repo contem:

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

Validacao local:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts\ldk-check.ps1 -Root tests\fixtures\valid
```

Fixture quebrado deve falhar:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts\ldk-check.ps1 -Root tests\fixtures\broken
```

## Fronteira do kit

Arquivos do processo LDK nao sao codigo do app. Durante uma task do produto, o Lovable nao deve alterar:

- Workspace Knowledge e Project Knowledge do LDK;
- skills `ldk-*`;
- templates do kit;
- scripts `ldk-check.*`;
- workflows/templates do kit.

Se uma task de app alterar o motor do LDK, isso e drift critico: rode `/ldk-doctor` e nao marque `DONE`.
