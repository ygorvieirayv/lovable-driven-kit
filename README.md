# Lovable Driven Kit (LDK)

Crie apps no Lovable com mais organização, menos retrabalho e prova real antes de chamar algo de pronto.

Regra central:

> Sem prova, não é done.

O LDK é um conjunto de skills e instruções para o Lovable seguir um fluxo simples:

1. extrair e confirmar o entendimento do projeto;
2. descobrir somente as preocupações relevantes;
3. organizar o recorte inicial;
4. ordenar as próximas features;
5. planejar antes de construir;
6. executar conforme o nível de autonomia;
7. acumular evidência e provar antes de marcar `DONE`.

Ele não transforma o usuário em programador. O Lovable continua implementando. O LDK só cria trilhos para a IA não
sair construindo coisa errada, grande demais ou sem verificação.

Repositório oficial:

```txt
https://github.com/ygorvieirayv/lovable-driven-kit
```

## Para quem é

- Pessoas que usam Lovable para criar aplicações de diferentes nichos e finalidades.
- Usuários não técnicos que querem ser guiados por perguntas, próximos passos e provas visuais/manuais.
- Devs que usam Lovable como acelerador, mas querem plano, diff, evidência e menos falso "pronto".

## O que você precisa lembrar

No dia a dia, quase sempre basta lembrar dois comandos:

```txt
/ldk-intake
/ldk-next
```

Use `/ldk-intake` no começo do projeto.

Use `/ldk-next` quando voltar depois de uma pausa ou quando não souber o próximo passo.

Os outros comandos existem, mas o próprio LDK deve recomendar quando usar.

O intake é um gate obrigatório: ele cria `ldk/discovery.md`, apresenta tudo que entendeu e pede sua confirmação.
Roadmap, plano e build só começam depois dessa aprovação.

## Como instalar no Lovable

O Lovable importa **uma skill por vez**. Não use a URL do repositório inteiro.

### 1. Abrir Skills

Na tela inicial do Lovable:

1. Clique em **Settings** ou **Configuração**.
2. Abra **Skills**.
3. Clique em **Add**.
4. Escolha **Import from GitHub**.

### 2. Importar as skills

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

Não importe `ldk-evaluate` no Lovable. Ela é uma skill externa de auditoria, explicada no fim deste README.

### 3. Adicionar Knowledge

No Lovable:

1. Vá em **Settings** ou **Configuração**.
2. Abra **Knowledge**.
3. Em **Workspace Knowledge**, cole o conteúdo de [workspace-knowledge.md](workspace-knowledge.md).
4. No projeto do app, abra **Project settings -> Knowledge**.
5. Cole o conteúdo de [project-knowledge-template.md](project-knowledge-template.md).

Você não precisa preencher tudo. O LDK deve perguntar o que faltar e marcar dúvidas com `[VERIFY]`.

## Começar um projeto novo

Depois de instalar as skills e o Knowledge, crie ou abra um projeto no Lovable e rode:

```txt
/ldk-intake
```

Você pode começar com um pedido simples:

```txt
/ldk-intake

Quero criar uma aplicação para <finalidade>.

Use o Lovable Driven Kit.
Extraia o que entendeu, pergunte somente o que mudar o projeto e prepare a descoberta para minha confirmação.
Não implemente ainda.
```

Se quiser criar uma base limpa antes de iniciar o LDK, use este prompt ao criar o projeto no Lovable:

```txt
Crie um projeto base o mais limpo possível.

Apenas uma tela inicial simples com o texto "Iniciar" centralizado.

Não antecipe funcionalidades, dados, backend, rotas, componentes ou integrações do produto.
Não crie a pasta ldk/ ainda.

Quero só uma base limpa para começar depois com o LDK.
```

Depois que a base existir, instale as skills/Knowledge e rode `/ldk-intake`.

## Usar em um app já existente

O LDK também pode entrar em um app que já funciona. Nesse caso, ele não deve recomeçar o projeto nem reimplementar
tudo. Ele deve mapear o estado atual, criar a memória `ldk/` e separar o que já existe do que ainda precisa ser
provado.

