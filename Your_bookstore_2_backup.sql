-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: CarlsonHotel
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `BookingID` int NOT NULL AUTO_INCREMENT,
  `GuestID` int NOT NULL,
  `RoomID` int NOT NULL,
  `CheckinDate` date NOT NULL,
  `CheckoutDate` date NOT NULL,
  `BookingStatus` enum('Booked','Checked-in','Checked-out','Cancelled') NOT NULL DEFAULT 'Booked',
  PRIMARY KEY (`BookingID`),
  KEY `GuestID` (`GuestID`),
  KEY `RoomID` (`RoomID`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`GuestID`) REFERENCES `guest` (`GuestID`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`RoomID`) REFERENCES `room` (`RoomID`),
  CONSTRAINT `check_min_one_night` CHECK ((`CheckoutDate` > `CheckinDate`))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,1,1,'2025-03-24','2025-03-25','Booked'),(2,2,7,'2025-03-25','2025-03-28','Booked'),(3,3,5,'2025-07-14','2025-07-16','Booked'),(4,4,3,'2025-10-07','2025-10-08','Booked'),(5,2,4,'2025-10-07','2025-10-08','Booked'),(6,1,5,'2025-12-24','2025-12-27','Booked'),(8,3,2,'2025-05-18','2025-05-19','Booked');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_bookinglog_insert` AFTER INSERT ON `booking` FOR EACH ROW BEGIN
    INSERT INTO BookingLog (BookingID, Action)
    VALUES (NEW.BookingID, 'NEW');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_bookinglog_update` AFTER UPDATE ON `booking` FOR EACH ROW BEGIN
    INSERT INTO BookingLog (BookingID, Action)
    VALUES (NEW.BookingID, 'UPDATED');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `bookinglog`
--

DROP TABLE IF EXISTS `bookinglog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookinglog` (
  `LogID` int NOT NULL AUTO_INCREMENT,
  `BookingID` int NOT NULL,
  `Action` varchar(50) NOT NULL DEFAULT 'NEW',
  `LogTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`LogID`),
  KEY `BookingID` (`BookingID`),
  CONSTRAINT `bookinglog_ibfk_1` FOREIGN KEY (`BookingID`) REFERENCES `booking` (`BookingID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookinglog`
--

LOCK TABLES `bookinglog` WRITE;
/*!40000 ALTER TABLE `bookinglog` DISABLE KEYS */;
INSERT INTO `bookinglog` VALUES (1,8,'NEW','2025-03-25 14:13:09');
/*!40000 ALTER TABLE `bookinglog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookingservice`
--

DROP TABLE IF EXISTS `bookingservice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookingservice` (
  `BkServiceID` int NOT NULL AUTO_INCREMENT,
  `BookingID` int NOT NULL,
  `ServiceID` int NOT NULL,
  `Quantity` int NOT NULL,
  PRIMARY KEY (`BkServiceID`),
  KEY `BookingID` (`BookingID`),
  KEY `ServiceID` (`ServiceID`),
  CONSTRAINT `bookingservice_ibfk_1` FOREIGN KEY (`BookingID`) REFERENCES `booking` (`BookingID`),
  CONSTRAINT `bookingservice_ibfk_2` FOREIGN KEY (`ServiceID`) REFERENCES `service` (`ServiceID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookingservice`
--

LOCK TABLES `bookingservice` WRITE;
/*!40000 ALTER TABLE `bookingservice` DISABLE KEYS */;
INSERT INTO `bookingservice` VALUES (1,1,1,1),(2,1,2,2);
/*!40000 ALTER TABLE `bookingservice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guest`
--

DROP TABLE IF EXISTS `guest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guest` (
  `GuestID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Email` varchar(100) NOT NULL,
  PRIMARY KEY (`GuestID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guest`
--

LOCK TABLES `guest` WRITE;
/*!40000 ALTER TABLE `guest` DISABLE KEYS */;
INSERT INTO `guest` VALUES (1,'Matilda','Andersson','0707-610 632','Matildas@mail.com'),(2,'Mattias','Karlsson','0735-401 390','Mattias70@spray.se'),(3,'Henrik','Henriksson','0761-610 259','Henrik.karlsson@hotmail.com'),(4,'Sandra','Dahlberg','0744-999 333','Sandra.D@gmail.com');
/*!40000 ALTER TABLE `guest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `PaymentID` int NOT NULL AUTO_INCREMENT,
  `BookingID` int NOT NULL,
  `PayMethodID` int NOT NULL,
  `PaymentDate` date NOT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `PaymentStatus` enum('Pending','Paid','Refunded') NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`PaymentID`),
  KEY `BookingID` (`BookingID`),
  KEY `PayMethodID` (`PayMethodID`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`BookingID`) REFERENCES `booking` (`BookingID`),
  CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`PayMethodID`) REFERENCES `paymethod` (`PayMethodID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,1,2,'2025-03-24',990.00,'Paid'),(2,2,3,'2025-03-24',8970.00,'Paid'),(3,3,3,'2025-03-22',3990.00,'Paid'),(4,4,4,'2025-02-23',1590.00,'Paid'),(5,5,1,'2025-03-28',1590.00,'Paid'),(6,6,4,'2025-12-23',5985.00,'Pending');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paymethod`
--

DROP TABLE IF EXISTS `paymethod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paymethod` (
  `PayMethodID` int NOT NULL AUTO_INCREMENT,
  `MethodName` varchar(50) NOT NULL,
  PRIMARY KEY (`PayMethodID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymethod`
--

LOCK TABLES `paymethod` WRITE;
/*!40000 ALTER TABLE `paymethod` DISABLE KEYS */;
INSERT INTO `paymethod` VALUES (1,'Kontanter'),(2,'Kortbetalning'),(3,'Swish'),(4,'Faktura');
/*!40000 ALTER TABLE `paymethod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `RoomID` int NOT NULL AUTO_INCREMENT,
  `RoomTypeID` int NOT NULL,
  `RoomNumber` varchar(10) NOT NULL,
  `RoomStatus` enum('Available','Occupied') NOT NULL DEFAULT 'Available',
  PRIMARY KEY (`RoomID`),
  UNIQUE KEY `RoomNumber` (`RoomNumber`),
  KEY `RoomTypeID` (`RoomTypeID`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`RoomTypeID`) REFERENCES `roomtype` (`RoomTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,1,'101','Available'),(2,1,'102','Available'),(3,2,'201','Available'),(4,2,'202','Available'),(5,3,'301','Available'),(6,3,'302','Available'),(7,4,'401','Available'),(8,4,'402','Available');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roomtype`
--

DROP TABLE IF EXISTS `roomtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roomtype` (
  `RoomTypeID` int NOT NULL AUTO_INCREMENT,
  `RoomName` varchar(50) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`RoomTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roomtype`
--

LOCK TABLES `roomtype` WRITE;
/*!40000 ALTER TABLE `roomtype` DISABLE KEYS */;
INSERT INTO `roomtype` VALUES (1,'Enkelrum',990.00),(2,'Dubbelrum',1590.00),(3,'Deluxe Dubbelrum',1995.00),(4,'Premium Deluxe',2990.00);
/*!40000 ALTER TABLE `roomtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `ServiceID` int NOT NULL AUTO_INCREMENT,
  `ServiceName` varchar(50) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ServiceID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'Chips',39.00),(2,'Carlsberg',69.00),(3,'Jordnötter',45.00);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-26 14:14:33
