-- Verificando permissão de acesso de usuários no MYSQL
use mysql;
show tables;
create database testuser;
select * from user;

-- criação usuário
create user 'geral' @localhost identified by '123'; -- geral é o nome do usuário, '123' a senha
grant all privileges on testuser.* to 'geral'@localhost;
-- criar um acesso pra uma tabela especifica
grant all privileges on testuser.table to 'geral'@localhost;
-- criar um usuário root
grant all privileges on *.* to 'geral'@localhost;
-- pode entrar e sair do workbench e entrar com o login e a senha que criamos
-- o usuário terá total acesso a tabela ou databases que deixamos, pode criar, acessas information_schema e etc...