Use:

```txt
/ldk-intake

Este é um app já funcional.

Use o Lovable Driven Kit para avaliar e organizar o estado atual do projeto, sem implementar nada ainda.

Quero que você:
- leia o app atual;
- identifique as principais features já existentes;
- crie ou atualize a pasta ldk/;
- registre as features existentes no ledger;
- marque como done apenas o que conseguir verificar com evidência;
- marque como partial quando algo parece existir mas ainda falta prova;
- marque como idea/planned apenas para melhorias futuras;
- identifique somente preocupações acionadas pela finalidade, jornada, dados e comportamento observados;
- sugira o próximo passo seguro.

Não altere UI, lógica, rotas, banco, auth ou integrações.
Não implemente melhorias agora.
```

## Comandos do LDK

Você não precisa decorar esta tabela. Use `/ldk-next` quando tiver dúvida.

| Comando | Para que serve | Quando usar |
|---|---|---|
| `/ldk-intake` | Extrai, questiona, reconcilia e aprova o entendimento. | Antes de qualquer roadmap ou criação. |
| `/ldk-next` | Lê o estado salvo e recomenda o próximo passo. | Sempre que você não souber o que fazer agora. |
| `/ldk-roadmap` | Ordena features por dependência. | Depois do discovery aprovado, quando há várias partes ou dependências. |
| `/ldk-plan` | Planeja uma feature antes de construir. | Depois do discovery aprovado e roadmap atual, quando aplicável. |
| `/ldk-build` | Executa uma feature aprovada e tenta fechar com prova. | Quando o plano já foi aprovado e o risco permite. |
| `/ldk-build-task` | Executa uma task específica. | Quando você quer controle manual ou uma etapa pequena. |
| `/ldk-proof` | Registra prova e decide `DONE`, `PARTIAL` ou `BLOCKED`. | Quando algo foi implementado e precisa ser validado. |
| `/ldk-review` | Revisa plano, prova, riscos e evidência. | Antes de seguir para a próxima feature ou publicar. |
| `/ldk-doctor` | Corrige inconsistências no estado do LDK. | Quando ledger, plano, proof ou app parecem desalinhados. |
| `/ldk-release` | Faz checklist final. | Antes de publicar, entregar ou mostrar como MVP fechado. |

## Como saber se está funcionando

Depois do `/ldk-intake`, o Lovable deve criar uma pasta `ldk/` no projeto. Ela é a memória do kit.

Estrutura esperada:

```txt
ldk/
  discovery.md
  project.md
  ledger.md
  roadmap.md        # criado por /ldk-roadmap depois do discovery
  decisions/
  features/         # pode conter evidence.md durante build
  issues/
  releases/
```

Se essa pasta não aparecer depois do intake, diga ao Lovable:

```txt
Use o LDK corretamente. Crie ou atualize a pasta ldk/ e registre o estado do projeto antes de continuar.
```

## Status de entrega

O LDK usa três resultados:

- `DONE`: a entrega essencial foi feita e a prova mínima foi atingida.
- `PARTIAL`: algo foi feito, mas falta critério, teste, preview, diff ou evidência.
- `BLOCKED`: não dá para concluir sem acesso, decisão, credencial ou correção prévia.

`DONE` não é permitido quando o Lovable não verificou.

## Discovery antes do roadmap

O `/ldk-intake` não gera roadmap. Primeiro ele registra finalidade, usuários, jornada, resultado, escopo,
pressupostos e um Concern Scan adaptativo em `ldk/discovery.md`. Em seguida mostra um resumo autocontido e pede
confirmação.

Se quiser confrontar a ideia com outra IA, o intake gera um pacote portátil. Ao colar a revisão de volta, o LDK
classifica sugestões, explica impactos e pede sua decisão antes de aprovar uma nova revisão.

Mudança estrutural incrementa `Discovery revision` e torna roadmap anterior `stale`.

