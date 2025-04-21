-- /createDatabase.sql:
drop database if exists `grupo4`;
create database if not exists `grupo4`;

use `grupo4`;

-- tabela de cargos:
create table `role`(
  `id` int not null primary key auto_increment,
  `active` tinyint not null default 1,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,

  `name` varchar(80) not null,
  `description` varchar(255),
  constraint `role_check_name` check (`name` in ("OWNER", "CUSTOMER", "EMPLOYEE"))
);

-- tabela de funcionários:
create table `employee`(
  `id` int not null primary key auto_increment,
  `active` tinyint not null default 1,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,

  `name` varchar(80) not null,
  `email` varchar(80) not null unique,
  `password` varchar(80) not null,
  `cpf` char(11) unique,
  `phone` char(11) unique,
  `cep` char(8),
  `fk_role` int not null,
  
  constraint `employee_fk_role` foreign key (`fk_role`) references `role`(`id`)
);

-- tabela de disponibilidade:
create table `availability`(
  `id` int not null primary key auto_increment,
  `active` tinyint not null default 1,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,
  `week_day` enum("SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY") not null,
  `start_time` time not null,
  `end_time` time not null,
  `fk_employee` int not null,
  
  constraint `availability_fk_employee` foreign key (`fk_employee`) references `employee`(`id`),
  constraint `availability_check_time` check (`start_time` < `end_time`)
);

-- tabela de exceção da disponibilidate:
create table `unavailable`(
  `id` int not null primary key auto_increment,
  `active` tinyint not null default 1,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,
  `day` datetime not null,
  `start_time` time,
  `end_time` time,
  `fk_availability` int not null,
  
  constraint `unavailable_fk_availability` foreign key (`fk_availability`) references `availability`(`id`),
  constraint `unavailable_check_time` check (`start_time` < `end_time`)
);

-- tabela de clientes:
create table `client`(
  `id` int not null primary key auto_increment,
  `active` tinyint not null default 1,
  `created_at` datetime not null default current_timestamp,
  `updated_at` datetime not null default current_timestamp on update current_timestamp,

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

  `fk_client` int not null,
  `fk_employee` int not null,
  `fk_payment_type` int,

  constraint `schedule_fk_client` foreign key (`fk_client`) references `client`(`id`),
  constraint `schedule_fk_employee` foreign key (`fk_employee`) references `employee`(`id`),
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
  constraint `feedback_fk_client` foreign key (`fk_client`) references `client`(`id`)
);

create table `log` (
  `id` int not null primary key auto_increment,
  `http_method` enum("POST", "PATCH", "PUT", "DELETE") not null,
  `entity` enum("AVAILABILITY", "CATEGORY", "CLIENT", "EMPLOYEE", "FEEDBACK", "PAYMENT_TYPE", "ROLE", "SCHEDULE", "SCHEDULE_ITEM", "SERVICE", "UNAVAILABLE"),
  `modified_at` datetime not null default current_timestamp,
  `column` varchar(45) not null,
  `old_value` varchar(255) not null,
  `new_value` varchar(255) not null
);