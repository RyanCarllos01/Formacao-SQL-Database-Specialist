use company_constraints;
show databases;
show tables;
desc departament;
desc dependent;
desc dept_locations;
desc employee;
desc project;
desc works_on;

show index from departament;
show index from dependent;
show index from dept_locations;
show index from employee;
show index from project;
show index from works_on;

select * from dept_locations;

create index Index_Fname_employee on employee(Fname) using btree;
create index Index_Minit_employee on employee(Minit) using btree;
create index Index_Lname_employee on employee(Lname) using btree;
create index Index_Dno_employee on employee(Dno) using btree;
create index Index_Pname_project on project(Pname) using btree;
create index Index_Pnumber_project on project(Pnumber) using btree;
create index Index_Pno_works_on on works_on(Pno) using btree;
create index Index_Essn_works_on on works_on(Essn) using btree;

select * from departament;
select * from employee;
select * from dept_locations;
select * from project;
select * from works_on;
-- alter table employee drop index Index_Minit_employee;

-- Qual o departamento com maior número de pessoas?

SELECT Dno, COUNT(*) AS total_funcionarios
FROM employee
GROUP BY Dno
ORDER BY total DESC
LIMIT 1;


/* SELECT Dno, Addres, COUNT(*) AS Departamentos_cidade
FROM employee
GROUP BY Dno, Addres
ORDER BY Departamentos_cidade DESC; */

-- Quais são os departamentos por cidade ?
select D.Dnumber, D.Dlocation, e.Dname from dept_locations as D inner join departament as e
on D.Dnumber = e.Dnumber;

-- relação de empregados por departamento
select e.Fname, e.Minit, e.Lname, d.Dnumber, d.Dlocation, c.Dname from dept_locations as d inner join departament as c
on d.Dnumber = c.Dnumber inner join employee as e on d.Dnumber = e.Dno;

show databases;
use ecommerce;
show tables;
desc produto;
DROP PROCEDURE IF EXISTS gerenciar_produtos;
-- procedure ecommerce

DELIMITER //

CREATE PROCEDURE gerenciar_produtos(
    IN P_Id_Popcao INT,
    IN P_Id_produto INT,
    IN P_Pname VARCHAR(45),
    IN P_classificacao_kids INT,
    IN P_categoria ENUM('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'),
    IN P_Descricao VARCHAR(45),
    IN P_avaliacao FLOAT,
    IN P_Size VARCHAR(10),
    IN P_Valor FLOAT
)
BEGIN

    IF P_Id_Popcao = 1 THEN
        SELECT * FROM produto;

    ELSEIF P_Id_Popcao = 2 THEN
INSERT INTO produto (
    Pname, classificação_kids, Categoria, Descrição, Avaliação, Size, Valor
)
VALUES (
    P_Pname, P_classificacao_kids, P_categoria, P_Descricao, P_avaliacao, P_Size, P_Valor
);
    ELSEIF P_Id_Popcao = 3 THEN
        UPDATE produto
        SET
			
            Pname = P_Pname,
            classificação_kids = P_classificacao_kids,
            Categoria = P_categoria,
            Descrição = P_Descricao,
            Avaliação = P_avaliacao,
            Size = P_Size,
            Valor = P_Valor
        WHERE Id_produto = P_Id_produto;

    ELSEIF P_Id_Popcao = 4 THEN
        DELETE FROM produto
        WHERE Id_produto = P_Id_produto;

    END IF;

END //
DESCRIBE produto;
desc produto;

DELIMITER ;
-- testando procedure

-- SELECT
CALL gerenciar_produtos(1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- INSERT 
CALL gerenciar_produtos(2, NULL, 'Camiseta', 1, 'Vestimenta', 'Camiseta básica', 4.5, 'M', 49.90);
-- UPDATE
CALL gerenciar_produtos(3, 10, 'Camiseta Atualizada', 1, 'Vestimenta', 'Nova descrição', 5.0, 'G', 79.90);
-- DROP
CALL gerenciar_produtos(4, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

