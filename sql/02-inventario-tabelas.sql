-- Etapa 1: listar tabelas físicas do esquema public.
-- Consulta somente de leitura.

SELECT
    table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'
ORDER BY table_name;
