drop user if exists 'infra'@'localhost';
create user 'infra'@'localhost' identified by 'infra';
grant all privileges on grupo4.* to 'infra'@'localhost';

-- Usuários para ambiente de desenvolvimento:
drop user if exists 'grupo4-infra-dev'@'localhost';
create user 'grupo4-infra-dev'@'localhost' identified by 'infra';
grant all privileges on grupo4.* to 'grupo4-infra-dev'@'localhost';

-- Usuários para ambiente de homologação:
drop user if exists 'grupo4-infra-hml'@'localhost';
create user 'grupo4-infra-hml'@'localhost' identified by 'infra';
grant all privileges on grupo4.* to 'grupo4-infra-hml'@'localhost';

-- Usuários para ambiente de produção:
drop user if exists 'grupo4-infra-prd'@'localhost';
create user 'grupo4-infra-prd'@'localhost' identified by 'infra';
grant all privileges on grupo4.* to 'grupo4-infra-prd'@'localhost';

-- Create Tables
create table `role`(
  `id` int not null primary key auto_increment,
  `is_active` tinyint not null default 1,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,

  `name` varchar(80) not null,
  `description` varchar(255)
);

-- tabela de usuários:
create table `user`(
	`id` int not null primary key auto_increment,
  `is_active` tinyint not null default 1,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,
  
  `name` varchar(80) not null,
  `email` varchar(80) not null,
  `cpf` char(11),
  `phone` char(11),
  `cep` char(8),

  `fk_role` int not null,

  constraint `user_fk_role` foreign key (`fk_role`) references `role`(`id`)
);

-- tabela de disponibilidade:
create table `availability`(
  `id` int not null primary key auto_increment,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,

  `is_available` tinyint not null default 1,
  `start_datetime` datetime not null,
  `end_datetime` datetime not null,

  `fk_employee` int not null,

  constraint `availability_check_datetime` check (`start_datetime` < `end_datetime`),

  constraint `availability_fk_employee` foreign key (`fk_employee`) references `user`(`id`)
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
  `is_active` tinyint not null default 1,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,

  `name` varchar(80) not null,
  `description` varchar(255)
);

-- tabela de serviços:
create table `service`(
  `id` int not null primary key auto_increment,
  `is_active` tinyint not null default 1,
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

  `fk_client` int not null,
  `fk_employee` int not null,
  `fk_payment_type` int,

  constraint `schedule_fk_client` foreign key (`fk_client`) references `user`(`id`),
  constraint `schedule_fk_employee` foreign key (`fk_employee`) references `user`(`id`),
  constraint `schedule_fk_payment_type` foreign key (`fk_payment_type`) references `payment_type`(`id`)
);

-- tabela de serviços por agendamento:
create table `schedule_item`(
  `id` int not null auto_increment,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,

  `final_price` decimal(5,2) not null,
  `discount` decimal(5,2) not null default 0,

  `fk_schedule` int not null,
  `fk_service` int not null,

  constraint `pk_schedule_item` primary key (`id`, `fk_schedule`, `fk_service`),
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

  constraint `feedback_fk_schedule` foreign key (`fk_schedule`) references `schedule`(`id`)
);

insert into role (`name`, `description`) values ("Administrador", "Administrador do sistema.");
insert into role (`name`, `description`) values ("Cliente", "Cliente do salão.");
insert into role (`name`, `description`) values ("Funcionário", "Funcionário do salão.");

insert into payment_type (`name`,`description`) values ('Cartão', 'Pagamento via cartão de crédito e débito');
insert into payment_type (`name`,`description`) values ('Pix', 'Pagamento instantâneo via Pix');
insert into payment_type (`name`,`description`) values ('Dinheiro', 'Pagamento em espécie');

insert into category (`name`, `description`) values ('Cabelo', 'Serviços relacionados a cortes, tinturas e tratamentos capilares');
insert into category (`name`, `description`) values ('Estética', 'Serviços de estética e cuidados com a pele');
insert into category (`name`, `description`) values ('Unhas', 'Serviços de manicure e pedicure');

insert into service (`name`, `base_price`, `base_duration`, `description`, `image`, `fk_category`) values
('Corte de cabelo feminino', 80.00, 60, 'Corte estilizado para mulheres', null, 1),
('Limpeza de pele', 120.00, 90, 'Tratamento de pele facial completo', null, 2),
('Manicure simples', 40.00, 45, 'Corte, lixamento e esmaltação básica para as mãos', null, 3),
('Pedicure simples', 50.00, 45, 'Corte, lixamento e esmaltação básica para os pés', null, 3),
('Unhas de gel', 80.00, 45, 'Serviço de unhas de gel para mão e pé', null, 3);

insert into user (`name`, `email`, `cpf`, `phone`, `cep`, `fk_role`) values
('João Silva', 'joao.silva@email.com', '12345678901', '11999999999', '01001000', 2), -- cliente
('Maria Souza', 'maria.souza@email.com', '98765432100', '11988888888', '02020000', 2), -- cliente
('Carlos Pereira', 'carlos.pereira@email.com', '45612378900', '11977777777', '03030000', 3), -- funcionário
('Ana Oliveira', 'ana.oliveira@email.com', '78945612300', '11966666666', '04040000', 3), -- funcionário
('Admin Master', 'admin@email.com', '11122233344', '11955555555', '05050000', 1); -- admin
