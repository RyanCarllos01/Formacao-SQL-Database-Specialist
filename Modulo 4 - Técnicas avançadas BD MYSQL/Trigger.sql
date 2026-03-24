-- Trigger 
use company_constraints;
show tables;
desc employee;
select * from employee;
-- Estrutura de uma trigger
/*
CREATE
    [DEFINER = user]
    TRIGGER [IF NOT EXISTS] trigger_name
    trigger_time trigger_event
    ON tbl_name FOR EACH ROW
    [trigger_order]
    trigger_body

trigger_time: { BEFORE | AFTER }
trigger_event: { INSERT | UPDATE | DELETE }
trigger_order: { FOLLOWS | PRECEDES } other_trigger_name
*/

-- before insert statement
# setando gerentes por departamento
delimiter \\
create trigger superssn_check before insert on company_constraints.employee
for each row
	begin
		case new.Dno
			when 1 then set new.Super_ssn = '333445555';
            when 2 then set new.Super_ssn = null;
            when 3 then set new.Super_ssn = null;
            when 4 then set new.Super_ssn = '123456789';
            when 5 then set new.Super_ssn = '987654321';
            end case;
	end \\
delimiter ;

drop trigger null_value_check;
show triggers from company_constraints;

/*testando trigger, se vemos colocamos como nulo no insert, mas como definirmos que se o DNO for 5 vai ser aquele número 
que criamos pre ponto */
select * from employee;
insert into employee (Fname, Minit, Lname, Ssn, Bdate, Addres, Sex, Salary, Super_ssn, Dno) 
			values('João', 'B', 'Smith', '123456759', '1965-01-09', '731-Fondren-Houston-TX', 'M', '32000.00', NULL, '5'); 
            show tables;
-- after insert statement
# verificar de algum valor nulo que não foi passado alter
# adiciona uma mensagem para o usuário.
create table user_messages(
id int auto_increment primary key,
message varchar (100), 
ssn char(9), 
constraint fk_ssn_messages foreign key (ssn) references employee(Ssn)
);

delimiter //
create trigger null_value_check after insert on employee
for each row
	if(new.Addres is Null) then 
		-- select 'Update yout address, please!' as message;
        -- não pode retornar um select em um trigger, por isso estamos
        -- criando a tabela user_messages
        insert into user_messages (message, ssn) values( concat('Update your address, please ', new.Fname),new.Ssn);
        else
         insert into user_messages (message, ssn) values( concat('Error', new.Fname),new.Ssn);
        end if;
        //
delimiter ;

insert into employee (Fname, Minit, Lname, Ssn, Bdate, Addres, Sex, Salary, Super_ssn, Dno) 
values('Fulana', 'B', 'Smith', '533489824', '1965-08-10', null, 'F', '35000.00', '123456789', '5');

desc employee;

select * from employee;
select * from user_messages;

-- outro exemplo:
create database if not exists triggersdb;
use triggersdb;


create table account(
id int primary key,
acct_num int not null,
amount decimal(10,2)
);

create trigger check_amount before insert on account
for each row
	set @sum = @sum+new.amount;
    
    set @sum = 0;
    insert into account (id, acct_num, amount)
					values(1, 137,14.98),
						  (2, 141,1937.50),
                          (3, 97,-100.00); 
                          
	select * from account;
    -- select @sum as 'total amount inserted'
    
    drop trigger check_amount;
    
    
delimiter // 
create trigger upd_check BEFORE UPDATE ON account 
       FOR EACH ROW 
       BEGIN 
       -- é como se fosse um limite relacionado a conta 
           IF NEW.amount < 0 THEN 
               SET NEW.amount = 0; 
           ELSEIF NEW.amount > 100 THEN 
               SET NEW.amount = 100; 
           END IF; 
       END// 
delimiter ; 

show triggers from triggersdb;
-- verificando se funcionou
update account set amount = -50 where id=3;
select * from account;
    

-- before update statement

# Atribuindo aumento de salário para um dept específico = 1 salary = salary * 1.20;
DELIMITER \\

CREATE TRIGGER Aumento_salario 
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
    IF NEW.Dno = 1 THEN
        SET NEW.Salary = NEW.Salary * 1.20;
    END IF;
END \\
DELIMITER ;

select * from employee;
-- testando o trigger
UPDATE employee
SET Salary = 40000
WHERE Ssn = '123769824';

select * from employee where Ssn = '123769824';

-- before delete statement
# salvando em outra tabela os employees demitidos
# old.attribute
select * from employee;
create table Fired_employees(
	Fname varchar(15) not null, 
	Minit char,
	Lname varchar(15) not null,
	Ssn char(9) not null, -- Char é fixo precisam ser inseridos essa quantidade que colocamos
	Bdate date,
	Addres varchar(30), 
	Sex char,
	Salary decimal(10,2),
	Super_ssn char(9),
	Dno int not null
);

delimiter \\
create trigger fired_employees_trigger before delete on employee
	for each row
    begin
    INSERT INTO Fired_employees
    (Fname, Minit, Lname, Ssn, Bdate, Addres, Sex, Salary, Super_ssn, Dno)
    VALUES
    (OLD.Fname, OLD.Minit, OLD.Lname, OLD.Ssn, OLD.Bdate, 
     OLD.Addres, OLD.Sex, OLD.Salary, OLD.Super_ssn, OLD.Dno);
    end \\
    delimiter ;
    
-- testando o trigger
    DELETE FROM employee
WHERE Ssn = '123769824';
select * from fired_employees;

         