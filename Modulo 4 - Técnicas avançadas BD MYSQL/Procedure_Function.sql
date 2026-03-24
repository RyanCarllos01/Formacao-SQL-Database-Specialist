-- criando uma função 
show databases;
use teste;
create function first_function( numa decimal(10,2), numb int)
returns int deterministic -- fala que vai retornado esse tipo 
return numa * numb; -- return vai retornar efetivamente isso 

-- determinar os valores para rodar e testar a função
select first_function (10.2,2);
-- dá pra criar uma função para aumento de salário por exemplo, seria bacana

-- drop function first_function;

-- Criando a primeira procedure

use company_constraints;
select * from employee;
select * from departament;

-- exemplo de estrutura
delimiter \\ 
create procedure procedure_test()
begin
-- procedimento;
-- instrução sql;
end \\
delimiter ;

-- drop procedure procedure_test

-- in: quando apenas iremos enviar os valores pra procedure
-- out: devolver apenas
-- inout: receber, processadas e retornar um valor

-- é só um exemplo se for pra fazer um select criar uma view

-- no caso de querer incluir algo na procedure tem que dropar e criar de novo 

drop procedure info_employee;

delimiter $$
create procedure info_employee()
begin
select * from employee inner join departament on Ssn = Mgr_ssn;
end $$
delimiter ; 

call info_employee;

-- procedure é pra diminuir retrabalho

delimiter %
create procedure insert_into_employee_proc()
begin
insert into employee(Fname, Minit, Lname, Ssn, Bdate, Addres, Sex, Salary, Super_ssn, Dno) 
values ('Maria', 'B', 'Smith', '123456824', '1965-08-10', '731-Fondren-Houston-TX', 'F', '35000.00', '123456789', '5'
);
end%
delimiter ;

-- drop procedure insert_into_employee_proc;
call insert_into_employee_proc;
select * from employee;

-- como fazer isso por variaveis?
desc employee;
delimiter %
create procedure insert_into_employee_proc(
in Fname_p varchar(15),
in Minit_p char(1),
in Lname_p varchar(15),
in Ssn_p char(9),
in Bdate_p date,
in Addres_p varchar(30) ,
in Sex_p char(1),
in Salary_p decimal(10,2),
in Super_ssn_p char(9),
in Dno_p int
)
begin
insert into employee(Fname, Minit, Lname, Ssn, Bdate, Addres, Sex, Salary, Super_ssn, Dno) 
values ( Fname_p, Minit_p, Lname_p, Ssn_p, Bdate_p, Addres_p, Sex_p, Salary_p, Super_ssn_p, Dno_p
);
-- retorna o registro persistido na procedure

-- não vai retornar a mensagem porque o select vem depois, mas vou deixar em comentário
-- select 'Inserção bem sucedida' as message;
-- select * from employee where Ssn = Ssn_p;
select * from employee;
end%
delimiter ;

-- não pode puxar a procedure sem colocar nada

call insert_into_employee_proc('Amanda', 'B', 'Teixeira', '123769824', '1990-08-10', '731-Fondren-Houston-TX', 'F', '40000.00', '123456789', '1');

-- procedure para criptografas a senha de um usuário
create database teste_proc;
use teste_proc;

create table user(
id int auto_increment primary key,
nome varchar(20) not null unique,
email varchar(30) not null,
senha varchar(60) not null,
data_cadastro datetime
);
drop table user;
delimiter \\ 
create procedure procedure_insert(
in nome_p varchar(20),
in email_p varchar(30),
in senha_p varchar(60)
)
begin
if (length(senha_p) < 10 and length(senha_p) > 7) then
insert into user (nome, email, senha, data_cadastro) values(nome_p, email_p, md5(senha_p), now());
-- md5() função hash, vai deixar a senha nebulosa, a pessoa não irá ver
select * from user;

	else 
		select 'Forneça outra senha' as message_error;
end if;
end \\
delimiter ;

-- vai dar erro porque checou e viu que deu menos de 7 números
call procedure_insert('Juliana', 'juliana@email.com', '1');
-- agora vai
call procedure_insert('Juliana', 'juliana@email.com', '123456789');

call procedure_insert('Marcia', 'Marcia@email.com', '123456789');

-- LENGHT conta o número de caracteres de senha
select length('123456789') as Senha;

select * from user;

desc user;

-- tarefa de casa
-- fazer uma procedure para verificar o e-mail, por exemplo verificar que tem um arroba etc...
-- podemos utilizar o case para fazer diferentes instruções, inserção, atualização, delete, em uma mesma procedure
