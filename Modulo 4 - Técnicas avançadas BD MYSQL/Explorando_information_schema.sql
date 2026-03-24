-- bancos de dados existentes MYSQL

show databases;

-- sys está relacionado a tudo do banco de dados 
use sys;
show tables like 'schema%';
-- as tabelas innodb está relacionado a performance no banco de dados

-- vai mostrar tudo relacionado as colunas com auto_increment do banco de dados
select * from schema_auto_increment_columns;
select * from schema_index_statistics;


select * from sys.host_summary_by_file_io;
select * from sys.host_summary;

-- mostra como é criada a view
show create view sys.version;

-- existem algumas tabelas que estão associadas a report
-- de algumas transações que estão rodando a muito tempo
-- são chamadas de long running

show tables like '%list';
show tables like '%session';

-- processamentos entre as tabelas
select * from sys.processlist;

-- sobre controle de sistema
-- atualiza em tempo real se eu entrar no mysql client e entrar em uma tablea
-- e rodarmos aqui esse comando ele identifica que entramos de uma outra forma no banco de dados
-- ele fala query porque entramos via comand line
select * from sys.session;

-- informações de um banco de dados que criamos: information schema
show databases;
use information_schema;
show databases;
-- engines não são gratuitas no mysql :(
-- navegar e dar select nas tabelas que achei bacana

-- 
select * from information_schema.keywords;
select * from information_schema.tables where table_schema='company_constraints';
select * from information_schema.tables where table_schema='company_constraints';
select * from information_schema.CHECK_CONSTRAINTS;
SELECT * From information_schema.referential_constraints where constraint_schema = 'company_constraints';
