# LDK Common Lessons

Biblioteca interna de licoes genericas para `ldk-intake`, `ldk-roadmap`, `ldk-plan` e `ldk-review`.
Nao e um loop de aprendizado do projeto e nao exige manutencao do usuario.

## Descoberta e escopo

- Finalidade, usuario, jornada e resultado esperado vêm antes de feature, stack ou arquitetura.
- Exemplo usado para explicar uma ideia nao vira requisito sem confirmacao.
- Preocupacao so entra no projeto quando existe sinal, impacto ou decisao que a torna aplicavel.
- Pedido ambiguo usa default reversivel; capacidade externa, irreversivel ou de alto impacto fica `[VERIFY]`.
- Escopo inflado aumenta falso done. Se uma task tocar varias entregas independentes, quebre antes de construir.

## Ordem e dependencias

- Construa pre-requisitos antes das capacidades que dependem deles.
- Defina fonte de dados e regras essenciais antes das experiencias que as consomem.
- Defina identidade e autorizacao antes de superficie privilegiada ou dado isolado por usuario.
- Defina modelo de falha e recuperacao antes de tornar uma dependencia externa critica para a jornada.
- Fluxo principal vem antes de visualizacao secundaria, automacao ou otimizacao que dependa dele.

## Execucao e confiabilidade

- Chamada de rede precisa de timeout; retry so quando a operacao puder ser repetida com seguranca.
- Evento, callback ou webhook que possa repetir precisa de idempotencia antes de producao.
- Trabalho assincrono que possa ser retomado ou concorrer exige ownership duravel. Revalide ownership e estado
  imediatamente antes de cada efeito externo ou irreversivel; libere a execucao de forma condicional.
- Cota, limite ou contador compartilhado exige reserva atomica antes do efeito e compensacao segura quando ele
  falhar. Ler, conferir e depois atualizar separadamente nao protege contra concorrencia.
- Trabalho demorado, recorrente ou desacoplado da resposta imediata exige estrategia explicita de execucao,
  observabilidade e recuperacao.
- Entrada publica ou operacao custosa exige validacao e protecao proporcional contra abuso.
- Dependencia externa precisa de tratamento de erro, estado vazio e fallback quando a jornada exigir continuidade.

## Dados e seguranca

- Segredo no bundle e falha critica. Use o mecanismo seguro disponivel no projeto.
- Identificador publico ou chave publicavel nao autentica worker, agendamento ou entrada privilegiada. Use segredo
  exclusivo do servidor e autorizacao proporcional ao efeito.
- PII em log, analytics, console ou mensagem de erro e falha critica.
- Validacao apenas na interface nao protege dado, transacao, permissao ou operacao sensivel.
- Controle de acesso deve ser aplicado na camada que realmente autoriza a leitura ou escrita.
- Operacao irreversivel exige confirmacao forte e estrategia de recuperacao quando aplicavel.

## Descoberta, mensuracao e desempenho

- Se o resultado depende de aquisicao ou conversao, descubra origem, evento de sucesso, fronteira da conversao e
  como a atribuicao sera validada antes de escolher ferramenta.
- Mensuracao precisa de taxonomia de eventos, fonte de verdade, prevencao de duplicidade e requisitos de
  privacidade proporcionais ao projeto.
- Desempenho tem baseline leve em qualquer produto; aprofunde quando for objetivo, dor atual ou fator de jornada,
  descoberta ou conversao.
- Quando o usuario relata problema existente, meca antes, altere e compare depois.
- Conteudo publico so exige estrategia de descoberta ou taxonomia quando a finalidade e a estrutura acionarem isso.

## Prova e IA

- Green falso acontece quando teste/build e mencionado sem output. Registre `not run` quando nao rodou.
- Proof visual fraco nao cobre comportamento. Suba a prova quando houver jornada, regra ou integracao.
- Evidencia deve registrar fonte, resultado, limite e referencia; texto da IA sozinho nao comprova execucao.
- Sincronizado, aplicado e publicado sao estados diferentes. Prove o estado entregue no ambiente e URL que o
  usuario realmente consumira.
- Ferramenta externa pode regenerar, reformatar ou duplicar artefatos. Depois de sync/import/export, inspecione o
  diff e repita os checks proporcionais antes de reutilizar evidencia anterior.
- Falha repetida sem novo sinal aciona o disjuntor: pare, registre e peca decisao ou contexto.
