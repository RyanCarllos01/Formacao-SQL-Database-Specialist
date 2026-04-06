show databases;
use company_constraints;
show tables;

desc departament;
desc dependent;
desc dept_locations;
desc employee;
desc project;
desc works_on;

-- Número de empregado por departamento e localidade
create view view_empregado_por_departamento_localidade as
select e.Fname as Primeiro_Nome, e.Minit as Nome_meio, e.Lname as Sobrenome,
d.Dnumber as Numero_departamento, d.Dlocation as localizacao_departamento,
c.Dname as Nome_departamento from dept_locations as d inner join departament as c
on d.Dnumber = c.Dnumber inner join employee as e on d.Dnumber = e.Dno;


-- Departamentos e seus gerentes
create view view_gerentes_departamentos as
select e.Fname, e.Minit, e.Lname, Mgr_ssn, Dname from employee as e
inner join departament as d on Ssn = Mgr_ssn;

-- Projetos com maior número de empregados
create view view_projetos_maior_numero_empregados as
SELECT p.Pnumber,p.Pname, d.Dname, e.Dno,
COUNT(*) AS Total_funcionarios_projeto
FROM employee AS e
INNER JOIN project AS p ON e.Dno = p.Dnum
INNER JOIN departament AS d ON d.Dnumber = e.Dno
GROUP BY p.Pnumber, p.Pname, d.Dname, e.Dno
ORDER BY Total_funcionarios_projeto DESC;

-- Lista de projetos, departamentos e gerentes
create view view_projeto_dep_gerentes as
select P.Pnumber, P.Pname, D.Dname, concat(Fname,' ', e.Minit,' ', e.Lname) as Nome_Completo_Gerente, D.Mgr_ssn from employee as e
inner join departament as D on E.Ssn = D.Mgr_ssn
inner join project as P on D.Dnumber = P.Dnum;

-- Quais empregados possuem dependentes e se são gerentes
create view view_empregados_ou_gerentes_e_dependendetes as
select concat(e.Fname, ' ', e.Minit, ' ', e.Lname, ' ') as Nome_empregado_responsavel, e.Ssn, D.Dependent_name, D.Relationship,
CASE
	WHEN 
    C.Mgr_ssn is not null then 'Sim'
    else 'Não '
    end as Gerente
    from employee as e
inner join Dependent as D on e.Ssn = D.Essn
left join departament as C on e.Ssn = C.Mgr_ssn; 

create user 'gerente'@localhost identified by '123456';
grant all privileges on company_contraints.view_empregado_por_departamento_localidade to
'gerente'@localhost;
grant all privileges on company_contraints.employee to
'gerente'@localhost;
grant all privileges on company_contraints.departament to
'gerente'@localhost;

SELECT User, Host
FROM mysql.user;

SHOW GRANTS FOR 'gerente'@'localhost';

create user 'employee'@localhost identified by '123';
grant all privileges on company_constraints.employee to 'employee'@localhost;
create user 'employee'@localhost identified by '123';
grant all privileges on company_constraints.dependent to 'employee'@localhost;
create user 'employee'@localhost identified by '123';
grant all privileges on company_constraints.project to 'employee'@localhost;


-- Desafio trigger ecommerce

-- trigger before delete
/* use ecommerce;
show tables;
create table Produto_excluido(
Id_Produto int,
Pname varchar(45),
classificação_kids	tinyint(1),
Categoria	enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'),
Descrição	varchar(45),
Avaliação	float,
Size	varchar(10),
Valor	float
);
desc Produto_excluido_trigger;
delimiter \\
create trigger Produto_excluido_trigger before delete on produto 
for each row
begin
insert into Produto_excluido (Id_Produto,Pname, classificação_kids, Categoria, Descrição, Avaliação, Size, Valor )
values (old.Id_Produto,Pname, old.classificação_kids, old.Categoria, old.Descrição, old.Avaliação, old.Size, old.Valor);
end \\
delimiter ;
select * from produto;
desc produto;
-- testando trigger
delete from produto 
where Id_produto = 10;

select * from Produto_excluido;
show tables;
select * from cliente_pf;*/
create table clientes_pf_excluidos(
Id_cliente_PF	int,
Nome_completo	varchar(65),
CPF	char(11),
Endereco	varchar(155),
Data_Nascimento	varchar(9)
);
delimiter \\
create trigger clientes_pf_excluidos_trigger before delete on cliente_pf
for each row
begin
insert into clientes_pf_excluidos (Id_cliente_PF,Nome_completo,CPF, Endereco, Data_Nascimento)
values (old.Id_cliente_PF, old.Nome_completo, old.CPF, old.Endereco, old.Data_Nascimento);
end \\
delimiter ;
select * from cliente_pf;
delete from cliente_pf
where Id_cliente_PF = 1;
desc cliente_pf;
-- trigger de atualização: before update
use company_constraints;
select * from employee;
DELIMITER \\

CREATE TRIGGER Aumentando_salario_employees
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
    IF NEW.Dno in (1,3,4) THEN
        SET NEW.Salary = NEW.Salary * 1.25;
    END IF;
END \\
DELIMITER ;

-- testando trigger before update
INSERT INTO employee (Fname, Minit, Lname, Ssn, Bdate, Addres, Sex, Salary, Super_ssn, Dno)
VALUES ('Carlos', 'A', 'Silva', '987546321', '1985-05-10', 'Rua das Flores, 123', 'M', 4000, NULL, 3);

select * from employee where
Ssn = '987546321';

UPDATE employee
SET Salary = Salary
WHERE Ssn = '987546321';








