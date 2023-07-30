CREATE DATABASE  IF NOT EXISTS `airline_dbms` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `airline_dbms`;
-- MySQL dump 10.13  Distrib 8.0.29, for macos12 (x86_64)
--
-- Host: localhost    Database: airline_dbms
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `aircraft`
--

DROP TABLE IF EXISTS `aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircraft` (
  `model_id` varchar(10) NOT NULL,
  `model_name` char(64) NOT NULL,
  `manufactured_year` int DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `airline_code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`model_id`),
  UNIQUE KEY `model_name` (`model_name`),
  KEY `airline_code` (`airline_code`),
  CONSTRAINT `aircraft_ibfk_1` FOREIGN KEY (`airline_code`) REFERENCES `airline` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft`
--

LOCK TABLES `aircraft` WRITE;
/*!40000 ALTER TABLE `aircraft` DISABLE KEYS */;
INSERT INTO `aircraft` VALUES ('A320','Airbus A320',2010,170,'DL'),('A330','Airbus A330',2005,250,'DL'),('A380','Airbus A380',2010,550,'DL'),('B737','Boeing 737',2000,150,'DL'),('B747','Boeing 747',2008,400,'DL'),('B777','Boeing 777',2015,300,'DL'),('B787','Boeing 787',2018,250,'DL'),('CRJ7','Bombardier CRJ700',2012,70,'DL'),('E190','Embraer E190',2016,100,'DL'),('MD11','McDonnell Douglas MD-11',1995,320,'DL');
/*!40000 ALTER TABLE `aircraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airline`
--

DROP TABLE IF EXISTS `airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airline` (
  `code` varchar(10) NOT NULL,
  `name` char(64) NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airline`
--

LOCK TABLES `airline` WRITE;
/*!40000 ALTER TABLE `airline` DISABLE KEYS */;
INSERT INTO `airline` VALUES ('DL','Delta Airlines');
/*!40000 ALTER TABLE `airline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport` (
  `code` varchar(10) NOT NULL,
  `name` char(64) NOT NULL,
  `street` varchar(64) NOT NULL,
  `city` char(20) NOT NULL,
  `zipcode` int NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `zipcode` (`zipcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
INSERT INTO `airport` VALUES ('CDG','Paris Charles de Gaulle Airport','95700 Roissy-en-France','Paris',95700),('DXB','Dubai International Airport','Dubai - United Arab Emirates','Dubai',0),('HND','Tokyo International Airport (Haneda)','4-chome Hanedakuko','Ota City',1440041),('ICN','Incheon International Airport','272 Gonghang-ro','Jung-gu',22382),('IST','Istanbul Atatürk Airport','Yesilkoy','Istanbul',34149),('JFK','John F. Kennedy International Airport','JFK Expressway','New York',54321),('LAX','Los Angeles International Airport','1 World Way','Los Angeles',67890),('LHR','London Heathrow Airport','Longford','London',67809),('MAD','Adolfo Suárez Madrid–Barajas Airport','Avenida de la Hispanidad s/n','Madrid',28042),('MEX','Mexico City International Airport','Av. Capitán Carlos León S/N','Mexico City',15620),('PEK','Beijing Capital International Airport','Airport Rd','Beijing',100621),('SFO','San Francisco International Airport','International Terminal','San Francisco',12354),('SIN','Changi Airport','Airport Blvd','Singapore',819642),('SYD','Sydney Kingsford Smith Airport','Airport Dr','Mascot',2020),('YYZ','Toronto Pearson International Airport','6301 Silver Dart Dr','Mississauga',12345);
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew`
--

DROP TABLE IF EXISTS `crew`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crew` (
  `crew_id` varchar(5) NOT NULL,
  `description` varchar(64) NOT NULL,
  PRIMARY KEY (`crew_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew`
--

LOCK TABLES `crew` WRITE;
/*!40000 ALTER TABLE `crew` DISABLE KEYS */;
INSERT INTO `crew` VALUES ('CR001','Cabin Crew'),('CR002','Baggage Crew'),('CR003','Customer Service Crew'),('CR004','Cabin Crew'),('CR005','Cabin Crew'),('CR006','Maintenance Crew'),('CR007','Cabin Crew'),('CR008','Cabin Crew'),('CR009','Baggage Crew'),('CR010','Customer Service Crew');
/*!40000 ALTER TABLE `crew` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` char(20) NOT NULL,
  `last_name` char(20) NOT NULL,
  `id_type` char(20) DEFAULT NULL,
  `credit_card_number` int DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `credit_card_number` (`credit_card_number`)
) ENGINE=InnoDB AUTO_INCREMENT=1013 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1001,'William','Shatner','Passport',12345678),(1002,'Robert','Downey','Driver License',23456789),(1003,'Steve','Smith','Passport',34567890),(1004,'Trent','Boult','National ID',45678901),(1005,'Emma','Stone','Passport',56789012),(1006,'Bradley','Cooper','Driver License',67890123),(1007,'Jennifer','Lawrence','Passport',78901234),(1008,'Chris','Hemsworth','National ID',89012345),(1009,'Scarlett','Johansson','Driver License',90123456),(1010,'Ryan','Reynolds','Passport',12347890);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `flight_no` varchar(10) NOT NULL,
  `dep_date` date DEFAULT NULL,
  `dep_time` time DEFAULT NULL,
  `gate_no` varchar(4) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `seats_available` int DEFAULT NULL,
  `aircraft_id` varchar(10) NOT NULL,
  `assigned_crew` varchar(5) DEFAULT NULL,
  `dep_airport` varchar(10) NOT NULL,
  `arr_airport` varchar(10) NOT NULL,
  PRIMARY KEY (`flight_no`),
  KEY `aircraft_id` (`aircraft_id`),
  KEY `assigned_crew` (`assigned_crew`),
  KEY `dep_airport` (`dep_airport`),
  KEY `arr_airport` (`arr_airport`),
  CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`aircraft_id`) REFERENCES `aircraft` (`model_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`assigned_crew`) REFERENCES `crew` (`crew_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `flight_ibfk_3` FOREIGN KEY (`dep_airport`) REFERENCES `airport` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `flight_ibfk_4` FOREIGN KEY (`arr_airport`) REFERENCES `airport` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES ('DL001','2023-05-01','08:00:00','A1','On time',148,'B737','CR001','JFK','LAX'),('DL002','2023-05-02','09:00:00','B2','On time',170,'A320','CR004','LHR','CDG'),('DL003','2023-05-03','10:00:00','C3','Delayed',298,'B777','CR001','DXB','JFK'),('DL004','2023-05-04','11:00:00','D4','On time',550,'A380','CR005','LAX','JFK'),('DL005','2023-05-05','12:00:00','E5','Delayed',249,'B787','CR004','LAX','SFO'),('DL006','2023-05-06','13:00:00','F6','On time',150,'B737','CR002','YYZ','LAX'),('DL007','2023-05-07','14:00:00','G7','Delayed',170,'A320','CR007','JFK','LHR'),('DL008','2023-05-08','15:00:00','H8','On time',300,'B777','CR003','CDG','JFK'),('DL009','2023-05-09','16:00:00','I9','Delayed',550,'A380','CR006','LHR','DXB'),('DL010','2023-05-10','17:00:00','J10','On time',250,'B787','CR008','SFO','LAX');
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `reservation_no` int NOT NULL AUTO_INCREMENT,
  `is_seat_assigned` tinyint(1) DEFAULT NULL,
  `flight_no` varchar(10) NOT NULL,
  `customer` int NOT NULL,
  PRIMARY KEY (`reservation_no`),
  KEY `flight_no` (`flight_no`),
  KEY `customer` (`customer`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`flight_no`) REFERENCES `flight` (`flight_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`customer`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (101,1,'DL001',1001),(102,0,'DL002',1002),(103,1,'DL003',1003),(104,0,'DL004',1004),(105,1,'DL001',1005),(106,0,'DL002',1006),(107,1,'DL003',1007),(108,0,'DL004',1008);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_seats_available_on_insert` AFTER INSERT ON `reservation` FOR EACH ROW BEGIN
IF (NEW.is_seat_assigned = 1) THEN
UPDATE flight
SET seats_available = seats_available - 1
WHERE flight_no = NEW.flight_no ;
END IF;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_seats_available_on_update` AFTER UPDATE ON `reservation` FOR EACH ROW BEGIN
-- Case 1
IF (OLD.is_seat_assigned = 1 AND NEW.is_seat_assigned = 1) THEN
UPDATE flight
SET seats_available = seats_available + 1
WHERE flight_no = OLD.flight_no;
UPDATE flight
SET seats_available = seats_available - 1
WHERE flight_no = NEW.flight_no;
END IF;
-- Case 2
IF (OLD.is_seat_assigned = 1 AND NEW.is_seat_assigned = 0) THEN
UPDATE flight
SET seats_available = seats_available + 1
WHERE flight_no = OLD.flight_no;
END IF;

-- Case 3
IF (OLD.is_seat_assigned = 0 AND NEW.is_seat_assigned = 1) THEN
UPDATE flight
SET seats_available = seats_available - 1
WHERE flight_no = NEW.flight_no;
END IF;

-- Case 4 No updates needed.
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_seats_available_on_delete` BEFORE DELETE ON `reservation` FOR EACH ROW BEGIN
UPDATE flight
SET seats_available = seats_available + 1
WHERE flight_no = OLD.flight_no;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` varchar(10) NOT NULL,
  `first_name` char(20) NOT NULL,
  `last_name` char(20) NOT NULL,
  `job_description` varchar(20) DEFAULT NULL,
  `email_id` varchar(64) DEFAULT NULL,
  `phone_number` int DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `email_id` (`email_id`),
  UNIQUE KEY `phone_number` (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES ('S001','John','Smith','Pilot','jsmith@airline.com',5551234),('S002','Jane','Doe','Flight Attendant','jdoe@airline.com',5555678),('S003','Mike','Johnson','Mechanic','mjohnson@airline.com',5559876),('S004','Sarah','Lee','Ticket Agent','slee@airline.com',5554321),('S005','David','Brown','Baggage Handler','dbrown@airline.com',5558765),('S006','Adam','Zampa','Pilot','azampa@airline.com',5553214),('S007','Sophie','Buttler','Flight Attendant','sbuttler@airline.com',5555865),('S008','Johnson','Mike','Mechanic','jmike@airline.com',5559654),('S009','Ash','Lee','Ticket Agent','alee@airline.com',5557755),('S010','Susan','Brown','Baggage Handler','dsbrown@airline.com',5558220),('S011','Robert','Johnson','Pilot','rjohnson@airline.com',5550111),('S012','Linda','Davis','Flight Attendant','ldavis@airline.com',5550222),('S013','Mark','Wilson','Mechanic','mwilson@airline.com',5550333),('S014','Karen','Lee','Ticket Agent','klee@airline.com',5550444),('S015','Jason','Brown','Baggage Handler','jbrown@airline.com',5550555),('S016','Peter','Garcia','Pilot','pgarcia@airline.com',5550666),('S017','Emily','Clark','Flight Attendant','eclark@airline.com',5550777),('S018','Olivia','Anderson','Mechanic','oanderson@airline.com',5550888),('S019','Ethan','Hall','Ticket Agent','ehall@airline.com',5550999),('S020','Mia','Gonzalez','Baggage Handler','mgonzalez@airline.com',5550000);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_assigned_crew`
--

DROP TABLE IF EXISTS `staff_assigned_crew`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_assigned_crew` (
  `staff_id` varchar(10) NOT NULL,
  `crew_id` varchar(5) NOT NULL,
  PRIMARY KEY (`staff_id`,`crew_id`),
  KEY `crew_id` (`crew_id`),
  CONSTRAINT `staff_assigned_crew_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `staff_assigned_crew_ibfk_2` FOREIGN KEY (`crew_id`) REFERENCES `crew` (`crew_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_assigned_crew`
--

LOCK TABLES `staff_assigned_crew` WRITE;
/*!40000 ALTER TABLE `staff_assigned_crew` DISABLE KEYS */;
INSERT INTO `staff_assigned_crew` VALUES ('S001','CR001'),('S003','CR001'),('S006','CR001'),('S009','CR001'),('S002','CR002'),('S008','CR002'),('S004','CR003'),('S007','CR003'),('S005','CR004'),('S010','CR004');
/*!40000 ALTER TABLE `staff_assigned_crew` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'airline_dbms'
--

--
-- Dumping routines for database 'airline_dbms'
--
/*!50003 DROP FUNCTION IF EXISTS `get_cust_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_cust_id`(first_name CHAR(20), last_name CHAR(20), ccn INT) RETURNS int
    NO SQL
BEGIN
RETURN (SELECT customer_id FROM customer 
WHERE first_name = first_name AND last_name = last_name AND credit_card_number = ccn 
LIMIT 1);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_customer`(
    IN first_name CHAR(20),
    IN last_name CHAR(20),
    IN id_type CHAR(20), 
    IN credit_card_number INT	
)
BEGIN
-- Insert the customer record
IF (SELECT get_cust_id(first_name, last_name, credit_card_number)) IS NULL THEN
SET @customer_id = LAST_INSERT_ID();
INSERT INTO customer (first_name, last_name, id_type, credit_card_number) 
VALUES (first_name, last_name, id_type, credit_card_number);
ELSE 
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Customer with the given details already exists',
MYSQL_ERRNO = 1644;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_reservation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_reservation`(
IN f_name CHAR(20),
IN l_name CHAR(20),
IN f_no VARCHAR(10),
IN assign_seat BOOL,
IN id CHAR(20), 
IN ccn INT
)
BEGIN
CALL add_customer(f_name, l_name, id, ccn);
SET @cust_id = (SELECT get_cust_id(f_name, l_name, ccn));
INSERT INTO reservation (is_seat_assigned, flight_no, customer) 
VALUES (assign_seat, f_no, @cust_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_customer`(
IN cust_id INT
)
BEGIN
DELETE FROM customer WHERE customer_id = cust_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_reservation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_reservation`(
IN res_no INT
)
BEGIN
SET @cust_id = (SELECT customer FROM reservation WHERE reservation_no = res_no);
CALL delete_customer(@cust_id);
DELETE FROM reservation WHERE reservation_no = res_no;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_flights` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_flights`(
IN dep_air VARCHAR(10),
IN arr_air VARCHAR(10)
)
BEGIN
SELECT flight_no, dep_date, dep_time, seats_available, dep_airport, arr_airport
FROM flight WHERE dep_airport = dep_air AND arr_airport = arr_air;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_reservation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_reservation`(
IN res_no INT
)
BEGIN
SELECT reservation_no, customer, first_name, last_name, r.flight_no, 
dep_date, dep_time, gate_no, status, 
is_seat_assigned, dep_airport, 
arr_airport FROM reservation r 
LEFT OUTER JOIN flight f 
ON r.flight_no = f.flight_no
LEFT OUTER JOIN customer c ON c.customer_id = r.customer
WHERE reservation_no = res_no;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_reservation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_reservation`(
IN res_no INT,
IN new_fli_no VARCHAR(10), 
IN assign_seat BOOL
)
BEGIN
UPDATE reservation
SET flight_no = new_fli_no, is_seat_assigned = assign_seat
WHERE reservation_no = res_no;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-21 13:21:29
