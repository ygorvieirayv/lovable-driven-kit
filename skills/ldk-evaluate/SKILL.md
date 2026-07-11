---
name: ldk-evaluate
description: 'Use when an external AI or reviewer needs to audit a completed Lovable Driven Kit run from discovery, audit log, ledger, roadmap, plans, proofs, and optional GitHub evidence. Run outside Lovable; do not import this skill into Lovable.'
---

# ldk-evaluate

LDK Version: 0.2.2
LDK Schema: 2

Use esta skill fora do Lovable para avaliar uma execucao LDK de ponta a ponta.

Esta skill e para um avaliador externo. Nao e comando do usuario final e nao deve ser importada no Lovable.

## Objetivo

Julgar se o Lovable seguiu o LDK e se o LDK melhorou a execucao:

- escopo ficou claro;
- dependencias foram ordenadas;
- plano veio antes de build;
- build ficou dentro do escopo aprovado;
- prova foi real e suficiente;
- `DONE` foi merecido;
- cerimonia foi proporcional;
- experiencia do usuario melhorou ou piorou.

## Entradas

Leia, quando disponivel:

- `README.md`
- `workspace-knowledge.md`
- `project-knowledge-template.md`
- skills principais: `ldk-intake`, `ldk-next`, `ldk-roadmap`, `ldk-plan`, `ldk-build`, `ldk-proof`, `ldk-doctor`
- `ldk/audit/log.md`
- `ldk/discovery.md`
- `ldk/project.md`
- `ldk/ledger.md`
- `ldk/roadmap.md`
- `ldk/features/*/brief.md`
- `ldk/features/*/plan.md`
- `ldk/features/*/proof.md`
- `ldk/issues/` e `ldk/releases/`, se existirem
- GitHub diff, commits, CI ou screenshots, se o usuario fornecer

Se o audit log nao existir, avalie pelos artefatos disponiveis e marque a rastreabilidade como limitada.
Se o audit log tiver entradas marcadas como `BACKFILL` ou "reconstruido", trate-as como resumo inferido, nao como
log original do momento da execucao.

## Metodo

1. Reconstrua a linha do tempo por feature.
2. Compare cada decisao com as regras do LDK.
3. Diferencie fatos, alegacoes e evidencia verificada.
4. Procure falso `DONE`, prova inventada, escopo inflado, provedor assumido, drift e cerimonia excessiva.
5. Verifique se o proof bate com ledger, plan e arquivos/diff quando disponiveis.
6. Julgue o processo, nao apenas o resultado visual.
7. Verifique se discovery foi aprovado antes do roadmap e se revisoes permaneceram coerentes.
8. Avalie se concern scan foi adaptativo, sem checklist irrelevante nem omissao acionada por sinais.
9. Registre branch/HEAD e vincule cada CI/diff/proof ao estado exato que verificou; green antigo e historico.
10. Nao confunda `State` do ledger com `Readiness` do roadmap nem evidence intermediaria com `Last evidence` final.
11. Se houver mutacao externa durante a avaliacao, reinicie a leitura no novo HEAD e separe acao do executor de
    sync automatico da plataforma.

## Escala

Use estes vereditos:

- APP: `aprovado` | `aprovado com ressalvas` | `bloqueado`
- LDK FLOW: `aderente` | `parcialmente aderente` | `ignorado`
- PROOF: `confiavel` | `incompleto` | `falso/nao comprovado`
- USER EXPERIENCE: `melhorou` | `neutra` | `piorou`

Se houver evidencia insuficiente, prefira `aprovado com ressalvas`, `parcialmente aderente` ou `incompleto`.

## Findings

Classifique achados:

- Critical: falso `DONE`, proof inventado, risco alto publicado sem prova, segredo/PII exposto.
- High: escopo importante fora do plano, dependencia pulada, drift nao reconciliado.
- Medium: cerimonia demais, log incompleto, proof fraco mas honesto, headers/estado inconsistentes.
- Low: texto ruim, melhoria de README/skill, pequenas inconsistencias sem impacto.

Cada finding deve citar arquivo, feature, comando ou trecho de log quando possivel.

## Saida

```md
# LDK Evaluation Report

## Verdict
- APP:
- LDK FLOW:
- PROOF:
- USER EXPERIENCE:

## Executive Summary
- ...

## Timeline
- F1:
- F2:

## Findings
### Critical
- ...

### High
- ...

### Medium
- ...

### Low
- ...

## What Worked
- ...

## What Failed Or Was Weak
- ...

## Proof Quality
- ...

## Ceremony And UX
- ...

## Recommendations
### App
- ...

### LDK Kit
- ...

## Residual Risk
- ...
```

Nao altere arquivos do projeto avaliado. Esta skill e de auditoria.
