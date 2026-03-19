-- técnicas avançadas de SQL modulo 4
show databases;
use company;

-- drop view v_today;
create or replace view v_today(Today) as select current_date();

describe v_today; -- mostra como se fosse uma tabela

-- como saber que é uma view
show databases;
use information_schema;
show tables;
select * from VIEWS ;
-- procurar v_today em TABLE_NAME

-- Exemplo mais elaborado de VIEWS

use company_constraints;
show tables from company_constraints;

-- só rodar esse create que cria a view, pra mostrar os empregados que ganham mais de 27000
create view employees_salary_27000_view
as
select concat(Fname, Minit, Lname) as Nome_Completo, Salary, Dno as Dept_number from employee
where Salary > 26999;

-- agora é só recuperar
select * from employees_salary_27000_view;

-- se criou a view com esse nome, só pode altera-la usando replace
-- Verificando quais são funcionários do sexo masculino
create or replace view employees_Mens_view
as
select concat(Fname, Minit, Lname) as Nome_Completo, Salary, Dno as Dept_number from employee
where Sex = 'M';

select * from employees_Mens;
--
create or replace view employees_Dependent_view
as
select concat(Fname, Minit, Lname) as Nome_Completo, e.Dno as Departament, d.Dependent_name as Dependent from employee e
inner join dependent d on e.Ssn = d.Essn;

select * from employees_Dependent_view;

-- uma view é armazenado em disco, então só faz sentido criar uma view que é utilizada

-- Modificando e Atualizando Views existentes no MySQL 
use company_constraints;
show tables;

select * from employees_salary_27000_view;

-- no caso da view não é alter table é update
update employees_salary_27000_view 
	set Dept_number = 5
    where Nome_completo = 'JohnBSmith';
    
    select * from employees_salary_27000_view;
    
    select * from employees_dependent_view;
    
    -- atualização no nome dependente e no departamento associado ao usuário
    
    -- não vai porque estamos tentando modificar duas tabelas diferentes 
    update employees_dependent_view
		set Dependent = 'Abner' and Nome_completo = 'Abners Father'
			where Departament = 4;
    
    

