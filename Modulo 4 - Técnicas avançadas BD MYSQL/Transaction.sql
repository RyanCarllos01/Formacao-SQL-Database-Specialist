/* verificar se o autocommit está igual a zero, se tiver 1
o my SQL entende que qualquer alteração será comitada automaticamente
e não é o que queremos  */

select @@autocommit;

-- setar o autocommit = off, false ou 0, pode ser uma das 3
set @@autocommit = 0;
select @orderNumbers := coalesce(max(orderNumbers), 0) + 1 from orders;
-- ideal utilizar o start transaction antes de fazer modificações pois ela só vai
-- se colocarmos commit, se der errado só colocar rollback
start transaction;
/* estamos declarando a variável orderNumber dentro da transação 
ele soma o último valor encontrado e coloca dentro da*/
-- o exemplo dela estava errado select @orderNumbers:= max(@orderNumbers) + 1 from orders;
# select @orderNumbers as Number; -- pra ver se deu certo 

insert into orders values(@orderNumbers,'2005-05-31', '2005-6-10', '2005-06-11', 'EM PROGRESSO',1),
						(@orderNumbers +1,'2005-05-31', '2005-6-10', '2005-06-11', 'EM PROGRESSO',1);
                       --  rollback;
/* depois de colocar o insert dar um select * from orders para ver que já mostram os dados
porém não realizamos o commit ainda, se executarmos esse rollback 
do jeito que está mesmo ele volta a transação 
 */
 -- select @orderNumbers as number;
                        
insert into ordersDetails values(@orderNumbers,'18_1749', 30, '136.00'),
(@orderNumbers, '18_2248', 50, '55.09');
-- rollback;

select * from ordersDetails
commit; -- insere 
