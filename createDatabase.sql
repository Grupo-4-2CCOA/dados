-- createDatabase.sql:
drop database if exists `grupo4`;
create database if not exists `grupo4`;

use `grupo4`;

-- tabela de usuários:
create table user (
  `id` int primary key auto_increment,
  `email` varchar(100) unique not null,
  `password` varchar(50) not null,
  `phone` char(11) unique not null,
  `cpf` char(11) unique not null,
  `name` varchar(75) not null,
  `cep` char(8) not null,
  `birth` date,
  `fidelity` enum('FIEL', 'NEW') not null
);
-- tabela de funcionários:
create table employee (
  `id` int primary key auto_increment,
  `email` varchar(100) unique not null,
  `password` varchar(50) not null,
  `phone` char(11) unique not null,
  `cpf` char(11) unique not null,
  `role` enum("OWNER", "EMPLOYEE") not null,
  `cep` char(8) not null,
  `birth` date,
  `name` varchar(75)
);
-- tabela de serviços:
create table service (
  `id` int primary key auto_increment,
  `type` varchar(50) not null,
  `category` varchar(75) not null,
  `price` decimal(5,2) not null,
  `discount` decimal(5,2),
  `description` varchar(200),
  `image` varchar(255)
);
-- tabela de agendamentos:
create table schedule (
  `id` int primary key auto_increment,
  `date_time` datetime not null,
  `duration` varchar(50),
  `fk_user` int,
  `fk_service` int,
  `fk_employee` int,

  constraint `schedule_fk_user` foreign key (`fk_user`) references `user`(`id`),
  constraint `schedule_fk_employee` foreign key (`fk_employee`) references `employee`(`id`),
  constraint `schedule_fk_service` foreign key (`fk_service`) references `service`(`id`)
);
-- tabela de métodos de pagamentos:
create table payment(
  `id` int primary key auto_increment,
  `type` enum('DEBITO', 'CREDITO', 'PIX') not null,
  `date_time` datetime not null,
  `transaction` varchar(255),
  `fk_user` int,
  
  constraint `payment_fk_user` foreign key (`fk_user`) references `user`(`id`)
);
-- tabela de feedbacks:
create table feedback (
  `id` int primary key auto_increment,
  `comment` varchar(200),
  `rating` tinyint,
  `fk_user` int,
  `fk_schedule` int,
  
  constraint `feedback_check_rating` check(`rating` between 0 and 5),
  constraint `feedback_fk_user` foreign key (`fk_user`) references `user`(`id`),
  constraint `feedback_fk_schedule` foreign key (`fk_schedule`) references `schedule`(`id`)
);