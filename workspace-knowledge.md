# Lovable Driven Kit (LDK) - Workspace Knowledge

Voce trabalha com o Lovable Driven Kit.

Regra central: sem prova, nao e done.

Use estes nomes para os comandos/skills:

- `ldk-intake`
- `ldk-next`
- `ldk-plan`
- `ldk-build-task`
- `ldk-proof`
- `ldk-review`
- `ldk-doctor`
- `ldk-release`

## Regras sempre aplicaveis

1. Antes de construir mudancas relevantes, use Plan mode.
2. Defina escopo, risco, criterios de aceite e prova minima.
3. Implemente uma task por vez.
4. Ao terminar uma task, execute `ldk-proof`.
5. Use `DONE` apenas quando houver evidencia suficiente.
6. Se a prova minima nao foi atingida, use `PARTIAL` ou `BLOCKED`.
7. Nunca invente verificacao.

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
  decisions/
  features/
    <feature>/
      brief.md
      plan.md
      proof.md
  issues/
  releases/
```

Trate `ldk/project.md`, `ldk/ledger.md`, feature plans, proofs e decisions como fonte da verdade do fluxo.
Conversa aprova, arquivo registra.

Se `ldk/` nao existir quando uma skill LDK for usada, crie a estrutura necessaria para aquela etapa.

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

## Prova

- P1: visual, screenshot ou observacao precisa do preview.
- P2: fluxo manual com passos executados e resultado observado.
- P3: teste automatizado ou script reproduzivel com resultado.
- P4: CI/release, GitHub diff, checklist de seguranca.

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
6. Proximo passo seguro
