-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `ecommerce`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ecommerce` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `ecommerce`;

--
-- Table structure for table `cliente_cnpj`
--

DROP TABLE IF EXISTS `cliente_cnpj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente_cnpj` (
  `Id_cliente_CNPJ` int NOT NULL AUTO_INCREMENT,
  `CNPJ` varchar(14) NOT NULL,
  `Endereço` varchar(45) NOT NULL,
  `Razão_Social_CNPJ` varchar(60) NOT NULL,
  PRIMARY KEY (`Id_cliente_CNPJ`),
  UNIQUE KEY `Razão_Social_CNPJ` (`Razão_Social_CNPJ`),
  UNIQUE KEY `unique_CNPJ_client` (`CNPJ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_cnpj`
--

LOCK TABLES `cliente_cnpj` WRITE;
/*!40000 ALTER TABLE `cliente_cnpj` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente_cnpj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente_pf`
--

DROP TABLE IF EXISTS `cliente_pf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente_pf` (
  `Id_cliente_PF` int NOT NULL AUTO_INCREMENT,
  `Nome_completo` varchar(65) NOT NULL,
  `CPF` char(11) NOT NULL,
  `Endereco` varchar(155) NOT NULL,
  `Data_Nascimento` varchar(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id_cliente_PF`),
  UNIQUE KEY `unique_cpf_client` (`CPF`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_pf`
--

LOCK TABLES `cliente_pf` WRITE;
/*!40000 ALTER TABLE `cliente_pf` DISABLE KEYS */;
INSERT INTO `cliente_pf` VALUES (1,'Maria M Silva','12346789','rua silva de prata 29, Carangola - Cidade das flores','0'),(2,'Matheus O Pimentel','987654321','rua alemeda 289, Centro - Cidade das flores','0'),(3,'Ricardo F Silva','45678913','avenida alemeda vinha 1009, Centro - Cidade das flores','0'),(4,'Julia S França','789123456','rua lareijras 861, Centro - Cidade das flores','0'),(5,'Roberta G Assis','98745631','avenidade koller 19, Centro - Cidade das flores','0'),(6,'Isabela M Cruz','654789123','rua alemeda das flores 28, Centro - Cidade das flores','0');
/*!40000 ALTER TABLE `cliente_pf` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `clientes_pf_excluidos_trigger` BEFORE DELETE ON `cliente_pf` FOR EACH ROW begin
insert into clientes_pf_excluidos (Id_cliente_PF,Nome_completo,CPF, Endereco, Data_Nascimento)
values (old.Id_cliente_PF, old.Nome_completo, old.CPF, old.Endereco, old.Data_Nascimento);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `clientes_pf_excluidos`
--

DROP TABLE IF EXISTS `clientes_pf_excluidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes_pf_excluidos` (
  `Id_cliente_PF` int DEFAULT NULL,
  `Nome_completo` varchar(65) DEFAULT NULL,
  `CPF` char(11) DEFAULT NULL,
  `Endereco` varchar(155) DEFAULT NULL,
  `Data_Nascimento` varchar(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes_pf_excluidos`
--

LOCK TABLES `clientes_pf_excluidos` WRITE;
/*!40000 ALTER TABLE `clientes_pf_excluidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientes_pf_excluidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estoque_produto`
--

DROP TABLE IF EXISTS `estoque_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estoque_produto` (
  `ID_estoque_produto` int NOT NULL AUTO_INCREMENT,
  `Localização_Estoque` varchar(255) DEFAULT NULL,
  `Quantidade` int DEFAULT '0',
  PRIMARY KEY (`ID_estoque_produto`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoque_produto`
--

LOCK TABLES `estoque_produto` WRITE;
/*!40000 ALTER TABLE `estoque_produto` DISABLE KEYS */;
INSERT INTO `estoque_produto` VALUES (1,'Rio de Janeiro',1000),(2,'Rio de Janeiro',500),(3,'São Paulo',10),(4,'São Paulo',100),(5,'São Paulo',10),(6,'Brasília',60);
/*!40000 ALTER TABLE `estoque_produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedor`
--

DROP TABLE IF EXISTS `fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecedor` (
  `Id_fornecedor` int NOT NULL AUTO_INCREMENT,
  `Razão_Social` varchar(255) NOT NULL,
  `CNPJ` char(15) NOT NULL,
  `Contato` char(11) NOT NULL,
  PRIMARY KEY (`Id_fornecedor`),
  UNIQUE KEY `Unique_fornecedor` (`CNPJ`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedor`
--

LOCK TABLES `fornecedor` WRITE;
/*!40000 ALTER TABLE `fornecedor` DISABLE KEYS */;
INSERT INTO `fornecedor` VALUES (1,'Almeida e filhos','123456789123456','21985474'),(2,'Eletrônicos Silva','854519649143457','21985484'),(3,'Eletrônicos Valma','934567893934695','21975474');
/*!40000 ALTER TABLE `fornecedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `localização_estoque`
--

DROP TABLE IF EXISTS `localização_estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `localização_estoque` (
  `idLproduto` int NOT NULL,
  `idlestoque` int NOT NULL,
  `localização` varchar(255) NOT NULL,
  PRIMARY KEY (`idLproduto`,`idlestoque`),
  KEY `fk_Localização_estoque_estoque` (`idlestoque`),
  CONSTRAINT `fk_Localização_estoque_estoque` FOREIGN KEY (`idlestoque`) REFERENCES `estoque_produto` (`ID_estoque_produto`),
  CONSTRAINT `fk_Localização_estoque_produto` FOREIGN KEY (`idLproduto`) REFERENCES `produto` (`Id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `localização_estoque`
--

LOCK TABLES `localização_estoque` WRITE;
/*!40000 ALTER TABLE `localização_estoque` DISABLE KEYS */;
INSERT INTO `localização_estoque` VALUES (1,2,'RJ'),(2,6,'GO');
/*!40000 ALTER TABLE `localização_estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordem_produto`
--

DROP TABLE IF EXISTS `ordem_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordem_produto` (
  `idPOproduto` int NOT NULL,
  `idPOordem` int NOT NULL,
  `poQuantidade` int DEFAULT '1',
  `poStatus` enum('Disponivel','Sem estoque') DEFAULT 'Disponivel',
  PRIMARY KEY (`idPOproduto`,`idPOordem`),
  KEY `fk_OrdemProduto_produto` (`idPOordem`),
  CONSTRAINT `fk_OrdemProduto_produto` FOREIGN KEY (`idPOordem`) REFERENCES `pedido` (`IdOrder`),
  CONSTRAINT `fk_OrdemProduto_vendedor` FOREIGN KEY (`idPOproduto`) REFERENCES `produto` (`Id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordem_produto`
--

LOCK TABLES `ordem_produto` WRITE;
/*!40000 ALTER TABLE `ordem_produto` DISABLE KEYS */;
INSERT INTO `ordem_produto` VALUES (1,1,1,NULL),(2,2,1,NULL),(3,3,1,NULL);
/*!40000 ALTER TABLE `ordem_produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamentos`
--

DROP TABLE IF EXISTS `pagamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamentos` (
  `Id_pagamentos` int NOT NULL,
  `Id_client_PF` int NOT NULL,
  `Id_client_CNPJ` int NOT NULL,
  `Tipo_pagamento` enum('Boleto','Cartão de crédito','Cartão de Débito','Pix') DEFAULT NULL,
  `Limite_disponível` float DEFAULT NULL,
  PRIMARY KEY (`Id_pagamentos`,`Id_client_PF`,`Id_client_CNPJ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamentos`
--

LOCK TABLES `pagamentos` WRITE;
/*!40000 ALTER TABLE `pagamentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `IdOrder` int NOT NULL AUTO_INCREMENT,
  `Id_cliente_PF_pedido` int DEFAULT NULL,
  `Id_cliente_CNPJ_pedido` int DEFAULT NULL,
  `Status_pedido` enum('cancelado','Em andamento','Processando','Enviado','Entregue') DEFAULT 'Processando',
  `Descrição_pedido` varchar(255) DEFAULT NULL,
  `Frete` float DEFAULT '10',
  `Pagamento_boleto` tinyint(1) DEFAULT '0',
  `paymentCash` int DEFAULT NULL,
  `Id_pagamento` int DEFAULT NULL,
  PRIMARY KEY (`IdOrder`),
  KEY `fk_Pedido_Client_PF` (`Id_cliente_PF_pedido`),
  KEY `fk_Pedido_Client_CNPJ` (`Id_cliente_CNPJ_pedido`),
  KEY `fk_id_pagamento` (`Id_pagamento`),
  CONSTRAINT `fk_id_pagamento` FOREIGN KEY (`Id_pagamento`) REFERENCES `pagamentos` (`Id_pagamentos`) ON UPDATE CASCADE,
  CONSTRAINT `fk_Pedido_Client_CNPJ` FOREIGN KEY (`Id_cliente_CNPJ_pedido`) REFERENCES `cliente_cnpj` (`Id_cliente_CNPJ`),
  CONSTRAINT `fk_Pedido_Client_PF` FOREIGN KEY (`Id_cliente_PF_pedido`) REFERENCES `cliente_pf` (`Id_cliente_PF`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,1,NULL,'Processando','compra via aplicativo',NULL,0,1,NULL),(2,2,NULL,'Processando','compra via aplicativo',50,0,0,NULL),(3,3,NULL,'Em andamento',NULL,NULL,0,1,NULL),(4,4,NULL,'Processando','compra via web site',150,0,0,NULL),(5,2,NULL,'Processando','compra via aplicativo',NULL,0,1,NULL);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `Id_produto` int NOT NULL AUTO_INCREMENT,
  `Pname` varchar(45) NOT NULL,
  `classificação_kids` tinyint(1) DEFAULT '0',
  `Categoria` enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') NOT NULL,
  `Descrição` varchar(45) DEFAULT NULL,
  `Avaliação` float DEFAULT '0',
  `Size` varchar(10) DEFAULT NULL,
  `Valor` float DEFAULT NULL,
  PRIMARY KEY (`Id_produto`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,'Fone de ouvido',0,'Eletrônico',NULL,4,NULL,NULL),(2,'Barbie Elsa',1,'Brinquedos',NULL,3,NULL,NULL),(3,'Body Carters',1,'Vestimenta',NULL,5,NULL,NULL),(4,'Microfone Vedo - Youtuber',0,'Eletrônico',NULL,4,NULL,NULL),(5,'Sofá retrátil',0,'Móveis',NULL,3,'3x57x80',NULL),(6,'Farinha de arroz',0,'Alimentos',NULL,2,NULL,NULL),(7,'Fire Stick Amazon',0,'Eletrônico',NULL,3,NULL,NULL),(9,'',0,'Eletrônico',NULL,0,NULL,NULL),(11,'Camiseta',1,'Vestimenta','Camiseta básica',4.5,'M',49.9);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Produto_excluido_trigger` BEFORE DELETE ON `produto` FOR EACH ROW begin
insert into Produto_excluido (Id_Produto,Pname, classificação_kids, Categoria, Descrição, Avaliação, Size, Valor )
values (old.Id_Produto,Pname, old.classificação_kids, old.Categoria, old.Descrição, old.Avaliação, old.Size, old.Valor);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `produto_excluido`
--

DROP TABLE IF EXISTS `produto_excluido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto_excluido` (
  `Id_Produto` int DEFAULT NULL,
  `Pname` varchar(45) DEFAULT NULL,
  `classificação_kids` tinyint(1) DEFAULT NULL,
  `Categoria` enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') DEFAULT NULL,
  `Descrição` varchar(45) DEFAULT NULL,
  `Avaliação` float DEFAULT NULL,
  `Size` varchar(10) DEFAULT NULL,
  `Valor` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto_excluido`
--

LOCK TABLES `produto_excluido` WRITE;
/*!40000 ALTER TABLE `produto_excluido` DISABLE KEYS */;
INSERT INTO `produto_excluido` VALUES (10,NULL,1,'Vestimenta','Nova descrição',5,'G',79.9);
/*!40000 ALTER TABLE `produto_excluido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto_fornecedor`
--

DROP TABLE IF EXISTS `produto_fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto_fornecedor` (
  `IdPsFornecedor` int NOT NULL,
  `IdPsProduto` int NOT NULL,
  `Quantidade` int NOT NULL,
  PRIMARY KEY (`IdPsFornecedor`,`IdPsProduto`),
  KEY `fk_produto_fornecedor_Produto` (`IdPsProduto`),
  CONSTRAINT `fk_produto_fornecedor_Fornecedor` FOREIGN KEY (`IdPsFornecedor`) REFERENCES `fornecedor` (`Id_fornecedor`),
  CONSTRAINT `fk_produto_fornecedor_Produto` FOREIGN KEY (`IdPsProduto`) REFERENCES `produto` (`Id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto_fornecedor`
--

LOCK TABLES `produto_fornecedor` WRITE;
/*!40000 ALTER TABLE `produto_fornecedor` DISABLE KEYS */;
INSERT INTO `produto_fornecedor` VALUES (1,1,500),(1,2,400),(2,4,633),(2,5,10),(3,3,5);
/*!40000 ALTER TABLE `produto_fornecedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto_vendedor`
--

DROP TABLE IF EXISTS `produto_vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto_vendedor` (
  `IdProduto_vendedor` int NOT NULL,
  `Id_pproduto` int NOT NULL,
  `Quantidade_produtos` int DEFAULT '1',
  PRIMARY KEY (`IdProduto_vendedor`,`Id_pproduto`),
  KEY `fk_produto_produto` (`Id_pproduto`),
  CONSTRAINT `fk_produto_produto` FOREIGN KEY (`Id_pproduto`) REFERENCES `produto` (`Id_produto`),
  CONSTRAINT `fk_produto_vendedor` FOREIGN KEY (`IdProduto_vendedor`) REFERENCES `vendedor` (`Id_Vendedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto_vendedor`
--

LOCK TABLES `produto_vendedor` WRITE;
/*!40000 ALTER TABLE `produto_vendedor` DISABLE KEYS */;
INSERT INTO `produto_vendedor` VALUES (1,6,80),(2,7,10);
/*!40000 ALTER TABLE `produto_vendedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendedor`
--

DROP TABLE IF EXISTS `vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendedor` (
  `Id_Vendedor` int NOT NULL AUTO_INCREMENT,
  `Razão_Social` varchar(255) NOT NULL,
  `Nome_fantasia` varchar(255) DEFAULT NULL,
  `Localidade` varchar(255) DEFAULT NULL,
  `CNPJ` char(15) DEFAULT NULL,
  `CPF` char(9) DEFAULT NULL,
  `Contato` char(11) NOT NULL,
  PRIMARY KEY (`Id_Vendedor`),
  UNIQUE KEY `Unique_Vendedor_CNPJ` (`CNPJ`),
  UNIQUE KEY `Unique_Vendedor_PF` (`CPF`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendedor`
--

LOCK TABLES `vendedor` WRITE;
/*!40000 ALTER TABLE `vendedor` DISABLE KEYS */;
INSERT INTO `vendedor` VALUES (1,'Tech eletronics',NULL,'Rio de Janeiro','123456789456321',NULL,'219946287'),(2,'Botique Durgas',NULL,'Rio de Janeiro',NULL,'123456783','219567895'),(3,'Kids World',NULL,'São Paulo','456789123654485',NULL,'1198657484');
/*!40000 ALTER TABLE `vendedor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-06 13:32:02
