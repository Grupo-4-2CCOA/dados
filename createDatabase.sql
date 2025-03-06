-- createDatabase.sql:
drop database if exists Grupo4;
create database if not exists Grupo4;

use Grupo4;

-- tabela de usuários:
create table user (
  id int primary key auto_increment,
  email varchar(100) unique,
  password varchar(50),
  phone char(11),
  fidelity enum('fiel', 'new'),
  name varchar(75),
  cpf char(11) unique,
  cep char(8),
  birth date
);
create table employee (
  id int primary key auto_increment,
  name varchar(75),
  email varchar(100) unique,
  password varchar(50),
  phone char(11),
  cpf char(11) unique,
  role enum("owner", "employee")
);
create table service (
  id int primary key auto_increment,
  type varchar(50),
  price decimal(5,2),
  discount decimal(5,2),
  description varchar(200),
  category varchar(75),
  image varchar(255)
);
create table schedule (
  id int primary key auto_increment,
  fk_user int,
  fkfuncionario int,
  fkservico int,
  dia date,
  hora time,
  duracao varchar(50),
  constraint fk_useragendamento foreign key (fk_user) references usuario(idusuario),
  constraint fkfuncionarioagendamento foreign key (fkfuncionario) references funcionario(idfuncionario),
  constraint fkservicoagendamento foreign key (fkservico) references servico(idservico)
);
create table payment(
  id int primary key auto_increment,
  type varchar(100),
  date datetime,
  transaction varchar(255),
  fk_payment int,
  constraint fk_userpagamento foreign key (fk_payment) references usuario(idusuario),
  constraint formacheck check (type in ('debito', 'credito', 'pix'))
);
create table feedback (
idfeedback int primary key auto_increment,
comentario varchar(200),
nota int,
fkfeedback int,
constraint fkfeedbackusuario foreign key (fkfeedback) references usuario(idusuario),
constraint notacheck check (nota in (1,2,3,4,5))
);

insert into pagamento values 
(default, 'debito', '2025-03-03 14:30:00', '2hr3uygh37n3uth73', 1),
(default, 'credito', '2025-03-03 14:30:00', '2hr3uygh37n3uth73', 2),
(default, 'pix', '2025-03-03 14:30:00', '2hr3uygh37n3uth73', 3),
(default, 'pix', '2025-03-03 14:30:00', '2hr3uygh37n3uth73', 4);

select u.name,
u.fidelidade,
f.name,
f.cargo,
s.type,
s.price,
s.category,
a.dia,
a.hora,
a.duracao, 
p.type,
p.transaction from agendamento a
join usuario u on fk_user = u.idusuario
join funcionario f on fkfuncionario = f.idfuncionario
join servico s on fkservico = s.idservico
join pagamento p on fk_payment = u.idusuario;



insert into feedback values 
(default, 'comentario teste', 4, 1),
(default, 'comentario teste', 3, 2),
(default, 'comentario teste', 5, 3),
(default, 'comentario teste', 5, 4);

select u.name,
u.fidelidade,
f.name,
f.cargo,
s.type,
s.price,
s.category,
a.dia,
a.hora,
a.duracao, 
p.type,
p.transaction,
fb.comentario,
fb.nota from agendamento a
join usuario u on fk_user = u.idusuario
join funcionario f on fkfuncionario = f.idfuncionario
join servico s on fkservico = s.idservico
join pagamento p on fk_payment = u.idusuario
join feedback fb on fkfeedback = u.idusuario;
