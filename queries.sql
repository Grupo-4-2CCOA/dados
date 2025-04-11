-- queries.sql:
-- queries simples:
select
  *
  from `user`;

select
  *
  from `employee`;

select
  *
  from `service`;

select
  *
  from `schedule`;

select
  *
  from `payment`;

select
  *
  from `feedback`;

-- query completa: agendamentos com usuários, funcionários, serviços, categorias, métodos de pagamento e feedbacks (somente informações importantes e públicas)

-- agendamentos da semana, mês e últimos 28-35 (quantos agendamentos foram feitos no momento atual: current_timestamp)
-- atendimentos (mesmas 3 métricas de tempo) (quantos atendimentos serão feitos no momento atual: current_timestamp)
-- query completa (para as mesmas 3 métricas de tempo)

-- agendamentos por semana e mês (quantos agendamentos foram feitos por período: group by)
-- atendimentos (mesmas 2 métricas de tempo) (quantos atendimentos serão feitos por período: group by)
-- query completa (para as mesmas 2 métricas de tempo)

-- atendimentos realizados (mesmas 5 métricas de tempo, 3 momentâneas e 2 agrupadas)
-- atendimentos cancelados (mesmas 5 métricas de tempo, 3 momentâneas e 2 agrupadas)
-- taxa de atendimentos realizados (mesmas 5 métricas de tempo, 3 momentâneas e 2 agrupadas)

-- ganhos por serviço (mesmas 5 métricas de tempo, 3 momentâneas e 2 agrupadas)
