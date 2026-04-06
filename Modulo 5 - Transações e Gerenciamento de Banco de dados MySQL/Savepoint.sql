-- Criando Transações Concorrentes no MySQL

-- precisa sempre dar um set@@autocommit =0; antes de iniciar a transação
show session variables like '%isolation%';
-- read-committed: só vai ler se efetuar o commit
-- REPEATABLE-READ: quando fazer alteração irá aparecer sem ter efetuado o commit, o rollback funcionaria ainda
-- a maneira default do mysql é o repeatable read
commit;
-- assim que muda o nível do isolation
set session transaction isolation level read committed;
set session transaction isolation level repeatable read;


set @@autocommit = 0;
select @@autocommit;

-- savepoints 
select @@autocommit;
select @@transaction_isolation;
start transaction;
select @nextorder := max(orderNumbers) +1 as Next_number
from orders;
-- insert into orders () values()
insert into orders 
			values(@nextorder,
            '2005-05-31',
			'2005-6-10',
			'2005-06-11',
			'Despachado', 2);
          
 select orderNumbers from orders;
savepoint insercao_order;

-- nova inserção em ordersDetails

-- estamos fazendo um erro de proposito para dar um rollback savepoint
insert into ordersDetails values (@nextorder +1,181749, 30, '136'),
								(@nextorder,182248, 50, '55.09'); 

savepoint insercao_order_details;

rollback to savepoint insercao_order;
-- rollback; se fazer assim seria total 
commit;