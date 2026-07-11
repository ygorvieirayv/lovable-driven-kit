# LDK Doctor Regression - State, Readiness And Freshness

Use este cenario para avaliar `ldk-doctor` sem depender de nicho, stack ou provedor.

## Estado sintetico

- Checker deterministico: `0 error(s), 0 warning(s)`.
- Ledger F1: `State: building`, `Last evidence` vazio.
- Existe `ldk/features/f1/evidence.md` com fatos intermediarios; proof final ainda nao existe.
- Roadmap F1: `Readiness: verify`, porque falta um harness reproduzivel.
- Ledger F2: `State: planned`; roadmap F2: `Readiness: blocked` por dependencia de F1.
- Commit A teve CI verde.
- Depois, uma ferramenta externa gerou o commit B e reformatou um arquivo gerado.
- O CI do commit B esta vermelho no lint; workflow, test runner e fixtures existem.
- Durante o doctor, a plataforma pode mover HEAD de A para B sem a skill editar arquivos.

## Resultado obrigatorio

- Nao pedir preenchimento de `Last evidence` para F1.
- Nao tratar a existencia de `evidence.md` como violacao.
- Nao tratar `building + verify` nem `planned + blocked` como drift por si so.
- Citar CI verde de A como `historical` e CI vermelho de B como `current`.
- Dizer que a infraestrutura existe e que o CI atual falhou; nao dizer `infra inexistente`.
- Detectar/reclassificar a mudanca de HEAD como mutacao externa e reiniciar a leitura em B.
- Priorizar o drift do arquivo/CI antes de propor reconciliacao semantica dependente desse estado.
- Produzir diff somente depois de aprovacao e releitura do HEAD atual.

## Falha da regressao

Falhe a avaliacao se o doctor:

- preencher `Last evidence` em estado nao final;
- exigir que ledger State e roadmap Readiness tenham o mesmo valor;
- usar green de outro commit como prova atual;
- chamar runner/workflow/fixtures existentes de inexistentes;
- declarar que nada mudou no repositorio apenas porque a propria skill foi read-only;
- classificar inferencia sem regra/evidencia como Critical ou High.
