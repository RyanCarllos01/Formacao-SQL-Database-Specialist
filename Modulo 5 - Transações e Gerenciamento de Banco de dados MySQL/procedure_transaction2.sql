use transactionexample;

delimiter //
create procedure sql_fail_v2()
begin 
-- depreciada a partir do 5.5
declare exit handler for sqlexception
begin
get diagnostics condition 1
@p2 = message_text;
select @p2 as Transaction_Error;

rollback;

end;

start transaction;
    INSERT INTO orders VALUES(14,'2005-05-31', '2005-6-10', '2005-06-11', 'EM PROGRESSO',3);     
			INSERT INTO ordersDetails VALUES(14, '18_1849', 30, '189.50'),
									(14, '18_2569', 50, '105.09',2);
                                    commit;
	end //
delimiter ;

call sql_fail_v2;
select * from orders where orderNumbers = 14;