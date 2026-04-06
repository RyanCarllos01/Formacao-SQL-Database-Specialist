use ecommerce;
show tables;
select * from produto;

show session variables like '%isolation%';
set session transaction isolation level read committed;
set @@autocommit = 0;
select @@autocommit;

select @@transaction_isolation;
delimiter //


create procedure Erro_SQL()
	begin
		declare exit handler for sqlexception
        begin 
        show errors limit 1;
			rollback;
    end ;
            start transaction;
               UPDATE produto SET preco = preco * 1.10 WHERE id = 9999;
	end //
delimiter ;

call Erro_SQL();


