# PostgreSQL Security & Database Auditing

> **Status:** Em desenvolvimento  
> **Tipo:** Projeto pessoal de laboratório  
> **Tecnologias:** PostgreSQL 18.6, SQL, Git e GitHub

## Sobre o projeto

Este projeto documenta um laboratório pessoal de análise de segurança e auditoria de consultas SQL utilizando o banco de demonstração `dvdrental` no PostgreSQL.

O objetivo é praticar e demonstrar, de forma reproduzível, como analisar consultas, reduzir a exposição desnecessária de dados, revisar permissões de acesso e examinar registros de atividades em um ambiente controlado.

**Este é um projeto educacional.** Não representa experiência profissional em uma implantação corporativa de Database Activity Monitoring (DAM), nem utiliza dados ou sistemas internos de empregadores.

## Objetivos

- Inspecionar a estrutura de um banco PostgreSQL.
- Comparar consultas SQL que retornam todas as colunas com consultas que selecionam apenas os campos necessários.
- Estudar o princípio do menor privilégio usando usuários e permissões de laboratório.
- Simular a análise de atividades e registros relevantes.
- Documentar riscos, evidências, limitações e recomendações técnicas.

## Ambiente utilizado

- Banco de dados: `dvdrental` (banco de demonstração informado para o laboratório).
- SGBD: PostgreSQL 18.6, em ambiente Windows 64-bit.
- Ferramenta de consulta: pgAdmin ou Query Tool PostgreSQL utilizado no ambiente local.

## Estrutura do repositório

```text
postgresql-security-audit/
├── README.md
├── docs/
│   └── 01-preparacao-do-ambiente.md
├── sql/
│   ├── 01-diagnostico-ambiente.sql
│   ├── 02-inventario-tabelas.sql
│   ├── 03-estrutura-customer.sql
│   └── 04-minimizacao-de-dados.sql
├── evidencias/
│   └── README.md
└── relatorios/
    └── README.md
```

## Etapas do laboratório

- [x] **Etapa 1 — Preparação e reconhecimento do ambiente:** identificação da versão do PostgreSQL, inventário de tabelas e inspeção da tabela `customer`.
- [x] **Caso 1 — Minimização de dados em consultas:** comparação entre `SELECT *` e seleção explícita de três colunas.
- [ ] **Etapa 2 — Revisão de permissões:** inspecionar privilégios e preparar testes isolados com usuários de laboratório.
- [ ] **Etapa 3 — Auditoria de atividades:** avaliar opções de registro e analisar eventos de teste.
- [ ] **Etapa 4 — Relatório técnico:** consolidar evidências, resultados e recomendações.

Uma etapa só será marcada como concluída após a execução e validação dos testes correspondentes.

## Caso 1 — Minimização de dados

Foi analisada a tabela `public.customer`, cuja estrutura possui 10 colunas. Em seguida, foram executadas duas consultas:

- Consulta A: `SELECT *` com filtro de clientes ativos e limite de 10 registros.
- Consulta B: seleção explícita de `customer_id`, `first_name` e `last_name`, com o mesmo filtro e limite.

**Resultado observado:** a primeira consulta retornou 10 colunas e a segunda retornou 3. Isso representa 70% menos colunas no resultado, mas não significa uma redução de 70% no risco total.

**Interpretação:** selecionar apenas os campos necessários pode reduzir a exposição desnecessária no resultado e tornar a intenção da consulta mais clara. Essa prática, isoladamente, não restringe as permissões do usuário nem impede que ele execute outra consulta com mais colunas.

## Como reproduzir

1. Tenha o PostgreSQL instalado e uma cópia de demonstração do banco `dvdrental`.
2. Abra o Query Tool no banco de demonstração.
3. Execute os scripts da pasta `sql/` na ordem numérica.
4. Compare os resultados com as observações registradas em `docs/`.
5. Registre capturas de tela sem expor credenciais ou informações desnecessárias.

Os scripts desta etapa são de leitura. As próximas etapas que criarem papéis ou alterarem privilégios terão instruções de execução, pré-requisitos e avisos específicos.

## Limitações

- O ambiente é um laboratório local, não um sistema de produção.
- A comparação inicial demonstra minimização de dados retornados, não um controle completo de acesso.
- Os resultados e capturas devem ser interpretados no contexto da versão e das permissões locais.
- Não há, nesta fase, integração com uma plataforma corporativa de DAM.

## Próximos passos

A próxima atividade é inspecionar os privilégios registrados para `public.customer` e planejar um teste isolado de controle de acesso.

---
Projeto educacional desenvolvido para estudo e portfólio de Segurança da Informação e bancos de dados.
