# Sistema de Gestão de Dados e Transações - Projeto Integrado

## 📌 Descrição do Sistema
Solução de arquitetura, modelagem, armazenamento, segurança e integração de dados desenvolvida para a disciplina de Gestão de Dados. O sistema foi projetado para alta concorrência (ACID), conformidade com LGPD e integrações via microsserviços.

## 💼 Valor para o Negócio (Entrega 9)
* **Storage:** Alta disponibilidade (Redis + Postgres) melhora a experiência do usuário e as conversões.
* **Security:** Criptografia e RBAC protegem contra vazamentos e multas.
* **Integration:** Automação reduz erros humanos e acelera fluxo de caixa.
* **Modeling:** Reduz redundâncias, garantindo relatórios confiáveis no ambiente OLAP para decisões estratégicas.

## 🛠️ Tecnologias Utilizadas
* Backend: Node.js / Java Spring Boot
* OLTP: PostgreSQL 16
* Cache/Mensageria: Redis 7.2 / RabbitMQ
* Storage: Amazon S3
* Segurança: JWT, Argon2id, TLS 1.3

## 📂 Documentação (Entregas)
* [Data Architecture & Modelo Lógico](docs/data-modeling/)
* [Data Storage](docs/data-storage/Data%20Storage.md)
* [Data Security](docs/data-security/Data%20Security.md)
* [Data Integration](docs/data-integration/Data%20Integration.md)
* [Arquitetura Integrada](docs/data-architecture/Integracao%20das%20Entregas.md)
