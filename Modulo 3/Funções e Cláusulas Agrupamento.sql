-- Funções e cláusulas de agrupamento
use company_constraints;

-- conta as linhas da tabela employee(empregados)
select count(*) from employee;

-- contando quantos empregados são do departamento reseach 
select count(*) from employee, departament
	where Dno=Dnumber and Dname ='Research';
    
select Dno, count(*), round(avg(Salary),2) from employee
	group by Dno;
    
select Dno, count(*) as Number_of_employees, round(avg(Salary),2) as Salary_Avg from employee
	group by Dno;
    
select Pnumber, Pname, count(*)
	from project, works_on
    where Pnumber = Pno
    group by Pnumber, Pname;
    
    -- descobrindo quantos salários diferentes tem na tabela employee
    select count(distinct Salary) as número_de_salário from employee;
    
    select sum(Salary) as total_salary, max(Salary) as salário_mais_alto, 
    min(Salary) as Salário_mais_baixo, avg (Salary) as média_salário from employee;
    
    
    
    