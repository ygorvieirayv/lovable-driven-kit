# LDK State Markers

Este contrato define onde o estado do Lovable Driven Kit mora e quais valores sao validos.

Regra de ouro:

> Conversa aprova, arquivo registra.

Estado que nao esta gravado em `ldk/` nao existe para retomada, prova ou auditoria.

## Ledger

Arquivo:

```txt
ldk/ledger.md
```

Formato minimo:

```md
| ID | Feature | Risk | State | Proof required | Last evidence |
|----|---------|------|-------|----------------|---------------|
| F1 | Catalogo | baixo | done | P2 | ldk/features/catalogo/proof.md |
```

Contrato machine-readable:

- Nao traduza nem renomeie estes headers: `ID`, `Feature`, `Risk`, `State`, `Proof required`, `Last evidence`.
- A coluna `ID` contem apenas o identificador (`F1`, `F2`, `F3`). Nao misture ID e nome da feature.
- O nome da feature fica apenas na coluna `Feature`.
- `Proof required` contem um unico valor: `P1`, `P2`, `P3` ou `P4`. Nao use `P1/P2`.
- Use valores canonicos em ingles/ASCII para `State`: `idea`, `planned`, `approved`, `building`, `proof-pending`,
  `done`, `partial`, `blocked`, `reopened`.

Valores permitidos:

- Risk: `trivial`, `baixo`, `medio`, `alto`
- State: `idea`, `planned`, `approved`, `building`, `proof-pending`, `done`, `partial`, `blocked`, `reopened`
- Proof required: `P1`, `P2`, `P3`, `P4`

Regra:

- `Last evidence` deve ficar vazio em `idea`, `planned`, `approved`, `building` e `proof-pending`.
- `Last evidence` nao deve apontar para `plan.md` ou `brief.md`; plano nao e prova.
- `partial` e `blocked` podem apontar para um proof/report que explique a limitacao.
- `done` exige `Last evidence` apontando para um proof existente.
- `done` exige proof com `Status: DONE`.
- `done` exige `Proof level achieved >= Proof level required`.

## Feature plan

Arquivo:

```txt
ldk/features/<feature>/plan.md
```

Marcadores recomendados:

```md
Status: planned | approved | building | proof-pending | done | partial | blocked | reopened
Risk: trivial | baixo | medio | alto
Proof required: P1 | P2 | P3 | P4
```

Tasks devem usar:

```txt
backlog -> ready -> in-progress -> proof-pending -> done
                                      -> blocked
```

Contrato machine-readable para tasks:

- Todo `plan.md` precisa ter uma tabela de tasks.
- Nao substitua a tabela por bullets.
- Headers obrigatorios: `ID`, `Descricao`, `AC`, `Arquivos esperados`, `Verificacao`, `State`.
- Cada task precisa de ID separado (`T1`, `T2`, `T3`) e `State` canonico.

Task `done` so e permitida quando a verificacao da task passou ou quando o proof final cobre a task.

## Roadmap

Arquivo:

```txt
ldk/roadmap.md
```

Readiness permitido:

- `ready`
- `blocked`
- `later`
- `done`
- `verify`

Regra:

- Uma feature `blocked` nao deve ir para `ldk-plan` sem decisao consciente do usuario.
- Uma feature `ready` precisa ter dependencias essenciais resolvidas ou declaradas como `[VERIFY]`.
- Se o ledger e o roadmap discordarem, rode `ldk-roadmap` ou `ldk-doctor`.

## Proof

Arquivo:

```txt
ldk/features/<feature>/proof.md
```

Marcadores obrigatorios:

```md
Task:
Feature:
Status: DONE | PARTIAL | BLOCKED
Risk: trivial | baixo | medio | alto
Proof level required: P1 | P2 | P3 | P4
Proof level achieved: P1 | P2 | P3 | P4 | none
```

`DONE` so e permitido quando:

- todos os AC essenciais estao `covered`;
- `Proof level achieved` e maior ou igual a `Proof level required`;
- nao ha erro critico conhecido;
- as limitacoes restantes nao bloqueiam o objetivo.

Se algo essencial nao foi verificado, use `PARTIAL` ou `BLOCKED`.
