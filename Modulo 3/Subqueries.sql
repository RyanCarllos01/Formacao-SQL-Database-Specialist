-- subqueries

use company_constraints;

desc works_on;
select * from employee;
-- está ocorrendo erro porque está buscando informações e não tem nenhuma linha retornada, se colocar Wallace
select distinct Pnumber from project 
	where Pnumber in 	
  (select distinct Pno
		from works_on, employee
        where (Essn= Ssn and Lname='Smith')
       
       	)
    or
  (
    select Pnumber from project, departament, employee
    where (Mgr_Ssn = Ssn and Lname = 'Smith' and Dnum = Dnumber)
    );
    
select distinct * from works_on 
	Where (Pno, Hours) in (select Pno,Hours from works_on
    where Essn = 123456789);
    
    -- Cláusulas com exists e unique

-- Quais employees possuem dependentes    
select e.Fname, e.Lname from employee as e
	where exists (select * from dependent as d 
    where e.Ssn = d.Essn and Relationship = 'Daughter');
    
    -- empregados que não possuem dependentes
    select e.Fname, e.Lname from employee as e
	where not exists (select * from dependent as d 
    where e.Ssn = d.Essn);
    
    -- lista de gerentes que possuem dependentes
    select e.Fname, e.Lname from employee as e
	where exists (select * from dependent as d 
    where e.Ssn = d.Essn) and (select * from departament where Ssn = Mgr_Ssn);
    
    -- essa é a correção da query acima
    select e.Fname, e.Lname from employee as e, departament d
	where (e.Ssn = Mgr_Ssn) and exists (select * from dependent as d 
    where e.Ssn = d.Essn) ;
  
  -- se o empregado tiver 2 ou mais dependentes irá mostrar essas informações
    select Fname, Lname from employee
		where(select count(*) from dependent where Ssn=Essn) >=2;
        
        -- comparação de conjuntos explicitos 
        
        select distinct Essn, Pno from works_on where Pno in (1,2,3);
        
        
        
        
    