-- transações sequenciais no myslq
select @@autocommit;

set @@autocommit =0;
# primeira transação 
start transaction;
    select orderNumbers as ID, orderStatus as Status, productCode as Product, round(price * 0.10,2) as Send_value
    from orders natural join ordersDetails;
commit; -- como não inseriu valores o commit vai apenas finalizar a transação 

select * from orders;
# segunda transação 
start transaction;
 select orderNumbers as ID, orderStatus as Status, productCode as Product, round(price * 0.10,2) as Send_value
    from orders natural join ordersDetails;
    update orders set orderStatus = 'ENTREGUE' where orderNumbers = 10;
    -- rollback;
commit;
