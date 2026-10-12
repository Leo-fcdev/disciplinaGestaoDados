

##A arquitetura de dados do TorcePlus foi redesenhada para unificar as funcionalidades transacionais (Core) e analíticas (Insights) em uma única plataforma integrada para os clubes.

### A. Sistemas Envolvidos
1. **TorcePlus App (Mobile/Web):** Interface do torcedor para cadastro, pagamento de assinaturas e resgate de descontos/benefícios.
2. **TorcePlus Platform (Web Admin):** A união do antigo Core com o Insights. É o portal onde a diretoria do clube gerencia os planos de sócio e também visualiza os dashboards analíticos de engajamento e inadimplência no mesmo ambiente.
3. **TorcePlus API (Backend):** O motor central de regras de negócio.
4. **Banco de Dados Operacional (Transacional):** AWS RDS (ex: PostgreSQL) para armazenar os dados do dia a dia.
5. **Storage de Arquivos:** AWS S3 para guardar documentos de identificação, termos e assets do clube (escudos, banners).
6. **Data Warehouse (Analítico):** AWS Redshift para processar grandes volumes de dados históricos e alimentar o módulo de Insights da plataforma.
7. **Integração Externa:** *Gateway de Pagamento* (ex: Pagar.me ou Stripe) para processamento das cobranças recorrentes.

### B. Fluxo de Dados
1. O clube configura seus dados institucionais, contas bancárias e planos de sócio diretamente na **TorcePlus Platform**.
2. O torcedor acessa o **TorcePlus App**, escolhe um plano e insere seus dados. A **API** salva as informações no **Banco Operacional**.
3. No momento da assinatura, os dados de cartão vão para o **Gateway de Pagamento**, que devolve apenas um *Token* de segurança.
4. Quando o torcedor utiliza um desconto em uma loja parceira (uso de benefício), isso é registrado na **API**.
5. Diariamente, um processo de ETL (Extração, Transformação e Carga) leva os dados do **Banco Operacional** para o **Data Warehouse**, limpando dados sensíveis (anonimização).
6. O módulo de Insights dentro da **TorcePlus Platform** consome os dados do **Data Warehouse** para exibir os gráficos de receita e churn para os gestores do clube, sem deixar o sistema principal lento.

### C. Transacional vs Analítico
* **Banco Operacional (Transacional / OLTP):** Focado no tempo de resposta rápido para o torcedor (ex: login, pagamento, atualização de cadastro). Trabalha com dados normalizados para garantir a integridade da cobrança mês a mês.
* **Data Warehouse (Analítico / OLAP):** Focado em leitura de grandes volumes de dados de forma rápida. Ele responde às perguntas do módulo Insights: "Qual a taxa de cancelamento de planos familiares neste semestre?" ou "Qual a previsão de receita para o mês que vem?".
