DROP DATABASE ProjetoSalaoDeBeleza;
CREATE DATABASE ProjetoSalaoDeBeleza;
Use ProjetoSalaoDeBeleza;

CREATE TABLE Usuario (
  idUsuario INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(75),
  email VARCHAR(100) UNIQUE,
  cpf CHAR(11) UNIQUE,
  cep CHAR(8),
  dtNasc DATE,
  telefone CHAR(11),
  fidelidade VARCHAR(50),
  senha VARCHAR(50),
  CONSTRAINT fidelidade_check CHECK (fidelidade IN ('FIEL', 'NOVA'))
);

insert into Usuario Values
(default, 'Felipe', 'Felipe@gmail,com', '12345678912', '12345678', '2006-03-03', '11950310303', 'FIEL', 'teste'),
(default, 'Miguel', 'Miguel@gmail,com', '12345678913', '12345678', '2006-01-01', '11950310303', 'FIEL', 'teste'),
(default, 'Murilo', 'Murilo@gmail,com', '12345678916', '12345678', '2006-02-02', '11950310303', 'NOVA', 'teste'),
(default, 'Fabricio', 'fabricio@gmail,com', '12345678917', '12345678', '2006-04-04', '11950310303', 'NOVA', 'teste');

Select * from Usuario;


CREATE TABLE Funcionario (
idFuncionario INT PRIMARY KEY auto_increment,
nome VARCHAR(75),
email VARCHAR(100) UNIQUE,
cpf CHAR(11) UNIQUE,
telefone CHAR(11),
cargo VARCHAR(50),
senha VARCHAR(50),
Constraint cargoCheck CHECK(cargo in ('DONO', 'FUNCIONARIO'))
);

Insert into Funcionario values
(default, 'Enzo', 'Enzo@gmail.com', '12345678903', '11950310303', 'DONO', 'teste'),
(default, 'Lucas', 'Lucas@gmail.com', '12345678900', '11950310303', 'FUNCIONARIO', 'teste');

Select * from Funcionario;


Create table Servico (
idServico INT PRIMARY KEY AUTO_INCREMENT,
tipo VARCHAR(50),
preco DECIMAL(5,2),
precoDesconto DECIMAL(5,2),
descricao VARCHAR(200),
categoria VARCHAR(75),
imagem VARCHAR(255),
CONSTRAINT categoriaCheck CHECK (categoria IN ('UNHA', 'CABELO', 'DEPILAÇÃO'))
);

insert into Servico values
(default, 'Unha das mãos', '50.50', '25.00', 'descricao teste', 'UNHA', 'imagem teste'),
(default, 'Corte de cabelo Feminino', '100.00', '50.00', 'descricao teste', 'CABELO', 'imagem teste'),
(default, 'Depilação a laser', '120.50', '60.25', 'descricao teste', 'DEPILACÃO', 'imagem teste');

select * from Servico;

CREATE TABLE Agendamento (
idAgendamento int primary key auto_increment,
fkUsuario INT,
fkFuncionario INT,
fkServico INT,
dia DATE,
hora TIME,
Duracao varchar(50),
constraint fkUsuarioAgendamento foreign key (fkUsuario) references Usuario(idUsuario),
constraint fkFuncionarioAgendamento foreign key (fkFuncionario) references Funcionario(idFuncionario),
constraint fkServicoAgendamento foreign key (fkServico) references Servico(idServico)
);

insert into Agendamento values
(default, 1, 1, 1, '2025-03-03', '14:30:00', '1 Hora'), 
(default, 2, 1, 1, '2025-03-03', '15:30:00', '1 Hora'), 
(default, 3, 2, 2, '2025-03-03', '16:30:00', '1 Hora'), 
(default, 4, 2, 3, '2025-03-03', '17:30:00', '1 Hora');

select * from Agendamento;


select * from Agendamento
join Usuario u on fkusuario = u.idUsuario
join Funcionario f on fkFuncionario = f.idFuncionario
join servico s on fkServico = s.idServico;

select u.nome,
u.fidelidade,
f.nome,
f.cargo,
s.tipo,
s.preco,
s.categoria,
a.dia,
a.hora,
a.duracao from Agendamento a
join Usuario u on fkUsuario = u.idUsuario
join Funcionario f on fkFuncionario = f.idFuncionario
join Servico s on fkServico = s.idServico;



CREATE TABLE Pagamento (
idPreco INT PRIMARY KEY auto_increment,
formaPagamento VARCHAR(100),
dataPagamento datetime,
numeroTransacao Varchar(255),
fkPagamento int,
constraint fkUsuarioPagamento foreign key (fkPagamento) references Usuario(idUsuario),
constraint formacheck CHECK (formaPagamento in ('DEBITO', 'CREDITO', 'PIX'))
);

insert into Pagamento values 
(default, 'DEBITO', '2025-03-03 14:30:00', '2hr3uygh37n3uth73', 1),
(default, 'CREDITO', '2025-03-03 14:30:00', '2hr3uygh37n3uth73', 2),
(default, 'PIX', '2025-03-03 14:30:00', '2hr3uygh37n3uth73', 3),
(default, 'PIX', '2025-03-03 14:30:00', '2hr3uygh37n3uth73', 4);

select u.nome,
u.fidelidade,
f.nome,
f.cargo,
s.tipo,
s.preco,
s.categoria,
a.dia,
a.hora,
a.duracao, 
p.formaPagamento,
p.numeroTransacao from Agendamento a
join Usuario u on fkUsuario = u.idUsuario
join Funcionario f on fkFuncionario = f.idFuncionario
join Servico s on fkServico = s.idServico
join Pagamento p on fkPagamento = u.idUsuario;


CREATE TABLE Feedback (
idFeedback int primary key auto_increment,
comentario VARCHAR(200),
nota INT,
fkFeedback int,
constraint fkFeedbackUsuario foreign key (fkFeedback) references Usuario(idUsuario),
constraint notacheck CHECK (nota in (1,2,3,4,5))
);

insert into Feedback values 
(default, 'comentario teste', 4, 1),
(default, 'comentario teste', 3, 2),
(default, 'comentario teste', 5, 3),
(default, 'comentario teste', 5, 4);

select u.nome,
u.fidelidade,
f.nome,
f.cargo,
s.tipo,
s.preco,
s.categoria,
a.dia,
a.hora,
a.duracao, 
p.formaPagamento,
p.numeroTransacao,
fb.comentario,
fb.nota from Agendamento a
join Usuario u on fkUsuario = u.idUsuario
join Funcionario f on fkFuncionario = f.idFuncionario
join Servico s on fkServico = s.idServico
join Pagamento p on fkPagamento = u.idUsuario
join Feedback fb on fkFeedback = u.idUsuario;
