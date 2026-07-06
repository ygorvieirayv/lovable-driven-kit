---
name: ldk-proof
description: 'Use when finishing a Lovable task and deciding DONE, PARTIAL, or BLOCKED by comparing acceptance criteria with real evidence. Required before marking anything done.'
---

# ldk-proof

Use esta skill ao fim de cada task para provar a entrega ou declarar `PARTIAL`/`BLOCKED`.

## Objetivo

Gerar `ldk/features/<feature>/proof.md` e atualizar `ldk/ledger.md` sem aceitar `DONE` sem evidência.

## Regra central

Sem prova, não é done.

Execute somente proof. Nao rode `ldk-review`, `ldk-release` ou outra skill nesta etapa.

## O que ler

- `ldk/ledger.md`
- `ldk/roadmap.md`, se existir
- `ldk/features/<feature>/brief.md`
- `ldk/features/<feature>/plan.md`
- registro minimo de AC no ledger ou no plan curto, se for tarefa trivial
- `contracts/always-rules.md`, se disponivel
- arquivos alterados ou GitHub diff, se disponível
- Preview, console/logs e testes, quando acessíveis

## Nível de prova

- P1: exige screenshot ou observação precisa do preview.
- P2: exige fluxo manual executado, passos e resultado observado.
- P3: exige teste automatizado ou script reproduzível com resultado `pass`.
- P4: exige CI verde, diff GitHub e checklist de segurança/release.

`Proof level achieved` precisa ser maior ou igual ao `Proof level required`.

## Cerimonia proporcional

- P1/trivial: proof curto e honesto e suficiente. Deve cobrir AC, observacao visual e self-check.
- P2/baixo: proof curto e honesto com passos manuais executados e resultado observado.
- P3/P4 ou risco medio/alto: use o formato completo, com testes, diff, CI/release e limitacoes quando aplicavel.

Nao adicione burocracia para uma mudanca pequena, mas nunca pule evidencia.

## Regras para status

Use `DONE` apenas quando:

- todos os AC essenciais estao `covered`;
- prova atingida >= prova exigida;
- não há erro crítico conhecido;
- limitações restantes não bloqueiam o objetivo.

Use `PARTIAL` quando:

- algo foi implementado, mas falta AC, teste, preview, diff ou validacao essencial.

Use `BLOCKED` quando:

- falta acesso, credencial, decisão, dado externo ou correção prévia;
- a verificação não pode ser executada;
- apareceu drift de motor LDK.

## Auto-check antes do status

Antes de escolher `DONE`, `PARTIAL` ou `BLOCKED`, preencha mentalmente e depois registre no proof a seção
`LDK self-check`.

Gates obrigatórios:

- Required proof identified: yes/no
- All essential AC covered: yes/no
- Evidence exists for every covered AC: yes/no
- Proof level achieved >= required: yes/no
- Critical errors known: yes/no
- LDK engine drift detected: yes/no
- If GitHub/CI is unavailable, limitation documented: yes/no/not applicable

Regra:

- Se qualquer gate essencial for `no`, status não pode ser `DONE`.
- Se `Critical errors known: yes`, status deve ser `BLOCKED`.
- Se `LDK engine drift detected: yes`, status deve ser `BLOCKED` e o próximo passo é `/ldk-doctor`.
- Se houver segredo exposto, PII em log, auth/pagamento/RLS sem prova forte, delecao/migracao insegura ou proof falso,
  status deve ser `BLOCKED`.
- Se a limitação é falta de GitHub/CI em prova P3/P4, status deve ser `PARTIAL` ou `BLOCKED`, não `DONE`.
- Para P1/P2, GitHub/CI pode ser `not available`, desde que a evidência visual/manual exigida exista.

## Nunca inventar

Se não abriu preview, registre:

```txt
Preview opened: no
```

Se não rodou teste:

```txt
Automated test result: not run
```

Se console/log não está disponível:

```txt
Console/log errors checked: not available
```

## Saída em arquivo

Grave `ldk/features/<feature>/proof.md` usando `templates/proof-report.md`.

Atualize o ledger:

- `done` se Status for `DONE`;
- `partial` se Status for `PARTIAL`;
- `blocked` se Status for `BLOCKED`;
- `Last evidence` deve apontar para o proof.

Nao use `plan.md` ou `brief.md` como `Last evidence`. Plano nao e prova.

## Saída final

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

### LDK self-check
- Required proof identified: yes/no
- All essential AC covered: yes/no
- Evidence exists for every covered AC: yes/no
- Proof level achieved >= required: yes/no
- Critical errors known: yes/no
- LDK engine drift detected: yes/no
- If GitHub/CI is unavailable, limitation documented: yes/no/not applicable

### Evidence
- Preview URL:
- Screenshot or visual observation:
- Manual steps:
- Test output:
- Commit/diff:

### Known limitations
- ...

### Etapa concluida
- Proof registrado e aguardando proximo comando.
```
