# Entrega 7 — Data Integration

## A. Sistemas Integrados
* **Origem:** Backend / API Gateway.
* **Destino:** Gateways de Pagamento, Serviços de Notificação, BI.
* **Motivo:** Processar transações, notificar clientes e consolidar métricas.

## B. Dados Integrados
Formato JSON (UTF-8) com schemas validados.
Exemplo:
```json
{
  "event_id": "evt_102938",
  "event_type": "ORDER_CREATED",
  "payload": {
    "order_id": "ord_550e84",
    "customer": { "id": "usr_789", "email": "leo@exemplo.com" },
    "payment": { "method": "PIX", "amount": 15000 }
  }
}
```

## C. Forma de Integração
* **REST API:** Síncrono, latência baixa (autenticação, consultas).
* **Webhooks:** Recebimento assíncrono (confirmações externas).
* **Mensageria (RabbitMQ):** Desacoplamento interno e fila de eventos.

## E. Tratamento de Erros e Consistência
* **Indisponibilidade:** Retry automático com Exponential Backoff e Dead Letter Queue (DLQ).
* **Timeout:** Padrão Circuit Breaker.
* **Consistência:** Chaves de idempotência verificadas no Redis, versionamento de concorrência otimista (updates) e reconciliação diária de dados.