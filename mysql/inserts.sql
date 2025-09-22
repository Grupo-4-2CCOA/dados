-- /inserts.sql:
-- inserção na tabela de usuários:
insert into
  `user`
  (`role`, `name`, `email`, `password`, `cpf`, `phone`, `cep`)
  values
  ('CUSTOMER', 'miguel', 'miguel@gmail,com', '12345678', '12345678913', '11950310304', 'teste'),
  ('EMPLOYEE', 'murilo', 'murilo@gmail,com', '12345678', '12345678916', '11950310305', 'teste'),
  ('OWNER', 'fabricio', 'fabricio@gmail,com', '12345678', '12345678917', '11950310306', 'teste');
-- inserção na tabela de métodos de pagamentos:
insert into
  `payment_type`
  (`name`)
  values
  ('debito'),
  ('credito'),
  ('pix'),
  ('dinheiro');
-- inserção na tabela de métodos de categoria:
insert into
  `category`
  (`name`)
  values
  ('Mão'),
  ('Cabelo'),
  ('Depilação'),
  ('Rosto');
-- inserção na tabela de serviços:
insert into
  `service`
  (`name`, `base_price`, `base_duration`, `fk_category`)
values
  ('Manicure', 50, 60, 1),
  ('Banho de Gel', 120, 90, 1),
  ('Escovação de cabelo', 30, 30, 2),
  ('Depilação de Axila', 25, 120, 3);
-- inserção na tabela de agendamentos:
insert into
  `schedule`
  (`status`, `appointment_datetime`, `fk_user`, `fk_payment_type`)
values
  ('ACTIVE', '2025-03-03 14:30:00', 1, 1),
  ('ACTIVE', '2025-03-03 15:30:00', 1, 2),
  ('ACTIVE', '2025-03-03 16:30:00', 2, 3),
  ('ACTIVE', '2025-03-03 17:30:00', 1, 3);
-- inserção na tabela de serviços por agendamentos:
insert into
  `schedule_item`
  (`final_price`, `fk_schedule`, `fk_service`)
values
  (50, 1, 1),
  (120, 2, 2),
  (30, 3, 3),
  (25, 4, 3);
-- inserção na tabela de feedbacks:
insert into
  `feedback`
  (`rating`, `comment`, `fk_schedule`, `fk_user`)
values
  (5, 'Excepcional', 1, 1),
  (5, 'Serviço de qualidade', 2, 2),
  (5, 'Rápido', 3, 3),
  (5, 'Ambiente acolhedor', 4, 3);
