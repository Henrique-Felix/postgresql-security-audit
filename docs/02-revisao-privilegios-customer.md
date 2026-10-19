# Etapa 4 — Revisão de privilégios da tabela `public.customer`

## Objetivo
Identificar os privilégios de tabela apresentados pela visão `information_schema.role_table_grants` para `public.customer`, sem modificar configurações ou permissões.

## Consulta executada
Arquivo reproduzível: [`sql/05-privilegios-customer.sql`](../sql/05-privilegios-customer.sql)

```sql
SELECT
    grantee AS usuario_ou_papel,
    privilege_type AS privilegio,
    is_grantable AS pode_conceder
FROM information_schema.role_table_grants
WHERE table_schema = 'public'
  AND table_name = 'customer'
ORDER BY grantee, privilege_type;
```

## Evidência
![Resultado da revisão de privilégios da tabela customer](../evidencias/04-privilegios-customer.png)

## Resultado observado
A captura mostra 7 linhas para o grantee `postgres`: `DELETE`, `INSERT`, `REFERENCES`, `SELECT`, `TRIGGER`, `TRUNCATE` e `UPDATE`. A coluna `pode_conceder` aparece como `YES` para as sete linhas.

## Interpretação
`YES` na coluna `is_grantable` indica que o privilégio listado pode ser concedido pelo grantee a outros usuários/papéis, conforme o mecanismo de privilégios do PostgreSQL.

A consulta mostra o que esta visão informa sobre privilégios de tabela. Ela não constitui, isoladamente, um inventário completo de todos os privilégios efetivos, associações/heranças de papéis ou outras regras de segurança. O resultado observado não prova, por si só, a existência de uma vulnerabilidade: é necessário conhecer o contexto da conta e comparar os privilégios com a necessidade operacional.

## Cuidados e próximos passos
- Nenhuma permissão foi alterada.
- Não concluir que há privilégio excessivo apenas porque `postgres` tem privilégios amplos; primeiro verificar o papel da conta e os demais usuários/papéis.
- Na próxima etapa, investigar os papéis existentes e seus atributos, mantendo as consultas somente de leitura.
