# Etapa 1 — Preparação e reconhecimento do ambiente

## 1. Objetivo

Reconhecer o ambiente PostgreSQL utilizado no laboratório, listar as tabelas disponíveis e inspecionar a estrutura da tabela `customer` antes de propor melhorias de segurança.

## 2. Ambiente

- Banco de demonstração: `dvdrental`
- SGBD identificado: PostgreSQL 18.6
- Sistema reportado pela versão: Windows 64-bit
- Esquema analisado: `public`

O nome do banco `dvdrental` foi informado durante a preparação do laboratório. A saída compartilhada da primeira consulta exibiu a versão do PostgreSQL; não foi registrada a saída completa com `current_database()` e `current_user`.

## 3. Diagnóstico inicial

Script: [`../sql/01-diagnostico-ambiente.sql`](../sql/01-diagnostico-ambiente.sql)

A consulta inicial usa `current_database()`, `current_user` e `version()` para identificar o banco ativo, o papel conectado e a versão do servidor.

**Resultado compartilhado:** PostgreSQL 18.6, compilação para Windows 64-bit.

## 4. Inventário de tabelas

Script: [`../sql/02-inventario-tabelas.sql`](../sql/02-inventario-tabelas.sql)

Foram identificadas 15 tabelas no esquema `public`:

`actor`, `address`, `category`, `city`, `country`, `customer`, `film`, `film_actor`, `film_category`, `inventory`, `language`, `payment`, `rental`, `staff` e `store`.

## 5. Estrutura da tabela `customer`

Script: [`../sql/03-estrutura-customer.sql`](../sql/03-estrutura-customer.sql)

A consulta aos metadados retornou 10 colunas:

| Coluna | Tipo reportado | Aceita NULL? |
|---|---|---|
| `customer_id` | `integer` | Não |
| `store_id` | `smallint` | Não |
| `first_name` | `character varying` | Não |
| `last_name` | `character varying` | Não |
| `email` | `character varying` | Sim |
| `address_id` | `smallint` | Não |
| `activebool` | `boolean` | Não |
| `create_date` | `date` | Não |
| `last_update` | `timestamp without time zone` | Sim |
| `active` | `integer` | Sim |

Nomes e e-mails podem ser dados pessoais em cenários reais. Por isso, o projeto evita publicar valores de registros sem necessidade; o foco desta etapa são os metadados e o comportamento das consultas.

## 6. Caso 1 — Minimização de dados

Script: [`../sql/04-minimizacao-de-dados.sql`](../sql/04-minimizacao-de-dados.sql)

### Cenário

Simular uma atividade em que o usuário precisa apenas do identificador e do nome de clientes ativos. O objetivo é comparar uma consulta ampla com outra que retorna apenas os campos necessários.

### Consulta A — seleção ampla

```sql
SELECT *
FROM customer
WHERE activebool = TRUE
LIMIT 10;
```

### Consulta B — seleção explícita

```sql
SELECT
    customer_id,
    first_name,
    last_name
FROM customer
WHERE activebool = TRUE
LIMIT 10;
```

### Resultado observado

- Consulta A: 10 colunas retornadas.
- Consulta B: 3 colunas retornadas.
- Diferença: 7 colunas a menos no resultado, ou 70% menos colunas.

### Análise

A Consulta B limita o resultado aos campos necessários para o cenário simulado. Isso reduz a exposição desnecessária de campos no resultado da consulta e explicita a intenção do código.

Não é correto concluir que o risco total caiu 70%. Contagem de colunas não é uma métrica direta de risco. Além disso, selecionar menos colunas não substitui controles de autorização no banco de dados.

### Recomendação

Selecionar explicitamente as colunas necessárias à finalidade da consulta e, em paralelo, aplicar permissões adequadas ao papel que executará a atividade.

### Evidências

Adicionar em `../evidencias/` capturas de tela das duas consultas e seus resultados, ocultando valores de registros que não sejam necessários para comprovar a diferença de colunas.

## 7. Situação e próximo passo

A preparação e o primeiro caso de minimização de dados foram executados e os resultados foram compartilhados. O próximo passo é consultar os privilégios de `public.customer` antes de alterar permissões ou criar papéis de teste.

## 8. Cuidados de segurança

- Executar o laboratório apenas em ambiente próprio ou autorizado.
- Não publicar senhas, strings de conexão, dados pessoais desnecessários ou informações de outros sistemas.
- Não aplicar alterações de privilégios antes de revisar o estado atual e planejar como reverter os testes.
