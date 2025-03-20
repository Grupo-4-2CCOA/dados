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
  `birth` date
);
-- tabela de funcionários:
create table employee (
  `id` int primary key auto_increment,
  `email` varchar(100) unique not null,
  `password` varchar(50) not null,
  `phone` char(11) unique not null,
  `cpf` char(11) unique not null,
  `role` enum("OWNER", "INFRA", "EMPLOYEE") not null,
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
-- tabela de atendimentos:
create table appointment (
	`id` int primary key auto_increment,
    `status` enum("ACTIVE", "INACTIVE") not null,
    `transaction_hash` varchar(255) not null,
    `duraction` varchar(45),
    `fk_employee` int,
    `fk_service` int,
    
    constraint `appointment_fk_employee` foreign key (`fk_employee`) references `employee`(`id`),
    constraint `appointment_fk_service` foreign key (`fk_service`) references `service`(`id`)
);
-- tabela de agendamentos:
create table schedule (
  `id` int auto_increment primary key,
  `status` enum("ACTIVE", "INACTIVE") not null,
  `date_time` datetime not null,
  `fk_appointment` int,
  
  constraint `schedule_fk_appointment` foreign key (`fk_appointment`) references `appointment`(`id`)
);
-- tabela de métodos de pagamentos:
create table payment(
  `id` int primary key auto_increment,
  `type` varchar(50) not null,
  `date_time` datetime not null,
  `fk_appointment` int,
  
  constraint `payment_fk_appointment` foreign key (`fk_appointment`) references `appointment`(`id`)
);
-- tabela de feedbacks:
create table feedback (
  `id` int auto_increment primary key,
  `comment` varchar(200),
  `rating` int
  
  constraint `feedback_check_rating` check(`rating` between 0 and 5)
);
-- tabela de n:n
create table user_appointment (
	`fk_user` int,
    `fk_appointment` int,
    `fk_feedback` int,
    primary key(`fk_user`, `fk_appointment`, `fk_feedback`),
    
    constraint `user_appointment_fk_user` foreign key (`fk_user`) references `user`(`id`),
    constraint `user_appointment_fk_appointment` foreign key (`fk_appointment`) references `appointment`(`id`),
    constraint `user_appointment_fk_feedback` foreign key (`fk_feedback`) references `feedback`(`id`)
);