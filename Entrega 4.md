#  Contribuição para os Objetivos de Negócio

A arquitetura e a modelagem propostas (com a unificação do Core e do Insights) atacam diretamente os objetivos estratégicos levantados pela TorcePlus na OAT 1:

1. **Redução da Inadimplência (15%):** A separação entre o Banco Operacional (RDS) e o Data Warehouse (Redshift) permite criar dashboards dinâmicos dentro da plataforma sem deixar o app do torcedor lento. O setor Financeiro consegue visualizar imediatamente pela tabela `Fato_Faturamento` quais torcedores estão com o cartão prestes a vencer ou com pagamentos atrasados, permitindo ações de cobrança proativas.

2. **Conformidade total com a LGPD:** Ao modelarmos o Data Warehouse, aplicamos a *anonimização* (a tabela `Dim_Torcedor_Anonimizado` guarda apenas faixa etária e cidade, deixando de fora Nome e CPF). Isso permite que o marketing do clube faça análises de comportamento e campanhas sem expor dados sensíveis. Além disso, a gestão estruturada dos termos físicos protege legalmente a relação com menores de idade.

3. **Diminuir o tempo de Onboarding (de 30 para 10 dias):** A modelagem transacional centralizada usando chaves estrangeiras (onde as tabelas de conta bancária, planos e torcedores apontam para o `clube_id`) cria uma arquitetura *Multi-tenant* (vários inquilinos no mesmo banco). O clube entra na base principal instantaneamente, bastando configurar seus dados bancários, eliminando a necessidade de criar um banco de dados isolado para cada novo cliente.

4. **Fechar contrato com 20 novos clubes:** Ao removermos integrações complexas (como a camada de catracas físicas) nesse momento, o sistema fica mais enxuto, estável e focado na dor principal dos clubes menores: gestão e monetização da base. Entregar o "Core" junto com "Insights" em uma única ferramenta web facilita as vendas, pois o clube não precisa contratar um sistema de BI à parte.
