# TorcePlus Sistemas

Sistema de gestão de sócio torcedor para clubes de futebol.

## Sobre a empresa

**Segmento:** Software para gestão esportiva, com foco em programas de sócio torcedor.

**Missão:** Ajudar clubes a transformar torcedores em sócios engajados, entregando ferramentas de gestão, comunicação e monetização da base de associados.

**Visão:** Ser a plataforma de referência em sócio torcedor para clubes de médio e pequeno porte no Brasil até 2030.

**Valores:**
- Transparência com o torcedor e com o clube
- Proteção de dados como prioridade, não como obrigação legal
- Simplicidade de uso para times pequenos sem estrutura de TI
- Compromisso com a paixão do futebol, sem perder o rigor técnico

## Produtos e serviços

- **TorcePlus Core** — plataforma web/mobile de gestão de sócio torcedor (cadastro, planos, cobrança recorrente, benefícios)
- **TorcePlus Ingressos** — módulo de venda e check-in de ingressos integrado ao cadastro de sócios
- **TorcePlus Insights** — painel de indicadores para o clube (inadimplência, engajamento, churn, receita recorrente)
- **App do Torcedor** — aplicativo para o sócio acompanhar benefícios, carteirinha digital e histórico de pagamentos

## Clientes

Clubes de futebol das séries B, C e D, e clubes de outras modalidades (basquete, vôlei) que têm programa de sócio torcedor ou querem lançar um.

## Fornecedores e parceiros

| Parceiro | Função |
|---|---|
| Gateway de pagamento (ex: Pagar.me, Stripe) | Processamento de cobranças recorrentes |
| Provedor de nuvem (AWS) | Hospedagem da infraestrutura |
| Bureau de crédito | Validação de CPF e checagem de inadimplência |
| Emissoras/parceiros de mídia do clube | Integração de conteúdo exclusivo para sócios |
| Empresas de bilheteria | Integração para venda de ingressos com desconto de sócio |

## Organograma

```
Diretoria Executiva
├── Diretoria de Produto
│   ├── Time de Produto (PO/PM)
│   └── Time de UX/Design
├── Diretoria de Engenharia
│   ├── Squad Backend
│   ├── Squad Mobile
│   └── Squad de Dados/Infra
├── Diretoria Comercial
│   ├── Vendas (novos clubes)
│   └── Customer Success (clubes ativos)
└── Diretoria de Operações
    ├── Suporte ao torcedor
    └── Financeiro/Jurídico
```

## Principais processos

- Onboarding de um novo clube na plataforma
- Cadastro e ativação de novo sócio torcedor
- Cobrança recorrente e tratamento de inadimplência
- Emissão de carteirinha digital e liberação de benefícios
- Atendimento e suporte ao torcedor
- Geração de relatórios gerenciais para o clube

## Objetivos estratégicos

1. Reduzir a taxa de inadimplência dos clubes clientes em 15% no primeiro ano de uso da plataforma
2. Fechar contrato com 20 novos clubes até o fim de 2027
3. Diminuir o tempo de onboarding de um clube novo de 30 para 10 dias
4. Garantir conformidade total com a LGPD em todos os módulos do sistema

---

# Sistema TorcePlus Core — Levantamento de Dados

## Dados que o sistema produz e utiliza

**Dados de entrada (fornecidos pelo torcedor ou pelo clube):**
- Dados cadastrais: nome, CPF, data de nascimento, endereço, telefone, e-mail
- Dados de pagamento: cartão de crédito (tokenizado), histórico de cobranças, forma de pagamento escolhida
- Plano de sócio contratado e data de adesão
- Preferências: time do coração dentro do clube (categoria/torcida organizada), setor preferido do estádio

**Dados gerados pelo sistema:**
- Status de adimplência/inadimplência
- Histórico de check-ins em jogos
- Pontuação de engajamento (frequência de uso do app, presença em jogos)
- Logs de acesso e uso da plataforma
- Relatórios agregados de receita, churn e ocupação de setores

## Quem utiliza esses dados

| Usuário | Uso |
|---|---|
| Torcedor/sócio | Consulta seus próprios dados, pagamentos e benefícios pelo app |
| Time de atendimento do clube | Consulta cadastro e histórico para resolver chamados |
| Financeiro do clube | Acompanha inadimplência e receita recorrente |
| Marketing do clube | Usa dados de engajamento para campanhas segmentadas |
| Bilheteria/operação do jogo | Valida check-in e direito a ingresso com desconto |
| Diretoria do clube | Consome relatórios agregados (TorcePlus Insights) |
| Equipe interna da TorcePlus | Suporte técnico, manutenção, evolução do produto |

## Onde os dados são armazenados

- Banco de dados relacional em nuvem (AWS RDS), com backup diário
- Dados de cartão de pagamento **não ficam armazenados na TorcePlus** — apenas o token retornado pelo gateway de pagamento
- Logs de aplicação em serviço de observabilidade na nuvem, com retenção de 90 dias
- Documentos de identificação (quando exigidos por algum clube) armazenados em bucket criptografado, separado do banco principal

## Dados sensíveis

- CPF e RG
- Dados de pagamento (mesmo tokenizados, exigem tratamento cuidadoso)
- Dados de menores de idade (planos familiares/infantis de sócio torcedor)
- Eventualmente, dados de saúde (ex: sócio que solicita meia-entrada por deficiência) — categoria de dado sensível pela LGPD

## Problemas relacionados aos dados

- Cadastros duplicados quando o torcedor se recadastra com e-mails diferentes
- Dados desatualizados (endereço, telefone) que afetam comunicação e cobrança
- Inconsistência entre o cadastro no sistema e a base antiga do clube (planilhas, sistemas legados) durante migração
- Falta de padronização de dados entre clubes diferentes na mesma plataforma

## Riscos

- Vazamento de dados cadastrais e de pagamento (risco reputacional e jurídico, LGPD)
- Uso indevido de dados de menores sem consentimento adequado dos responsáveis
- Dependência de fornecedor único de gateway de pagamento (risco operacional)
- Acesso indevido de funcionários do clube a dados fora do escopo do seu trabalho (falta de controle de permissões)
- Ataques de força bruta ou fraude em cadastros para obter benefícios de sócio indevidamente

## Necessidades do negócio

- Sistema de permissões por perfil de usuário dentro do clube (financeiro, marketing, atendimento não devem ter o mesmo nível de acesso)
- Anonimização/agregação de dados para relatórios de marketing, evitando exposição de dados individuais
- Processo formal de consentimento (LGPD) no cadastro, com clareza sobre uso de dados de menores
- Rotina de auditoria de acessos aos dados sensíveis
- Política de retenção e descarte de dados de sócios inativos há mais de X anos
