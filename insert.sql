-- insert.sql:
-- inserção na tabela de usuários:
insert into
  `user`
values
  (default, 'felipe', 'felipe@gmail,com', '12345678912', '12345678', '2006-03-03', '11950310303', 'fiel', 'teste'),
  (default, 'miguel', 'miguel@gmail,com', '12345678913', '12345678', '2006-01-01', '11950310303', 'fiel', 'teste'),
  (default, 'murilo', 'murilo@gmail,com', '12345678916', '12345678', '2006-02-02', '11950310303', 'nova', 'teste'),
  (default, 'fabricio', 'fabricio@gmail,com', '12345678917', '12345678', '2006-04-04', '11950310303', 'nova', 'teste');

-- inserção na tabela de funcionários:
insert into
  `employee`
values
  (default, 'enzo', 'enzo@gmail.com', '12345678903', '11950310303', 'dono', 'teste'),
  (default, 'lucas', 'lucas@gmail.com', '12345678900', '11950310303', 'funcionario', 'teste');

-- inserção na tabela de serviços:
insert into
  `service`
values
  (default, 'unha das mãos', '50.50', '25.00', 'description teste', 'unha', 'image teste'),
  (default, 'corte de cabelo feminino', '100.00', '50.00', 'description teste', 'cabelo', 'image teste'),
  (default, 'depilação a laser', '120.50', '60.25', 'description teste', 'depilacão', 'image teste');

-- inserção na tabela de agendamentos:
insert into
  `schedule`
values
  (default, 1, 1, 1, '2025-03-03', '14:30:00', '1 hora'),
  (default, 2, 1, 1, '2025-03-03', '15:30:00', '1 hora'),
  (default, 3, 2, 2, '2025-03-03', '16:30:00', '1 hora'),
  (default, 4, 2, 3, '2025-03-03', '17:30:00', '1 hora');

-- inserção na tabela de métodos de pagamentos:
insert into
  `payment`
values
  (default, 'debito', '2025-03-03 14:30:00', '2hr3uygh37n3uth73', 1),
  (default, 'credito', '2025-03-03 14:30:00', '2hr3uygh37n3uth73', 2),
  (default, 'pix', '2025-03-03 14:30:00', '2hr3uygh37n3uth73', 3),
  (default, 'pix', '2025-03-03 14:30:00', '2hr3uygh37n3uth73', 4);

-- inserção na tabela de feedbacks:
insert into
  `feedback`
values
  (default, 'comentario teste', 4, 1),
  (default, 'comentario teste', 3, 2),
  (default, 'comentario teste', 5, 3),
  (default, 'comentario teste', 5, 4);
