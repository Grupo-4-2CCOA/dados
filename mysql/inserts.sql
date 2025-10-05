-- /mysql/inserts.mysql:
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
