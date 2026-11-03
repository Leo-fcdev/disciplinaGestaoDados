# Entrega 5 — Data Storage

## A. Armazenamento
**1. Tecnologias Utilizadas**
* **Banco Operacional (OLTP):** PostgreSQL 16.
* **Cache e Sessão:** Redis 7.2.
* **Armazenamento de Arquivos:** Amazon S3.
* **Ambiente Analítico (OLAP):** PostgreSQL Read-Replica / Data Lake.

**2. Justificativas**
* **PostgreSQL:** Conformidade ACID, suporte a JSONB e integridade referencial.
* **Redis:** Velocidade em memória para rate limiting e sessões.
* **S3:** Durabilidade e baixo custo para PDFs e imagens.

**3. Dados e Organização**
* **PostgreSQL:** Dados relacionais em 3FN, chaves UUIDv4, índices B-Tree/GIN. Volume: 25GB iniciais a 500GB na maturidade. Escala vertical e réplicas de leitura.
* **Redis:** Chave-valor com TTL.
* **S3:** Hierarquia de buckets por ano/mês/tipo.

## B. Persistência
* **Persistentes:** Usuários, transações, logs (PostgreSQL/S3).
* **Temporários:** Tokens, cache (Redis).
* **Operações:** Inserção via transações seguras, atualização via *Soft Delete* (`deleted_at`), exclusão física restrita a dados temporários ou exigência LGPD. Prevenção de duplicidade por constraints UNIQUE e idempotência.

## C. Backup e Recuperação
* **Estratégia:** Snapshot diário (S3 WORM) + WAL Streaming a cada 5 min (PITR).
* **Retenção:** 30 dias (diário), 12 meses (mensal), 5 anos (anual).
* **Recuperação:** Restauração de snapshot + WAL. RPO < 5 min, RTO < 1 hora.

## D. Transacional vs Analítico
* **Operacional:** Mantém dados de alta cardinalidade no PostgreSQL primário (escritas rápidas).
* **Analítico:** Réplica de leitura ou Data Lake para histórico e relatórios de BI, sem impactar a latência do cliente.