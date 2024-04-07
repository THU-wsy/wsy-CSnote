-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 192.168.101.65    Database: xc148_system
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
-- Table structure for table `dictionary`
--

DROP TABLE IF EXISTS `dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dictionary` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id标识',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据字典名称',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据字典代码',
  `item_values` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '数据字典项--json格式\n  ',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `tb_code_unique` (`code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='数据字典';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dictionary`
--

LOCK TABLES `dictionary` WRITE;
/*!40000 ALTER TABLE `dictionary` DISABLE KEYS */;
INSERT INTO `dictionary` (`id`, `name`, `code`, `item_values`) VALUES (12,'公共属性类型','000','[{\"code\":\"1\",\"codeInt\":1,\"desc\":\"使用态\"},{\"code\":\"0\",\"codeInt\":0,\"desc\":\"删除态\"},{\"code\":\"-1\",\"codeInt\":-1,\"desc\":\"暂时态\"}]'),(13,'对象的审核状态','002','[{\"code\":\"002001\",\"desc\":\"审核未通过\"},{\"code\":\"002002\",\"desc\":\"未审核\"},{\"code\":\"002003\",\"desc\":\"审核通过\"}]'),(14,'资源类型','001','[{\"code\":\"001001\",\"desc\":\"图片\"},{\"code\":\"001002\",\"desc\":\"视频\"},{\"code\":\"001003\",\"desc\":\"其它\"}]'),(15,'课程审核状态','202','[{\"code\":\"202001\",\"desc\":\"审核未通过\"},{\"code\":\"202002\",\"desc\":\"未提交\"},{\"code\":\"202003\",\"desc\":\"已提交\"},{\"code\":\"202004\",\"desc\":\"审核通过\"}]'),(16,'课程收费情况','201','[{\"code\":\"201000\",\"desc\":\"免费\"},{\"code\":\"201001\",\"desc\":\"收费\"}]'),(17,'课程等级','204','[{\"code\":\"204001\",\"desc\":\"初级\"},{\"code\":\"204002\",\"desc\":\"中级\"},{\"code\":\"204003\",\"desc\":\"高级\"}]'),(18,'课程模式状态','200','[{\"code\":\"200002\",\"desc\":\"录播\"},{\"code\":\"200003\",\"desc\":\"直播\"}]'),(19,'课程发布状态','203','[{\"code\":\"203001\",\"desc\":\"未发布\"},{\"code\":\"203002\",\"desc\":\"已发布\"},{\"code\":\"203003\",\"desc\":\"下线\"}]'),(20,'订单交易类型状态','600','[{\"code\":\"600001\",\"desc\":\"未支付\"},{\"code\":\"600002\",\"desc\":\"已支付\"},{\"code\":\"600003\",\"desc\":\"已关闭\"},{\"code\":\"600004\",\"desc\":\"已退款\"},{\"code\":\"600005\",\"desc\":\"已完成\"}]'),(21,'课程作业记录审批状态','306','[{\"code\":\"306001\",\"desc\":\"未提交\"},{\"code\":\"306002\",\"desc\":\"待批改\"},{\"code\":\"306003\",\"desc\":\"已批改\"}]'),(22,'消息通知状态','003','[{\"code\":\"003001\",\"desc\":\"未通知\"},{\"code\":\"003002\",\"desc\":\"成功\"}]'),(23,'支付记录交易状态','601','[{\"code\":\"601001\",\"desc\":\"未支付\"},{\"code\":\"601002\",\"desc\":\"已支付\"},{\"code\":\"601003\",\"desc\":\"已退款\"}]'),(24,'业务订单类型','602','[{\"code\":\"60201\",\"desc\":\"购买课程\"},{\"code\":\"60202\",\"desc\":\"学习资料\"}]'),(25,'第三方支付渠道编号','603','[{\"code\":\"603001\",\"desc\":\"微信支付\"},{\"code\":\"603002\",\"desc\":\"支付宝\"}]'),(26,'选课类型','700','[{\"code\":\"700001\",\"desc\":\"免费课程\"},{\"code\":\"700002\",\"desc\":\"收费课程\"}]'),(27,'选课状态','701','[{\"code\":\"701001\",\"desc\":\"选课成功\"},{\"code\":\"701002\",\"desc\":\"待支付\"}]'),(28,'选课学习资格','702','[{\"code\":\"702001\",\"desc\":\"正常学习\"},{\"code\":\"702002\",\"desc\":\"没有选课或选课后没有支付\"},{\"code\":\"702003\",\"desc\":\"已过期需要申请续期或重新支付\"}]');
/*!40000 ALTER TABLE `dictionary` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-09 16:52:00
