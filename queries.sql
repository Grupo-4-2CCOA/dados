-- queries.sql:

select * from usuario;
select * from funcionario;
select * from servico;
select * from agendamento;


select * from agendamento
join usuario u on fk_user = u.idusuario
join funcionario f on fkfuncionario = f.idfuncionario
join servico s on fkservico = s.idservico;

select u.name,
u.fidelidade,
f.name,
f.cargo,
s.type,
s.price,
s.category,
a.dia,
a.hora,
a.duracao from agendamento a
join usuario u on fk_user = u.idusuario
join funcionario f on fkfuncionario = f.idfuncionario
join servico s on fkservico = s.idservico;