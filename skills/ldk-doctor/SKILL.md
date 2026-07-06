---
name: ldk-doctor
description: 'Use when LDK project state may have drifted: ledger, proof, app code, GitHub diff, or LDK engine files disagree. Starts read-only and reconciles only with explicit approval.'
---

# ldk-doctor

Use esta skill para diagnosticar drift entre Knowledge, arquivos `ldk/`, app e GitHub.

## Objetivo

Encontrar inconsistencias e propor recuperacao segura.

Esta skill comeca read-only. Nao corrija nada sem aprovacao explicita, um item por vez.

## Camadas

### T0 - Check deterministico

Se existir `scripts/ldk-check.*`, rode o script.

Se nao existir, valide manualmente:

- `ldk/ledger.md` existe;
- `ldk/roadmap.md` existe quando o projeto tem varias features;
- estados validos;
- `done` tem proof;
- proof `DONE` tem prova suficiente.

### T1 - Ledger x arquivos

Procure:

- ledger diz `done`, mas proof ausente;
- proof diz `DONE`, mas `Proof level achieved` e insuficiente;
- feature com plan/brief mas sem ledger;
- ledger aponta evidence quebrada;
- roadmap aponta proxima feature ja concluida ou bloqueada;
- roadmap e ledger discordam sobre estado/ordem;
- `[VERIFY]` critico aberto em feature `done`;
- task em `done` sem proof correspondente.

### T2 - Proof x realidade

Procure:

- proof diz preview aberto, mas nao ha URL/observacao;
- proof diz teste passou, mas nao ha output;
- proof diz GitHub diff disponivel, mas nao ha link ou commit;
- AC marcado `covered` sem evidencia.

### T3 - Diff x fronteira

Procure:

- alteracao em skills, Knowledge, templates, scripts ou workflows LDK durante feature do app;
- arquivos fora do escopo planejado;
- mudancas grandes demais para uma task.

## Saida do diagnostico

```md
## LDK Doctor

Verdict: healthy | drift-found | serious-drift

Critical:
- arquivo:linha - problema - regra violada

High:
- ...

Medium:
- ...

Low:
- ...

Nothing changed yet.
```

## Reconciliacao

Para cada achado, ofereca:

- A) Corrigir o artefato/codigo de baixo para obedecer a fonte de verdade.
- B) Mudar conscientemente a fonte de verdade.
- C) Registrar como debito e seguir.

Para drift de motor LDK, recomende restaurar a partir do repo oficial:

```txt
https://github.com/ygorvieirayv/lovable-driven-kit
```

Regras:

- Uma correcao por vez.
- Mostrar diff.
- Reexecutar check relevante.
- Sem aprovacao explicita, nao alterar nada.
