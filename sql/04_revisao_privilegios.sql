/*
Projeto: Auditoria e Segurança de Banco de Dados PostgreSQL
Etapa: revisão inicial de papéis e privilégios
Ambiente de referência: PostgreSQL 18.6 / dvdrental
Todas as consultas abaixo são somente de leitura.
*/

-- 1. Contexto da sessão
SELECT
    current_database() AS banco_atual,
    current_user AS usuario_atual,
    session_user AS usuario_da_sessao,
    version() AS versao_postgresql;

-- 2. Inventário de papéis e atributos
SELECT
    rolname AS nome_papel,
    rolcanlogin AS pode_fazer_login,
    rolsuper AS superusuario,
    rolcreatedb AS pode_criar_bancos,
    rolcreaterole AS pode_criar_papeis,
    rolinherit AS herda_privilegios,
    rolreplication AS pode_replicar,
    rolbypassrls AS ignora_row_level_security
FROM pg_roles
ORDER BY rolname;

-- 3. Associações entre papéis
SELECT
    membro.rolname AS papel_membro,
    concedido.rolname AS papel_concedido,
    associacao.admin_option
FROM pg_auth_members AS associacao
JOIN pg_roles AS membro
    ON membro.oid = associacao.member
JOIN pg_roles AS concedido
    ON concedido.oid = associacao.roleid
ORDER BY membro.rolname, concedido.rolname;

-- 4. Privilégios efetivos sobre o banco e schema
SELECT
    r.rolname AS nome_papel,
    has_database_privilege(r.rolname, 'dvdrental', 'CONNECT') AS pode_conectar,
    has_database_privilege(r.rolname, 'dvdrental', 'CREATE') AS pode_criar_schemas_no_banco,
    has_database_privilege(r.rolname, 'dvdrental', 'TEMPORARY') AS pode_criar_tabelas_temporarias,
    has_schema_privilege(r.rolname, 'public', 'USAGE') AS pode_usar_schema,
    has_schema_privilege(r.rolname, 'public', 'CREATE') AS pode_criar_objetos_no_schema
FROM pg_roles AS r
ORDER BY r.rolname;

-- 5. Privilégios efetivos sobre public.customer
SELECT
    r.rolname AS nome_papel,
    has_table_privilege(r.rolname, 'public.customer', 'SELECT') AS pode_consultar,
    has_table_privilege(r.rolname, 'public.customer', 'INSERT') AS pode_inserir,
    has_table_privilege(r.rolname, 'public.customer', 'UPDATE') AS pode_atualizar,
    has_table_privilege(r.rolname, 'public.customer', 'DELETE') AS pode_excluir,
    has_table_privilege(r.rolname, 'public.customer', 'TRUNCATE') AS pode_truncar_tabela
FROM pg_roles AS r
ORDER BY r.rolname;

-- 6. Proprietário e ACL armazenada de public.customer
SELECT
    c.relname AS tabela,
    pg_get_userbyid(c.relowner) AS proprietario,
    c.relacl AS acl_armazenada
FROM pg_class AS c
JOIN pg_namespace AS n
    ON n.oid = c.relnamespace
WHERE n.nspname = 'public'
  AND c.relname = 'customer';

-- 7. Associações diretas para papéis de leitura/escrita ampla
SELECT
    membro.rolname AS papel_membro,
    concedido.rolname AS papel_concedido,
    associacao.admin_option
FROM pg_auth_members AS associacao
JOIN pg_roles AS membro
    ON membro.oid = associacao.member
JOIN pg_roles AS concedido
    ON concedido.oid = associacao.roleid
WHERE concedido.rolname IN ('pg_read_all_data', 'pg_write_all_data')
ORDER BY concedido.rolname, membro.rolname;
