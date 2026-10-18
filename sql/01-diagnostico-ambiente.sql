-- Etapa 1: identificar o banco, o papel conectado e a versão.
-- Consulta somente de leitura.

SELECT
    current_database() AS banco_atual,
    current_user AS usuario_atual,
    version() AS versao_postgresql;
