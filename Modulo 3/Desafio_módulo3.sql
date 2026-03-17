-- Criação do banco de dados para o cenário de E-commerce
create database if not exists ecommerce;
use ecommerce;

create table cliente_PF
(
Id_cliente_PF int auto_increment primary key,
Nome_completo varchar (65) not null,
CPF char(11) not null,
Endereco varchar(155) not null,
Data_Nascimento varchar(9)not null default 0,
constraint unique_cpf_client unique(CPF)
);

create table cliente_CNPJ
(
Id_cliente_CNPJ int auto_increment primary key,
CNPJ varchar (14) not null,
Endereço varchar(45) not null,
Razão_Social_CNPJ varchar(60) not null unique,
constraint unique_CNPJ_client unique(CNPJ)

);

create table Produto
(
Id_produto int auto_increment primary key,
Pname varchar(45) not null,
classificação_kids bool default false,
Categoria enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
Descrição varchar(45),
Avaliação float default 0,
Size varchar(10), -- size é a dimensão do produto
Valor float
);
create table pagamentos(
Id_pagamentos int,
Id_client_PF int,
Id_client_CNPJ int, 
Tipo_pagamento enum ('Boleto', 'Cartão de crédito', 'Cartão de Débito', 'Pix'),
Limite_disponível float,
Primary key (Id_pagamentos, Id_client_PF, Id_client_CNPJ)
);
-- criar tabela pedido
create table pedido(
IdOrder int auto_increment primary key,
Id_cliente_PF_pedido int,
Id_cliente_CNPJ_pedido int,
Status_pedido ENUM('cancelado','Em andamento', 'Processando', 'Enviado', 'Entregue') default 'Processando',
Descrição_pedido varchar(255),
Frete float default 10,
Pagamento_boleto bool default false,
paymentCash int,
Id_pagamento int,
constraint fk_Pedido_Client_PF foreign key (Id_cliente_PF_pedido) references cliente_PF (Id_cliente_PF),
constraint fk_Pedido_Client_CNPJ foreign key (Id_cliente_CNPJ_pedido) references cliente_CNPJ (Id_cliente_CNPJ),
constraint fk_id_pagamento foreign key (Id_pagamento) references Pagamentos(Id_pagamentos)
on update cascade
);

create table Estoque_Produto(
ID_estoque_produto int auto_increment primary key,
Localização_Estoque varchar(255),
Quantidade int default 0
);

create table Fornecedor(
Id_fornecedor int auto_increment primary key,
Razão_Social varchar(255) not null,
CNPJ char(15) not null,
Contato char(11) not null,
constraint Unique_fornecedor unique (CNPJ)
);

Create table Vendedor(
Id_Vendedor int auto_increment primary key,
Razão_Social varchar(255) not null,
Nome_fantasia varchar (255),
Localidade varchar(255),
CNPJ char(15),
CPF char(9),
Contato char(11) not null,
constraint Unique_Vendedor_CNPJ unique (CNPJ),
constraint Unique_Vendedor_PF unique (CPF)
);

create table Produto_vendedor(
IdProduto_vendedor int,
Id_pproduto int,
Quantidade_produtos int default 1,
primary key (IdProduto_vendedor, Id_pproduto),
constraint fk_produto_vendedor foreign key (IdProduto_vendedor) references Vendedor(ID_Vendedor),
constraint fk_produto_produto foreign key (Id_pproduto) references Produto(Id_produto)
);

create table Ordem_Produto(
idPOproduto int,
idPOordem int,
poQuantidade int default 1,
poStatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
primary key (idPOproduto, idPOordem ),
constraint fk_OrdemProduto_vendedor foreign key (idPOproduto) references produto(Id_produto),
constraint fk_OrdemProduto_produto foreign key (idPOordem) references pedido(IdOrder)
);

create table Localização_estoque(
idLproduto int,
idlestoque int,
localização varchar(255) not null,
primary key (idLproduto, idlestoque),
constraint fk_Localização_estoque_produto foreign key (idLproduto) references produto(Id_produto),
constraint fk_Localização_estoque_estoque foreign key (idlestoque) references Estoque_Produto(ID_estoque_produto)
);

create table Produto_Fornecedor(
IdPsFornecedor int,
IdPsProduto int,
Quantidade int not null,
Primary key (IdPsFornecedor, IdPsProduto),
constraint fk_produto_fornecedor_Fornecedor foreign key (IdPsFornecedor) references Fornecedor (Id_fornecedor),
constraint fk_produto_fornecedor_Produto foreign key (IdPsProduto) references Produto (Id_produto)
);
create table Entrega(
IdEntrega int auto_increment primary key,
código_rastreio varchar(15) not null unique,
Status_pedido enum('Em preparação', 'Objeto Postado','A caminho','Entregue'),
Id_Cliente_PF_Entrega int,
Id_Cliente_CNPJ_Entrega int,
Id_Pedido_Entrega int,
constraint fk_Entrega_Cliente_PF foreign key (Id_Cliente_PF_Entrega) references client_PF (Id_cliente_PF),
constraint fk_Entrega_Cliente_CNPJ foreign key(Id_Cliente_CNPJ_Entrega) references cliente_CNPJ (Id_cliente_CNPJ),
constraint fk_Entrega_pedido foreign key (Id_Pedido_Entrega) references pedido(IdOrder)
);
-- show tables;
show tables;
use information_schema;
desc REFERENTIAL_CONSTRAINTS;
SELECT * FROM REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = 'ecommerce';

