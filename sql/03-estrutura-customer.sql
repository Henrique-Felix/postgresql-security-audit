-- Etapa 1: inspecionar metadados das colunas de public.customer.
-- Consulta somente de leitura; não retorna os valores dos registros.

SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'customer'
ORDER BY ordinal_position;
