-- Criando Transações com Procedures no MySQL

-- se der algum erro na transação a procedure vai mostrar uma mensagem e dar um rollback
use transactionexample;
-- pra alterar a procedure precisa dropar fazer as alterações e depois subir de novo
drop procedure sql_fail;
delimiter //

create procedure sql_fail()
	begin
		declare exit handler for sqlexception
        begin 
        show errors limit 1;
			rollback;
         --  select 'A transação foi encerrada devido algum erro ocorrido' as Warning;
            -- show warnings limit 1;
            -- show errors limit 1;
        end ;
        
        start transaction;
      --  select @nextorder := max(orderNumbers) +1 as Next_number
		-- from orders;

           INSERT INTO orders VALUES(14,'2005-05-31', '2005-6-10', '2005-06-11', 'EM PROGRESSO',3);     
			INSERT INTO ordersDetails VALUES(14, '18_1849', 30, '189.50',2),
									(14, '18_2569', 50, '105.09',2);
                                    commit;
	end //
delimiter ;

call sql_fail();
select * from orders where orderNumbers = 14;