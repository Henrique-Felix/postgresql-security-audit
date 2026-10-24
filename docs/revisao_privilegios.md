# Revisão inicial de papéis e privilégios

**Projeto:** Auditoria e Segurança de Banco de Dados PostgreSQL  
**Ambiente observado:** PostgreSQL 18.6 em Windows, pgAdmin 4, banco `dvdrental`  
**Escopo desta revisão:** papéis, associações entre papéis e privilégios efetivos sobre `public.customer`  
**Status:** diagnóstico inicial realizado; revisão não equivale a uma auditoria exaustiva de todos os caminhos de autorização.

## 1. Objetivo

Investigar papéis e privilégios antes de configurar o pgAudit. As consultas desta etapa são de leitura e não alteram permissões.

## 2. Contexto validado

O resultado enviado pelo usuário mostrou:

- Banco atual: `dvdrental`
- Usuário efetivo: `postgres`
- Usuário da sessão: `postgres`
- Versão reportada: PostgreSQL 18.6 em Windows 64 bits

## 3. Inventário de papéis

A consulta a `pg_roles` retornou 17 papéis. O papel `postgres` apresentou `rolcanlogin`, `rolsuper`, `rolcreatedb` e `rolcreaterole` como `true` no resultado observado. A saída também apresentou papéis predefinidos `pg_*`.

Os papéis predefinidos não são, por si só, evidência de vulnerabilidade. A análise deve verificar sua finalidade e se foram concedidos a usuários que realmente precisam dessas capacidades.

## 4. Associações observadas

A consulta inicial de associações retornou três linhas relacionadas ao papel `pg_monitor`:

- `pg_read_all_settings`
- `pg_read_all_stats`
- `pg_stat_scan_tables`

Nas três linhas, `admin_option` apareceu como `false`.

Uma consulta posterior filtrada para associações em que `pg_read_all_data` ou `pg_write_all_data` fossem o papel concedido retornou zero linhas. Isso significa que não foram encontradas associações diretas correspondentes a esse filtro; não prova ausência de privilégios por todas as outras vias.

## 5. Privilégios efetivos em `public.customer`

A consulta com `has_table_privilege()` retornou, entre os resultados visíveis:

- `pg_read_all_data`: `SELECT = true`; `INSERT`, `UPDATE`, `DELETE` e `TRUNCATE = false`.
- `pg_write_all_data`: `INSERT`, `UPDATE` e `DELETE = true`; `SELECT` e `TRUNCATE = false`.
- `postgres`: os cinco indicadores (`SELECT`, `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`) apareceram como `true`.
- Os demais papéis visíveis na captura apresentaram os cinco indicadores como `false`.

`has_table_privilege()` verifica privilégios efetivos. O resultado não identifica sozinho se a permissão veio de concessão direta, associação herdada, `PUBLIC` ou privilégios administrativos.

## 6. ACL e proprietário da tabela

A consulta ao catálogo `pg_class` e ao schema `pg_namespace` mostrou:

- Tabela: `customer`
- Proprietário: `postgres`
- `relacl`: `NULL`

`relacl = NULL` não significa ausência de privilégios. Indica que não há uma ACL explícita armazenada nessa coluna; a análise deve considerar os privilégios padrão aplicáveis.

Uma consulta que aplicou `COALESCE(relacl, acldefault(...))` exibiu os privilégios padrão associados ao proprietário. Portanto, as oito linhas produzidas por essa consulta não devem ser descritas como oito concessões explícitas armazenadas na ACL.

## 7. Limitações e próximos passos

Esta revisão é um diagnóstico inicial e não constitui prova de vulnerabilidade nem inventário exaustivo de autorização. Permanecem como próximos passos:

1. Confirmar associações diretas e indiretas relevantes para papéis com privilégios amplos.
2. Inspecionar privilégios em objetos relevantes e, se necessário, privilégios por coluna e sequências.
3. Registrar conclusões finais e evidências aprovadas.
4. Verificar a compatibilidade do pgAudit com PostgreSQL 18.6 no Windows antes de alterar configuração.
5. Implementar e validar a coleta de logs no Elasticsearch e as consultas/dashboards no Kibana.

Nenhuma permissão foi alterada nesta etapa. A configuração do pgAudit, a ingestão no Elasticsearch e os dashboards no Kibana ainda não estão validados.

## 8. Evidências

As capturas de tela foram recebidas durante a conversa, mas não foram incluídas automaticamente neste pacote. Adicione apenas capturas reais aprovadas para publicação, com texto legível e sem dados sensíveis.
