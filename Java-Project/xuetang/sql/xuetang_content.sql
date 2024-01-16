-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 192.168.101.65    Database: xc148_content
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `course_audit`
--

DROP TABLE IF EXISTS `course_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_audit` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `course_id` bigint NOT NULL COMMENT '课程id',
  `audit_mind` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审核意见',
  `audit_status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '审核状态',
  `audit_people` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审核人',
  `audit_date` datetime DEFAULT NULL COMMENT '审核时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_audit`
--

LOCK TABLES `course_audit` WRITE;
/*!40000 ALTER TABLE `course_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_base`
--

DROP TABLE IF EXISTS `course_base`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_base` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `company_id` bigint NOT NULL COMMENT '机构ID',
  `company_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '机构名称',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程名称',
  `users` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '适用人群',
  `tags` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '课程标签',
  `mt` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '大分类',
  `st` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '小分类',
  `grade` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程等级',
  `teachmode` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教育模式(common普通，record 录播，live直播等）',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '课程介绍',
  `pic` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '课程图片',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `change_date` datetime DEFAULT NULL COMMENT '修改时间',
  `create_people` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建人',
  `change_people` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新人',
  `audit_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '审核状态',
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '课程发布状态 未发布  已发布 下线',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='课程基本信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_base`
--

LOCK TABLES `course_base` WRITE;
/*!40000 ALTER TABLE `course_base` DISABLE KEYS */;
INSERT INTO `course_base` (`id`, `company_id`, `company_name`, `name`, `users`, `tags`, `mt`, `st`, `grade`, `teachmode`, `description`, `pic`, `create_date`, `change_date`, `create_people`, `change_people`, `audit_status`, `status`) VALUES (1,1232141425,'','JAVA8/9/10新特性讲解','java爱好者,有一定java基础','有个java 版本变化的新内容，帮助大家使用最新的思想和工具','1','1-3-2','204002','200002',NULL,'https://cdn.educba.com/academy/wp-content/uploads/2018/08/Spring-BOOT-Interview-questions.jpg','2019-09-03 17:48:19','2022-09-17 16:47:29','1',NULL,'202004','203001'),(2,1232141425,'Test1','测试课程01','IT爱好者IT爱好者IT爱好者IT爱好者IT爱好者IT爱好者IT爱好者IT爱好者','课程标签','1-1','1-1-1','204001','200002','测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程','/mediafiles/2022/09/18/a16da7a132559daf9e1193166b3e7f52.jpg','2019-09-04 08:49:26','2022-09-18 15:01:47',NULL,NULL,'202004','203002'),(7,1232141425,'Test3','wode24','高级程师',NULL,'1','1-3-2','204003','200002',NULL,'https://cdn.educba.com/academy/wp-content/uploads/2018/08/Spring-BOOT-Interview-questions.jpg','2019-09-04 09:56:19',NULL,NULL,NULL,'202004','203001'),(18,1232141425,NULL,'java零基础入门v2.0','java小白java小白java小白java小白','aa','1-3','1-3-2','200001','200002','java零基础入门v2.0java零基础入门v2.0java零基础入门v2.0java零基础入门v2.0','/mediafiles/2022/12/18/a61805e1360ab946def5471aaefc0a98.jpg','2019-09-04 09:56:19','2022-12-18 12:19:10',NULL,NULL,'202004','203002'),(22,1232141425,NULL,'大数据2','具有一定的java基础',NULL,'1-6','1-6-1','200001','200002','111111大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据大数据','https://cdn.educba.com/academy/wp-content/uploads/2018/08/Spring-BOOT-Interview-questions.jpg','2019-09-04 09:56:19','2022-09-16 07:59:57',NULL,NULL,'202001','203001'),(24,1232141425,NULL,'人工智能+python','小白',NULL,'1-6','1-6-5','200002','200002','人工智能+python非常不错！！！','https://cdn.educba.com/academy/wp-content/uploads/2018/08/Spring-BOOT-Interview-questions.jpg','2019-09-04 09:56:19',NULL,NULL,NULL,'202004','203001'),(25,1232141425,NULL,'Bootstrap开发框架','Bootstrap是由Twitter推出的一个前台页面开发框架，在行业之中使用较为广泛。此开发框架包含了大量的CSS、JS程序代码，可以帮助开发者（尤其是不擅长页面开发的程序人员）轻松的实现一个不受浏览器限制的精美界面效果。',NULL,'1-1','1-1-1','200002','200002','Bootstrap是由Twitter推出的一个前台页面开发框架，在行业之中使用较为广泛。此开发框架包含了大量的CSS、JS程序代码，可以帮助开发者（尤其是不擅长页面开发的程序人员）轻松的实现一个不受浏览器限制的精美界面效果。','/mediafiles/2022/12/18/c051fe97e672dd399902a90f4ac67962.jpg','2019-09-04 09:56:19','2022-12-18 12:14:49',NULL,NULL,'202002','203001'),(26,1232141425,NULL,'spring cloud实战','所有人',NULL,'1-3','1-3-2','200003','200002','本课程主要从四个章节进行讲解： 1.微服务架构入门 2.spring cloud 基础入门 3.实战Spring Boot 4.注册中心eureka。','https://cdn.educba.com/academy/wp-content/uploads/2018/08/Spring-BOOT-Interview-questions.jpg','2019-09-04 09:56:19','2021-12-26 22:10:38',NULL,NULL,'202002','203001'),(27,1232141425,NULL,'Javascript之VueJS','所有人',NULL,'1-1','1-1-9','200002','200002','Vue系列课程：从Vue1.0讲到Vue2.0，从理论讲到实战，理论与案例巧妙结合，让课程更容易理解！','https://cdn.educba.com/academy/wp-content/uploads/2018/08/Spring-BOOT-Interview-questions.jpg','2019-09-04 09:56:19',NULL,NULL,NULL,'202004','203001'),(28,1232141425,NULL,'Redis从入门到项目实战','',NULL,'1-3','1-3-2','200002','200002','redis在当前的大型网站和500强企业中，已被广泛应用。 redis是基于内存的key-value数据库，比传统的关系型数据库在性能方面有非常大的优势。 肖老师这套视频，精选了redis在实际项目中的十几个应用场景。通过本课程的学习，可以让学员快速掌握redis在实际项目中如何应用。 作为架构师，redis是必须要掌握的技能！','https://cdn.educba.com/academy/wp-content/uploads/2018/08/Spring-BOOT-Interview-questions.jpg','2019-09-04 09:56:19',NULL,NULL,NULL,'202004','203001'),(39,1,NULL,'SpringBoot核心11111','Spring Boot初学者','Spring项目的快速构建','1-3','1-3-2','200003','200002','课程系统性地深度探讨 Spring Boot 核心特性，引导小伙伴对 Java 规范的重视，启发对技术原理性的思考，掌握排查问题的技能，以及学习阅读源码的方法和技巧，全面提升研发能力，进军架构师队伍。','https://cdn.educba.com/academy/wp-content/uploads/2018/08/Spring-BOOT-Interview-questions.jpg','2019-09-10 16:03:51','2019-09-11 14:53:17',NULL,NULL,'202004','203001'),(40,1232141425,NULL,'SpringBoot核心','Spring Boot初学者','Spring项目的快速构建','1-3','1-3-2','200003','200002','课程系统性地深度探讨 Spring Boot 核心特性，引导小伙伴对 Java 规范的重视，启发对技术原理性的思考，掌握排查问题的技能，以及学习阅读源码的方法和技巧，全面提升研发能力，进军架构师队伍。','https://cdn.educba.com/academy/wp-content/uploads/2018/08/Spring-BOOT-Interview-questions.jpg','2019-09-10 16:05:39','2022-09-16 08:07:41',NULL,NULL,'202004','203001'),(71,1232141425,'','java入门','初学者','java','1-3','1-3-2','204001','200002','java入门','http://r3zc5rung.hd-bkt.clouddn.com/d8ff4b26-3611-486b-b101-dd14646e1316CpWXDoUKfAkzdYlM','2021-12-17 22:28:35','2021-12-21 00:27:10','','','202004','203001'),(72,1232141425,NULL,'卢中耀讲java','group01','','1-1','1-1-1','204001','200002','卢中耀牛逼','http://r3zc5rung.hd-bkt.clouddn.com/53659164-6287-4e8e-b516-4e01b451abd1crlkQdKe3v13QIS0','2021-12-25 16:17:50','2021-12-25 17:45:04',NULL,NULL,'202003','203001'),(73,1232141425,NULL,'111','111','111','1-1','1-1-1','204001','200002','111','http://r3zc5rung.hd-bkt.clouddn.com/c6e8f95e-435f-4d26-8d8d-0e3291443bb2v3Epoz06pYcxUJa8','2021-12-25 17:50:28','2021-12-25 18:19:11',NULL,NULL,'202003','203001'),(74,1232141425,NULL,'思想政治','中小学生中小学生中小学生中小学生','','1-1','1-1-1','204001','200002','思想政治思想政治思想政治','/bucket-pic/2022/08/25/44fd0d55-b4d6-4d13-9127-abdf48030218.png','2021-12-25 17:53:07','2022-09-16 15:54:56',NULL,NULL,'202004','203002'),(75,1232141425,NULL,'测试课程001','初学者初学者初学者初学者','aa','1-3','1-3-3','204001','200002','测试课程001','','2021-12-26 18:21:44','2022-09-08 22:05:45',NULL,NULL,'202002','203001'),(76,1232141425,NULL,'3w点','小学生','22','1-1','1-1-1','204003','200002','无','','2021-12-26 19:59:38','2021-12-27 16:08:51',NULL,NULL,'202002','203001'),(77,1232141425,NULL,'测试10','1','无','1-1','1-1-1','204003','200002','1','','2021-12-26 20:01:59','2022-08-22 18:25:48',NULL,NULL,'202002','203001'),(78,1232141425,NULL,'测试','1','123','1-1','1-1-1','204001','200002','1','','2021-12-26 20:54:22','2021-12-27 11:14:29',NULL,NULL,'202002','203001'),(79,1232141425,NULL,'Spring','Spring','Spring','1-3','1-3-3','204001','200002','Spring','http://r3zc5rung.hd-bkt.clouddn.com/d96b3f2a-7c72-42e1-89bb-200558027f05flX5NNF7EklC9sqe','2021-12-27 10:34:34','2021-12-27 10:50:01',NULL,NULL,'202003','203001'),(80,1232141425,NULL,'Java Web','Java Web','Java Web','1-3','1-3-3','204001','200002','Java Web','http://r3zc5rung.hd-bkt.clouddn.com/a3ad6341-b9dc-4e82-a571-88786945001aKrbAuMnLP0jHK8hB','2021-12-27 11:08:29','2021-12-27 11:11:44',NULL,NULL,'202003','203001'),(81,1232141425,NULL,'Spring Boot','Spring Boot','Spring Boot','1-5','1-5-5','204002','200002','Spring Boot','','2021-12-27 11:27:59','2021-12-27 11:38:20',NULL,NULL,'202002','203001'),(82,1232141425,NULL,'Spring Boot入门','Spring 初级程序员。','Spring Boot','1-3','1-3-2','204002','200002','springboot可以帮你简化spring的搭建，并且快速创建一个spring的应用程序。该框架使用了特定的方式来进行配置，从而使开发人员不再需要定义样板化的配置。','/mediafiles/2022/09/18/d4af959873182feb0fdb91dc6c1958b5.png','2021-12-27 11:28:00','2022-09-19 09:35:31',NULL,NULL,'202003','203001'),(83,1232141425,NULL,'123','123','123','1-5','1-5-5','204002','200002','123','http://r3zc5rung.hd-bkt.clouddn.com/7bcf3dae-3ee6-43ed-8a4e-c5deb75bf54468C4F11uCgf5KPki','2021-12-27 12:22:01',NULL,NULL,NULL,'202002','203001'),(84,1232141425,NULL,'Spring Cloud','Spring Cloud','Spring Cloud','1-1','1-1-1','204001','200002','Spring Cloud','/mediafiles/2022/09/18/e00ce88f53cc391d9ffd51a81834d2af.jpg','2021-12-27 13:42:01','2022-09-18 21:48:53',NULL,NULL,'202002','203001'),(85,1232141425,NULL,'最终测试','小母牛','好','1-5','1-5-1','204003','200002','nb','http://r3zc5rung.hd-bkt.clouddn.com/cc807e18-f3d2-4e0a-9326-e8c42a3ba6cdbvjU3MrtGeV0yxUR','2021-12-27 15:54:59','2021-12-27 18:08:08',NULL,NULL,'202003','203001'),(86,1232141425,NULL,'最终测试2','好','加油','1-1','1-1-1','204001','200002','好','http://r3zc5rung.hd-bkt.clouddn.com/eea77eb2-04d0-45c0-80f5-baeb37897592FfVk8l6h1K84gaht','2021-12-27 20:01:06','2021-12-27 20:12:46',NULL,NULL,'202003','203001'),(87,1232141425,NULL,'1','1','1','1-1','1-1-1','204001','200002','1','http://r3zc5rung.hd-bkt.clouddn.com/cb1b6038-ef68-4362-8c29-a966886d1dc5sakUiFHLb5sRFdIK','2021-12-27 20:14:13',NULL,NULL,NULL,'202002','203001'),(88,1232141425,NULL,'1','1','1','1-1','1-1-1','204001','200002','1','http://r3zc5rung.hd-bkt.clouddn.com/cb1b6038-ef68-4362-8c29-a966886d1dc5sakUiFHLb5sRFdIK','2021-12-27 20:14:53','2021-12-27 20:28:58',NULL,NULL,'202002','203001'),(89,1232141425,NULL,'qaq','qaq','qaq','1-1','1-1-1','204001','200002','qaq','http://r3zc5rung.hd-bkt.clouddn.com/11935d1c-f84e-41ee-b24c-44f7cceae887YA0wRBRNilq25y55','2021-12-27 20:21:46','2021-12-27 20:23:12',NULL,NULL,'202003','203001'),(90,1232141425,NULL,'111111','1','111','1-1','1-1-1','204001','200002','1','http://r3zc5rung.hd-bkt.clouddn.com/09275e98-3792-449f-82be-94139f425c0aXq5Or9VUJ9SxuKiM','2021-12-27 20:26:57','2021-12-27 20:30:49',NULL,NULL,'202003','203001'),(91,1232141425,NULL,'测试测试','1','测试','1-5','1-5-5','204003','200002','1','http://r3zc5rung.hd-bkt.clouddn.com/c1efba7e-165c-4373-855f-e3cfd6eb771978y2fvUzmxhEFMPt','2021-12-27 20:35:07','2021-12-27 20:36:35',NULL,NULL,'202003','203001'),(92,1232141425,NULL,'最终测试2','问问','新','1-3','1-3-1','204003','200002','我','http://r3zc5rung.hd-bkt.clouddn.com/028688b0-6107-4ded-916d-eabb5fdb9cd2vomf7CoLMD27hqU0','2021-12-27 20:53:32','2021-12-27 20:54:58',NULL,NULL,'202003','203001'),(93,1232141425,NULL,'最最最终测试','踩踩踩踩踩踩从','测试','1-1','1-1-1','204002','200002','草草草草','http://r3zc5rung.hd-bkt.clouddn.com/d4e83002-e92c-4d23-9281-b218187e1632XzB1WC2Ckw4gcTMj','2021-12-27 23:23:17','2021-12-27 23:24:59',NULL,NULL,'202003','203001'),(94,1232141425,NULL,'最最最最最最最最最最终测试','最最最最最最最最最最终测试','最最最最最最最最最最终测试','1-2','1-2-1','204003','200002','最最最最最最最最最最终测试','http://r3zc5rung.hd-bkt.clouddn.com/4a603cf0-a6ee-460d-bd02-4a730c1f5fdc7zfCzVvxi6tFY5nP','2021-12-27 23:48:14','2021-12-27 23:49:20',NULL,NULL,'202003','203001'),(95,1232141425,NULL,'真最终测试','v','真最终测试','1-1','1-1-1','204001','200002','真最终测试','','2021-12-28 02:08:08','2021-12-28 02:09:24',NULL,NULL,'202003','203001'),(96,1232141425,NULL,'究极测试','究极测试','究极测试','1-1','1-1-1','204001','200002','究极测试','http://r3zc5rung.hd-bkt.clouddn.com/1370eeb2-47a1-4e68-9e04-d0f56ebb10217aovGzS2Ipyp7dqD','2021-12-28 03:10:25','2021-12-28 03:12:22',NULL,NULL,'202003','203001'),(97,1232141425,NULL,'项目展示','项目展示','项目展示','1-1','1-1-1','204002','200002','项目展示','','2021-12-28 03:36:52','2021-12-28 03:41:18',NULL,NULL,'202003','203001'),(98,1232141425,NULL,'测试课01','初学者','','1-1','1-1-1','204001','200002','','','2022-08-22 10:07:09',NULL,NULL,NULL,'202002','203001'),(99,1232141425,NULL,'测试课程02','初级人员','','1-1','1-1-1','204001','200002','','','2022-08-22 12:23:01',NULL,NULL,NULL,'202002','203001'),(100,1232141425,NULL,'测试课程02','初级人员','','1-1','1-1-1','204001','200002','','','2022-08-22 12:55:29',NULL,NULL,NULL,'202002','203001'),(101,1,NULL,'测试课程03','初级人员','','1-1','1-1-1','204001','200002','','',NULL,NULL,NULL,NULL,'202002','203001'),(102,1,NULL,'测试课程102','初级人员','','1-1','1-1-1','204001','200002','','','2022-09-07 19:13:16',NULL,NULL,NULL,'202002','203001'),(103,1,NULL,'测试课程103','初级人员','','1-1','1-1-1','204001','200002','','','2022-09-07 19:17:25',NULL,NULL,NULL,'202002','203001'),(104,1,NULL,'测试课程104','测试课程104','测试课程104','1-1','1-1-1','204001','200003','测试课程104','','2022-09-07 19:19:47',NULL,NULL,NULL,'202002','203001'),(105,1,NULL,'测试课程104','测试课程104','测试课程104','1-1','1-1-1','204001','200003','测试课程104','','2022-09-07 19:24:38',NULL,NULL,NULL,'202002','203001'),(106,1,NULL,'测试课程106','测试课程106','','1-1','1-1-1','204001','200003',NULL,'','2022-09-07 21:46:52',NULL,NULL,NULL,'202002','203001'),(107,1,NULL,'测试课程106','测试课程106','','1-1','1-1-1','204001','200003',NULL,'','2022-09-07 21:49:22',NULL,NULL,NULL,'202002','203001'),(108,1,NULL,'测试课程106','测试课程106','','1-1','1-1-1','204001','200003',NULL,'','2022-09-07 21:56:22',NULL,NULL,NULL,'202002','203001'),(109,1,NULL,'测试课程103','初级人员','','1-1','1-1-1','204001','200002','','','2022-09-08 07:35:16',NULL,NULL,NULL,'202002','203001'),(111,1,NULL,'测试课程01','初学者','','1-3','1-3-3','204001','200002','测试课程01','','2022-09-08 21:34:33',NULL,NULL,NULL,'202002','203001'),(112,1,NULL,'测试课程01','测试课程01','','1-3','1-3-3','204001','200002','测试课程01','','2022-09-08 21:40:05',NULL,NULL,NULL,'202002','203001'),(113,1,NULL,'测试课程01','w','ww','1-3','1-3-3','204001','200002','w','','2022-09-08 21:40:51',NULL,NULL,NULL,'202002','203001'),(114,1,NULL,'测试课程01','w','ww','1-3','1-3-3','204001','200002','w','','2022-09-08 21:41:33',NULL,NULL,NULL,'202002','203001'),(115,1,NULL,'测试课程01','w','ww','1-3','1-3-3','204001','200002','w','','2022-09-08 21:42:05',NULL,NULL,NULL,'202002','203001'),(116,1,NULL,'人性的弱点','人性的弱点人性的弱点人性的弱点','','1-1','1-1-1','204001','200002','人性的弱点人性的弱点','','2022-09-09 11:31:50',NULL,NULL,NULL,'202002','203001'),(117,1232141425,NULL,'Nacos微服务开发实战','中高级Java开发工程师','','1-3','1-3-2','204002','200002','Nacos 是阿里巴巴推出来的一个新开源项目，这是一个更易于构建云原生应用的动态服务发现、配置管理和服务管理平台。\n\nNacos 致力于帮助您发现、配置和管理微服务。Nacos 提供了一组简单易用的特性集，帮助您快速实现动态服务发现、服务配置、服务元数据及流量管理。\n\nNacos 帮助您更敏捷和容易地构建、交付和管理微服务平台。 Nacos 是构建以“服务”为中心的现代应用架构 (例如微服务范式、云原生范式) 的服务基础设施\n\nNacos 支持如下核心特性：\n\n1）服务发现： 支持 DNS 与 RPC 服务发现，也提供原生 SDK 、OpenAPI 等多种服务注册方式和 DNS、HTTP 与 API 等多种服务发现方式。\n2）服务健康监测： Nacos 提供对服务的实时的健康检查，阻止向不健康的主机或服务实例发送请求。\n3）动态配置服务： Nacos 提供配置统一管理功能，能够帮助我们将配置以中心化、外部化和动态化的方式管理所有环境的应用配置和服务配置。\n4）动态 DNS 服务： Nacos 支持动态 DNS 服务权重路由，能够让我们很容易地实现中间层负载均衡、更灵活的路由策略、流量控制以及数据中心内网的简单 DNS 解析服务。\n5）服务及其元数据管理： Nacos 支持从微服务平台建设的视角管理数据中心的所有服务及元数据，包括管理服务的描述、生命周期、服务的静态依赖分析、服务的健康状态、服务的流量管理、路由及安全策略、服务的 SLA 以及最首要的 metrics 统计数据。','/mediafiles/2022/10/04/8026f17cf7b8697eccec2c8406d0c96c.png','2022-10-04 18:58:11','2022-10-04 19:04:33',NULL,NULL,'202004','203002'),(118,22,NULL,'测试课程111','初级人员','标签','1-1','1-1-1','204001','200002','课程介绍','','2022-12-10 17:41:25',NULL,NULL,NULL,'202002','203001'),(120,22,NULL,'测试课程112','适用人群适用人群适用人群适用人群','课程标签','1-1','1-1-1','204001','200002','测试课程112测试课程112测试课程112测试课程112','','2022-12-10 17:46:34',NULL,NULL,NULL,'202002','203001'),(121,1232141425,NULL,'Spring Cloud 开发实战','具有web开发基础','','1-3','1-3-2','204002','200002','Spring Cloud是一系列框架的有序集合。它利用Spring Boot的开发便利性巧妙地简化了分布式系统基础设施的开发，如服务发现注册、配置中心、消息总线、负载均衡、断路器、数据监控等，都可以用Spring Boot的开发风格做到一键启动和部署。Spring Cloud并没有重复制造轮子，它只是将各家公司开发的比较成熟、经得起实际考验的服务框架组合起来，通过Spring Boot风格进行再封装屏蔽掉了复杂的配置和实现原理，最终给开发者留出了一套简单易懂、易部署和易维护的分布式系统开发工具包。','/mediafiles/2023/02/09/ef29eb93515e32f2d897956d5d914db7.png','2023-02-09 11:10:42','2023-02-09 11:50:43',NULL,NULL,'202004','203002');
/*!40000 ALTER TABLE `course_base` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_category`
--

DROP TABLE IF EXISTS `course_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_category` (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `label` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类标签默认和名称一样',
  `parentid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '父结点id（第一级的父节点是0，自关联字段id）',
  `is_show` tinyint DEFAULT NULL COMMENT '是否显示',
  `orderby` int DEFAULT NULL COMMENT '排序字段',
  `is_leaf` tinyint DEFAULT NULL COMMENT '是否叶子',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='课程分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_category`
--

LOCK TABLES `course_category` WRITE;
/*!40000 ALTER TABLE `course_category` DISABLE KEYS */;
INSERT INTO `course_category` (`id`, `name`, `label`, `parentid`, `is_show`, `orderby`, `is_leaf`) VALUES ('1','根结点','根结点','0',1,1,0),('1-1','前端开发','前端开发','1',1,1,0),('1-1-1','HTML/CSS','HTML/CSS','1-1',1,1,1),('1-1-10','其它','其它','1-1',1,10,1),('1-1-2','JavaScript','JavaScript','1-1',1,2,1),('1-1-3','jQuery','jQuery','1-1',1,3,1),('1-1-4','ExtJS','ExtJS','1-1',1,4,1),('1-1-5','AngularJS','AngularJS','1-1',1,5,1),('1-1-6','ReactJS','ReactJS','1-1',1,6,1),('1-1-7','Bootstrap','Bootstrap','1-1',1,7,1),('1-1-8','Node.js','Node.js','1-1',1,8,1),('1-1-9','Vue','Vue','1-1',1,9,1),('1-10','研发管理','研发管理','1',1,10,0),('1-10-1','敏捷开发','敏捷开发','1-10',1,1,1),('1-10-2','软件设计','软件设计','1-10',1,2,1),('1-10-3','软件测试','软件测试','1-10',1,3,1),('1-10-4','研发管理','研发管理','1-10',1,4,1),('1-10-5','其它','其它','1-10',1,5,1),('1-11','系统运维','系统运维','1',1,11,0),('1-11-1','Linux','Linux','1-11',1,1,1),('1-11-10','其它','其它','1-11',1,10,1),('1-11-2','Windows','Windows','1-11',1,2,1),('1-11-3','UNIX','UNIX','1-11',1,3,1),('1-11-4','Mac OS','Mac OS','1-11',1,4,1),('1-11-5','网络技术','网络技术','1-11',1,5,1),('1-11-6','路由协议','路由协议','1-11',1,6,1),('1-11-7','无线网络','无线网络','1-11',1,7,1),('1-11-8','Ngnix','Ngnix','1-11',1,8,1),('1-11-9','邮件服务器','邮件服务器','1-11',1,9,1),('1-12','产品经理','产品经理','1',1,12,0),('1-12-1','交互设计','交互设计','1-12',1,1,1),('1-12-2','产品设计','产品设计','1-12',1,2,1),('1-12-3','原型设计','原型设计','1-12',1,3,1),('1-12-4','用户体验','用户体验','1-12',1,4,1),('1-12-5','需求分析','需求分析','1-12',1,5,1),('1-12-6','其它','其它','1-12',1,6,1),('1-13','企业/办公/职场','企业/办公/职场','1',1,13,0),('1-13-1','运营管理','运营管理','1-13',1,1,1),('1-13-2','企业信息化','企业信息化','1-13',1,2,1),('1-13-3','网络营销','网络营销','1-13',1,3,1),('1-13-4','Office/WPS','Office/WPS','1-13',1,4,1),('1-13-5','招聘/面试','招聘/面试','1-13',1,5,1),('1-13-6','电子商务','电子商务','1-13',1,6,1),('1-13-7','CRM','CRM','1-13',1,7,1),('1-13-8','ERP','ERP','1-13',1,8,1),('1-13-9','其它','其它','1-13',1,9,1),('1-14','信息安全','信息安全','1',1,14,0),('1-14-1','密码学/加密/破解','密码学/加密/破解','1-14',1,1,1),('1-14-10','其它','其它','1-14',1,10,1),('1-14-2','渗透测试','渗透测试','1-14',1,2,1),('1-14-3','社会工程','社会工程','1-14',1,3,1),('1-14-4','漏洞挖掘与利用','漏洞挖掘与利用','1-14',1,4,1),('1-14-5','云安全','云安全','1-14',1,5,1),('1-14-6','防护加固','防护加固','1-14',1,6,1),('1-14-7','代码审计','代码审计','1-14',1,7,1),('1-14-8','移动安全','移动安全','1-14',1,8,1),('1-14-9','病毒木马','病毒木马','1-14',1,9,1),('1-15','测试目录','测试目录','1',1,15,0),('1-15-1','测试目录01','测试目录01','1-15',1,1,1),('1-2','移动开发','移动开发','1',1,2,0),('1-2-1','微信开发','微信开发','1-2',1,1,1),('1-2-2','iOS','iOS','1-2',1,2,1),('1-2-3','手游开发','手游开发','1-2',1,3,1),('1-2-4','Swift','Swift','1-2',1,4,1),('1-2-5','Android','Android','1-2',1,5,1),('1-2-6','ReactNative','ReactNative','1-2',1,6,1),('1-2-7','Cordova','Cordova','1-2',1,7,1),('1-2-8','其它','其它','1-2',1,8,1),('1-3','编程开发','编程开发','1',1,3,0),('1-3-1','C/C++','C/C++','1-3',1,1,1),('1-3-2','Java','Java','1-3',1,2,1),('1-3-3','.NET','.NET','1-3',1,3,1),('1-3-4','Objective-C','Objective-C','1-3',1,4,1),('1-3-5','Go语言','Go语言','1-3',1,5,1),('1-3-6','Python','Python','1-3',1,6,1),('1-3-7','Ruby/Rails','Ruby/Rails','1-3',1,7,1),('1-3-8','其它','其它','1-3',1,8,1),('1-4','数据库','数据库','1',1,4,0),('1-4-1','Oracle','Oracle','1-4',1,1,1),('1-4-2','MySQL','MySQL','1-4',1,2,1),('1-4-3','SQL Server','SQL Server','1-4',1,3,1),('1-4-4','DB2','DB2','1-4',1,4,1),('1-4-5','NoSQL','NoSQL','1-4',1,5,1),('1-4-6','Mongo DB','Mongo DB','1-4',1,6,1),('1-4-7','Hbase','Hbase','1-4',1,7,1),('1-4-8','数据仓库','数据仓库','1-4',1,8,1),('1-4-9','其它','其它','1-4',1,9,1),('1-5','人工智能','人工智能','1',1,5,0),('1-5-1','机器学习','机器学习','1-5',1,1,1),('1-5-2','深度学习','深度学习','1-5',1,2,1),('1-5-3','语音识别','语音识别','1-5',1,3,1),('1-5-4','计算机视觉','计算机视觉','1-5',1,4,1),('1-5-5','NLP','NLP','1-5',1,5,1),('1-5-6','强化学习','强化学习','1-5',1,6,1),('1-5-7','其它','其它','1-5',1,7,1),('1-6','云计算/大数据','云计算/大数据','1',1,6,0),('1-6-1','Spark','Spark','1-6',1,1,1),('1-6-2','Hadoop','Hadoop','1-6',1,2,1),('1-6-3','OpenStack','OpenStack','1-6',1,3,1),('1-6-4','Docker/K8S','Docker/K8S','1-6',1,4,1),('1-6-5','云计算基础架构','云计算基础架构','1-6',1,5,1),('1-6-6','虚拟化技术','虚拟化技术','1-6',1,6,1),('1-6-7','云平台','云平台','1-6',1,7,1),('1-6-8','ELK','ELK','1-6',1,8,1),('1-6-9','其它','其它','1-6',1,9,1),('1-7','UI设计','UI设计','1',1,7,0),('1-7-1','Photoshop','Photoshop','1-7',1,1,1),('1-7-10','InDesign','InDesign','1-7',1,10,1),('1-7-11','Pro/Engineer','Pro/Engineer','1-7',1,11,1),('1-7-12','Cinema 4D','Cinema 4D','1-7',1,12,1),('1-7-13','3D Studio','3D Studio','1-7',1,13,1),('1-7-14','After Effects（AE）','After Effects（AE）','1-7',1,14,1),('1-7-15','原画设计','原画设计','1-7',1,15,1),('1-7-16','动画制作','动画制作','1-7',1,16,1),('1-7-17','Dreamweaver','Dreamweaver','1-7',1,17,1),('1-7-18','Axure','Axure','1-7',1,18,1),('1-7-19','其它','其它','1-7',1,19,1),('1-7-2','3Dmax','3Dmax','1-7',1,2,1),('1-7-3','Illustrator','Illustrator','1-7',1,3,1),('1-7-4','Flash','Flash','1-7',1,4,1),('1-7-5','Maya','Maya','1-7',1,5,1),('1-7-6','AUTOCAD','AUTOCAD','1-7',1,6,1),('1-7-7','UG','UG','1-7',1,7,1),('1-7-8','SolidWorks','SolidWorks','1-7',1,8,1),('1-7-9','CorelDraw','CorelDraw','1-7',1,9,1),('1-8','游戏开发','游戏开发','1',1,8,0),('1-8-1','Cocos','Cocos','1-8',1,1,1),('1-8-2','Unity3D','Unity3D','1-8',1,2,1),('1-8-3','Flash','Flash','1-8',1,3,1),('1-8-4','SpriteKit 2D','SpriteKit 2D','1-8',1,4,1),('1-8-5','Unreal','Unreal','1-8',1,5,1),('1-8-6','其它','其它','1-8',1,6,1),('1-9','智能硬件/物联网','智能硬件/物联网','1',1,9,0),('1-9-1','无线通信','无线通信','1-9',1,1,1),('1-9-10','物联网技术','物联网技术','1-9',1,10,1),('1-9-11','其它','其它','1-9',1,11,1),('1-9-2','电子工程','电子工程','1-9',1,2,1),('1-9-3','Arduino','Arduino','1-9',1,3,1),('1-9-4','体感技术','体感技术','1-9',1,4,1),('1-9-5','智能硬件','智能硬件','1-9',1,5,1),('1-9-6','驱动/内核开发','驱动/内核开发','1-9',1,6,1),('1-9-7','单片机/工控','单片机/工控','1-9',1,7,1),('1-9-8','WinCE','WinCE','1-9',1,8,1),('1-9-9','嵌入式','嵌入式','1-9',1,9,1);
/*!40000 ALTER TABLE `course_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_market`
--

DROP TABLE IF EXISTS `course_market`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_market` (
  `id` bigint NOT NULL COMMENT '主键，课程id',
  `charge` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收费规则，对应数据字典',
  `price` float(10,2) DEFAULT NULL COMMENT '现价',
  `original_price` float(10,2) DEFAULT NULL COMMENT '原价',
  `qq` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '咨询qq',
  `wechat` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '微信',
  `phone` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话',
  `valid_days` int DEFAULT NULL COMMENT '有效期天数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='课程营销信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_market`
--

LOCK TABLES `course_market` WRITE;
/*!40000 ALTER TABLE `course_market` DISABLE KEYS */;
INSERT INTO `course_market` (`id`, `charge`, `price`, `original_price`, `qq`, `wechat`, `phone`, `valid_days`) VALUES (1,'201001',2.00,11.00,'1','1','1',1),(2,'201001',1.00,11111.00,'2222','3333','4444',555),(18,'201001',11.00,111.00,'123456','654321','13333333',365),(22,'201001',11.00,1111.00,'334455','223321','1333333',33),(25,'201001',222.00,2222.00,'323232','323232','323232',365),(40,'201001',11.00,1111.00,NULL,NULL,NULL,NULL),(74,'201001',1.00,100.00,'123456','654321','1333333',365),(82,'201001',22.00,222.00,'22','33','33',33),(84,'201001',11.00,11111.00,'11','11','22',22),(117,'201001',1.00,198.00,'24965575','24965575','24965575',365),(118,'201001',10.00,100.00,'43232','4324322','432432',365),(120,'201001',111.00,11.00,'432432','432432','43242',365),(121,'201001',1.00,100.00,'2323232','3232432','432432',365);
/*!40000 ALTER TABLE `course_market` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_publish`
--

DROP TABLE IF EXISTS `course_publish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_publish` (
  `id` bigint NOT NULL COMMENT '主键',
  `company_id` bigint NOT NULL COMMENT '机构ID',
  `company_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '公司名称',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程名称',
  `users` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '适用人群',
  `tags` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标签',
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建人',
  `mt` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '大分类',
  `mt_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '大分类名称',
  `st` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '小分类',
  `st_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '小分类名称',
  `grade` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程等级',
  `teachmode` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教育模式',
  `pic` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程图片',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '课程介绍',
  `market` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '课程营销信息，json格式',
  `teachplan` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '所有课程计划，json格式',
  `teachers` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '教师信息，json格式',
  `create_date` datetime DEFAULT NULL COMMENT '发布时间',
  `online_date` datetime DEFAULT NULL COMMENT '上架时间',
  `offline_date` datetime DEFAULT NULL COMMENT '下架时间',
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '1' COMMENT '发布状态',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `charge` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收费规则，对应数据字典--203',
  `price` float(10,2) DEFAULT NULL COMMENT '现价',
  `original_price` float(10,2) DEFAULT NULL COMMENT '原价',
  `valid_days` int DEFAULT NULL COMMENT '课程有效期天数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='课程发布';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_publish`
--

LOCK TABLES `course_publish` WRITE;
/*!40000 ALTER TABLE `course_publish` DISABLE KEYS */;
INSERT INTO `course_publish` (`id`, `company_id`, `company_name`, `name`, `users`, `tags`, `username`, `mt`, `mt_name`, `st`, `st_name`, `grade`, `teachmode`, `pic`, `description`, `market`, `teachplan`, `teachers`, `create_date`, `online_date`, `offline_date`, `status`, `remark`, `charge`, `price`, `original_price`, `valid_days`) VALUES (2,1232141425,'Test1','测试课程01','IT爱好者IT爱好者IT爱好者IT爱好者IT爱好者IT爱好者IT爱好者IT爱好者','课程标签',NULL,'1-1','前端开发','1-1-1','HTML/CSS','204001','200002','/mediafiles/2022/09/18/a16da7a132559daf9e1193166b3e7f52.jpg','测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程测试课程','{\"charge\":\"201001\",\"id\":2,\"originalPrice\":11111.0,\"phone\":\"4444\",\"price\":1.0,\"qq\":\"2222\",\"validDays\":555,\"wechat\":\"3333\"}','[{\"courseId\":2,\"grade\":1,\"id\":266,\"isPreview\":\"0\",\"orderby\":1,\"parentid\":0,\"pname\":\"第1章\",\"teachPlanTreeNodes\":[{\"courseId\":2,\"grade\":2,\"id\":267,\"isPreview\":\"0\",\"orderby\":1,\"parentid\":266,\"pname\":\"第1节\",\"teachplanMedia\":{\"courseId\":2,\"teachplanId\":267}}]}]',NULL,'2022-09-25 22:35:19',NULL,NULL,'203002',NULL,'201001',1.00,11111.00,555),(18,1232141425,NULL,'java零基础入门v2.0','java小白java小白java小白java小白','aa',NULL,'1-3','编程开发','1-3-2','Java','200001','200002','/mediafiles/2022/12/18/a61805e1360ab946def5471aaefc0a98.jpg','java零基础入门v2.0java零基础入门v2.0java零基础入门v2.0java零基础入门v2.0','{\"charge\":\"201001\",\"id\":18,\"originalPrice\":111.0,\"phone\":\"13333333\",\"price\":11.0,\"qq\":\"123456\",\"validDays\":365,\"wechat\":\"654321\"}','[{\"courseId\":18,\"grade\":1,\"id\":279,\"orderby\":1,\"parentid\":0,\"pname\":\"第一章xxx\",\"teachPlanTreeNodes\":[{\"courseId\":18,\"grade\":2,\"id\":280,\"orderby\":1,\"parentid\":279,\"pname\":\"第一节xxx\",\"teachplanMedia\":{\"id\":49,\"mediaFilename\":\"垂直分库-插入和查询测试.avi\",\"mediaId\":\"18f919e23bedab97a78762c4875addc4\"}}]}]',NULL,'2019-09-04 09:56:19',NULL,NULL,'203002',NULL,'201001',11.00,111.00,365),(117,1232141425,NULL,'Nacos微服务开发实战','中高级Java开发工程师','',NULL,'1-3','编程开发','1-3-2','Java','204002','200002','/mediafiles/2022/10/04/8026f17cf7b8697eccec2c8406d0c96c.png','Nacos 是阿里巴巴推出来的一个新开源项目，这是一个更易于构建云原生应用的动态服务发现、配置管理和服务管理平台。\n\nNacos 致力于帮助您发现、配置和管理微服务。Nacos 提供了一组简单易用的特性集，帮助您快速实现动态服务发现、服务配置、服务元数据及流量管理。\n\nNacos 帮助您更敏捷和容易地构建、交付和管理微服务平台。 Nacos 是构建以“服务”为中心的现代应用架构 (例如微服务范式、云原生范式) 的服务基础设施\n\nNacos 支持如下核心特性：\n\n1）服务发现： 支持 DNS 与 RPC 服务发现，也提供原生 SDK 、OpenAPI 等多种服务注册方式和 DNS、HTTP 与 API 等多种服务发现方式。\n2）服务健康监测： Nacos 提供对服务的实时的健康检查，阻止向不健康的主机或服务实例发送请求。\n3）动态配置服务： Nacos 提供配置统一管理功能，能够帮助我们将配置以中心化、外部化和动态化的方式管理所有环境的应用配置和服务配置。\n4）动态 DNS 服务： Nacos 支持动态 DNS 服务权重路由，能够让我们很容易地实现中间层负载均衡、更灵活的路由策略、流量控制以及数据中心内网的简单 DNS 解析服务。\n5）服务及其元数据管理： Nacos 支持从微服务平台建设的视角管理数据中心的所有服务及元数据，包括管理服务的描述、生命周期、服务的静态依赖分析、服务的健康状态、服务的流量管理、路由及安全策略、服务的 SLA 以及最首要的 metrics 统计数据。','{\"charge\":\"201001\",\"id\":117,\"originalPrice\":198.0,\"phone\":\"24965575\",\"price\":1.0,\"qq\":\"24965575\",\"validDays\":365,\"wechat\":\"24965575\"}','[{\"courseId\":117,\"grade\":1,\"id\":268,\"isPreview\":\"0\",\"orderby\":1,\"parentid\":0,\"pname\":\"1.配置管理\",\"teachPlanTreeNodes\":[{\"courseId\":117,\"grade\":2,\"id\":269,\"isPreview\":\"1\",\"orderby\":1,\"parentid\":268,\"pname\":\"1.1 什么是配置中心\",\"teachplanMedia\":{\"courseId\":117,\"id\":40,\"mediaFilename\":\"01-Nacos配置管理-内容介绍.avi\",\"mediaId\":\"3a5a861d1c745d05166132c47b44f9e4\",\"teachplanId\":269}},{\"courseId\":117,\"grade\":2,\"id\":270,\"isPreview\":\"0\",\"orderby\":2,\"parentid\":268,\"pname\":\"1.2Nacos简介\",\"teachplanMedia\":{\"courseId\":117,\"id\":41,\"mediaFilename\":\"16-Nacos配置管理-课程总结.avi\",\"mediaId\":\"23f83ae728bd1269eee7ea2236e79644\",\"teachplanId\":270}},{\"courseId\":117,\"grade\":2,\"id\":271,\"isPreview\":\"0\",\"orderby\":3,\"parentid\":268,\"pname\":\"1.3安装Nacos Server\",\"teachplanMedia\":{\"courseId\":117,\"id\":42,\"mediaFilename\":\"01-Nacos配置管理-内容介绍.avi\",\"mediaId\":\"3a5a861d1c745d05166132c47b44f9e4\",\"teachplanId\":271}},{\"courseId\":117,\"grade\":2,\"id\":272,\"isPreview\":\"0\",\"orderby\":4,\"parentid\":268,\"pname\":\"1.4Nacos配置入门\",\"teachplanMedia\":{\"courseId\":117,\"id\":43,\"mediaFilename\":\"01-Nacos配置管理-内容介绍.avi\",\"mediaId\":\"3a5a861d1c745d05166132c47b44f9e4\",\"teachplanId\":272}},{\"courseId\":117,\"grade\":2,\"id\":273,\"isPreview\":\"0\",\"orderby\":5,\"parentid\":268,\"pname\":\"1.5命名空间管理\",\"teachplanMedia\":{\"courseId\":117,\"id\":44,\"mediaFilename\":\"16-Nacos配置管理-课程总结.avi\",\"mediaId\":\"23f83ae728bd1269eee7ea2236e79644\",\"teachplanId\":273}}]},{\"courseId\":117,\"grade\":1,\"id\":274,\"isPreview\":\"0\",\"orderby\":2,\"parentid\":0,\"pname\":\"2.服务发现\",\"teachPlanTreeNodes\":[{\"courseId\":117,\"grade\":2,\"id\":275,\"isPreview\":\"0\",\"orderby\":1,\"parentid\":274,\"pname\":\"2.1什么是服务发现\",\"teachplanMedia\":{\"courseId\":117,\"id\":45,\"mediaFilename\":\"01-分布式事务专题课程介绍.avi\",\"mediaId\":\"1f229319d6fed3431d2f9d06193a433b\",\"teachplanId\":275}},{\"courseId\":117,\"grade\":2,\"id\":276,\"isPreview\":\"0\",\"orderby\":2,\"parentid\":274,\"pname\":\"2.2服务发现快速入门\",\"teachplanMedia\":{\"courseId\":117,\"id\":46,\"mediaFilename\":\"07-分布式事务基础理论-BASE理论.avi\",\"mediaId\":\"6ad24a762f67c18f61966c1b8c55abe6\",\"teachplanId\":276}},{\"courseId\":117,\"grade\":2,\"id\":277,\"isPreview\":\"0\",\"orderby\":3,\"parentid\":274,\"pname\":\"2.3服务发现数据模型\",\"teachplanMedia\":{\"courseId\":117,\"id\":47,\"mediaFilename\":\"01-分布式事务专题课程介绍.avi\",\"mediaId\":\"1f229319d6fed3431d2f9d06193a433b\",\"teachplanId\":277}},{\"courseId\":117,\"grade\":2,\"id\":278,\"isPreview\":\"0\",\"orderby\":4,\"parentid\":274,\"pname\":\"2.4服务列表管理\",\"teachplanMedia\":{\"courseId\":117,\"id\":48,\"mediaFilename\":\"07-分布式事务基础理论-BASE理论.avi\",\"mediaId\":\"6ad24a762f67c18f61966c1b8c55abe6\",\"teachplanId\":278}}]}]',NULL,'2022-10-04 19:14:50',NULL,NULL,'203002',NULL,'201001',1.00,198.00,365),(121,1232141425,NULL,'Spring Cloud 开发实战','具有web开发基础','',NULL,'1-3','编程开发','1-3-2','Java','204002','200002','/mediafiles/2023/02/09/ef29eb93515e32f2d897956d5d914db7.png','Spring Cloud是一系列框架的有序集合。它利用Spring Boot的开发便利性巧妙地简化了分布式系统基础设施的开发，如服务发现注册、配置中心、消息总线、负载均衡、断路器、数据监控等，都可以用Spring Boot的开发风格做到一键启动和部署。Spring Cloud并没有重复制造轮子，它只是将各家公司开发的比较成熟、经得起实际考验的服务框架组合起来，通过Spring Boot风格进行再封装屏蔽掉了复杂的配置和实现原理，最终给开发者留出了一套简单易懂、易部署和易维护的分布式系统开发工具包。','{\"charge\":\"201001\",\"id\":121,\"originalPrice\":100.0,\"phone\":\"432432\",\"price\":1.0,\"qq\":\"2323232\",\"validDays\":365,\"wechat\":\"3232432\"}','[{\"courseId\":121,\"grade\":1,\"id\":281,\"orderby\":1,\"parentid\":0,\"pname\":\"第1章 SpringCloud概述\",\"teachPlanTreeNodes\":[{\"courseId\":121,\"grade\":2,\"id\":282,\"orderby\":1,\"parentid\":281,\"pname\":\"Spring Cloud发展历史\",\"teachplanMedia\":{\"id\":57,\"mediaFilename\":\"01-分布式事务专题课程介绍.avi\",\"mediaId\":\"1f229319d6fed3431d2f9d06193a433b\"}},{\"courseId\":121,\"grade\":2,\"id\":283,\"orderby\":2,\"parentid\":281,\"pname\":\"Spring Cloud与SpringBoot的关系\",\"teachplanMedia\":{\"id\":51,\"mediaFilename\":\"nacos01.mp4\",\"mediaId\":\"287cdd91c5d444e0752b626cbd95b41c\"}}]},{\"courseId\":121,\"grade\":1,\"id\":284,\"orderby\":2,\"parentid\":0,\"pname\":\"第2章 基础组件\",\"teachPlanTreeNodes\":[{\"courseId\":121,\"grade\":2,\"id\":285,\"orderby\":1,\"parentid\":284,\"pname\":\"服务注册中心\",\"teachplanMedia\":{\"id\":52,\"mediaFilename\":\"01-分布式事务专题课程介绍.avi\",\"mediaId\":\"1f229319d6fed3431d2f9d06193a433b\"}},{\"courseId\":121,\"grade\":2,\"id\":286,\"orderby\":2,\"parentid\":284,\"pname\":\"配置中心\",\"teachplanMedia\":{\"id\":53,\"mediaFilename\":\"垂直分库-插入和查询测试.avi\",\"mediaId\":\"18f919e23bedab97a78762c4875addc4\"}},{\"courseId\":121,\"grade\":2,\"id\":287,\"orderby\":3,\"parentid\":284,\"pname\":\"负载均衡\",\"teachplanMedia\":{\"id\":54,\"mediaFilename\":\"01-分布式事务专题课程介绍.avi\",\"mediaId\":\"1f229319d6fed3431d2f9d06193a433b\"}},{\"courseId\":121,\"grade\":2,\"id\":288,\"orderby\":4,\"parentid\":284,\"pname\":\"远程调用\",\"teachplanMedia\":{\"id\":55,\"mediaFilename\":\"16-Nacos配置管理-课程总结.avi\",\"mediaId\":\"23f83ae728bd1269eee7ea2236e79644\"}},{\"courseId\":121,\"grade\":2,\"id\":289,\"orderby\":5,\"parentid\":284,\"pname\":\"熔断降级\",\"teachplanMedia\":{\"id\":56,\"mediaFilename\":\"16-Nacos配置管理-课程总结.avi\",\"mediaId\":\"23f83ae728bd1269eee7ea2236e79644\"}}]}]',NULL,'2023-02-09 11:10:42',NULL,NULL,'203002',NULL,'201001',1.00,100.00,365);
/*!40000 ALTER TABLE `course_publish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_publish_pre`
--

DROP TABLE IF EXISTS `course_publish_pre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_publish_pre` (
  `id` bigint NOT NULL COMMENT '主键',
  `company_id` bigint NOT NULL COMMENT '机构ID',
  `company_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '公司名称',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程名称',
  `users` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '适用人群',
  `tags` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标签',
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建人',
  `mt` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '大分类',
  `mt_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '大分类名称',
  `st` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '小分类',
  `st_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '小分类名称',
  `grade` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程等级',
  `teachmode` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教育模式',
  `pic` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程图片',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '课程介绍',
  `market` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '课程营销信息，json格式',
  `teachplan` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '所有课程计划，json格式',
  `teachers` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '教师信息，json格式',
  `create_date` datetime DEFAULT NULL COMMENT '提交时间',
  `audit_date` datetime DEFAULT NULL COMMENT '审核时间',
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '1' COMMENT '状态',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `charge` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收费规则，对应数据字典--203',
  `price` float(10,2) DEFAULT NULL COMMENT '现价',
  `original_price` float(10,2) DEFAULT NULL COMMENT '原价',
  `valid_days` int DEFAULT NULL COMMENT '课程有效期天数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='课程发布';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_publish_pre`
--

LOCK TABLES `course_publish_pre` WRITE;
/*!40000 ALTER TABLE `course_publish_pre` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_publish_pre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_teacher`
--

DROP TABLE IF EXISTS `course_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_teacher` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `course_id` bigint DEFAULT NULL COMMENT '课程标识',
  `teacher_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '教师标识',
  `position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '教师职位',
  `introduction` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '教师简介',
  `photograph` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '照片',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `courseid_teacherId_unique` (`course_id`,`teacher_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='课程-教师关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_teacher`
--

LOCK TABLES `course_teacher` WRITE;
/*!40000 ALTER TABLE `course_teacher` DISABLE KEYS */;
INSERT INTO `course_teacher` (`id`, `course_id`, `teacher_name`, `position`, `introduction`, `photograph`, `create_date`) VALUES (1,72,'wangxu','java高级讲师','1111','http://r3zc5rung.hd-bkt.clouddn.com/2424e25d-b3ff-4ea2-92a5-249af918a42dGDSzBXIgWuwMCiZ4','2021-12-25 17:44:07'),(3,79,'博文','教师','帅哥','http://r3zc5rung.hd-bkt.clouddn.com/5fc0c47f-a3b4-4d93-b618-bb1cce8271f065L1s0qQjE1eLUAS','2021-12-27 10:35:49'),(4,80,'小王吧','SaaS','ASAD','http://r3zc5rung.hd-bkt.clouddn.com/bbdca546-524e-4938-abda-41b221642e7b4KtfBnPKutsdcqwI','2021-12-27 11:09:43'),(5,82,'驱蚊器','为','去',NULL,'2021-12-27 11:29:16'),(6,83,'111','111','111','http://r3zc5rung.hd-bkt.clouddn.com/e169c906-a32a-4d0d-8262-e050de0f5f78obzlSd955zLAdeqv','2021-12-27 12:24:01'),(7,84,'123','123','123','http://r3zc5rung.hd-bkt.clouddn.com/6f6ac157-fc87-4bcc-a0ea-6c1e7c802fa6Igv8qAA9vwVYuNEv','2021-12-27 13:44:01'),(8,85,'黄哥','大牛','nb','http://r3zc5rung.hd-bkt.clouddn.com/0ac34fcb-009c-40d3-9a67-9615d2d2e079ZR3JLyZNbcpdhdZF','2021-12-27 16:11:30'),(9,86,'1','1','1','http://r3zc5rung.hd-bkt.clouddn.com/625f7d6b-eeb8-4b24-aa9c-d2dd7fc0a3f2FXkxFmophiqhz5au','2021-12-27 20:03:21'),(10,88,'1','1','1','http://r3zc5rung.hd-bkt.clouddn.com/4fd7bfaa-f374-44c9-a4db-aa8ef23a76ddhvlJXSn6zcGKQS1u','2021-12-27 20:15:19'),(11,89,'q','qq','去','http://r3zc5rung.hd-bkt.clouddn.com/5e7a6877-39e2-4269-a656-c6c56c4ee259DVa7QIBQHs0OQ3yI','2021-12-27 20:22:40'),(12,90,'1','11','1','http://r3zc5rung.hd-bkt.clouddn.com/b3aeddb4-b4a4-4707-a4dc-16b9a9b04ddbATTiKwht7R3UFem6','2021-12-27 20:27:43'),(13,91,'1','1','1','http://r3zc5rung.hd-bkt.clouddn.com/28535bad-5186-4b93-b949-85af1f9698157U9V9ybKbD6eMIym','2021-12-27 20:35:55'),(14,92,'1','1','1','http://r3zc5rung.hd-bkt.clouddn.com/347a1e0d-793c-4b7f-8c26-2f3b1d2509aardGNVuaR19aV9EYW','2021-12-27 20:54:23'),(15,93,'小公牛','欢喜','欢喜','http://r3zc5rung.hd-bkt.clouddn.com/7b60fbeb-1857-4881-b4f1-1752e7c897ecQJGFVRhfevzXqVIU','2021-12-27 23:24:27'),(16,94,'最最最最最最最最最最终测试','最最最最最最最最最最终测试','最最最最最最最最最最终测试',NULL,'2021-12-27 23:48:59'),(17,95,'1','1','1','http://r3zc5rung.hd-bkt.clouddn.com/490587bd-21df-4739-bcfb-dd0dbcad9a58OW3cttni1nlacpmZ','2021-12-28 02:08:54'),(18,96,'究极测试','究极测试','究极测试','http://r3zc5rung.hd-bkt.clouddn.com/8bc6a8be-df5c-4456-82c0-edc4c51731f1gkuxrGC7Jwlj7RKT','2021-12-28 03:11:24'),(19,22,'王老师','高级讲师','',NULL,'2022-08-21 21:17:53'),(20,74,'张老师','java老师','讲课生动。','/bucket-pic/2022/08/25/a0950c47-ed28-4dec-8a87-76ff108448d7.jpg','2022-08-23 15:46:27');
/*!40000 ALTER TABLE `course_teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mq_message`
--

DROP TABLE IF EXISTS `mq_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mq_message` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '消息id',
  `message_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息类型代码: course_publish ,  media_test',
  `business_key1` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '关联业务信息',
  `business_key2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '关联业务信息',
  `business_key3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '关联业务信息',
  `execute_num` int unsigned NOT NULL DEFAULT '0' COMMENT '通知次数',
  `state` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '处理状态，0:初始，1:成功',
  `returnfailure_date` datetime DEFAULT NULL COMMENT '回复失败时间',
  `returnsuccess_date` datetime DEFAULT NULL COMMENT '回复成功时间',
  `returnfailure_msg` varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '回复失败内容',
  `execute_date` datetime DEFAULT NULL COMMENT '最近通知时间',
  `stage_state1` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '阶段1处理状态, 0:初始，1:成功',
  `stage_state2` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '阶段2处理状态, 0:初始，1:成功',
  `stage_state3` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '阶段3处理状态, 0:初始，1:成功',
  `stage_state4` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '阶段4处理状态, 0:初始，1:成功',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mq_message`
--

LOCK TABLES `mq_message` WRITE;
/*!40000 ALTER TABLE `mq_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `mq_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mq_message_history`
--

DROP TABLE IF EXISTS `mq_message_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mq_message_history` (
  `id` bigint NOT NULL COMMENT '消息id',
  `message_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息类型代码',
  `business_key1` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '关联业务信息',
  `business_key2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '关联业务信息',
  `business_key3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '关联业务信息',
  `execute_num` int unsigned DEFAULT NULL COMMENT '通知次数',
  `state` int(10) unsigned zerofill DEFAULT NULL COMMENT '处理状态，0:初始，1:成功，2:失败',
  `returnfailure_date` datetime DEFAULT NULL COMMENT '回复失败时间',
  `returnsuccess_date` datetime DEFAULT NULL COMMENT '回复成功时间',
  `returnfailure_msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '回复失败内容',
  `execute_date` datetime DEFAULT NULL COMMENT '最近通知时间',
  `stage_state1` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `stage_state2` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `stage_state3` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `stage_state4` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mq_message_history`
--

LOCK TABLES `mq_message_history` WRITE;
/*!40000 ALTER TABLE `mq_message_history` DISABLE KEYS */;
INSERT INTO `mq_message_history` (`id`, `message_type`, `business_key1`, `business_key2`, `business_key3`, `execute_num`, `state`, `returnfailure_date`, `returnsuccess_date`, `returnfailure_msg`, `execute_date`, `stage_state1`, `stage_state2`, `stage_state3`, `stage_state4`) VALUES (1,'course_publish','121',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'1','1','0','0'),(2,'course_publish','121',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'1','1','0','0'),(3,'course_publish','121',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'1','1','0','0'),(17,'course_publish','222',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'1','0','0','0'),(18,'course_publish','18',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'1','0','0','0'),(20,'course_publish','18',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'1','1','0','0');
/*!40000 ALTER TABLE `mq_message_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachplan`
--

DROP TABLE IF EXISTS `teachplan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachplan` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pname` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程计划名称',
  `parentid` bigint NOT NULL COMMENT '课程计划父级Id',
  `grade` smallint NOT NULL COMMENT '层级，分为1、2、3级',
  `media_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '课程类型:1视频、2文档',
  `start_time` datetime DEFAULT NULL COMMENT '开始直播时间',
  `end_time` datetime DEFAULT NULL COMMENT '直播结束时间',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '章节及课程时介绍',
  `timelength` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '时长，单位时:分:秒',
  `orderby` int DEFAULT '0' COMMENT '排序字段',
  `course_id` bigint NOT NULL COMMENT '课程标识',
  `course_pub_id` bigint DEFAULT NULL COMMENT '课程发布标识',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态（1正常  0删除）',
  `is_preview` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '是否支持试学或预览（试看）',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `change_date` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=290 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='课程计划';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachplan`
--

LOCK TABLES `teachplan` WRITE;
/*!40000 ALTER TABLE `teachplan` DISABLE KEYS */;
INSERT INTO `teachplan` (`id`, `pname`, `parentid`, `grade`, `media_type`, `start_time`, `end_time`, `description`, `timelength`, `orderby`, `course_id`, `course_pub_id`, `status`, `is_preview`, `create_date`, `change_date`) VALUES (2,'数据库基础知识',43,2,'1','2019-09-16 10:45:36',NULL,NULL,NULL,1,25,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(3,'SQL查询',43,2,'1','2019-09-16 10:45:36',NULL,NULL,NULL,3,25,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(4,'SQL优化',43,2,'1','2019-09-16 10:45:36',NULL,NULL,NULL,2,25,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(5,'微服务架构入门',0,1,NULL,'2019-09-16 10:45:36',NULL,'微服务架构入门',NULL,1,26,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(6,'spring cloud 基础入门',0,1,NULL,'2019-09-16 10:45:36',NULL,'spring cloud 基础入门',NULL,2,26,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(7,'实战-Spring Boot',0,1,NULL,'2019-09-16 10:45:36',NULL,'实战-Spring Boot',NULL,3,26,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(8,'注册中心Eureka',0,1,NULL,'2019-09-16 10:45:36',NULL,'注册中心Eureka','55.00',4,26,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(9,'为什么要使用微服务:微服务的优缺点',13,2,'1','2019-09-16 10:45:36',NULL,'为什么要使用微服务:微服务的优缺点','55.00',2,26,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(10,'为什么要使用微服务:单体架构的特点',13,2,'1','2019-09-16 10:45:36',NULL,'为什么要使用微服务:单体架构的特点','44.00',1,26,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(11,'为什么springcloud要设计一套新的版本升级规则？',14,2,'1','2019-09-16 10:45:36',NULL,'为什么springcloud要设计一套新的版本升级规则？','33.00',2,26,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(12,'计算机原理',0,1,'0','2019-09-16 10:45:36',NULL,'介绍计算机工作原理',NULL,1,25,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(13,'为什么要选择spring cloud?',14,2,'1','2019-09-16 10:45:36',NULL,'为什么要选择spring cloud?','12.00',1,26,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(14,'spring boot的入门例子',15,2,'1','2019-09-16 10:45:36',NULL,'spring boot的入门例子','44.00',2,26,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(16,'为什么越来越多的开发者选择使用spring boot？它解决了什么问题？',15,2,'1','2019-09-16 10:45:36',NULL,'为什么越来越多的开发者选择使用spring boot？它解决了什么问题？','10.00',1,26,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(17,' 一个Eureka注册中心的入门例子',16,2,'1','2019-09-16 10:45:36',NULL,' 一个Eureka注册中心的入门例子','22.00',2,26,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(18,'微服务架构为什么需要注册中心，它解决了什么问题？',16,2,'1','2019-09-16 10:45:36',NULL,'微服务架构为什么需要注册中心，它解决了什么问题？','33.00',1,26,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(20,'Vuejs 第一讲',0,1,NULL,'2019-09-16 10:45:36',NULL,'Vuejs 第一讲',NULL,1,27,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(21,'Vuejs 第二讲',0,1,NULL,'2019-09-16 10:45:36',NULL,NULL,NULL,2,43,23,203002,NULL,'2019-09-16 10:45:36','2019-11-19 00:55:16'),(22,'Vuejs 第三讲',0,1,NULL,'2019-09-16 10:45:36',NULL,NULL,NULL,3,27,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(23,'计算机硬件',2,2,'1','2019-09-16 10:45:36',NULL,NULL,'10.00',1,25,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(24,'第一节 vue基础、常用指令、bootstrap+vue的简易留言',20,2,'1','2019-09-16 10:45:36',NULL,'第一节 vue基础、常用指令、bootstrap+vue的简易留言','22.00',1,27,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(25,'第二节 属性和事件、模板、交互、案例',20,2,'1','2019-09-16 10:45:36',NULL,'第二节 属性和事件、模板、交互、案例','33.00',2,27,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(26,'第一节 计算属性的使用、vue实例的简单方法、提高循环的性能，让重复数据显示出来',21,2,NULL,'2019-09-16 10:45:36',NULL,NULL,NULL,1,27,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(27,'第二节 自定义过滤器、自定义指令 、自定义键盘事件、数据的监听',21,2,'1','2019-09-16 10:45:36',NULL,NULL,NULL,2,27,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(29,'第一章：redis简介',0,1,NULL,'2019-09-16 10:45:36',NULL,NULL,NULL,1,28,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(30,'第二章：redis的安装与配置',0,1,NULL,'2019-09-16 10:45:36',NULL,NULL,NULL,2,28,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(31,'第三章：Redis数据操作',0,1,NULL,'2019-09-16 10:45:36',NULL,NULL,NULL,3,28,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(32,'第四章：Redis进阶操作',0,1,NULL,'2019-09-16 10:45:36',NULL,NULL,NULL,4,28,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(33,'第五章：Redis主从配置',0,1,NULL,'2019-09-16 10:45:36',NULL,NULL,NULL,5,28,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(34,'计算机软件',2,2,'1','2019-09-16 10:45:36',NULL,NULL,'12.00',2,25,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(35,'操作系统类型介绍',12,2,'1','2019-09-16 10:45:36',NULL,'操作系统类型介绍操作系统类型介绍','11.00',2,25,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(36,'操作系统原理',12,2,'1','2019-09-16 10:45:36',NULL,'操作系统原理操作系统原理操作系统原理操作系统原理','22.00',1,25,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(37,'第一节 NoSQL简介',29,2,'1','2019-09-16 10:45:36',NULL,NULL,NULL,1,28,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(38,'第二节 认识Redis',29,2,'1','2019-09-16 10:45:36',NULL,NULL,NULL,2,28,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(39,'计算机编程入门',0,1,'0','2019-09-16 10:45:36',NULL,NULL,NULL,3,25,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(40,'java语法介绍',39,2,'1','2019-09-16 10:45:36',NULL,NULL,NULL,2,25,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(41,'Hello World',39,2,'1','2019-09-16 10:45:36',NULL,NULL,NULL,1,25,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(43,'数据库编程',0,1,'1','2019-09-16 10:45:36',NULL,'数据库编程数据库编程','11.00',2,25,NULL,0,NULL,'2019-09-16 10:45:36',NULL),(110,'第一章',0,1,NULL,NULL,NULL,NULL,NULL,1,72,NULL,1,'0','2021-12-25 16:27:34',NULL),(111,'第一小节',110,2,NULL,NULL,NULL,NULL,NULL,1,72,NULL,1,'0','2021-12-25 16:27:42',NULL),(113,'第1章基础知识',0,1,NULL,NULL,NULL,NULL,NULL,1,74,NULL,1,'0','2021-12-25 17:53:12',NULL),(115,'第1节项目概述',113,2,'001002',NULL,NULL,NULL,NULL,1,74,NULL,1,'0','2021-12-25 17:53:17',NULL),(117,'新章名称 [点击修改]',0,1,NULL,NULL,NULL,NULL,NULL,1,75,NULL,1,'0','2021-12-26 18:21:51',NULL),(118,'新章名称 [点击修改]',0,1,NULL,NULL,NULL,NULL,NULL,2,75,NULL,1,'0','2021-12-26 18:29:48',NULL),(121,'第一大章节',0,1,NULL,NULL,NULL,NULL,NULL,1,76,NULL,1,'0','2021-12-26 19:59:43',NULL),(122,'新章名称 [点击修改]',0,1,NULL,NULL,NULL,NULL,NULL,1,76,NULL,1,'0','2021-12-26 19:59:43',NULL),(123,'第一小节',121,2,NULL,NULL,NULL,NULL,NULL,1,76,NULL,1,'0','2021-12-26 19:59:46',NULL),(125,'第一大章节',0,1,NULL,NULL,NULL,NULL,NULL,1,77,NULL,1,'0','2021-12-26 20:02:08',NULL),(126,'第一小节',125,2,NULL,NULL,NULL,NULL,NULL,1,77,NULL,1,'0','2021-12-26 20:02:24',NULL),(128,'第一大章',0,1,NULL,NULL,NULL,NULL,NULL,1,78,NULL,1,'0','2021-12-26 20:54:25',NULL),(129,'第一小节',128,2,NULL,NULL,NULL,NULL,NULL,1,78,NULL,1,'0','2021-12-26 20:54:40',NULL),(131,'新小节名称 [点击修改]',128,2,NULL,NULL,NULL,NULL,NULL,3,78,NULL,1,'0','2021-12-26 20:55:40',NULL),(135,'新小节名称 [点击修改]',121,2,'001004',NULL,NULL,NULL,NULL,2,76,NULL,1,'0','2021-12-27 09:56:49',NULL),(137,'Spring1',0,1,NULL,NULL,NULL,NULL,NULL,1,79,NULL,1,'0','2021-12-27 10:34:41',NULL),(138,'Spring1.2',137,2,NULL,NULL,NULL,NULL,NULL,1,79,NULL,1,'0','2021-12-27 10:34:52',NULL),(139,'Spring2',0,1,NULL,NULL,NULL,NULL,NULL,2,79,NULL,1,'0','2021-12-27 10:34:59',NULL),(141,'Java Web1',0,1,NULL,NULL,NULL,NULL,NULL,1,80,NULL,1,'0','2021-12-27 11:08:35',NULL),(142,'Java Web1.1',141,2,NULL,NULL,NULL,NULL,NULL,1,80,NULL,1,'0','2021-12-27 11:08:40',NULL),(143,'Java Web2',0,1,NULL,NULL,NULL,NULL,NULL,2,80,NULL,1,'0','2021-12-27 11:09:05',NULL),(144,'Java Web2.1',143,2,NULL,NULL,NULL,NULL,NULL,1,80,NULL,1,'0','2021-12-27 11:09:10',NULL),(146,'什么是微服务',0,1,NULL,NULL,NULL,NULL,NULL,1,82,NULL,1,'1','2021-12-27 11:28:07',NULL),(147,'什么是微服务',146,2,NULL,NULL,NULL,NULL,NULL,1,82,NULL,1,'1','2021-12-27 11:28:14',NULL),(148,'Spring Boot入门',0,1,NULL,NULL,NULL,NULL,NULL,2,82,NULL,1,'1','2021-12-27 11:28:35',NULL),(149,'入门程序',148,2,NULL,NULL,NULL,NULL,NULL,1,82,NULL,1,'1','2021-12-27 11:28:41',NULL),(152,'123',0,1,NULL,NULL,NULL,NULL,NULL,1,83,NULL,1,'0','2021-12-27 12:22:08',NULL),(153,'123456',152,2,'001002',NULL,NULL,NULL,NULL,1,83,NULL,1,'0','2021-12-27 12:22:14',NULL),(154,'456',0,1,NULL,NULL,NULL,NULL,NULL,2,83,NULL,1,'0','2021-12-27 12:22:23',NULL),(155,'123456',154,2,'001004',NULL,NULL,NULL,NULL,1,83,NULL,1,'0','2021-12-27 12:22:29',NULL),(157,'Spring Cloud1',0,1,NULL,NULL,NULL,NULL,NULL,1,84,NULL,1,'0','2021-12-27 13:42:06',NULL),(158,'Spring Cloud1.1',157,2,'001002',NULL,NULL,NULL,NULL,1,84,NULL,1,'1','2021-12-27 13:42:12',NULL),(159,'Spring Cloud2',0,1,NULL,NULL,NULL,NULL,NULL,2,84,NULL,1,'0','2021-12-27 13:42:18',NULL),(160,'Spring Cloud2.1',159,2,'001004',NULL,NULL,NULL,NULL,1,84,NULL,1,'1','2021-12-27 13:42:23',NULL),(162,'第一章',0,1,NULL,NULL,NULL,NULL,NULL,1,85,NULL,1,'0','2021-12-27 15:55:03',NULL),(163,'第二章',0,1,NULL,NULL,NULL,NULL,NULL,2,85,NULL,1,'0','2021-12-27 15:55:04',NULL),(164,'第三章',0,1,NULL,NULL,NULL,NULL,NULL,3,85,NULL,1,'0','2021-12-27 15:55:05',NULL),(165,'第一小节',162,2,'001004',NULL,NULL,NULL,NULL,1,85,NULL,1,'0','2021-12-27 15:55:06',NULL),(166,'第一小节',163,2,'001004',NULL,NULL,NULL,NULL,1,85,NULL,1,'0','2021-12-27 15:55:07',NULL),(167,'第二小节',162,2,'001002',NULL,NULL,NULL,NULL,2,85,NULL,1,'0','2021-12-27 15:55:08',NULL),(168,'第一章',164,2,'001002',NULL,NULL,NULL,NULL,1,85,NULL,1,'0','2021-12-27 15:55:10',NULL),(170,'1',0,1,NULL,NULL,NULL,NULL,NULL,1,86,NULL,1,'0','2021-12-27 20:01:08',NULL),(171,'2',0,1,NULL,NULL,NULL,NULL,NULL,2,86,NULL,1,'0','2021-12-27 20:01:16',NULL),(172,'3',0,1,NULL,NULL,NULL,NULL,NULL,3,86,NULL,1,'0','2021-12-27 20:01:17',NULL),(173,'1',170,2,'001004',NULL,NULL,NULL,NULL,1,86,NULL,1,'0','2021-12-27 20:01:31',NULL),(174,'2',170,2,'001004',NULL,NULL,NULL,NULL,2,86,NULL,1,'0','2021-12-27 20:01:37',NULL),(175,'1',171,2,'001002',NULL,NULL,NULL,NULL,1,86,NULL,1,'0','2021-12-27 20:01:42',NULL),(176,'2',171,2,'001002',NULL,NULL,NULL,NULL,2,86,NULL,1,'0','2021-12-27 20:01:43',NULL),(177,'1',172,2,'001004',NULL,NULL,NULL,NULL,1,86,NULL,1,'0','2021-12-27 20:01:47',NULL),(179,'新章名称 [点击修改]',0,1,NULL,NULL,NULL,NULL,NULL,1,87,NULL,1,'0','2021-12-27 20:14:15',NULL),(180,'新小节名称 [点击修改]',179,2,'001004',NULL,NULL,NULL,NULL,1,87,NULL,1,'0','2021-12-27 20:14:17',NULL),(181,'新小节名称 [点击修改]',179,2,'001004',NULL,NULL,NULL,NULL,2,87,NULL,1,'0','2021-12-27 20:14:29',NULL),(183,'新章名称 [点击修改]',0,1,NULL,NULL,NULL,NULL,NULL,1,88,NULL,1,'0','2021-12-27 20:14:56',NULL),(184,'新小节名称 [点击修改]',183,2,'001004',NULL,NULL,NULL,NULL,1,88,NULL,1,'0','2021-12-27 20:14:59',NULL),(186,'1',0,1,NULL,NULL,NULL,NULL,NULL,1,89,NULL,1,'0','2021-12-27 20:21:50',NULL),(187,'2',186,2,'001002',NULL,NULL,NULL,NULL,1,89,NULL,1,'1','2021-12-27 20:21:55',NULL),(189,'1',0,1,NULL,NULL,NULL,NULL,NULL,1,90,NULL,1,'0','2021-12-27 20:26:59',NULL),(190,'2',189,2,'001002',NULL,NULL,NULL,NULL,1,90,NULL,1,'1','2021-12-27 20:27:04',NULL),(191,'3',0,1,NULL,NULL,NULL,NULL,NULL,2,90,NULL,1,'0','2021-12-27 20:27:11',NULL),(192,'4',191,2,'001004',NULL,NULL,NULL,NULL,1,90,NULL,1,'1','2021-12-27 20:27:14',NULL),(194,'第一大章',0,1,NULL,NULL,NULL,NULL,NULL,1,91,NULL,1,'0','2021-12-27 20:35:10',NULL),(195,'1',194,2,'001002',NULL,NULL,NULL,NULL,1,91,NULL,1,'1','2021-12-27 20:35:13',NULL),(196,'2',194,2,'001004',NULL,NULL,NULL,NULL,2,91,NULL,1,'1','2021-12-27 20:35:27',NULL),(198,'新章名称 [点击修改]',0,1,'',NULL,NULL,NULL,NULL,1,92,NULL,1,'0','2021-12-27 20:53:34',NULL),(199,'新章名称 [点击修改]',0,1,'',NULL,NULL,NULL,NULL,2,92,NULL,1,'0','2021-12-27 20:53:35',NULL),(200,'新小节名称 [点击修改]',198,2,'001004',NULL,NULL,NULL,NULL,1,92,NULL,1,'0','2021-12-27 20:53:39',NULL),(201,'新小节名称 [点击修改]',198,2,'001004',NULL,NULL,NULL,NULL,2,92,NULL,1,'0','2021-12-27 20:53:40',NULL),(202,'新小节名称 [点击修改]',199,2,'001002',NULL,NULL,NULL,NULL,1,92,NULL,1,'0','2021-12-27 20:53:41',NULL),(204,'新章名称 [点击修改]',0,1,'',NULL,NULL,NULL,NULL,1,93,NULL,1,'0','2021-12-27 23:23:19',NULL),(205,'新章名称 [点击修改]',0,1,'',NULL,NULL,NULL,NULL,2,93,NULL,1,'0','2021-12-27 23:23:20',NULL),(206,'新章名称 [点击修改]',0,1,'',NULL,NULL,NULL,NULL,3,93,NULL,1,'0','2021-12-27 23:23:21',NULL),(207,'新小节名称 [点击修改]',204,2,'001004',NULL,NULL,NULL,NULL,1,93,NULL,1,'0','2021-12-27 23:23:22',NULL),(208,'新小节名称 [点击修改]',204,2,'001004',NULL,NULL,NULL,NULL,2,93,NULL,1,'0','2021-12-27 23:23:23',NULL),(209,'新小节名称 [点击修改]',205,2,'001002',NULL,NULL,NULL,NULL,1,93,NULL,1,'0','2021-12-27 23:23:24',NULL),(211,'新章名称 [点击修改]',0,1,'',NULL,NULL,NULL,NULL,1,94,NULL,1,'0','2021-12-27 23:48:16',NULL),(212,'新章名称 [点击修改]',0,1,'',NULL,NULL,NULL,NULL,2,94,NULL,1,'0','2021-12-27 23:48:17',NULL),(213,'新章名称 [点击修改]',0,1,'',NULL,NULL,NULL,NULL,3,94,NULL,1,'0','2021-12-27 23:48:17',NULL),(214,'新小节名称 [点击修改]',211,2,'001004',NULL,NULL,NULL,NULL,1,94,NULL,1,'0','2021-12-27 23:48:18',NULL),(215,'新小节名称 [点击修改]',211,2,'001004',NULL,NULL,NULL,NULL,2,94,NULL,1,'0','2021-12-27 23:48:20',NULL),(216,'新小节名称 [点击修改]',212,2,'001004',NULL,NULL,NULL,NULL,1,94,NULL,1,'0','2021-12-27 23:48:22',NULL),(217,'新小节名称 [点击修改]',213,2,'001002',NULL,NULL,NULL,NULL,1,94,NULL,1,'0','2021-12-27 23:48:47',NULL),(219,'新章名称 [点击修改]',0,1,'',NULL,NULL,NULL,NULL,1,95,NULL,1,'0','2021-12-28 02:08:10',NULL),(220,'新章名称 [点击修改]',0,1,'',NULL,NULL,NULL,NULL,2,95,NULL,1,'0','2021-12-28 02:08:11',NULL),(221,'新小节名称 [点击修改]',219,2,'001004',NULL,NULL,NULL,NULL,1,95,NULL,1,'0','2021-12-28 02:08:13',NULL),(222,'新小节名称 [点击修改]',219,2,'001004',NULL,NULL,NULL,NULL,2,95,NULL,1,'0','2021-12-28 02:08:14',NULL),(223,'新小节名称 [点击修改]',220,2,'001002',NULL,NULL,NULL,NULL,1,95,NULL,1,'0','2021-12-28 02:08:38',NULL),(225,'究极测试1',0,1,'',NULL,NULL,NULL,NULL,1,96,NULL,1,'0','2021-12-28 03:10:28',NULL),(226,'1',225,2,'001004',NULL,NULL,NULL,NULL,1,96,NULL,1,'1','2021-12-28 03:10:32',NULL),(227,'2',225,2,'001002',NULL,NULL,NULL,NULL,2,96,NULL,1,'1','2021-12-28 03:10:34',NULL),(228,'究极测试2',0,1,'',NULL,NULL,NULL,NULL,2,96,NULL,1,'0','2021-12-28 03:10:35',NULL),(230,'新章名称 [点击修改]',0,1,'',NULL,NULL,NULL,NULL,1,97,NULL,1,'0','2021-12-28 03:36:54',NULL),(231,'新章名称 [点击修改]',0,1,'',NULL,NULL,NULL,NULL,2,97,NULL,1,'0','2021-12-28 03:36:55',NULL),(232,'新章名称 [点击修改]',0,1,'',NULL,NULL,NULL,NULL,3,97,NULL,1,'0','2021-12-28 03:36:56',NULL),(234,'新小节名称 [点击修改]',231,2,'001002',NULL,NULL,NULL,NULL,1,97,NULL,1,'0','2021-12-28 03:36:59',NULL),(235,'新小节名称 [点击修改]',230,2,'001004',NULL,NULL,NULL,NULL,2,97,NULL,1,'0','2021-12-28 03:38:27',NULL),(236,'新小节名称 [点击修改]',231,2,'001004',NULL,NULL,NULL,NULL,2,97,NULL,1,'0','2021-12-28 03:39:11',NULL),(237,'第1章',0,1,'',NULL,NULL,NULL,NULL,1,22,NULL,1,'0','2022-08-21 21:09:58',NULL),(240,'第1节',237,2,'',NULL,NULL,NULL,NULL,1,22,NULL,1,'1','2022-08-21 21:16:29',NULL),(241,'第2节',237,2,'',NULL,NULL,NULL,NULL,2,22,NULL,1,'0','2022-08-21 21:17:20',NULL),(242,'第2章快速入门',0,1,'',NULL,NULL,NULL,NULL,1,74,NULL,1,'0','2022-08-23 15:07:09',NULL),(244,'第1节搭建环境',242,2,'001002',NULL,NULL,NULL,NULL,2,74,NULL,1,'1','2022-08-23 15:36:30',NULL),(245,'第2节项目概述',242,2,'001002',NULL,NULL,NULL,NULL,3,74,NULL,1,'0','2022-08-23 18:35:16',NULL),(246,'第3章项目概述',0,1,NULL,NULL,NULL,NULL,NULL,3,74,NULL,1,'0',NULL,NULL),(247,'第4章',0,1,NULL,NULL,NULL,NULL,NULL,4,74,NULL,1,'0',NULL,NULL),(248,'第3-1节',246,2,NULL,NULL,NULL,NULL,NULL,4,74,NULL,1,'1',NULL,NULL),(249,'第4-1小节 ',247,2,NULL,NULL,NULL,NULL,NULL,5,74,NULL,1,'0',NULL,NULL),(250,'第4-0小节',247,2,NULL,NULL,NULL,NULL,NULL,2,74,NULL,1,'0',NULL,NULL),(251,'新章名称 [点击修改]',0,1,NULL,NULL,NULL,NULL,NULL,5,74,NULL,1,'0',NULL,NULL),(252,'小节名称 [点击修改]',247,2,NULL,NULL,NULL,NULL,NULL,3,74,NULL,1,'0',NULL,NULL),(253,'第1节修改名称',237,2,'',NULL,NULL,NULL,NULL,3,22,NULL,1,'1',NULL,NULL),(255,'第1章',0,1,NULL,NULL,NULL,NULL,NULL,1,1,NULL,1,'0',NULL,NULL),(256,'第1小节',255,2,NULL,NULL,NULL,NULL,NULL,1,1,NULL,1,'0',NULL,NULL),(257,'配置详解',148,2,NULL,NULL,NULL,NULL,NULL,2,82,NULL,1,'0',NULL,NULL),(258,'项目实战',148,2,NULL,NULL,NULL,NULL,NULL,3,82,NULL,1,'0',NULL,NULL),(259,'新章名称 [点击修改]',0,1,NULL,NULL,NULL,NULL,NULL,2,22,NULL,1,'0',NULL,NULL),(260,'新小节名称 [点击修改]',259,2,NULL,NULL,NULL,NULL,NULL,1,22,NULL,1,'0',NULL,NULL),(261,'新章名称 [点击修改]',0,1,NULL,NULL,NULL,NULL,NULL,1,40,NULL,1,'0',NULL,NULL),(262,'新小节名称 [点击修改]',261,2,NULL,NULL,NULL,NULL,NULL,1,40,NULL,1,'1',NULL,NULL),(263,'新小节名称 [点击修改]',255,2,NULL,NULL,NULL,NULL,NULL,2,1,NULL,1,'0',NULL,NULL),(264,'新章名称 [点击修改]',0,1,NULL,NULL,NULL,NULL,NULL,2,1,NULL,1,'0',NULL,NULL),(265,'新小节名称 [点击修改]',264,2,NULL,NULL,NULL,NULL,NULL,1,1,NULL,1,'0',NULL,NULL),(266,'第1章',0,1,NULL,NULL,NULL,NULL,NULL,1,2,NULL,1,'0',NULL,NULL),(267,'第1节',266,2,NULL,NULL,NULL,NULL,NULL,1,2,NULL,1,'0',NULL,NULL),(268,'1.配置管理',0,1,NULL,NULL,NULL,NULL,NULL,1,117,NULL,1,'0',NULL,NULL),(269,'1.1 什么是配置中心',268,2,NULL,NULL,NULL,NULL,NULL,1,117,NULL,1,'0',NULL,NULL),(270,'1.2Nacos简介',268,2,NULL,NULL,NULL,NULL,NULL,2,117,NULL,1,'0',NULL,NULL),(271,'1.3安装Nacos Server',268,2,NULL,NULL,NULL,NULL,NULL,3,117,NULL,1,'0',NULL,NULL),(272,'1.4Nacos配置入门',268,2,NULL,NULL,NULL,NULL,NULL,4,117,NULL,1,'0',NULL,NULL),(273,'1.5命名空间管理',268,2,NULL,NULL,NULL,NULL,NULL,5,117,NULL,1,'0',NULL,NULL),(274,'2.服务发现',0,1,NULL,NULL,NULL,NULL,NULL,2,117,NULL,1,'0',NULL,NULL),(275,'2.1什么是服务发现',274,2,NULL,NULL,NULL,NULL,NULL,1,117,NULL,1,'0',NULL,NULL),(276,'2.2服务发现快速入门',274,2,NULL,NULL,NULL,NULL,NULL,2,117,NULL,1,'0',NULL,NULL),(277,'2.3服务发现数据模型',274,2,NULL,NULL,NULL,NULL,NULL,3,117,NULL,1,'0',NULL,NULL),(278,'2.4服务列表管理',274,2,NULL,NULL,NULL,NULL,NULL,4,117,NULL,1,'0',NULL,NULL),(279,'第一章xxx',0,1,NULL,NULL,NULL,NULL,NULL,1,18,NULL,1,'0',NULL,NULL),(280,'第一节xxx',279,2,NULL,NULL,NULL,NULL,NULL,1,18,NULL,1,'0',NULL,NULL),(281,'第1章 SpringCloud概述',0,1,NULL,NULL,NULL,NULL,NULL,1,121,NULL,1,'0',NULL,NULL),(282,'Spring Cloud发展历史',281,2,NULL,NULL,NULL,NULL,NULL,1,121,NULL,1,'0',NULL,NULL),(283,'Spring Cloud与SpringBoot的关系',281,2,NULL,NULL,NULL,NULL,NULL,2,121,NULL,1,'0',NULL,NULL),(284,'第2章 基础组件',0,1,NULL,NULL,NULL,NULL,NULL,2,121,NULL,1,'0',NULL,NULL),(285,'服务注册中心',284,2,NULL,NULL,NULL,NULL,NULL,1,121,NULL,1,'0',NULL,NULL),(286,'配置中心',284,2,NULL,NULL,NULL,NULL,NULL,2,121,NULL,1,'0',NULL,NULL),(287,'负载均衡',284,2,NULL,NULL,NULL,NULL,NULL,3,121,NULL,1,'0',NULL,NULL),(288,'远程调用',284,2,NULL,NULL,NULL,NULL,NULL,4,121,NULL,1,'0',NULL,NULL),(289,'熔断降级',284,2,NULL,NULL,NULL,NULL,NULL,5,121,NULL,1,'0',NULL,NULL);
/*!40000 ALTER TABLE `teachplan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachplan_media`
--

DROP TABLE IF EXISTS `teachplan_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachplan_media` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `media_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '媒资文件id',
  `teachplan_id` bigint NOT NULL COMMENT '课程计划标识',
  `course_id` bigint NOT NULL COMMENT '课程标识',
  `media_fileName` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '媒资文件原始名称',
  `create_date` datetime DEFAULT NULL,
  `create_people` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `change_people` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachplan_media`
--

LOCK TABLES `teachplan_media` WRITE;
/*!40000 ALTER TABLE `teachplan_media` DISABLE KEYS */;
INSERT INTO `teachplan_media` (`id`, `media_id`, `teachplan_id`, `course_id`, `media_fileName`, `create_date`, `create_people`, `change_people`) VALUES (35,'23f83ae728bd1269eee7ea2236e79644',149,82,'16-Nacos配置管理-课程总结.avi','2022-09-15 08:02:26',NULL,NULL),(38,'3a5a861d1c745d05166132c47b44f9e4',147,82,'01-Nacos配置管理-内容介绍.avi','2022-09-15 08:02:55',NULL,NULL),(40,'3a5a861d1c745d05166132c47b44f9e4',269,117,'01-Nacos配置管理-内容介绍.avi','2022-10-04 19:04:45',NULL,NULL),(41,'23f83ae728bd1269eee7ea2236e79644',270,117,'16-Nacos配置管理-课程总结.avi','2022-10-04 19:04:55',NULL,NULL),(42,'3a5a861d1c745d05166132c47b44f9e4',271,117,'01-Nacos配置管理-内容介绍.avi','2022-10-04 19:05:03',NULL,NULL),(43,'3a5a861d1c745d05166132c47b44f9e4',272,117,'01-Nacos配置管理-内容介绍.avi','2022-10-04 19:05:10',NULL,NULL),(44,'23f83ae728bd1269eee7ea2236e79644',273,117,'16-Nacos配置管理-课程总结.avi','2022-10-04 19:05:14',NULL,NULL),(45,'1f229319d6fed3431d2f9d06193a433b',275,117,'01-分布式事务专题课程介绍.avi','2022-10-04 19:05:22',NULL,NULL),(46,'6ad24a762f67c18f61966c1b8c55abe6',276,117,'07-分布式事务基础理论-BASE理论.avi','2022-10-04 19:05:27',NULL,NULL),(47,'1f229319d6fed3431d2f9d06193a433b',277,117,'01-分布式事务专题课程介绍.avi','2022-10-04 19:05:31',NULL,NULL),(48,'6ad24a762f67c18f61966c1b8c55abe6',278,117,'07-分布式事务基础理论-BASE理论.avi','2022-10-04 19:05:35',NULL,NULL),(49,'18f919e23bedab97a78762c4875addc4',280,18,'垂直分库-插入和查询测试.avi','2022-12-15 19:49:47',NULL,NULL),(51,'287cdd91c5d444e0752b626cbd95b41c',283,121,'nacos01.mp4','2023-02-09 11:13:27',NULL,NULL),(52,'1f229319d6fed3431d2f9d06193a433b',285,121,'01-分布式事务专题课程介绍.avi','2023-02-09 11:13:34',NULL,NULL),(53,'18f919e23bedab97a78762c4875addc4',286,121,'垂直分库-插入和查询测试.avi','2023-02-09 11:33:03',NULL,NULL),(54,'1f229319d6fed3431d2f9d06193a433b',287,121,'01-分布式事务专题课程介绍.avi','2023-02-09 11:33:07',NULL,NULL),(55,'23f83ae728bd1269eee7ea2236e79644',288,121,'16-Nacos配置管理-课程总结.avi','2023-02-09 11:33:12',NULL,NULL),(56,'23f83ae728bd1269eee7ea2236e79644',289,121,'16-Nacos配置管理-课程总结.avi','2023-02-09 11:33:16',NULL,NULL),(57,'1f229319d6fed3431d2f9d06193a433b',282,121,'01-分布式事务专题课程介绍.avi','2023-02-09 11:45:52',NULL,NULL);
/*!40000 ALTER TABLE `teachplan_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachplan_work`
--

DROP TABLE IF EXISTS `teachplan_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachplan_work` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `work_id` bigint NOT NULL COMMENT '作业信息标识',
  `work_title` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '作业标题',
  `teachplan_id` bigint NOT NULL COMMENT '课程计划标识',
  `course_id` bigint DEFAULT NULL COMMENT '课程标识',
  `create_date` datetime DEFAULT NULL,
  `course_pub_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachplan_work`
--

LOCK TABLES `teachplan_work` WRITE;
/*!40000 ALTER TABLE `teachplan_work` DISABLE KEYS */;
INSERT INTO `teachplan_work` (`id`, `work_id`, `work_title`, `teachplan_id`, `course_id`, `create_date`, `course_pub_id`) VALUES (12,8,'测试作业1',138,79,'2021-12-27 10:35:15',NULL),(13,8,'测试作业1',144,80,'2021-12-27 11:09:20',NULL),(14,8,'测试作业1',129,78,'2021-12-27 11:15:04',NULL),(15,8,'测试作业1',147,82,'2021-12-27 11:28:28',NULL),(17,8,'测试作业1',155,83,'2021-12-27 12:22:55',NULL),(18,8,'测试作业1',160,84,'2021-12-27 13:43:42',NULL),(19,24,'最终测试',165,85,'2021-12-27 15:55:17',NULL),(21,8,'测试作业1',135,76,'2021-12-27 16:06:23',NULL),(22,24,'最终测试',166,85,'2021-12-27 16:09:17',NULL),(23,24,'最终测试',173,86,'2021-12-27 20:02:03',NULL),(24,8,'测试作业1',174,86,'2021-12-27 20:02:34',NULL),(25,8,'测试作业1',177,86,'2021-12-27 20:03:03',NULL),(26,8,'测试作业1',180,87,'2021-12-27 20:14:25',NULL),(27,20,'测试作业',181,87,'2021-12-27 20:14:36',NULL),(28,8,'测试作业1',184,88,'2021-12-27 20:15:05',NULL),(29,8,'测试作业1',192,90,'2021-12-27 20:27:33',NULL),(30,8,'测试作业1',196,91,'2021-12-27 20:35:41',NULL),(31,24,'最终测试',200,92,'2021-12-27 20:53:50',NULL),(32,24,'最终测试',201,92,'2021-12-27 20:54:06',NULL),(33,25,'小母猪',207,93,'2021-12-27 23:23:38',NULL),(34,26,'小母牛',208,93,'2021-12-27 23:23:48',NULL),(35,24,'最终测试',214,94,'2021-12-27 23:48:28',NULL),(36,25,'小母猪',215,94,'2021-12-27 23:48:36',NULL),(37,26,'小母牛',216,94,'2021-12-27 23:48:44',NULL),(39,29,'真最终测试',222,95,'2021-12-28 02:08:28',NULL),(40,8,'测试作业1',221,95,'2021-12-28 02:08:36',NULL),(41,8,'测试作业1',226,96,'2021-12-28 03:11:04',NULL),(42,32,'项目展示',233,97,'2021-12-28 03:37:11',NULL),(43,20,'测试作业',235,97,'2021-12-28 03:39:08',NULL),(44,32,'项目展示',236,97,'2021-12-28 03:40:56',NULL);
/*!40000 ALTER TABLE `teachplan_work` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-09 16:46:23
