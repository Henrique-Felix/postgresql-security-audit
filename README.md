# PostgreSQL Security & Database Auditing

**Projeto pessoal de laboratório e portfólio em Segurança da Informação**

> **Status:** em desenvolvimento  
> **Ambiente de estudo:** PostgreSQL 18.6 no Windows, administrado pelo pgAdmin 4  
> **Base de dados:** `dvdrental`  
> **Escopo atual:** diagnóstico do ambiente e revisão inicial de papéis e privilégios

## Sobre o projeto

Este projeto documenta a construção gradual de um laboratório de segurança para bancos de dados PostgreSQL. O objetivo é praticar a análise de permissões, a investigação de atividades e a auditoria de acessos, registrando consultas reproduzíveis, resultados observados e limitações.

A proposta final é evoluir o laboratório para um fluxo de auditoria com **PostgreSQL + pgAudit + Elasticsearch + Kibana**. A integração entre essas ferramentas ainda está planejada e só será considerada concluída depois de configurada, executada e validada.

## Objetivos

- Inventariar o ambiente, os objetos do banco e suas estruturas.
- Revisar papéis, associações e privilégios efetivos.
- Investigar consultas e atividades relevantes para a segurança.
- Avaliar e configurar o pgAudit com um escopo de auditoria definido.
- Encaminhar logs para o Elasticsearch e realizar pesquisas sobre os eventos coletados.
- Criar visualizações e dashboards no Kibana.
- Documentar decisões, limitações e evidências reais para o portfólio.

## Tecnologias

| Tecnologia | Uso previsto | Estado |
|---|---|---|
| PostgreSQL 18.6 | Banco de dados do laboratório | Ambiente observado |
| SQL | Consultas de diagnóstico e investigação | Em uso |
| pgAdmin 4 | Administração e execução de consultas | Em uso |
| pgAudit | Auditoria de atividades do PostgreSQL | Pendente de avaliação e configuração |
| Elasticsearch | Armazenamento e pesquisa dos logs ingeridos | Pendente |
| Kibana | Pesquisa visual, visualizações e dashboards | Pendente |
| Git e GitHub | Versionamento e documentação do projeto | Em uso |

## Ambiente e escopo

- Sistema operacional: Windows.
- Banco de estudo: `dvdrental`.
- Schema principal: `public`.
- Tabela inicialmente analisada: `public.customer`.

As consultas de diagnóstico e revisão de privilégios realizadas até aqui foram de leitura. Nenhuma permissão foi alterada durante essa etapa.

## Etapas concluídas e resultados observados

### 1. Diagnóstico do ambiente

O resultado registrado nas consultas confirmou:

- Banco atual: `dvdrental`.
- Usuário efetivo e usuário da sessão: `postgres`.
- Versão observada: PostgreSQL 18.6 em Windows 64 bits.

Esses dados descrevem a sessão utilizada no laboratório; não representam, por si só, uma avaliação completa da segurança do servidor.

### 2. Inventário inicial do schema `public`

O inventário documentado anteriormente registrou **22 objetos retornados pela consulta utilizada**, incluindo tabelas e views. Esse número deve ser interpretado conforme os filtros e os tipos de objeto considerados pela consulta de inventário.

### 3. Estrutura de `public.customer`

Foi documentada a estrutura de 10 colunas da tabela `public.customer`, incluindo tipos de dados, nulabilidade e limites de caracteres, conforme os resultados observados no pgAdmin.

### 4. Revisão inicial de papéis e privilégios

Foram executadas consultas somente de leitura para inspecionar atributos de papéis, associações e privilégios relacionados ao banco, ao schema `public` e à tabela `public.customer`.

Principais observações registradas:

- A consulta de inventário de papéis retornou 17 papéis.
- `postgres` apareceu como proprietário de `public.customer`.
- A coluna `relacl` da tabela retornou `NULL`. Isso **não significa ausência de privilégios**: quando não há uma ACL explícita armazenada, é necessário considerar os privilégios padrão e a propriedade do objeto.
- Nas verificações de privilégios efetivos realizadas, `pg_read_all_data` apresentou `SELECT` como verdadeiro, e `pg_write_all_data` apresentou `INSERT`, `UPDATE` e `DELETE` como verdadeiros. Esses resultados devem ser interpretados no contexto da função consultada e do objeto avaliado.
- O papel `postgres` apresentou como verdadeiros os cinco privilégios testados na consulta de tabela: `SELECT`, `INSERT`, `UPDATE`, `DELETE` e `TRUNCATE`.
- A consulta de associação filtrada para os papéis `pg_read_all_data` e `pg_write_all_data` não retornou linhas. Isso indica apenas que não foram encontradas associações diretas que correspondessem àquele filtro; não prova ausência de toda forma possível de acesso indireto.

**Interpretação responsável:** esses resultados são observações do laboratório, não uma declaração de vulnerabilidade nem uma auditoria exaustiva de todos os caminhos de autorização do PostgreSQL.

## Estrutura do repositório

```text
.
├── README.md
├── INSTRUCOES_ATUALIZACAO.md
├── docs/
│   └── revisao_privilegios.md
├── sql/
│   └── 04_revisao_privilegios.sql
├── evidencias/
└── relatorios/
```

A estrutura acima mostra os arquivos principais previstos/registrados para esta etapa. Outros arquivos existentes no repositório devem ser preservados. A pasta `evidencias/` deve conter somente capturas reais aprovadas para publicação.

## Roadmap

- [x] Diagnóstico inicial do ambiente PostgreSQL.
- [x] Inventário inicial de objetos do schema `public`.
- [x] Documentação da estrutura de `public.customer`.
- [x] Consultas iniciais de revisão de papéis e privilégios.
- [ ] Consolidar e validar as conclusões da revisão de privilégios.
- [ ] Avaliar a compatibilidade e a disponibilidade do pgAudit para o ambiente PostgreSQL 18.6 no Windows.
- [ ] Definir o escopo de auditoria e configurar o pgAudit, se compatível.
- [ ] Gerar um evento controlado e validar o registro correspondente nos logs.
- [ ] Definir e implementar a ingestão dos logs no Elasticsearch.
- [ ] Pesquisar eventos ingeridos e criar visualizações/dashboards no Kibana.
- [ ] Executar testes controlados de investigação.
- [ ] Consolidar relatório técnico e evidências aprovadas.

Uma etapa só será marcada como concluída depois da execução e validação prática correspondente.

## Segurança, limitações e evidências

- As consultas de diagnóstico desta fase são somente de leitura; não foram alteradas permissões.
- A configuração do pgAudit, a ingestão no Elasticsearch e os dashboards no Kibana ainda não foram validados.
- Não publicar senhas, dados pessoais, logs sensíveis ou capturas que não tenham sido aprovadas.
- Registrar separadamente fatos observados, hipóteses e recomendações.
- Não declarar vulnerabilidades sem evidências suficientes.
- As evidências visuais serão adicionadas somente quando forem capturas reais fornecidas ou aprovadas pelo autor.

## Documentação e scripts

- [`docs/revisao_privilegios.md`](docs/revisao_privilegios.md) — documentação da revisão inicial de privilégios.
- [`sql/04_revisao_privilegios.sql`](sql/04_revisao_privilegios.sql) — consultas SQL de diagnóstico utilizadas nessa etapa.

## Autor e repositório

Repositório: [Henrique-Felix/postgresql-security-audit](https://github.com/Henrique-Felix/postgresql-security-audit)

Projeto pessoal desenvolvido para estudo prático e construção de portfólio em Segurança da Informação.
