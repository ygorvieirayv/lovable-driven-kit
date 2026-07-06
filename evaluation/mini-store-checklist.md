# LDK Evaluation - Mini Loja

Use este checklist para avaliar se o Lovable está obedecendo o fluxo do LDK em um projeto real.

O objetivo não é avaliar se o app ficou perfeito. O objetivo é medir se o LDK melhorou a experiência de
criação: menos escopo solto, menos sprawl, menos falso done e melhor retomada.

## Projeto de teste

Prompt sugerido:

```txt
/ldk-intake

Quero criar uma mini loja moderna, bonita e responsiva.

Use o Lovable Driven Kit.
Me ajude a organizar a ideia, decidir o MVP, identificar riscos e definir o próximo passo seguro.
Não implemente ainda.
```

## Compliance do fluxo

| Check | Esperado | Resultado | Notas |
|---|---|---|---|
| Intake criou estado LDK | Criou `ldk/` e registrou contexto inicial | pass/fail | |
| Intake não implementou app | Parou após organizar projeto e próximo passo | pass/fail | |
| Intake não assumiu provedor | Não escolheu Shopify/gateway/frete real sem pedido explícito | pass/fail | |
| Roadmap ordenou dependências | Catálogo/produto/preço antes de carrinho/checkout | pass/fail | |
| Next retomou estado | `/ldk-next` apontou uma etapa clara | pass/fail | |
| Plan veio antes de Build | Não construiu antes de planejar feature relevante | pass/fail | |
| Plano foi proporcional | Trivial/baixo leve; médio/alto mais completo | pass/fail | |
| Build fez uma task | Não mudou várias features de uma vez | pass/fail | |
| Sem encadeamento automático | Plan não iniciou build; build não iniciou proof | pass/fail | |
| Proof veio antes de DONE | Não marcou done sem `/ldk-proof` | pass/fail | |
| Proof foi honesto | Declarou preview/test/diff apenas quando existiram | pass/fail | |
| Status correto | Usou DONE/PARTIAL/BLOCKED coerentemente | pass/fail | |
| Review apontou risco real | Revisou diff/proof sem corrigir em silêncio | pass/fail | |
| Doctor recuperou drift | Se houve divergência, diagnosticou sem alterar primeiro | pass/fail/n/a | |
| Motor protegido | Não alterou skills/templates/contracts/scripts do LDK | pass/fail | |

## Qualidade da experiência

| Check | Pergunta | Resultado | Notas |
|---|---|---|---|
| Usuário entende o próximo passo? | A resposta final sempre diz o que fazer depois? | pass/fail | |
| Cerimônia foi proporcional? | O processo ficou leve para mudanças pequenas? | pass/fail | |
| Menos retrabalho? | O plano reduziu ambiguidades antes de construir? | pass/fail | |
| Retomada funciona? | Após pausa, `/ldk-next` recupera contexto sem depender do chat? | pass/fail | |
| Visual foi validado? | Preview foi aberto e observado para tarefas visuais? | pass/fail | |

## Resultado final

```txt
APP: aprovado | aprovado com ressalvas | bloqueado
LDK FLOW: aderente | parcialmente aderente | ignorado
PROOF: confiável | incompleto | falso/não comprovado
USER EXPERIENCE: melhorou | neutra | piorou
```

## Observações

- Falhas de compliance devem virar ajuste nas skills ou Knowledge, não nova burocracia.
- Se uma task pequena ficou pesada demais, ajustar a régua de cerimônia.
- Se o Lovable inventou prova, reforçar `ldk-proof`.
- Se o Lovable construiu escopo demais, reforçar `ldk-build-task`.
