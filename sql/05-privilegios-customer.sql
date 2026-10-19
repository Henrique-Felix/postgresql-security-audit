-- Objetivo: listar privilégios de tabela visíveis para public.customer.
-- Consulta somente leitura; não altera permissões.
SELECT
    grantee AS usuario_ou_papel,
    privilege_type AS privilegio,
    is_grantable AS pode_conceder
FROM information_schema.role_table_grants
WHERE table_schema = 'public'
  AND table_name = 'customer'
ORDER BY grantee, privilege_type;
