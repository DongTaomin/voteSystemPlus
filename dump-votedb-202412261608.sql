-- MySQL dump 10.13  Distrib 8.0.35, for Win64 (x86_64)
--
-- Host: localhost    Database: votedb
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Table structure for table `issue`
--

DROP TABLE IF EXISTS `issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `description` text NOT NULL,
  `status` varchar(20) DEFAULT '待解决',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `issue_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue`
--

LOCK TABLES `issue` WRITE;
/*!40000 ALTER TABLE `issue` DISABLE KEYS */;
INSERT INTO `issue` VALUES (1,6,'111111111111111111111111111111111111111111','待解决','2024-11-29 14:00:25','2024-11-29 14:00:25'),(2,6,'ä½ å¥½ä½ å¥½','已解决','2024-11-29 14:03:14','2024-12-26 04:34:24'),(3,4,'277272772772727','待解决','2024-12-26 03:41:53','2024-12-26 03:41:53'),(4,4,'ceshi','已解决','2024-12-26 05:42:04','2024-12-26 06:17:08'),(5,4,'ceshi2','待解决','2024-12-26 05:42:15','2024-12-26 05:42:15'),(6,4,'1','待解决','2024-12-26 05:55:50','2024-12-26 05:55:50'),(7,4,'11111111111','待解决','2024-12-26 06:51:00','2024-12-26 06:51:00'),(8,4,'325543i2i54op32i54234','待解决','2024-12-26 06:54:21','2024-12-26 06:54:21'),(9,4,'ceshihihihi','待解决','2024-12-26 06:56:39','2024-12-26 06:56:39');
/*!40000 ALTER TABLE `issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `universities`
--

DROP TABLE IF EXISTS `universities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `universities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `vote_count` int DEFAULT '0',
  `description` text,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `universities`
--

