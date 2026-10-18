-- Objetivo: listar tabelas e views do schema public.
-- Observação: o resultado observado nesta execução apresentou 22 objetos,
-- incluindo BASE TABLE e VIEW. Não interpretar todos como tabelas-base.
SELECT
    table_schema,
    table_name,
    table_type
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;
