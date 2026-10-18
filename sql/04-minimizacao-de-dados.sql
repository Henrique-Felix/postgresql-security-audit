-- Comparação didática: retornar todas as colunas versus somente as necessárias.
-- Exemplo 1: expõe todas as colunas disponíveis no resultado.
SELECT *
FROM public.customer
WHERE activebool = TRUE
LIMIT 10;

-- Exemplo 2: retorna somente os campos necessários para este exemplo.
SELECT
    customer_id,
    first_name,
    last_name
FROM public.customer
WHERE activebool = TRUE
LIMIT 10;
