-- /createDatabase.sql:
drop database if exists `grupo4`;
create database if not exists `grupo4`;

use `grupo4`;

-- tabela de cargos:
create table `role`(
  `id` int not null primary key auto_increment,
  `is_active` tinyint not null default 1,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,

  `name` varchar(80) not null,
  `description` varchar(255),
  constraint `role_check_name` check (`name` in ("OWNER", "CUSTOMER", "EMPLOYEE"))
);

-- tabela de usuários:
create table `user`(
	`id` int not null primary key auto_increment,
    `is_active` tinyint not null default 1,
    `created_at` datetime not null default current_timestamp,
    `updated_at` datetime not null default current_timestamp on update current_timestamp,
    
    `name` varchar(80) not null,
    `email` varchar(80) not null,
    `password` varchar(80) not null,
    `cpf` char(11),
    `ph one` char(11),
    `cep` char(8),
    `fk_role` int not null,
    
    constraint `role_check_name` check (`name` in ("OWNER", "CUSTOMER", "EMPLOYEE"))
    );

-- tabela de disponibilidade:
 create table `availability`(
  `id` int not null primary key auto_increment,
  `is_available` tinyint not null default 1,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,
  `day` date not null,
  `start_time` time not null,
  `end_time` time not null,
  `fk_employee` int not null,
  
  constraint `availability_fk_employee` foreign key (`fk_role`) references `user`(`id`),
  constraint `availability_check_time` check (`start_time` < `end_time`)
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

  constraint `schedule_fk_client` foreign key (`fk_role`) references `user`(`id`),
  constraint `schedule_fk_employee` foreign key (`fk_role`) references `user`(`id`),
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
  `fk_client` int not null,

  constraint `feedback_fk_schedule` foreign key (`fk_schedule`) references `schedule`(`id`),
  constraint `feedback_fk_client` foreign key (`fk_role`) references `user`(`id`)
);