-- Criando queries com CASE statement

use company_constraints;

show tables;

select Fname, Salary, Dno from employee;
-- desabilitar o safe mode
-- edit > preferences > SQL editor > rolar até o final e desabilitar o safe updates
update employee set Salary =
	case
      when Dno = 5 then Salary + 2000
      when Dno = 4 then Salary + 1500
      when Dno = 1 then Salary + 3000
      else Salary + 0
      end;
      

