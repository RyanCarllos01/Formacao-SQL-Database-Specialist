show databases;
create database if not exists first_example;
use first_example;
create table person(
	person_id smallint unsigned, -- podiamos colocar a primary key do lado do smallint unsigned e depois ter colocado a virgula
    -- porém melhor fazer separado e definir uma constraint pra nomear a pk
	fname varchar(20),
	lname varchar(20),
	gender enum('M','F','Others'),
	birth_date date,
	street varchar(30), -- do street ao postal code, era um atributo composto no schema entidade relacionamento, 
    -- transformamos em atributos simples
	city varchar(20),
	state varchar(20),
	country varchar(20),
	postal_code varchar(20),
   Constraint pk_person primary key (person_id)
);
desc person;

create table favorite_food(
	person_id smallint unsigned,
    food varchar(20),
    constraint pk_favorite_food primary key (person_id, food),
    constraint fk_favorite_food_person_id foreign key (person_id) 
    references person(person_id)
);
desc favorite_food;
show databases;
select * from information_schema.table_constraints 
where Constraint_schema = 'first_example';
-- vendo o nome das contraints de uma tabela especifica
desc information_schema.table_constraints;
select constraint_name from information_schema.table_constraints
where table_name = 'person';
-- vendo todas as colunas de uma determinada tabela
select * from information_schema.table_constraints
where constraint_schema = 'first_example';

desc person;

insert into person values ('3', 'Roberta', 'Silva', 'F', '1979-08-21',
							'rua tal', 'Cidade J', 'RJ','Brasil','26054-89'),('1', 'Luiz', 'Silva', 'M', '1979-08-21',
							'rua tal', 'Cidade J', 'RJ','Brasil','26054-89'),('2', 'Carolina', 'Figueiredo', 'F', '1979-08-21',
							'rua tal', 'Cidade J', 'RJ','Brasil','26054-89'); -- como no caso não estamos definindo pra qual atributo da tabela 
-- vamos inserir essas informações ele vai incluir esses valores em todos os atributos

select * from person;
delete from person where person_id=3 or person_id=2 or person_id=1;
desc favorite_food;

insert into favorite_food values(1,'lasanha'), (2,'frango assado'), ('3','Pizza');
select * from favorite_food;