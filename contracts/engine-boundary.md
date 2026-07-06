# LDK Engine Boundary

Este contrato separa o motor do Lovable Driven Kit dos artefatos do app.

## Motor do LDK

Estes arquivos sao processo, nao produto:

- `workspace-knowledge.md`
- `project-knowledge-template.md`
- `contracts/**`
- `skills/**`
- `templates/**`
- `scripts/ldk-check.*`
- `github/workflows/proof.yml`
- `github/playwright-smoke.spec.ts`

Se estes arquivos forem copiados para um app Lovable, eles continuam sendo motor do LDK.

## Artefatos do produto

Estes arquivos pertencem ao app e podem mudar pelo fluxo normal:

- `ldk/project.md`
- `ldk/ledger.md`
- `ldk/roadmap.md`
- `ldk/decisions/**`
- `ldk/features/**`
- `ldk/issues/**`
- `ldk/releases/**`
- codigo, assets, componentes, rotas, testes e configs do app

## Regra operacional

Durante uma feature do app:

1. Nao edite o motor do LDK.
2. Nao "melhore" skills, templates ou scripts como efeito colateral.
3. Antes de marcar `DONE`, confira os arquivos alterados.
4. Se o diff tocar motor do LDK, trate como drift critico.
5. Rode `ldk-doctor` e nao avance ate reconciliar.

## Recuperacao

Se o motor do LDK foi alterado por engano:

1. Informe os caminhos afetados.
2. Nao corrija em silencio.
3. Recomende restaurar os arquivos a partir do repo oficial:
   `https://github.com/ygorvieirayv/lovable-driven-kit`
4. Reexecute `ldk-check` no app.
5. So depois retome a feature.
