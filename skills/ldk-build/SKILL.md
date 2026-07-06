---
name: ldk-build
description: 'Use when executing an approved LDK feature end-to-end after planning: run planned safe tasks in sequence, do a pre-flight optimistic/pessimistic verdict before editing, verify evidence, write proof, and return DONE/PARTIAL/BLOCKED. Default build path for trivial, baixo, and safe medio features; not for intake, planning, review, or release.'
---

# ldk-build

Use esta skill em Build mode para executar uma feature aprovada com pouca microcerimonia.

## Objetivo

Executar a feature planejada ate onde for seguro:

1. pensar antes de editar;
2. implementar as tasks planejadas em sequencia;
3. atualizar estados no `plan.md` e `ledger.md`;
4. verificar a prova minima;
5. escrever `proof.md`;
6. decidir `DONE`, `PARTIAL` ou `BLOCKED`.

Isto nao e encadear skills. O escopo desta skill inclui build e proof da feature aprovada.

## Quando usar

Use `ldk-build` como caminho padrao quando:

- a feature esta `approved`, `building` ou com tasks `ready`/`in-progress`;
- existe `plan.md` com tabela de tasks;
- a tabela de tasks usa exatamente os headers `ID | Descricao | AC | Arquivos esperados | Verificacao | State`;
- o risco e `trivial`, `baixo` ou `medio` sem decisao aberta critica;
- o usuario quer resultado, nao operar T1/T2/T3 manualmente.

Use `ldk-build-task` em vez disso quando:

- o usuario pediu explicitamente uma task especifica;
- a feature e `alto` risco;
- ha auth, pagamento real, PII, RLS, migracao, delecao, credencial ou integracao externa sensivel;
- ha `[VERIFY]` que muda escopo, provedor, dado ou seguranca;
- houve falha repetida ou drift que exige passo menor.

## Antes de editar

Leia:

- `ldk/project.md`
- `ldk/ledger.md`
- `ldk/roadmap.md`, se existir
- `ldk/features/<feature>/brief.md`
- `ldk/features/<feature>/plan.md`
- `ldk/features/<feature>/proof.md`, se existir
- arquivos do app citados no plano

Nao dependa de `contracts/` como bundled file. Se algum contrato estiver disponivel, use; se nao estiver, siga o
Workspace Knowledge e esta skill.

## Pre-flight obrigatorio

Antes de editar app ou `src/`, faca o pre-flight:

- Veredito otimista: por que o plano parece executavel agora.
- Veredito pessimista: o que pode dar errado, ficar falso ou exigir pausa.
- Decisao antes de executar: `proceed`, `pause` ou `blocked`.

Use o veredito pessimista como ferramenta de qualidade:

- se apontar um ajuste pequeno dentro do escopo, incorpore na execucao;
- se apontar decisao aberta, risco alto, credencial, provedor, dado sensivel ou prova impossivel, pare antes de
  editar e explique o bloqueio;
- se apontar escopo novo, recomende `ldk-plan` ou `ldk-doctor`.

## Execucao

- Implemente somente a feature ativa.
- Nao puxe nova feature do roadmap.
- Execute tasks planejadas em sequencia, uma por vez internamente.
- Antes de editar uma task, marque-a como `in-progress` se isso ajudar a registrar o estado.
- Ao concluir uma task, marque-a como `proof-pending`.
- Se uma task ja estiver `proof-pending`/`done`, nao refaca sem drift claro.
- Se todas as tasks essenciais ficarem `proof-pending` ou `done`, marque a feature no ledger como
  `proof-pending` antes da prova final.
- Nao edite motor do LDK como efeito colateral da feature.

Pare imediatamente se encontrar:

- tabela de tasks sem headers exatos; recomende `ldk-doctor` para normalizar antes de construir;
- `[VERIFY]` que afeta a feature atual;
- arquivo fora do escopo que seria necessario alterar;
- segredo, PII, auth, pagamento real, RLS, migracao ou delecao nao planejados;
- rollback/drift que contradiz task `proof-pending` ou `done`;
- falha repetida no mesmo ponto.

## Prova dentro do build

Depois das tasks essenciais, verifique conforme `Proof required`:

- P1: screenshot ou observacao precisa do preview.
- P2: fluxo manual com passos e resultado observado.
- P3: teste automatizado ou script reproduzivel.
- P4: CI/release, diff GitHub e checklist de seguranca.

Nunca invente prova. Se nao abriu preview, nao rodou teste ou nao viu diff, declare isso.

Escreva `ldk/features/<feature>/proof.md` com:

- pre-flight otimista/pessimista;
- arquivos alterados;
- AC cobertos;
- verificacao executada;
- veredito otimista da prova;
- veredito pessimista da prova;
- `LDK self-check`;
- status final.

Use `DONE` apenas quando:

- todas as tasks essenciais estao `proof-pending` ou `done`;
- todos os AC essenciais estao cobertos;
- a prova atingida e maior ou igual a exigida;
- nao existe erro critico conhecido;
- a limitacao restante nao bloqueia o objetivo.

Use `PARTIAL` quando algo foi implementado, mas a prova ou algum AC essencial ficou incompleto.
Use `BLOCKED` quando falta decisao, acesso, credencial, correcao previa ou prova essencial.

Atualize o ledger:

- `done` se Status for `DONE`;
- `partial` se Status for `PARTIAL`;
- `blocked` se Status for `BLOCKED`;
- `Last evidence` apontando para `ldk/features/<feature>/proof.md`.

Atualize tambem o `plan.md`:

- se Status for `DONE`, marque as tasks essenciais cobertas como `done`;
- se Status for `PARTIAL`, deixe tasks sem prova suficiente como `proof-pending` ou `blocked`;
- se Status for `BLOCKED`, marque a task afetada como `blocked` quando o bloqueio for especifico.

## Audit log opcional

Se o Project Knowledge tiver `Audit log: on`, adicione uma entrada compacta em `ldk/audit/log.md` ao final.
Registre pre-flight, actions, evidence claimed, decision e next. Se estiver `off` ou ausente, nao crie log.

## Saida

```md
## LDK Build

Feature:
Modo: feature autopilot | checkpoint | blocked-before-build
Risk:
Proof required:

### Pre-flight antes da execucao
Veredito otimista:
- ...
Veredito pessimista:
- ...
Decisao antes de executar: proceed | pause | blocked

### Execucao
- Tasks executadas:
- Arquivos alterados:

### Prova
- Proof level achieved:
- Preview/testes/diff:
- Veredito otimista:
- Veredito pessimista:

Status: DONE | PARTIAL | BLOCKED
Etapa concluida e aguardando proximo comando.
```

Se o pre-flight decidir `pause` ou `blocked`, nao edite app. Explique o proximo passo seguro.
