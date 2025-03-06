-- insert.sql:

insert into usuario values
(default, 'felipe', 'felipe@gmail,com', '12345678912', '12345678', '2006-03-03', '11950310303', 'fiel', 'teste'),
(default, 'miguel', 'miguel@gmail,com', '12345678913', '12345678', '2006-01-01', '11950310303', 'fiel', 'teste'),
(default, 'murilo', 'murilo@gmail,com', '12345678916', '12345678', '2006-02-02', '11950310303', 'nova', 'teste'),
(default, 'fabricio', 'fabricio@gmail,com', '12345678917', '12345678', '2006-04-04', '11950310303', 'nova', 'teste');

insert into funcionario values
(default, 'enzo', 'enzo@gmail.com', '12345678903', '11950310303', 'dono', 'teste'),
(default, 'lucas', 'lucas@gmail.com', '12345678900', '11950310303', 'funcionario', 'teste');

insert into servico values
(default, 'unha das mãos', '50.50', '25.00', 'description teste', 'unha', 'image teste'),
(default, 'corte de cabelo feminino', '100.00', '50.00', 'description teste', 'cabelo', 'image teste'),
(default, 'depilação a laser', '120.50', '60.25', 'description teste', 'depilacão', 'image teste');

insert into agendamento values
(default, 1, 1, 1, '2025-03-03', '14:30:00', '1 hora'), 
(default, 2, 1, 1, '2025-03-03', '15:30:00', '1 hora'), 
(default, 3, 2, 2, '2025-03-03', '16:30:00', '1 hora'), 
(default, 4, 2, 3, '2025-03-03', '17:30:00', '1 hora');