LOCK TABLES `universities` WRITE;
/*!40000 ALTER TABLE `universities` DISABLE KEYS */;
INSERT INTO `universities` VALUES (1,'清华大学',1,'修改222636271637612763788889999999999999','https://lh3.googleusercontent.com/p/AF1QipPyrZgnuj4gjoFFV0bO0tKzKrLbhz1olqhWRlJt=s680-w680-h510'),(2,'北京大学',1,'北京大学（英语：Peking University，缩写：PKU）[注 1]，简称北大[注 2]，创建于1898年，初名京师大学堂，成立之初为中国最高学府，同时也是国家最高教育行政机关，行使教育部职能，统管全国教育。中华民国建立后，校名改为北京大学校，后又改名为国立北京大学。1916年—1927年，蔡元培任北京大学校长时期，“循思想自由原则、取兼容并包之义”，推行改革，把北大办成以文、理两科为重点的综合性大学，使北京大学成为新文化运动和五四运动的策源地。1937年中华民国政府在平津作战失守北平后，北大与清华、南开迁昆明组建新的国立西南联合大学，留守北京的学者于1939-1945年在北京成立沦陷区北京大学招收留守北京的贫寒学生，1946年北京大学由昆明回迁北平，接收了沦陷区北大学生。1952年院系调整后，北京大学聚集了原北大、清华、燕大三校的自然科学、人文学者，奠定了北大文理学科在中国高校中长期领先的地位。同时因为此次调整，北京大学也失去了其绝大部分工科的教授与资源。2000年，北京医科大学并入北京大学，成为北京大学医学部。','https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/West_Gate_of_Peking_University.jpg/1920px-West_Gate_of_Peking_University.jpg'),(3,'复旦大学',2,'复旦大学（英语：Fudan University），简称复旦，旧称复旦公学、国立复旦大学，始创于1905年，位于中国上海，是一所综合性研究型大学。复旦大学校名取自《尚书大传》之“日月光华，旦复旦兮”，表示取之不尽，用之不竭的自力更生和勤奋[4]，更含不忘“震旦”之旧和复兴中华的意义。1917年始设大学部，1952年院系调整，苏、浙、皖、沪等地大批文理学科的专家学者调入复旦，复旦大学自此成为人文社会和自然科学的全国重镇。2000年与上海医科大学合并组建新的复旦大学。','https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Fudan-building3.jpg/1280px-Fudan-building3.jpg'),(4,'上海交通大学',2,'上海交通大学（英语：Shanghai Jiao Tong University，缩写：SJTU），简称交大、上交、上交大或上海交大，是位于中国上海市的一所具有理工特色，涵盖理、工、医、经、管、文、法、农等9个学科门类的教育部直属综合性全国重点大学[3]，为华东五校之一。','https://cdn.pixabay.com/photo/2020/04/12/12/33/shanghai-jiao-tong-university-5034074_960_720.jpg'),(5,'浙江大学',1,'浙江大学，简称浙大，是一所直属中华人民共和国教育部的综合型研究型创新型大学[需要第三方来源]，本部位于浙江省杭州市，拥有紫金港、玉泉、西溪、华家池、之江、舟山、海宁等7个校区[7]。','https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Yuquan_campus_30.jpg/1280px-Yuquan_campus_30.jpg'),(6,'南京大学',1,'南京大学是中华人民共和国排名前列的高校之一，现时属于“泰晤士高等教育世界百强大学”及“美国新闻与世界报道世界百强大学”，是“双一流A类”和原“985工程”、原“211工程”重点建设大学，为基础学科拔尖学生培养试验计划、九校联盟、中国大学校长联谊会、环太平洋大学联盟、21世纪学术联盟、国际应用科技开发协作网、东亚研究型大学协会、新工科教育国际联盟、中国高校行星科学联盟、长三角研究型大学联盟成员。南大现有1个国家实验室（筹），7个国家重点实验室，15个部、省重点实验室，21个国家和部、省工程中心[12]，人文社会科学方面有27个各类重点研究基地[13]，此外全校还设有200多个研究机构[14][15]。医学院有附属鼓楼医院、金陵医院（南京总医院）、南京市口腔医院。除大学外，还有南大附属中学、丁家桥小学等[注 6]。另有科技产业园区和多个产学研结合机构。南京大学有超过二十位诺贝尔奖得者作为荣誉教授[16]，德国前总理默克尔也拥有南京大学的名誉博士学位[17]。 依据评估全球大学的自然科学研究成果的主要指标“自然指数排行榜”(Nature Index 2017 Tables)，南京大学的排名为全国第二（仅次于北京大学）、全亚太地区第三、全球第十二，超越加州理工学院、康奈尔大学、新加坡国立大学、南洋理工大学、帝国理工学院等校[18]。南京大学中文系的排名保持在全国前两名，与北京大学并列第一或仅次于北京大学[19][20]。除此，南京大学中文系为培养全国第一位中文博士莫砺锋教授的大学[21]。南京大学工程管理学院为培养控制科学专家周尚清教授的学院。在2018年QS世界大学排名中，南京大学位列世界第114位[22]。在中国校友会网中国大学排行榜2020年中国大学排名中位列第5位。2020年ARWU中国大学排名位列第5。在2024泰晤士高等教育世界大学排名中，南京大学位列第73位，再创历史新高[2','https://upload.wikimedia.org/wikipedia/commons/c/ca/Nju.auditoria.jpg'),(7,'中国科学技术大学',3,'中国科学技术大学（英语：University of Science and Technology of China，缩写：USTC），标准简称为中国科大，常用简称科大、中科大、中国科技大学或科技大[注 1]，是中国大陆的一所公立研究型大学，主体部分文革时期从北京迁出，现位于安徽省合肥市。','https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Gate_of_USTC.JPG/1280px-Gate_of_USTC.JPG'),(8,'哈佛大学',1,'哈佛大学（Harvard University）是一所位于美国马萨诸塞州剑桥市的私立大学，是世界上最著名的大学之一。','https://lh3.googleusercontent.com/p/AF1QipNxJFlijaazYq4Hgb7uBpvaI1JLNIRBnwienevp=s680-w680-h510'),(9,'斯坦福大学',0,'斯坦福大学（Stanford University）是一所位于美国加利福尼亚州帕洛阿尔托的私立大学，享有极高的声誉。','https://lh3.googleusercontent.com/p/AF1QipOQVYydEk4J8MRi_yGMl80-KcgnLQRFYYfD89iK=s680-w680-h510'),(10,'长安大学',0,'长安大学位于中国陕西省西安市，直属国家教育部，是教育部和交通运输部、国土资源部、住房和城乡建设部、陕西省人民政府共建的国家“211工程”重点建设公立大学[2]，拥有“公路建设和交通运送保障科学与技术”985工程优势学科创新平台[3]，同时也是“111计划”、“国家建设高水平大学公派研究生项目”和“卓越工程师教育培养计划”重点建设高校。2000年由西安公路交通大学（原西安公路学院）、西安工程学院（原西安地质学院）、西北建筑工程学院三所院校合并而成的综合性大学。','https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/ChdUniversityLibrary.jpg/1280px-ChdUniversityLibrary.jpg'),(11,'西北工业大学',0,'西北工业大学（英语：Northwestern Polytechnical University，缩写：NWPU），简称西工大，旧称国立西北工学院、西北工学院，是一所位于陕西省西安市的公立大学，是一所以发展航空、航天、航海（三航）等领域人才培养和科学研究为特色的多科性、研究型、开放式大学，现隶属于中华人民共和国工业和信息化部，为国防七子之一[1]。学校现有两个校区，其中长安校区位于西安市长安区，友谊校区位于碑林区，在江苏省太仓市设有太仓智汇港，在哈萨克斯坦设有分校。','https://lh3.googleusercontent.com/p/AF1QipO-aWwDWwqQihTIkodb3Eo9g6mEz29KhUF0tz7O=s680-w680-h510'),(12,'武汉大学',0,'武汉大学（英语：Wuhan University，缩写：WHU），简称武大，是一所位于中国大陆湖北省武汉市武昌区的副部级科研型综合大学。\r\n\r\n学缘可以追溯到清末，现官方以1893年创立的自强学堂为办学起点。1913年为六大国立高师之一的国立武昌高等师范学校，1923年更名为国立武昌师范大学，1924年更名为国立武昌大学，1926年合并组建国立武昌中山大学，于1928年正式定名国立武汉大学，是“民国四大名校”之一。1949年更名为武汉大学，2000年8月2日合并组建新的武汉大学。学校坐拥珞珈山东湖南岸风景区一线，占地面积5178亩，建筑面积258万平方米，中西合璧的宫殿式建筑群古朴典雅，樱花烂漫时，不负“中国最美丽的大学校园”之誉（其次为坐拥东南旖旎海岸的厦门大学）。','https://rmtzx.sciencenet.cn//kxwsprint/66a48f41e4b03b5da6d13a8c.png');
/*!40000 ALTER TABLE `universities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `has_voted` tinyint(1) DEFAULT '0',
  `role` varchar(20) NOT NULL DEFAULT 'user',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Alice','password123','女',0,'user'),(2,'Bob','password123','男',0,'user'),(3,'Charlie','password123','男',0,'user'),(4,'dtm','123456','男',1,'user'),(5,'zhangsan','111111','男',0,'user'),(6,'bing','111','男',1,'user'),(7,'giao','111','女',1,'user'),(8,'user','111','男',1,'user'),(9,'admin','123','女',0,'admin'),(12,'F12','123456','男',0,'user');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votes`
--

DROP TABLE IF EXISTS `votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `votes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `university_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `university_id` (`university_id`),
  CONSTRAINT `votes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `votes_ibfk_2` FOREIGN KEY (`university_id`) REFERENCES `universities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votes`
--

LOCK TABLES `votes` WRITE;
/*!40000 ALTER TABLE `votes` DISABLE KEYS */;
INSERT INTO `votes` VALUES (1,1,1),(2,2,2),(3,3,3),(4,1,3),(5,1,4),(6,1,3),(7,1,7),(8,1,7),(9,4,1),(10,4,4),(11,4,5),(12,4,2),(13,5,2),(14,4,2),(15,6,6),(16,7,7),(17,8,8);
/*!40000 ALTER TABLE `votes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'votedb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-26 16:08:11
