-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: lydtpc00534_tt
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `Username` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Fullname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Photo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES ('admin','12345','Nguyễn Admin123','admin@fpt.edu.vn','user.png'),('pm','12345','Huỳnh PM','pm@fpt.edu.vn','user.png'),('user','12345','Trần User','user@fpt.edu.vn','user.png');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authorities`
--

DROP TABLE IF EXISTS `authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authorities` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `RoleId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UKhtk0tjw6uf67w0vkhy5n3j1oq` (`Username`,`RoleId`),
  KEY `FKevi9708lm1k06pa4dugc91k7v` (`RoleId`),
  CONSTRAINT `FKevi9708lm1k06pa4dugc91k7v` FOREIGN KEY (`RoleId`) REFERENCES `roles` (`Id`),
  CONSTRAINT `FKlw0sapcjvuxfa1kvyjw7jml88` FOREIGN KEY (`Username`) REFERENCES `accounts` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorities`
--

LOCK TABLES `authorities` WRITE;
/*!40000 ALTER TABLE `authorities` DISABLE KEYS */;
INSERT INTO `authorities` VALUES (2,'admin','ADMIN'),(3,'pm','PM'),(4,'pm','USER'),(15,'user','USER');
/*!40000 ALTER TABLE `authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `Id` char(4) NOT NULL,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES ('1000','Điện thoại di động'),('2000','Máy tính'),('3000','Đồng hồ');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetails` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `OrderId` bigint NOT NULL,
  `ProductId` int NOT NULL,
  `Price` float NOT NULL,
  `Quantity` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FKj4gc2ja2otvwemf4rho2lp3s8` (`OrderId`),
  KEY `FKaltatpxipsjtcih4d1h6bn0xr` (`ProductId`),
  CONSTRAINT `FKaltatpxipsjtcih4d1h6bn0xr` FOREIGN KEY (`ProductId`) REFERENCES `products` (`Id`),
  CONSTRAINT `FKj4gc2ja2otvwemf4rho2lp3s8` FOREIGN KEY (`OrderId`) REFERENCES `orders` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
INSERT INTO `orderdetails` VALUES (1,1,1,1000000,10),(2,2,2,2000000,5),(5,3,3,2500000,2),(6,6,1,1000000,2),(7,6,3,2500000,1);
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime NOT NULL,
  `Address` varchar(256) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FKk3cjfcgb621qhahps1tre43e4` (`Username`),
  CONSTRAINT `FKk3cjfcgb621qhahps1tre43e4` FOREIGN KEY (`Username`) REFERENCES `accounts` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'user','2021-03-02 00:00:00','Cần Thơ'),(2,'user','2021-05-02 00:00:00','Cần Thơ'),(3,'pm','2020-10-26 00:00:00','Sóc Trăng'),(4,'pm','2021-01-13 00:00:00','Sóc Trăng'),(5,'user','2021-08-01 00:00:00','Cần Thơ'),(6,'user','2021-09-03 00:00:00','Bạc Liêu');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Image` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Price` float NOT NULL,
  `CreateDate` date NOT NULL,
  `Available` bit(1) NOT NULL,
  `CategoryId` char(4) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK1krrsjgcawsfg8k8u4hm5gi8q` (`CategoryId`),
  CONSTRAINT `FK1krrsjgcawsfg8k8u4hm5gi8q` FOREIGN KEY (`CategoryId`) REFERENCES `categories` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Iphone 11','ip1.png',1000000,'2020-09-09',_binary '','1000'),(2,'Iphone 11  Pro','ip2.png',2000000,'2020-10-01',_binary '','1000'),(3,'Iphone 11 Pro Max','ip3.png',2500000,'2021-01-03',_binary '','1000'),(4,'Iphone 11 Blue','ip4.png',3000000,'2020-09-10',_binary '','1000'),(5,'Iphone 11 Pro','ip5.png',3500000,'2020-01-05',_binary '','1000'),(6,'Iphone 11 Color','ip6.png',4000000,'2021-05-26',_binary '','1000'),(7,'Iphone 15 Purple','ip7.png',4500000,'2020-09-21',_binary '','1000'),(8,'Iphone 11 Color','ip8.png',5000000,'2021-05-05',_binary '','1000'),(9,'Iphone 11 Pro Grey ','ip9.png',5200000,'2021-10-01',_binary '','1000'),(10,'Iphone 12 Pro','ip10.png',5400000,'2021-12-26',_binary '','1000'),(11,'Iphone 11 ','ip11.png',5500000,'2021-09-10',_binary '','1000'),(12,'Iphone 12 Pro Blue & Purple  ','ip12.png',5600000,'2021-02-02',_binary '','1000'),(13,'Iphone 11 Color','ip13.png',5700000,'2021-02-23',_binary '','1000'),(14,'Iphone 12 Pro Blue','ip14.png',5800000,'2021-02-23',_binary '','1000'),(15,'Laptop Dell','mt1.jpg',1400000,'2021-02-02',_binary '','2000'),(16,'Laptop 2','mt2.jpg',2000000,'2021-09-10',_binary '','2000'),(17,'Laptop ASUS','mt3.jpg',2300000,'2021-02-02',_binary '','2000'),(18,'Laptop HP','mt4.png',3000000,'2021-12-26',_binary '','2000'),(19,'Laptop Gaming','mt5.jpg',5000000,'2021-05-05',_binary '','2000'),(20,'Laptop MSI','mt6.jpg',3400000,'2021-10-01',_binary '','2000'),(21,'Laptop HP','mt7.png',3200000,'2021-09-10',_binary '','2000'),(22,'Laptop MSI','mt9.jpg',3400000,'2021-10-01',_binary '','2000'),(23,'Laptop Lenovo','mt10.jpg',3450000,'2021-02-02',_binary '','2000'),(24,'Laptop MSI','mt9.jpg',3400000,'2021-10-01',_binary '','2000'),(25,'Đồng hồ Hublot nữ','dh1.jpg',6000000,'2021-09-28',_binary '','3000'),(26,'Đồng hồ TEINTOP','dh2.jpg',4500000,'2021-02-02',_binary '','3000'),(27,'Đồng hồ thể thao','dh3.jpg',1500000,'2021-05-05',_binary '','3000'),(28,'Đồng hồ Hublot nam','dh4.jpg',6000000,'2021-09-28',_binary '','3000'),(30,'Đồng hồ cá tính','dh9.jpg',1200000,'2021-10-01',_binary '','3000'),(31,'Đồng hồ mạ Bạc','dh6.jpg',2300000,'2021-10-01',_binary '','3000'),(32,'Đồng hồ thể thao','dh7.jpg',1400000,'2021-02-02',_binary '','3000'),(33,'Đồng hồ thể thao','dh8.jpg',1400000,'2021-10-01',_binary '','3000'),(34,'Đồng hồ thể thao','dh10.jpg',1400000,'2021-10-01',_binary '','3000');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `Id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES ('ADMIN','Admin'),('PM','Pm'),('USER','User');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-08 10:18:28
