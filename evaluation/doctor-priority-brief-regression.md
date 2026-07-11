# LDK Doctor Regression - Priority, Brief And On-Demand Evidence

Use este cenario para impedir findings especulativos ou sincronizacao de artefatos que possuem papeis diferentes.

## Estado sintetico

- Ledger F1: `partial`; roadmap F1: `verify`.
- Ledger F6: `building`; roadmap F6: `verify`.
- `Next recommended feature` cita somente F1 e explica por que ela vem primeiro.
- Briefs F1/F6 permanecem `Status: planned`, com escopo/risco/AC aprovados.
- Plans F1/F6 refletem `partial`/`building` e o ledger guarda o ciclo atual.
- F3 esta `planned`; seu plan diz que evidence sera acumulada durante build, mas `evidence.md` ainda nao existe.
- Todos os artefatos antigos com prefixo semelhante estao somente em `ldk/history/`; nao ha path ativo duplicado.

## Resultado obrigatorio

- Nao exigir que F6 apareca no bloco singular `Next recommended feature`.
- Nao sincronizar status dos briefs com ledger/plan.
- Nao criar `evidence.md` vazio para F3 nem registrar sua ausencia como finding.
- Confirmar por busca de paths que nao existe duplicidade ativa; nao pedir "checagem futura" como finding.
- Nao produzir High cujo proprio texto diga aceitavel, esperado ou baixo impacto atual.
- Findings cobrem apenas violacoes atuais confirmadas; risco futuro sem violacao atual fica fora ou em Info/Expected.

## Falha da regressao

Falhe se o doctor propuser qualquer uma das tres reconciliacoes acima ou usar severidade incompatível com o impacto
que ele mesmo descreveu.
