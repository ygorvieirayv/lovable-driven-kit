# Substituir o LDK no Lovable

LDK Version: 0.2.2
LDK Schema: 2

Este e o pacote canonico de importacao do LDK. Ele funciona pelo navegador no computador, celular ou tablet: nao
exige terminal, `git clone` ou copia dos `contracts/`.

## Antes de substituir

- Nao execute comandos LDK durante a troca.
- A estrategia desta versao e `replace-all`: apague as skills antigas e importe as 10 novamente.
- Atualize as duas Knowledges e todas as skills na mesma sessao para nao misturar versoes.
- A pasta `ldk/` do app e o estado do projeto e nao deve ser apagada.

## 1. Apague as skills antigas

Em **Settings -> Skills**, apague estas skills se ja existirem:

1. `ldk-intake`
2. `ldk-next`
3. `ldk-roadmap`
4. `ldk-plan`
5. `ldk-build`
6. `ldk-build-task`
7. `ldk-proof`
8. `ldk-review`
9. `ldk-doctor`
10. `ldk-release`

Nao importe `ldk-evaluate`: ela pertence ao avaliador externo, nao ao Lovable.

## 2. Importe as 10 skills

Em **Settings -> Skills -> Add -> Import from GitHub**, importe uma URL por vez, nesta ordem:

1. [ldk-intake](https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-intake)
2. [ldk-next](https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-next)
3. [ldk-roadmap](https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-roadmap)
4. [ldk-plan](https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-plan)
5. [ldk-build](https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-build)
6. [ldk-build-task](https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-build-task)
7. [ldk-proof](https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-proof)
8. [ldk-review](https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-review)
9. [ldk-doctor](https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-doctor)
10. [ldk-release](https://github.com/ygorvieirayv/lovable-driven-kit/tree/main/skills/ldk-release)

## 3. Substitua as duas Knowledges

Nao preencha nem adapte os arquivos durante a importacao. O contexto especifico do app permanece nos artefatos
`ldk/`; as duas Knowledges continuam genericas.

1. Em **Workspace Settings -> Knowledge**, selecione todo o conteudo antigo e cole o conteudo completo de
   [workspace-knowledge.md](https://raw.githubusercontent.com/ygorvieirayv/lovable-driven-kit/main/workspace-knowledge.md).
2. No app, em **Project Settings -> Knowledge**, selecione todo o conteudo antigo e cole o conteudo completo de
   [project-knowledge-template.md](https://raw.githubusercontent.com/ygorvieirayv/lovable-driven-kit/main/project-knowledge-template.md).

Nao importe `contracts/`, `templates/`, `scripts/`, `evaluation/` nem workflows no Lovable. Eles servem ao repo,
aos validadores e a avaliacao externa; as regras necessarias ao Lovable ja estao nas Knowledges e skills.

## 4. Verifique sem alterar o app

Confirme visualmente que existem exatamente as 10 skills acima. Depois envie este prompt no projeto:

```txt
Sem alterar arquivos ou executar outro comando, informe apenas:
1. a versao e o schema LDK lidos no Workspace Knowledge;
2. a versao e o schema LDK lidos no Project Knowledge;
3. se os comandos ldk-intake, ldk-next, ldk-roadmap, ldk-plan, ldk-build, ldk-build-task,
   ldk-proof, ldk-review, ldk-doctor e ldk-release estao disponiveis;
4. qualquer divergencia encontrada.
```

O resultado esperado nas duas Knowledges e `LDK Version: 0.2.2` e `LDK Schema: 2`, com as 10 skills disponiveis.

## 5. Retome o projeto

- App que ja usa schema 2: rode `/ldk-doctor` primeiro. Ele diagnostica sem corrigir nada automaticamente.
- Artefatos `ldk/` criados em 0.2.0/0.2.1 podem permanecer como historico compativel: 0.2.2 nao muda o schema e nao
  exige reescrever o estado do projeto apenas para trocar a patch.
- App antigo em schema 1: rode `/ldk-intake` para criar/aprovar o discovery e migrar o estado antes de continuar.
- Projeto novo: rode `/ldk-intake`.

O arquivo machine-readable que fixa esta distribuicao e
[`lovable-import-manifest.json`](lovable-import-manifest.json). Se o guia, a versao ou uma URL divergirem dele, a
validacao do repo deve falhar.
