# Evidências iniciais do laboratório

## 00 — Diagnóstico do ambiente
**Arquivo:** `evidencias/00-diagnostico-ambiente.png`

Consulta executada:
```sql
SELECT
    version() AS versao_postgresql,
    current_database() AS banco_atual,
    current_user AS usuario_atual;
```

**Resultado observado:** PostgreSQL 18.6 em Windows x86_64; banco `dvdrental`; usuário da sessão `postgres`.

**Interpretação:** confirma o contexto da sessão usada no laboratório. Isso não comprova, por si só, que os privilégios do usuário estejam adequados ou inadequados.

## 01 — Diagnóstico detalhado
**Arquivo:** `evidencias/01-diagnostico-ambiente-detalhado.png`

Captura complementar da consulta de diagnóstico. A imagem mostra a versão do servidor, o banco conectado e o usuário atual.

## 02 — Inventário de objetos do schema `public`
**Arquivo:** `evidencias/02-inventario-objetos-public.png`

Consulta:
```sql
SELECT
    table_schema,
    table_name,
    table_type
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;
```

**Resultado observado:** 22 linhas/objetos. O resultado inclui objetos `BASE TABLE` e `VIEW`; portanto, o total de objetos não deve ser confundido com o número de tabelas-base.

## 03 — Estrutura de `public.customer`
**Arquivo:** `evidencias/03-estrutura-tabela-customer.png`

Consulta:
```sql
SELECT
    column_name,
    data_type,
    is_nullable,
    character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'customer'
ORDER BY ordinal_position;
```

**Resultado observado:** 10 colunas. Entre os campos exibidos estão `customer_id`, `first_name`, `last_name`, `email`, `activebool`, `create_date` e outros.

**Interpretação de segurança:** conhecer os campos e seus tipos ajuda a planejar consultas que retornem apenas os dados necessários. A presença de um campo como `email` não caracteriza, isoladamente, uma vulnerabilidade.

## Limitações
- O laboratório usa a base demonstrativa `dvdrental`.
- As consultas registradas até aqui são de inspeção e leitura.
- Ainda não foi concluída a revisão de privilégios; não foram alteradas permissões.
- As capturas documentam o que foi observado na interface, não uma auditoria independente do servidor.
