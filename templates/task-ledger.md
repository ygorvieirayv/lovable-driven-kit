# LDK Ledger

Do not translate or rename this table. Keep the exact columns and value vocabularies.
`ID` must contain only a stable ID like `F1`; put the feature name only in `Feature`.

| ID | Feature | Risk | State | Proof required | Last evidence |
|----|---------|------|-------|----------------|---------------|
| F1 | <feature> | baixo | idea | P2 | |

## Vocabulario

- Risk: `trivial`, `baixo`, `medio`, `alto`
- State: `idea`, `planned`, `approved`, `building`, `proof-pending`, `done`, `partial`, `blocked`, `reopened`
- Proof required: `P1`, `P2`, `P3`, `P4`

## Last evidence

- Empty for `idea`, `planned`, `approved`, `building`, and `proof-pending`.
- Never point to `plan.md` or `brief.md`.
- Use only proof/report evidence for `done`, `partial`, or `blocked`.

`done` exige proof existente e suficiente.
