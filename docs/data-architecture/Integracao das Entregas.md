# Entrega 8 — Integração das Entregas

A arquitetura final interliga os conceitos de forma estruturada:

1. **Data Integration:** Clientes acessam via HTTPS/TLS. Webhooks e sistemas externos comunicam-se via APIs REST e RabbitMQ.
2. **Data Security:** O API Gateway faz o Rate Limiting e valida os tokens JWT (RBAC), repassando as requisições seguras para os microserviços.
3. **Data Architecture & Modeling:** Os serviços processam a regra de negócio e interagem com o PostgreSQL (OLTP) modelado em 3FN, com Row-Level Security ativado para isolar inquilinos/clientes.
4. **Data Storage:** O PostgreSQL cuida da persistência relacional; o Redis gerencia o cache e as sessões em milissegundos; o S3 guarda documentos e backups. Os dados transacionais são assincronamente exportados para a Read-Replica (OLAP) e Data Lake para analytics.