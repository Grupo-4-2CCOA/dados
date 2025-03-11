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

-- agendamento, usuário, funcionário e serviço:
select
  *
  from `schedule` s
    join `user` u on s.`fk_user` = u.`id`
    join `employee` f on s.`fk_employee` = f.`id`
    join `service` se on s.`fk_service` = se.`id`;

-- agendamento, usuário e serviço (somente informações importantes e públicas):
select
  u.`name`,
  u.`fidelity`,
  f.`name`,
  f.`role`,
  se.`type`,
  se.`price`,
  se.`category`,
  s.`day`,
  s.`time`,
  s.`duration`
  from `schedule` s
    join `user` u on s.`fk_user` = u.`id`
    join `employee` f on s.`fk_employee` = f.`id`
    join `service` se on s.`fk_service` = se.`id`;

-- agendamento, usuário, serviço e método de pagamento (somente informações importantes e públicas):
select
  u.`name`,
  u.`fidelity`,
  f.`name`,
  f.`role`,
  se.`type`,
  se.`price`,
  se.`category`,
  a.`dia`,
  a.`hora`,
  a.`duracao`,
  p.`type`,
  p.`transaction`
  from `schedule` a
    join `user` u on s.`fk_user` = u.`id`
    join `employee` f on s.`fk_employee` = f.`id`
    join `service` se on s.`fk_service` = se.`id`
    join `payment` p on s.`fk_payment` = u.`id`;

-- agendamento, usuário, serviço, método de pagamento e feedback (somente informações importantes e públicas):
select
  u.`name`,
  u.`fidelity`,
  f.`name`,
  f.`role`,
  se.`type`,
  se.`price`,
  se.`category`,
  a.`dia`,
  a.`hora`,
  a.`duracao`,
  p.`type`,
  p.`transaction`,
  fb.`comment`,
  fb.`rating`
  from `schedule` s
    join `user` u on `fk_user` = u.`id`
    join `employee` f on `fk_employee` = f.`id`
    join `service` se on `fk_service` = se.`id`
    join `payment` p on `fk_payment` = u.`id`
    join `feedback` fb on `fk_feedback` = u.`id`;
