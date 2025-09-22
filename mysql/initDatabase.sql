-- /createDatabase.sql:
drop database if exists `grupo4`;
create database if not exists `grupo4`;

use `grupo4`;

-- tabela de usuários:
create table `user`(
  `id` int not null primary key auto_increment,
  `active` tinyint not null default 1,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,

  `role` enum("OWNER", "EMPLOYEE", "CUSTOMER") not null,
  `name` varchar(80) not null,
  `email` varchar(80) not null unique,
  `password` varchar(80) not null,
  `cpf` char(11) unique,
  `phone` char(11) unique,
  `cep` char(8)
);
-- tabela de tipo de pagamento:
create table `payment_type`(
  `id` int not null primary key auto_increment,
  `active` tinyint not null default 1,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,

  `name` varchar(80) not null,
  `description` varchar(255)
);
-- tabela de categoria:
create table `category`(
  `id` int not null primary key auto_increment,
  `active` tinyint not null default 1,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,

  `name` varchar(80) not null,
  `description` varchar(255)
);
-- tabela de serviços:
create table `service`(
  `id` int not null primary key auto_increment,
  `active` tinyint not null default 1,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,

  `name` varchar(80) not null,
  `base_price` decimal(5,2) not null,
  `base_duration` int not null,
  `description` varchar(255),
  `image` varchar(255),

  `fk_category` int not null,

  constraint `service_fk_category` foreign key (`fk_category`) references `category`(`id`)
);
-- tabela de agendamentos:
create table `schedule` (
  `id` int not null primary key auto_increment,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,

  `status` enum('ACTIVE', 'COMPLETED', 'CANCELED') not null,
  `appointment_datetime` datetime not null,
  `duration` int,
  `transaction_hash` varchar(255),

  `fk_user` int not null,
  `fk_payment_type` int,

  constraint `schedule_fk_user` foreign key (`fk_user`) references `user`(`id`),
  constraint `schedule_fk_payment_type` foreign key (`fk_payment_type`) references `payment_type`(`id`)
);
-- tabela de serviços por agendamento:
create table `schedule_item`(
  `id` int not null primary key auto_increment,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,

  `final_price` decimal(5,2) not null,
  `discount` decimal(5,2) not null default 0,

  `fk_schedule` int not null,
  `fk_service` int not null,

  constraint `schedule_item_fk_schedule` foreign key (`fk_schedule`) references `schedule`(`id`),
  constraint `schedule_item_fk_service` foreign key (`fk_service`) references `service`(`id`)
);
-- tabela de feedbacks:
create table `feedback` (
  `id` int not null primary key auto_increment,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,

  `rating` int not null,
  `comment` varchar(255),

  `fk_schedule` int not null,
  `fk_user` int not null,

  constraint `feedback_fk_schedule` foreign key (`fk_schedule`) references `schedule`(`id`),
  constraint `feedback_fk_user` foreign key (`fk_user`) references `user`(`id`)
);

-- /inserts.sql:
-- inserção na tabela de usuários:
insert into
  `user`
  (`role`, `name`, `email`, `password`, `cpf`, `phone`, `cep`)
  values
  ('CUSTOMER', 'felipe', 'felipe@gmail,com', '12345678', '12345678912', '11950310303', 'teste'),
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
