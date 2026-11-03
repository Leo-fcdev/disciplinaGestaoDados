# Entrega 6 — Data Security

## A. Identificação e Classificação
* **Públicos:** Catálogos, preços, contatos institucionais.
* **Internos:** Documentação de arquitetura, métricas, código-fonte.
* **Confidenciais:** Contratos, faturamento.
* **Sensíveis (LGPD):** Nomes completos, CPFs, senhas, logs de acesso.

## B. Controle de Acesso
* **Administrador:** Acesso completo com auditoria.
* **Operador:** Acesso operacional, dados sensíveis mascarados.
* **Cliente:** Acesso estrito aos próprios dados (Row-Level Security - RLS).
* **Sistema Externo:** Acesso restrito a endpoints específicos.

## C. Autenticação e Autorização
* **Autenticação:** OAuth 2.0 e JWT (RS256) com MFA exigido para admins.
* **Autorização:** RBAC (Role-Based Access Control) embutido no token JWT.
* **Tentativas Inválidas:** Retorno 401/403 e bloqueio de IP após 5 falhas (Rate Limiting).

## D. Proteção dos Dados
* **Transmissão:** HTTPS / TLS 1.3.
* **Armazenamento:** Encriptação AES-256 no disco. Hash Argon2id/bcrypt para senhas.
* **Processamento:** Segredos gerenciados por Secrets Manager e injetados via variáveis de ambiente.

## E. Auditoria
Registro imutável em `audit_logs` contemplando: Ação (INSERT/UPDATE/DELETE), Tabela, ID do registro, Usuário, IP, Timestamp e valores antigos/novos.

## F. Riscos e Mitigações
1. **Vazamento de senha:** (Alto) -> Uso de hash lento Argon2id.
2. **Acesso indevido:** (Alto) -> RBAC e RLS no banco de dados.
3. **Interceptação de dados:** (Alto) -> Obrigatório HTTPS/TLS 1.3.
4. **Injeção de SQL:** (Alto) -> ORM e Prepared Statements.
5. **Exclusão acidental:** (Médio) -> Soft Delete e Backups imutáveis.