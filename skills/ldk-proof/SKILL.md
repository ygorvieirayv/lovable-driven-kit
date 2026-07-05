---
name: ldk-proof
description: Use when finishing a Lovable task and deciding DONE, PARTIAL, or BLOCKED by comparing acceptance criteria with real evidence. Required before marking anything done.
---

# ldk-proof

Use esta skill ao fim de cada task para provar a entrega ou declarar `PARTIAL`/`BLOCKED`.

## Objetivo

Gerar `ldk/features/<feature>/proof.md` e atualizar `ldk/ledger.md` sem aceitar `DONE` sem evidencia.

## Regra central

Sem prova, nao e done.

## O que ler

- `ldk/ledger.md`
- `ldk/features/<feature>/brief.md`
- `ldk/features/<feature>/plan.md`
- arquivos alterados ou GitHub diff, se disponivel
- Preview, console/logs e testes, quando acessiveis

## Nivel de prova

- P1: exige screenshot ou observacao precisa do preview.
- P2: exige fluxo manual executado, passos e resultado observado.
- P3: exige teste automatizado ou script reproduzivel com resultado `pass`.
- P4: exige CI verde, diff GitHub e checklist de seguranca/release.

`Proof level achieved` precisa ser maior ou igual ao `Proof level required`.

## Regras para status

Use `DONE` apenas quando:

- todos os AC essenciais estao `covered`;
- prova atingida >= prova exigida;
- nao ha erro critico conhecido;
- limitacoes restantes nao bloqueiam o objetivo.

Use `PARTIAL` quando:

- algo foi implementado, mas falta AC, teste, preview, diff ou validacao essencial.

Use `BLOCKED` quando:

- falta acesso, credencial, decisao, dado externo ou correcao previa;
- a verificacao nao pode ser executada;
- apareceu drift de motor LDK.

## Nunca inventar

Se nao abriu preview, registre:

```txt
Preview opened: no
```

Se nao rodou teste:

```txt
Automated test result: not run
```

Se console/log nao esta disponivel:

```txt
Console/log errors checked: not available
```

## Saida em arquivo

Grave `ldk/features/<feature>/proof.md` usando `templates/proof-report.md`.

Atualize o ledger:

- `done` se Status for `DONE`;
- `partial` se Status for `PARTIAL`;
- `blocked` se Status for `BLOCKED`;
- `Last evidence` deve apontar para o proof.

## Saida final

```md
## Proof of Done

Task:
Feature:
Status: DONE | PARTIAL | BLOCKED
Risk:
Proof level required:
Proof level achieved:

### Changed files
- ...

### Acceptance criteria
- AC1: covered | not covered | not applicable

### Verification performed
- Preview opened: yes/no
- Main user flow tested: yes/no
- Responsive/mobile checked: yes/no
- Console/log errors checked: yes/no/not available
- GitHub diff available: yes/no
- Automated test available: yes/no
- Automated test result: pass/fail/not run/not available
- CI result: pass/fail/not run/not available

### Evidence
- Preview URL:
- Screenshot or visual observation:
- Manual steps:
- Test output:
- Commit/diff:

### Known limitations
- ...

### Next safe step
- ...
```
