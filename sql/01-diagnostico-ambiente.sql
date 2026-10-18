-- Objetivo: identificar versão do PostgreSQL, banco e usuário da sessão.
-- Consulta somente leitura.
SELECT
    version() AS versao_postgresql,
    current_database() AS banco_atual,
    current_user AS usuario_atual;