-- inserção dos dados
-- idClient, Fname, Minit, Lname, CPF, Address
use ecommerce;
insert into cliente_PF (Nome_completo, CPF, Endereco) 
	   values('Maria M Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores'),
		     ('Matheus O Pimentel', 987654321,'rua alemeda 289, Centro - Cidade das flores'),
			 ('Ricardo F Silva', 45678913,'avenida alemeda vinha 1009, Centro - Cidade das flores'),
			 ('Julia S França', 789123456,'rua lareijras 861, Centro - Cidade das flores'),
			 ('Roberta G Assis', 98745631,'avenidade koller 19, Centro - Cidade das flores'),
			 ('Isabela M Cruz', 654789123,'rua alemeda das flores 28, Centro - Cidade das flores');
             
             insert into Produto (Pname, classificação_kids, Categoria, Avaliação, Size) values
							  ('Fone de ouvido',false,'Eletrônico','4',null),
                              ('Barbie Elsa',true,'Brinquedos','3',null),
                              ('Body Carters',true,'Vestimenta','5',null),
                              ('Microfone Vedo - Youtuber',False,'Eletrônico','4',null),
                              ('Sofá retrátil',False,'Móveis','3','3x57x80'),
                              ('Farinha de arroz',False,'Alimentos','2',null),
                              ('Fire Stick Amazon',False,'Eletrônico','3',null);

insert into pedido (Id_cliente_PF_pedido, Status_pedido, Descrição_pedido, Frete, PaymentCash ) values 
							 (1, default,'compra via aplicativo',null,1),
                             (2,default,'compra via aplicativo',50,0),
                             (3,'Em andamento',null,null,1),
                             (4,default,'compra via web site',150,0);
                             
					insert into Ordem_Produto (idPOproduto, idPOordem, poQuantidade, poStatus) values
						 (1,1,1,null),
                         (2,2,1,null),
                         (3,3,1,null);
                         insert into Estoque_Produto (Localização_Estoque,Quantidade) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);
                            
                            insert into  Localização_estoque (idLproduto, idlestoque, localização) values
						 (1,2,'RJ'),
                         (2,6,'GO');
                         select * from Ordem_Produto;
insert into Fornecedor (Razão_social, CNPJ, Contato) values 
							('Almeida e filhos', 123456789123456,'21985474'),
                            ('Eletrônicos Silva',854519649143457,'21985484'),
                            ('Eletrônicos Valma', 934567893934695,'21975474');
                            
                            insert into Produto_Fornecedor (idPsFornecedor, idPsProduto, Quantidade) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);
                         
                         insert into Vendedor (Razão_Social, Nome_fantasia, CNPJ, CPF, Localidade, Contato) values 
						('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
					    ('Botique Durgas',null,null,123456783,'Rio de Janeiro', 219567895),
						('Kids World',null,456789123654485,null,'São Paulo', 1198657484);
                        
                        insert into Produto_vendedor (IdProduto_vendedor, Id_pproduto,Quantidade_produtos ) values 
						 (1,6,80),
                         (2,7,10);
                         select * from Pedido;
                         select Nome_completo as Cliente_PF, IdOrder as Request, Status_pedido from Cliente_PF c, pedido P where Id_cliente_PF_pedido = Id_cliente_PF_pedido;
                         
                         insert into Pedido (Id_cliente_PF_pedido, Status_pedido, Descrição_pedido, Frete, paymentCash) values 
							 (2, default,'compra via aplicativo',null,1);
                      
                         select count(*) from cliente_PF, pedido
                         where Id_cliente_PF_pedido = Id_cliente_PF_pedido
                         group by IdOrder;
                         
                         -- recuperação de pedido com produto associado
					select * from cliente_PF c 
				inner join pedido o ON c.Id_cliente_PF = o.Id_cliente_PF_pedido
                inner join Ordem_Produto p on p.idPOordem = o.IdOrder;
				-- group by Id_cliente_PF; 
        
        
                         -- Recuperar quantos pedidos foram realizados pelos clientes
                            select * from pedido;
                     select c.Id_cliente_PF, Nome_completo, count(*) as Number_of_orders from cliente_PF c inner join pedido o on c.Id_cliente_PF = o.Id_cliente_PF_pedido
                        -- inner join Ordem_Produto p on p.idPOordem = o.IdOrder
                        group by Id_cliente_PF
                        having count(*)>1;
                        
                        -- Verificando se algum vendedor também é fornecedor , não existe
			select V.Id_Vendedor, V.Razão_Social, F.Razão_Social, F.Id_fornecedor, V.CNPJ as CNPJ_Vendedor, F.CNPJ as CNPJ_fornecedor from Vendedor V inner join Fornecedor F using (CNPJ);
         
	select 
    P.Id_produto,
    P.Pname as Produto,
    F.Id_fornecedor,
    F.Razão_Social as Fornecedor,
    LF.Quantidade as Quantidade_Fornecida,
    E.Localização_Estoque as Estoque_Local,
    LE.localização as Localização_Produto
from Produto P
inner join Produto_Fornecedor LF on P.Id_produto = LF.IdPsProduto
inner join Fornecedor F on LF.IdPsFornecedor = F.Id_fornecedor
left join Localização_estoque LE on P.Id_produto = LE.idLproduto
left join Estoque_Produto E on LE.idlestoque = E.ID_estoque_produto
order by Quantidade_Fornecida desc
 ;

select F.Razão_Social as Nome_fornecedor, P.Pname as Nome_produto from Fornecedor F
left join Produto_Fornecedor PF on F.Id_fornecedor = PF.IdPsFornecedor
left join Produto P on PF.IdPsProduto = P.Id_produto;