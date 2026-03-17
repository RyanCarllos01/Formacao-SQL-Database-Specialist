create database Oficina;
use oficina;
create table Clientes(
id_Cliente int auto_increment primary key,
Fname varchar(30) not null,
Lname varchar(30) not null,
Telefone varchar(12) not null, 
Endereço_Cliente varchar(50) not null,
constraint Unique_telefone unique (Telefone)

);
create table Mão_de_Obra(
Id_Mão_obra int not null auto_increment primary key,
Serviços enum('Troca de velas', 'Pintura', 'Troca de Câmbio', 'Limpeza', 'Troca de óleo', 'troca de pneus'),
Valor_pecas decimal(10,2)
);
create table Oficina_Mecanica(
Id_Oficina int not null auto_increment primary key,
Código_mecanicos int,
CNPJ char(15) not null,
Razão_Social varchar(45),
Endereço varchar(50) not null,
Nome_fantasia varchar(45)
);
create table Veiculo_cliente (
Id_Veiculo int not null primary key auto_increment,
Id_cliente_Veiculo int,
Id_Oficina int,
Cor enum('Verde', 'Branco', 'Preto', 'Azul', 'Rosa', 'Amarelo', 'Vermelho'),
Fabricante varchar(45),
Modelo enum('SUV', 'Sedan', 'Picape', 'Hatch', 'Crossover', 'Minivan', 'Conversível'),
constraint Fk_Id_cliente_Veiculo foreign key(Id_cliente_Veiculo) references Clientes(id_Cliente),
constraint Fk_Id_Oficina foreign key (Id_Oficina) references Oficina_Mecanica(Id_Oficina)
);

Create table Ordem_Serviço(
Id_Oficina_OS int,
Id_Mao_obra_OS int,
Id_Veiculo_OS int,
Número_OS int not null primary key,
data_emissão_OS date not null,
Valores decimal(10,2),
Status_OS enum('em analise','Aguardando aprovação', 'Solicatado','Fila espera', 'Aguardando peças', 'Pronto pra retirada') default "em analise",
Data_Conclusão date,
constraint Fk_Id_Oficina_OS foreign key (Id_Oficina_OS) references Oficina_Mecanica(Id_Oficina),
constraint Fk_ID_Mao_obra_OS foreign key (Id_Mao_obra_OS) references Mão_de_Obra (Id_Mão_obra),
constraint fk_Id_Veiculo foreign key (Id_Veiculo_OS) references Veiculo_cliente(Id_Veiculo)
);

insert into Clientes (Fname, Lname, Telefone, Endereço_Cliente) values
('João', 'Silva', '11999990001', 'Rua A, São Paulo'),
('Maria', 'Oliveira', '11999990002', 'Rua B, São Paulo'),
('Carlos', 'Souza', '11999990003', 'Rua C, São Paulo'),
('Ana', 'Pereira', '11999990004', 'Rua D, São Paulo'),
('Lucas', 'Ferreira', '11999990005', 'Rua E, São Paulo');

insert into Mão_de_Obra (Serviços, Valor_pecas) values
('Troca de óleo', 150.00),
('Troca de pneus', 400.00),
('Pintura', 1200.00),
('Limpeza', 80.00),
('Troca de velas', 200.00);

insert into Oficina_Mecanica (CNPJ, Razão_Social, Endereço, Nome_fantasia) values
('12345678000101', 'Oficina Silva LTDA', 'Av Central, SP', 'Silva Mecânica'),
('98765432000199', 'Auto Center Brasil', 'Av Norte, SP', 'Auto Center'),
('45678912000155', 'Mecânica Rápida', 'Rua Sul, SP', 'Mecânica Rápida');

insert into Veiculo_cliente (Id_cliente_Veiculo, Id_Oficina, Cor, Fabricante, Modelo) values
(1, 1, 'Preto', 'Ford', 'Hatch'),
(1, 2, 'Branco', 'Chevrolet', 'Sedan'),
(2, 1, 'Azul', 'Toyota', 'SUV'),
(3, 3, 'Vermelho', 'Honda', 'Sedan'),
(4, 2, 'Preto', 'Hyundai', 'Hatch'),
(5, 1, 'Branco', 'Fiat', 'Picape');

insert into Ordem_Serviço 
(Id_Oficina_OS, Id_Mao_obra_OS, Id_Veiculo_OS, Número_OS, data_emissão_OS, Valores, Status_OS, Data_Conclusão)
values
(1, 1, 1, 1001, '2026-03-01', 150.00, 'Pronto pra retirada', '2026-03-02'),
(2, 2, 2, 1002, '2026-03-02', 400.00, 'Em analise', null),
(1, 3, 3, 1003, '2026-03-03', 1200.00, 'Aguardando peças', null),
(3, 4, 4, 1004, '2026-03-04', 80.00, 'Pronto pra retirada', '2026-03-04'),
(2, 5, 5, 1005, '2026-03-05', 200.00, 'Fila espera', null),
(1, 1, 6, 1006, '2026-03-06', 150.00, 'Solicatado', null);

-- quantas Ordens de serviço estão registradas?
select * from Ordem_Serviço;
-- há quantos carros sedan na oficina?
select count(*) from Veiculo_Cliente 
where Modelo = 'Sedan';

-- ordenando OS por data emissão
select * from Ordem_Serviço
order by data_emissão_OS asc;
-- quais são os nomes dos clientes e seus respectivos carros
select concat(Fname,' ', Lname) as Nome_Sobrenome, Modelo from Clientes inner join Veiculo_cliente on id_Cliente = Id_cliente_Veiculo;

SELECT Cor, COUNT(*) as total_veiculos FROM Veiculo_cliente
GROUP BY Cor
HAVING COUNT(*) > 1
ORDER BY Cor;