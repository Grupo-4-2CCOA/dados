-- createDatabase.sql:
drop database if exists `grupo4`;
create database if not exists `grupo4`;

use `grupo4`;

-- tabela de usuários:
create table user (
  `id` int primary key auto_increment,
  `email` varchar(100) unique,
  `password` varchar(50),
  `phone` char(11),
  `cpf` char(11) unique,
  `name` varchar(75),
  `cep` char(8),
  `birth` date,
  `fidelity` enum('fiel', 'new')
);
-- tabela de funcionários:
create table employee (
  `id` int primary key auto_increment,
  `email` varchar(100) unique,
  `password` varchar(50),
  `phone` char(11),
  `cpf` char(11) unique,
  `role` enum("owner", "employee"),
  `cep` char(8),
  `birth` date,
  `name` varchar(75)
);
-- tabela de serviços:
create table service (
  `id` int primary key auto_increment,
  `type` varchar(50),
  `category` varchar(75),
  `price` decimal(5,2),
  `discount` decimal(5,2),
  `description` varchar(200),
  `image` varchar(255)
);
-- tabela de agendamentos:
create table schedule (
  `id` int primary key auto_increment,
  `day` date,
  `time` time,
  `duration` varchar(50),
  `fk_user` int,
  `fk_servico` int,
  `fk_funcionario` int,

  constraint `schedule_fk_user` foreign key (`fk_user`) references `user`(`id`),
  constraint `schedule_fk_employee` foreign key (`fk_employee`) references `employee`(`id`),
  constraint `schedule_fk_service` foreign key (`fk_service`) references `service`(`id`)
);
-- tabela de métodos de pagamentos:
create table payment(
  `id` int primary key auto_increment,
  `type` enum('debito', 'credito', 'pix'),
  `date` datetime,
  `transaction` varchar(255),
  `fk_user` int,
  
  constraint `payment_fk_user` foreign key (`fk_user`) references `user`(`id`)
);
-- tabela de feedbacks:
create table feedback (
  `id` int primary key auto_increment,
  `comment` varchar(200),
  `rating` enum (1, 2, 3, 4, 5),
  `fk_user` int,
  
  constraint `feedback_fk_user` foreign key (`fk_user`) references `user`(`id`)
);
