-- cláusulas de ordenação 
use company_constraints;
-- order by ordena as tuplas do resultado
select * from employee order by Fname, Lname ;

-- Nome do departamento, nome do gerente
select distinct Dname, concat(e.Fname,' ', e.Lname ) as Manager , Addres from departament as d, employee as e, works_on as w, project p
	where (d.Dnumber = e.Dno and e.Ssn= d.Mgr_ssn and w.Pno = p.Pnumber)
		order by d.Dname, e.Fname, e.Lname;
  
  -- recupero todos os empregados e seus projetos em andamento 
select distinct d.Dname as Department, concat(e.Fname,' ', e.Lname ) as Employee, p.Pname as Project_Name, Addres
from departament as d, employee e, works_on w, project p
	where(d.Dnumber = e.Dno and e.Ssn = w.Essn and w.Pno = p.Pnumber)
    order by d.Dname desc, e.Fname asc, e.Lname asc;


