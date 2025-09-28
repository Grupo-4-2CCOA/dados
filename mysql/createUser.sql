-- /mysql/createUser.sql:
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