## Autonomia

O Project Knowledge define `Autonomy mode`:

- `guided`: execução granular e checkpoints manuais;
- `balanced`: padrão; feature aprovada executa tasks seguras e proof sem microaprovações;
- `autopilot`: conclui a feature aprovada até `DONE`, `PARTIAL` ou `BLOCKED`, sem iniciar outra.

Risco alto, decisão aberta, credencial, operação irreversível, drift ou prova impossível sempre interrompem.

## Risco e prova

| Risco | Exemplos | Prova esperada |
|---|---|---|
| trivial | texto, cor, padding | P1 visual |
| baixo | comportamento isolado e reversível | escolha única P1 ou P2 |
| médio | jornada, regra ou dependência com impacto moderado | escolha única P2 ou P3 |
| alto | acesso, dado sensível, transação real, operação irreversível ou dependência crítica | P4 |

| Prova | Evidência mínima |
|---|---|
| P1 | screenshot ou observação precisa do preview |
| P2 | fluxo manual executado com passos e resultado |
| P3 | teste automatizado ou script reproduzível passando |
| P4 | CI verde, diff GitHub e checklist de segurança |

Na dúvida, suba o risco.

Regras importantes:

- sem prova falsa;
- sem `DONE` sem evidência;
- sem segredo em código, bundle ou logs;
- sem dados pessoais desnecessários em logs, analytics, console ou mensagens de erro;
- acesso, autorização, transação real, dado sensível, deleção e migração nunca são triviais;
- sem escolher plataforma, provedor ou integração sem decisão explícita;
- exemplos não viram requisitos; pedido ambíguo usa default reversível e `[VERIFY]` no que muda o projeto.

## GitHub

Conectar o app Lovable ao GitHub é recomendado, mas não é obrigatório para começar.

O GitHub ajuda a verificar:

- arquivos alterados;
- diff real;
- histórico de mudanças;
- CI, se você configurar;
- se a prova bate com o código.

## Auditoria opcional

Por padrão, o LDK não salva log de execução. Isso mantém o fluxo simples.

O [project-knowledge-template.md](project-knowledge-template.md) já vem assim:

```md
## Auditoria LDK
- Audit log: off
- Audit log file: `ldk/audit/log.md`
```

Deixe `off` se você quer o uso normal.

Se quiser avaliar o projeto depois com outra IA, troque apenas esta linha no **Project Knowledge**:

```md
- Audit log: on
```

Com isso ligado, comandos LDK que alteram estado ou arquivos devem adicionar entradas compactas em
`ldk/audit/log.md`.

Se você ligar o audit log no meio de um projeto, o log começa dali em diante. O histórico anterior não é
reconstruído automaticamente. Se quiser recuperar um resumo do que aconteceu antes, peça um backfill explicitamente
e trate essas entradas como `BACKFILL reconstruído`, não como log original.

## Avaliação externa

O repo contém uma skill chamada:

```txt
skills/ldk-evaluate
```

Ela **não é para importar no Lovable**. Use apenas fora do Lovable, com outra IA ou outro agente avaliador, quando
quiser auditar se o projeto seguiu bem o LDK.

Fluxo recomendado:

1. Crie o app normalmente no Lovable.
2. Sincronize ou exporte o projeto no GitHub.
3. Em outra IA, use `ldk-evaluate` para ler `ldk/`, proofs, audit log, diff e commits.
4. Peça um relatório de aderência ao LDK, qualidade da prova, cerimônia e riscos.

O objetivo é separar executor e avaliador: o Lovable executa; outra IA julga a execução.

## Para mantenedores do LDK

Esta seção é para quem vai alterar o kit, não para quem só quer usar no Lovable.

Validação local:

```powershell
node scripts\ldk-instructions-check.mjs
```

Depois valide os fixtures:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts\ldk-check.ps1 -Root tests\fixtures\valid
```

Fixture quebrado deve falhar:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts\ldk-check.ps1 -Root tests\fixtures\broken
```
