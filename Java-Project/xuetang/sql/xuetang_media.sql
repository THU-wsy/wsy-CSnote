-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 192.168.101.65    Database: xc148_media
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
-- Table structure for table `media_files`
--

DROP TABLE IF EXISTS `media_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_files` (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件id,md5值',
  `company_id` bigint DEFAULT NULL COMMENT '机构ID',
  `company_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '机构名称',
  `filename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件名称',
  `file_type` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件类型（图片、文档，视频）',
  `tags` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标签',
  `bucket` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '存储目录',
  `file_path` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '存储路径',
  `file_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件id',
  `url` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '媒资文件访问地址',
  `username` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '上传人',
  `create_date` datetime DEFAULT NULL COMMENT '上传时间',
  `change_date` datetime DEFAULT NULL COMMENT '修改时间',
  `status` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '1' COMMENT '状态,1:正常，0:不展示',
  `remark` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `audit_status` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '审核状态',
  `audit_mind` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '审核意见',
  `file_size` bigint DEFAULT NULL COMMENT '文件大小',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unique_fileid` (`file_id`) USING BTREE COMMENT '文件id唯一索引 '
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='媒资信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_files`
--

LOCK TABLES `media_files` WRITE;
/*!40000 ALTER TABLE `media_files` DISABLE KEYS */;
INSERT INTO `media_files` (`id`, `company_id`, `company_name`, `filename`, `file_type`, `tags`, `bucket`, `file_path`, `file_id`, `url`, `username`, `create_date`, `change_date`, `status`, `remark`, `audit_status`, `audit_mind`, `file_size`) VALUES ('1137f04b2f44d1b2c37bcb73608864da',1232141425,NULL,'course29943168382846755.html','001003',NULL,'mediafiles','course/18.html','1137f04b2f44d1b2c37bcb73608864da',NULL,NULL,'2022-12-18 12:21:32',NULL,'1',NULL,'002003',NULL,34210),('1580180577525002241',1232141425,NULL,'1.jpg','001003',NULL,'mediafiles',NULL,'8383a8c2c1d098fcc07da7d6e79ae31e','/mediafiles/2022/10/12/8383a8c2c1d098fcc07da7d6e79ae31e.jpg',NULL,'2022-10-12 20:56:23',NULL,'1',NULL,NULL,NULL,5767),('18f919e23bedab97a78762c4875addc4',1232141425,NULL,'垂直分库-插入和查询测试.avi','001002','课程视频','video','1/8/18f919e23bedab97a78762c4875addc4/18f919e23bedab97a78762c4875addc4.avi','18f919e23bedab97a78762c4875addc4',NULL,NULL,'2022-12-15 09:45:18',NULL,'1',NULL,'002003',NULL,16305152),('1d0f0e6ed8a0c4a89bfd304b84599d9c',1232141425,NULL,'asset-icoGather.png','001001',NULL,'mediafiles','2022/09/20/1d0f0e6ed8a0c4a89bfd304b84599d9c.png','1d0f0e6ed8a0c4a89bfd304b84599d9c','/mediafiles/2022/09/20/1d0f0e6ed8a0c4a89bfd304b84599d9c.png',NULL,'2022-09-20 21:21:28',NULL,'1','','002003',NULL,8059),('1f229319d6fed3431d2f9d06193a433b',1232141425,NULL,'01-分布式事务专题课程介绍.avi','001002','课程视频','video','1/f/1f229319d6fed3431d2f9d06193a433b/1f229319d6fed3431d2f9d06193a433b.avi','1f229319d6fed3431d2f9d06193a433b','/video/1/f/1f229319d6fed3431d2f9d06193a433b/1f229319d6fed3431d2f9d06193a433b.mp4',NULL,'2022-09-14 18:30:02',NULL,'1','','002003',NULL,14705152),('23f83ae728bd1269eee7ea2236e79644',1232141425,NULL,'16-Nacos配置管理-课程总结.avi','001002','课程视频','video','2/3/23f83ae728bd1269eee7ea2236e79644/23f83ae728bd1269eee7ea2236e79644.avi','23f83ae728bd1269eee7ea2236e79644','/video/2/3/23f83ae728bd1269eee7ea2236e79644/23f83ae728bd1269eee7ea2236e79644.mp4',NULL,'2022-09-14 18:21:44',NULL,'1','','002003',NULL,26053632),('287cdd91c5d444e0752b626cbd95b41c',1232141425,NULL,'nacos01.mp4','001002','课程视频','video','2/8/287cdd91c5d444e0752b626cbd95b41c/287cdd91c5d444e0752b626cbd95b41c.mp4','287cdd91c5d444e0752b626cbd95b41c','/video/2/8/287cdd91c5d444e0752b626cbd95b41c/287cdd91c5d444e0752b626cbd95b41c.mp4',NULL,'2022-09-14 18:28:43',NULL,'1','','002003',NULL,25953447),('33c643206bb7c08e2cb99b622d7a1b63',1232141425,NULL,'1.png','001001',NULL,'mediafiles','2022/10/07/33c643206bb7c08e2cb99b622d7a1b63.png','33c643206bb7c08e2cb99b622d7a1b63','/mediafiles/2022/10/07/33c643206bb7c08e2cb99b622d7a1b63.png',NULL,'2022-10-07 06:20:05',NULL,'1','','002003',NULL,169788),('345db593849aada5675ed1e438650eeb',1232141425,NULL,'1.png','001001',NULL,'mediafiles','2022/10/07/345db593849aada5675ed1e438650eeb.png','345db593849aada5675ed1e438650eeb','/mediafiles/2022/10/07/345db593849aada5675ed1e438650eeb.png',NULL,'2022-10-07 09:31:46',NULL,'1','','002003',NULL,70171),('3a5a861d1c745d05166132c47b44f9e4',1232141425,NULL,'01-Nacos配置管理-内容介绍.avi','001002','课程视频','video','3/a/3a5a861d1c745d05166132c47b44f9e4/3a5a861d1c745d05166132c47b44f9e4.avi','3a5a861d1c745d05166132c47b44f9e4','/video/3/a/3a5a861d1c745d05166132c47b44f9e4/3a5a861d1c745d05166132c47b44f9e4.mp4',NULL,'2022-09-14 18:19:24',NULL,'1','','002003',NULL,23839232),('3fb1d9a565cb92f395f384bd62ef24cd',1232141425,NULL,'1614759607876_0.png','001001','课程图片','mediafiles','2022/09/20/3fb1d9a565cb92f395f384bd62ef24cd.png','3fb1d9a565cb92f395f384bd62ef24cd','/mediafiles/2022/09/20/3fb1d9a565cb92f395f384bd62ef24cd.png',NULL,'2022-09-20 21:06:11',NULL,'1','','002003',NULL,58873),('500598cae139f77c1bb54459909e0443',1232141425,NULL,'course8561649859933456434.html','001003',NULL,'mediafiles','course/119.html','500598cae139f77c1bb54459909e0443','/mediafiles/course/119.html',NULL,'2022-10-07 09:39:49',NULL,'1','','002003',NULL,35652),('538bd3d652593b8df70d84e643b12842',1232141425,NULL,'course6941513291436463735.html','001003',NULL,'mediafiles','course/121.html','538bd3d652593b8df70d84e643b12842',NULL,NULL,'2023-02-09 11:33:18',NULL,'1',NULL,'002003',NULL,36292),('5878a684ee9a36daae5d0741aaca0747',1232141425,NULL,'Spring Security集成测试','001002',NULL,'video','5/8/5878a684ee9a36daae5d0741aaca0747/5878a684ee9a36daae5d0741aaca0747.avi','5878a684ee9a36daae5d0741aaca0747',NULL,NULL,'2022-10-16 15:30:17',NULL,'1',NULL,'002003',NULL,NULL),('6ad24a762f67c18f61966c1b8c55abe6',1232141425,NULL,'07-分布式事务基础理论-BASE理论.avi','001002','课程视频','video','6/a/6ad24a762f67c18f61966c1b8c55abe6/6ad24a762f67c18f61966c1b8c55abe6.avi','6ad24a762f67c18f61966c1b8c55abe6','/video/6/a/6ad24a762f67c18f61966c1b8c55abe6/6ad24a762f67c18f61966c1b8c55abe6.mp4',NULL,'2022-09-14 18:30:16',NULL,'1','','002003',NULL,13189632),('70a98b4a2fffc89e50b101f959cc33ca',1232141425,NULL,'22-Hmily实现TCC事务-开发bank2的confirm方法.avi','001002','课程视频','video','7/0/70a98b4a2fffc89e50b101f959cc33ca/70a98b4a2fffc89e50b101f959cc33ca.avi','70a98b4a2fffc89e50b101f959cc33ca','/video/7/0/70a98b4a2fffc89e50b101f959cc33ca/70a98b4a2fffc89e50b101f959cc33ca.mp4',NULL,'2022-09-14 18:30:52',NULL,'1','','002003',NULL,18444288),('74b386417bb9f3764009dc94068a5e44',1232141425,NULL,'test2.html','001003',NULL,'mediafiles','course/74b386417bb9f3764009dc94068a5e44.html','74b386417bb9f3764009dc94068a5e44','/mediafiles/course/74b386417bb9f3764009dc94068a5e44.html',NULL,'2022-09-20 21:56:02',NULL,'1','','002003',NULL,40124),('757891eae4473e7ba78827656b1ccacf',1232141425,NULL,'studyuser.png','001001',NULL,'mediafiles',NULL,'757891eae4473e7ba78827656b1ccacf','/mediafiles/2022/10/13/757891eae4473e7ba78827656b1ccacf.png',NULL,'2022-10-13 19:57:01',NULL,'1',NULL,'002003',NULL,4922),('8026f17cf7b8697eccec2c8406d0c96c',1232141425,NULL,'nacos.png','001001',NULL,'mediafiles','2022/10/04/8026f17cf7b8697eccec2c8406d0c96c.png','8026f17cf7b8697eccec2c8406d0c96c','/mediafiles/2022/10/04/8026f17cf7b8697eccec2c8406d0c96c.png',NULL,'2022-10-04 18:55:01',NULL,'1','','002003',NULL,128051),('809694a6a974c35e3a36f36850837d7c',1232141425,NULL,'1.avi','001002','课程视频','video',NULL,'809694a6a974c35e3a36f36850837d7c','/video/8/0/809694a6a974c35e3a36f36850837d7c/809694a6a974c35e3a36f36850837d7c.avi',NULL,'2022-10-13 21:27:14',NULL,'1','','002003',NULL,NULL),('81d7ed5153316f5774885d3b4c07d8bc',1232141425,NULL,'Spring Security快速上手-创建工程.avi','001002','课程视频','video','8/1/81d7ed5153316f5774885d3b4c07d8bc/81d7ed5153316f5774885d3b4c07d8bc.avi','81d7ed5153316f5774885d3b4c07d8bc',NULL,NULL,'2022-12-15 09:41:50',NULL,'1',NULL,'002003',NULL,19945472),('9b0a355a0a954fdb3671998b4b016474',1232141425,NULL,'test.html','001003',NULL,'mediafiles','course/test.html','9b0a355a0a954fdb3671998b4b016474',NULL,NULL,'2022-12-17 17:04:40',NULL,'1',NULL,'002003',NULL,34174),('a16da7a132559daf9e1193166b3e7f52',1232141425,NULL,'1.jpg','001003',NULL,'mediafiles','2022/09/20/a16da7a132559daf9e1193166b3e7f52.jpg','a16da7a132559daf9e1193166b3e7f52','/mediafiles/2022/09/20/a16da7a132559daf9e1193166b3e7f52.jpg',NULL,'2022-09-20 21:26:08',NULL,'1','','002003',NULL,248329),('a61805e1360ab946def5471aaefc0a98',1232141425,NULL,'teacherpic.jpg','001001',NULL,'mediafiles','2022/12/18/a61805e1360ab946def5471aaefc0a98.jpg','a61805e1360ab946def5471aaefc0a98','/mediafiles/2022/12/18/a61805e1360ab946def5471aaefc0a98.jpg',NULL,'2022-12-18 12:10:52',NULL,'1',NULL,'002003',NULL,11600),('a6fb4fc7faf1d3d0831819969529b888',1232141425,NULL,'1.项目背景.mp4','001002','课程视频','video',NULL,'a6fb4fc7faf1d3d0831819969529b888','/video/a/6/a6fb4fc7faf1d3d0831819969529b888/a6fb4fc7faf1d3d0831819969529b888.mp4',NULL,'2022-10-13 21:30:17',NULL,'1','','002003',NULL,NULL),('b2deb4a098bb12653c57bbaa0099697a',1232141425,NULL,'course3448922126748441722.html','001003',NULL,'mediafiles','course/117.html','b2deb4a098bb12653c57bbaa0099697a','/mediafiles/course/117.html',NULL,'2022-10-04 19:20:01',NULL,'1','','002003',NULL,37705),('c051fe97e672dd399902a90f4ac67962',1232141425,NULL,'widget-3.jpg','001001',NULL,'mediafiles','2022/12/18/c051fe97e672dd399902a90f4ac67962.jpg','c051fe97e672dd399902a90f4ac67962','/mediafiles/2022/12/18/c051fe97e672dd399902a90f4ac67962.jpg',NULL,'2022-12-18 12:02:29',NULL,'1',NULL,'002003',NULL,62469),('ca1d75b0a37b85fafd5f2e443f6f3f01',1232141425,NULL,'course2996275631019924973.html','001003',NULL,'mediafiles','course/118.html','ca1d75b0a37b85fafd5f2e443f6f3f01','/mediafiles/course/118.html',NULL,'2022-10-07 06:40:51',NULL,'1','','002003',NULL,35905),('d4af959873182feb0fdb91dc6c1958b5',1232141425,NULL,'widget-5.png','001001','课程图片','mediafiles','2022/09/18/d4af959873182feb0fdb91dc6c1958b5.png','d4af959873182feb0fdb91dc6c1958b5','/mediafiles/2022/09/18/d4af959873182feb0fdb91dc6c1958b5.png',NULL,'2022-09-18 21:49:55',NULL,'1','','002003',NULL,17799),('db4e24f27d78ccac14401b7479b35c26',1232141425,NULL,'nonepic.jpg','001001',NULL,'mediafiles','2022/09/23/db4e24f27d78ccac14401b7479b35c26.jpg','db4e24f27d78ccac14401b7479b35c26','/mediafiles/2022/09/23/db4e24f27d78ccac14401b7479b35c26.jpg',NULL,'2022-09-23 18:27:26',NULL,'1','','002003',NULL,6919),('df39983fcad83a6ceef14bfeeb1bc523',1232141425,NULL,'add.jpg','001001',NULL,'mediafiles','2022/09/20/df39983fcad83a6ceef14bfeeb1bc523.jpg','df39983fcad83a6ceef14bfeeb1bc523','/mediafiles/2022/09/20/df39983fcad83a6ceef14bfeeb1bc523.jpg',NULL,'2022-09-20 21:13:59',NULL,'1','','002003',NULL,10487),('e00ce88f53cc391d9ffd51a81834d2af',1232141425,NULL,'widget-1.jpg','001001','课程图片','mediafiles','2022/09/18/e00ce88f53cc391d9ffd51a81834d2af.jpg','e00ce88f53cc391d9ffd51a81834d2af','/mediafiles/2022/09/18/e00ce88f53cc391d9ffd51a81834d2af.jpg',NULL,'2022-09-18 21:48:50',NULL,'1','','002003',NULL,71386),('e726b71ba99c70e8c9d2850c2a7019d7',1232141425,NULL,'asset-login_img.jpg','001001',NULL,'mediafiles','2022/09/20/e726b71ba99c70e8c9d2850c2a7019d7.jpg','e726b71ba99c70e8c9d2850c2a7019d7','/mediafiles/2022/09/20/e726b71ba99c70e8c9d2850c2a7019d7.jpg',NULL,'2022-09-20 21:44:50',NULL,'1','','002003',NULL,22620),('ef29eb93515e32f2d897956d5d914db7',1232141425,NULL,'Snipaste_2023-02-09_11-06-52.png','001001',NULL,'mediafiles','2023/02/09/ef29eb93515e32f2d897956d5d914db7.png','ef29eb93515e32f2d897956d5d914db7','/mediafiles/2023/02/09/ef29eb93515e32f2d897956d5d914db7.png',NULL,'2023-02-09 11:07:02',NULL,'1',NULL,'002003',NULL,327814),('efd2eacc4485946fc27feb0caef7506c',1232141425,NULL,'读写分离-理解读写分离.avi','001002','课程视频','video','e/f/efd2eacc4485946fc27feb0caef7506c/efd2eacc4485946fc27feb0caef7506c.avi','efd2eacc4485946fc27feb0caef7506c',NULL,NULL,'2022-12-15 09:45:19',NULL,'1',NULL,'002003',NULL,14879232),('fbb57de7001cccf1e28fbe34c7506ddc',1232141425,NULL,'asset-logo.png','001001',NULL,'mediafiles','2022/09/20/fbb57de7001cccf1e28fbe34c7506ddc.png','fbb57de7001cccf1e28fbe34c7506ddc','/mediafiles/2022/09/20/fbb57de7001cccf1e28fbe34c7506ddc.png',NULL,'2022-09-20 21:55:25',NULL,'1','','002003',NULL,4355);
/*!40000 ALTER TABLE `media_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_process`
--

DROP TABLE IF EXISTS `media_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_process` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file_id` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件标识',
  `filename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件名称',
  `bucket` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '存储桶',
  `file_path` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '存储路径',
  `status` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态,1:未处理，2：处理成功  3处理失败',
  `create_date` datetime NOT NULL COMMENT '上传时间',
  `finish_date` datetime DEFAULT NULL COMMENT '完成时间',
  `fail_count` int DEFAULT 0 COMMENT '失败次数',
  `url` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '媒资文件访问地址',
  `errormsg` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '失败原因',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unique_fileid` (`file_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_process`
--

LOCK TABLES `media_process` WRITE;
/*!40000 ALTER TABLE `media_process` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_process_history`
--

DROP TABLE IF EXISTS `media_process_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_process_history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file_id` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件标识',
  `filename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件名称',
  `bucket` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '存储源',
  `status` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态,1:未处理，2：处理成功  3处理失败',
  `create_date` datetime NOT NULL COMMENT '上传时间',
  `finish_date` datetime NOT NULL COMMENT '完成时间',
  `url` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '媒资文件访问地址',
  `fail_count` int DEFAULT 0 COMMENT '失败次数',
  `file_path` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件路径',
  `errormsg` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '失败原因',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_process_history`
--

LOCK TABLES `media_process_history` WRITE;
/*!40000 ALTER TABLE `media_process_history` DISABLE KEYS */;
INSERT INTO `media_process_history` (`id`, `file_id`, `filename`, `bucket`, `status`, `create_date`, `finish_date`, `url`, `file_path`, `errormsg`) VALUES (1,'81d7ed5153316f5774885d3b4c07d8bc','Spring Security快速上手-创建工程.avi','video','2','2022-12-15 09:41:50','2022-12-15 10:30:26','/video/8/1/81d7ed5153316f5774885d3b4c07d8bc/81d7ed5153316f5774885d3b4c07d8bc.mp4','8/1/81d7ed5153316f5774885d3b4c07d8bc/81d7ed5153316f5774885d3b4c07d8bc.avi',NULL),(2,'18f919e23bedab97a78762c4875addc4','垂直分库-插入和查询测试.avi','video','2','2022-12-15 09:45:18','2022-12-15 10:30:11','/video/1/8/18f919e23bedab97a78762c4875addc4/18f919e23bedab97a78762c4875addc4.mp4','1/8/18f919e23bedab97a78762c4875addc4/18f919e23bedab97a78762c4875addc4.avi',NULL),(3,'efd2eacc4485946fc27feb0caef7506c','读写分离-理解读写分离.avi','video','2','2022-12-15 09:45:19','2022-12-15 10:31:04','/video/e/f/efd2eacc4485946fc27feb0caef7506c/efd2eacc4485946fc27feb0caef7506c.mp4','e/f/efd2eacc4485946fc27feb0caef7506c/efd2eacc4485946fc27feb0caef7506c.avi',NULL);
/*!40000 ALTER TABLE `media_process_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mq_message`
--

DROP TABLE IF EXISTS `mq_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mq_message` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息id',
  `message_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息类型代码',
  `business_key1` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '关联业务信息',
  `business_key2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '关联业务信息',
  `business_key3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '关联业务信息',
  `mq_host` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息队列主机',
  `mq_port` int NOT NULL COMMENT '消息队列端口',
  `mq_virtualhost` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息队列虚拟主机',
  `mq_queue` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '队列名称',
  `inform_num` int unsigned NOT NULL COMMENT '通知次数',
  `state` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '处理状态，0:初始，1:成功',
  `returnfailure_date` datetime DEFAULT NULL COMMENT '回复失败时间',
  `returnsuccess_date` datetime DEFAULT NULL COMMENT '回复成功时间',
  `returnfailure_msg` varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '回复失败内容',
  `inform_date` datetime DEFAULT NULL COMMENT '最近通知时间',
  `stage_state1` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '阶段1处理状态, 0:初始，1:成功',
  `stage_state2` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '阶段2处理状态, 0:初始，1:成功',
  `stage_state3` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '阶段3处理状态, 0:初始，1:成功',
  `stage_state4` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '阶段4处理状态, 0:初始，1:成功',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mq_message`
--

LOCK TABLES `mq_message` WRITE;
/*!40000 ALTER TABLE `mq_message` DISABLE KEYS */;
INSERT INTO `mq_message` (`id`, `message_type`, `business_key1`, `business_key2`, `business_key3`, `mq_host`, `mq_port`, `mq_virtualhost`, `mq_queue`, `inform_num`, `state`, `returnfailure_date`, `returnsuccess_date`, `returnfailure_msg`, `inform_date`, `stage_state1`, `stage_state2`, `stage_state3`, `stage_state4`) VALUES ('f29a3149-7429-40be-8a4e-9909f32003b0','xc.mq.msgsync.coursepub','111',NULL,NULL,'127.0.0.1',5607,'/','xc.course.publish.queue',0,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `mq_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mq_message_history`
--

DROP TABLE IF EXISTS `mq_message_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mq_message_history` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息id',
  `message_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息类型代码',
  `business_key1` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '关联业务信息',
  `business_key2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '关联业务信息',
  `business_key3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '关联业务信息',
  `mq_host` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息队列主机',
  `mq_port` int NOT NULL COMMENT '消息队列端口',
  `mq_virtualhost` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息队列虚拟主机',
  `mq_queue` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '队列名称',
  `inform_num` int(10) unsigned zerofill DEFAULT NULL COMMENT '通知次数',
  `state` int(10) unsigned zerofill DEFAULT NULL COMMENT '处理状态，0:初始，1:成功，2:失败',
  `returnfailure_date` datetime DEFAULT NULL COMMENT '回复失败时间',
  `returnsuccess_date` datetime DEFAULT NULL COMMENT '回复成功时间',
  `returnfailure_msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '回复失败内容',
  `inform_date` datetime DEFAULT NULL COMMENT '最近通知时间',
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
/*!40000 ALTER TABLE `mq_message_history` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-09 16:51:35
