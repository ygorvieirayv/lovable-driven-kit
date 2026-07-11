---
name: ldk-proof
description: Use when finishing an LDK feature after essential tasks are proof-pending/done, consolidating current observable evidence and deciding DONE, PARTIAL, or BLOCKED. Not for implementation, review, or release.
---

# ldk-proof

LDK Version: 0.2.1
LDK Schema: 2

Sem prova, nao e done.

Execute somente proof.

## Gate

Leia discovery, project, ledger, roadmap, brief, plan, evidence/proof anterior, arquivos/diff, preview, console e
testes acessiveis.

- Discovery precisa estar approved.
- Discovery, roadmap e plan precisam usar a mesma revision.
- Plan precisa estar approved/building/proof-pending.
- Todas as tasks sao essenciais, salvo `Optional tasks:`.
- Se essencial estiver backlog/ready/in-progress, nao use DONE; salvo checkpoint parcial pedido, pare e recomende
  build.
- Evidencia antiga so vale se ainda refletir app atual.
- Contradicao por rollback/sync exige doctor ou reabertura; nao reutilize proof.
- Codigo preexistente fora da feature ativa nao e drift.

## Niveis

- P1: screenshot ou observacao precisa do preview.
- P2: fluxo manual executado com passos e resultado.
- P3: teste/script reproduzivel com `pass` e referencia de output.
- P4: CI `pass`, diff e checklist de seguranca/release.

Proof atingido precisa ser >= requerido. GitHub/CI pode ser indisponivel para P1/P2 se a evidencia exigida existir;
para P3/P4, ausencia essencial impede DONE.

## Evidencia observavel

Nunca invente preview, teste, console, diff, CI ou verificacao.

Consolide `evidence.md` ou evidencia inline. Para cada AC coberto, identifique:

- fonte/tool;
- acao/comando;
- resultado observado;
- exit code quando aplicavel;
- output, URL, artefato ou diff;
- data/estado atual;
- limitacao.

Texto da IA sozinho nao prova execucao. Se algo nao foi aberto/rodado/visto, registre `no`, `not run` ou
`not available`.

## Status

`DONE` somente quando:

- todas as tasks essenciais estao proof-pending/done;
- todos os AC essenciais tem evidencia atual;
- prova atingida >= exigida;
- nenhum erro critico/drift conhecido;
- limitacao restante nao bloqueia objetivo.

`PARTIAL`: implementacao existe, mas falta AC, preview, teste, diff ou outra validacao essencial.

`BLOCKED`: falta acesso, decisao, dado externo, correcao previa, verificacao possivel ou ha risco/drift critico.

## Self-check obrigatorio

Registre no proof:

- Required proof identified: yes/no
- All essential AC covered: yes/no
- Evidence exists for every covered AC: yes/no
- Evidence references are current and observable: yes/no
- Proof level achieved >= required: yes/no
- Critical errors known: yes/no
- LDK engine drift detected: yes/no
- If GitHub/CI is unavailable, limitation documented: yes/no/not applicable

Qualquer gate essencial `no` impede DONE. Critical/drift `yes` exige BLOCKED. Evidencia falsa, segredo/PII exposto,
controle de acesso/transacao/dado sensivel sem prova forte ou operacao irreversivel insegura exige BLOCKED.

## Escrita de estado

Use `templates/proof-report.md` e grave discovery revision/evidence reference.

- DONE -> ledger `done`, Last evidence=proof, tasks essenciais cobertas=`done`.
- PARTIAL -> ledger `partial`, tasks sem prova=`proof-pending`/`blocked`.
- BLOCKED -> ledger `blocked`, task afetada=`blocked` quando especifica.

Last evidence nunca aponta plan/brief/evidence log; aponta o proof final.

Se `Audit log: on`, registre version/schema, revision, fontes de evidencia, decisao, limitacoes e next. Se off, nao
crie log.

## Saida

```md
## Proof of Done

Feature:
Tasks:
Discovery revision:
Status: DONE | PARTIAL | BLOCKED
Risk:
Proof level required:
Proof level achieved:
Evidence log/inline:

Changed files:
- ...

Acceptance criteria:
- AC1: covered | not covered | not applicable -> evidence reference

Verification performed:
- Preview opened: yes/no
- Main user flow tested: yes/no
- Responsive/mobile checked: yes/no
- Console/log errors checked: yes/no/not available
- GitHub diff available: yes/no
- Automated test result: pass/fail/not run/not available
- Test command/exit code/reference:
- CI result/reference: pass/fail/not run/not available

LDK self-check:
- ...

Proof verdict:
- Optimistic:
- Pessimistic:

Known limitations:
- ...

Etapa concluida e aguardando proximo comando.
```
