PostgreSQL Security & Database Auditing
Status: Em desenvolvimento  
Tipo: Projeto pessoal de laboratório e portfólio  
Banco de estudo: `dvdrental`  
Ambiente observado: PostgreSQL 18.6 no Windows, administrado pelo pgAdmin 4
Sobre o projeto
Projeto pessoal de Segurança da Informação voltado à análise de privilégios, auditoria de atividades e monitoramento de acessos em bancos de dados PostgreSQL.
O laboratório está sendo desenvolvido de forma incremental para demonstrar, com consultas reproduzíveis e evidências reais, como inspecionar o ambiente, analisar papéis e permissões, configurar auditoria de eventos e encaminhar os logs para uma plataforma de pesquisa e visualização.
O objetivo final é implementar um fluxo de auditoria utilizando PostgreSQL + pgAudit + Elasticsearch + Kibana, com consultas de investigação e dashboards para apoiar a análise de atividades no banco.
> Este é um projeto educacional de portfólio. Não representa uma implantação corporativa de Database Activity Monitoring (DAM), e nenhuma integração será declarada concluída antes de ser executada e validada.
Objetivos técnicos
Inventariar bancos, schemas, objetos e papéis do PostgreSQL.
Revisar privilégios efetivos e concessões de acesso.
Aplicar o princípio do menor privilégio na análise de permissões.
Configurar e validar o pgAudit para registrar eventos selecionados.
Implementar a coleta e a ingestão dos logs no Elasticsearch.
Pesquisar eventos e criar visualizações e dashboards no Kibana.
Executar testes controlados e documentar os resultados observados.
Manter scripts, documentação e evidências reproduzíveis para estudo e portfólio.
Tecnologias
Tecnologia	Finalidade	Status
PostgreSQL 18.6	Banco de dados do laboratório	Ambiente identificado
`dvdrental`	Base demonstrativa para as análises	Utilizada nas consultas iniciais
SQL	Inventário e análise de privilégios	Em uso
pgAdmin 4	Administração e execução das consultas	Em uso
pgAudit	Auditoria de sessões e/ou objetos	Planejado; instalação e validação pendentes
Elasticsearch	Ingestão, indexação e pesquisa dos logs	Planejado; integração pendente
Kibana	Consultas, visualizações e dashboards	Planejado; integração pendente
Git e GitHub	Versionamento e documentação do portfólio	Repositório em uso
Progresso registrado
1. Diagnóstico do ambiente
O resultado da consulta confirmou `dvdrental` como banco atual, `postgres` como usuário efetivo e usuário da sessão, e PostgreSQL 18.6 em Windows 64 bits.
2. Inventário de objetos
O inventário inicial do schema `public` foi documentado anteriormente. O README anterior registra 22 objetos retornados pela consulta utilizada, incluindo tabelas-base e views.
3. Estrutura da tabela `public.customer`
Foi realizada a inspeção das 10 colunas, incluindo tipos de dados, nulabilidade e limites de caracteres.
4. Revisão inicial de papéis e privilégios
Foram executadas consultas somente de leitura para inspecionar papéis, atributos, associações e privilégios efetivos no banco, schema `public` e tabela `public.customer`.
Resultados observados nas capturas fornecidas:
O inventário retornou 17 papéis.
A tabela `public.customer` tem `postgres` como proprietário.
A coluna `relacl` de `public.customer` retornou `NULL`; isso não significa ausência de privilégios, pois devem ser considerados os privilégios padrão.
`has_table_privilege()` retornou `SELECT = true` para `pg_read_all_data` e `INSERT`, `UPDATE` e `DELETE = true` para `pg_write_all_data`.
A consulta de associações filtrada para esses dois papéis retornou zero linhas. Isso não exclui todas as outras formas de obter privilégios.
`postgres` apresentou os cinco privilégios testados (`SELECT`, `INSERT`, `UPDATE`, `DELETE` e `TRUNCATE`) como `true`.
Esses resultados são observações do laboratório, não uma declaração de vulnerabilidade. A análise não deve ser interpretada como auditoria exaustiva de todos os caminhos de autorização.
Roadmap
Consolidar e validar a revisão inicial de privilégios.
Verificar a compatibilidade do pgAudit com PostgreSQL 18.6 no Windows.
Configurar o pgAudit com escopo de auditoria definido e validar a geração de eventos.
Definir a estratégia de coleta e implementar a ingestão dos logs no Elasticsearch.
Criar consultas, visualizações e dashboards no Kibana.
Realizar testes controlados e investigar os eventos coletados.
Consolidar relatório técnico, documentação e evidências aprovadas.
Estrutura do repositório
`docs/`: documentação das análises, decisões e limitações.
`sql/`: consultas SQL reproduzíveis.
`evidencias/`: capturas reais das execuções, aprovadas para publicação.
`relatorios/`: relatórios técnicos consolidados.
Critérios de validação
Uma etapa só será marcada como concluída depois de:
executar os comandos ou configurações correspondentes;
analisar os resultados reais;
registrar limitações e decisões técnicas;
aprovar as evidências que serão publicadas.
Para a integração final, será necessário gerar um evento controlado no PostgreSQL, localizar o registro correspondente nos logs ingeridos no Elasticsearch e demonstrar sua pesquisa ou visualização no Kibana.
Segurança e limitações
As consultas de diagnóstico desta fase são somente de leitura.
Nenhuma permissão foi alterada durante a revisão documentada.
A instalação e configuração do pgAudit ainda não foram validadas.
A ingestão no Elasticsearch e os dashboards no Kibana ainda não foram implementados e validados.
Não publique senhas, dados pessoais, logs sensíveis ou capturas que não tenham sido aprovadas.
Resultados e conclusões devem se limitar às evidências efetivamente observadas.
