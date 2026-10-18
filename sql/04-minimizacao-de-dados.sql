-- Caso 1A: consulta ampla para fins de comparação.
-- Retorna todas as colunas; LIMIT restringe a quantidade de linhas,
-- mas não restringe a quantidade de colunas retornadas.

SELECT *
FROM customer
WHERE activebool = TRUE
LIMIT 10;


-- Caso 1B: selecionar explicitamente apenas as colunas necessárias
-- ao cenário simulado (identificador e nome do cliente).

SELECT
    customer_id,
    first_name,
    last_name
FROM customer
WHERE activebool = TRUE
LIMIT 10;

-- Resultado observado no laboratório:
-- Caso 1A: 10 colunas.
-- Caso 1B: 3 colunas.
--
-- Nota: a seleção explícita reduz a exposição no resultado,
-- mas não substitui privilégios de acesso no banco.
