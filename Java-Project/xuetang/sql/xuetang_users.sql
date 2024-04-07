-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 192.168.101.65    Database: xc148_users
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
-- Table structure for table `oauth_access_token`
--

DROP TABLE IF EXISTS `oauth_access_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_access_token` (
  `token_id` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `token` blob,
  `authentication_id` varchar(48) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_name` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `client_id` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `authentication` blob,
  `refresh_token` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`authentication_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_token`
--

LOCK TABLES `oauth_access_token` WRITE;
/*!40000 ALTER TABLE `oauth_access_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_access_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_approvals`
--

DROP TABLE IF EXISTS `oauth_approvals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_approvals` (
  `userId` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `clientId` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `scope` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `expiresAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lastModifiedAt` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_approvals`
--

LOCK TABLES `oauth_approvals` WRITE;
/*!40000 ALTER TABLE `oauth_approvals` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_approvals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_client_details`
--

DROP TABLE IF EXISTS `oauth_client_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_client_details` (
  `client_id` varchar(48) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `resource_ids` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `client_secret` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `scope` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `authorized_grant_types` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `web_server_redirect_uri` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `authorities` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `access_token_validity` int DEFAULT NULL,
  `refresh_token_validity` int DEFAULT NULL,
  `additional_information` varchar(4096) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `autoapprove` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`client_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_client_details`
--

LOCK TABLES `oauth_client_details` WRITE;
/*!40000 ALTER TABLE `oauth_client_details` DISABLE KEYS */;
INSERT INTO `oauth_client_details` (`client_id`, `resource_ids`, `client_secret`, `scope`, `authorized_grant_types`, `web_server_redirect_uri`, `authorities`, `access_token_validity`, `refresh_token_validity`, `additional_information`, `autoapprove`) VALUES ('app',NULL,'app','app','password,refresh_token',NULL,NULL,NULL,NULL,NULL,NULL),('XcWebApp',NULL,'XcWebApp','app','authorization_code,password,refresh_token,client_credentials',NULL,NULL,43200,43200,NULL,NULL);
/*!40000 ALTER TABLE `oauth_client_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_client_token`
--

DROP TABLE IF EXISTS `oauth_client_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_client_token` (
  `token_id` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `token` blob,
  `authentication_id` varchar(48) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_name` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `client_id` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`authentication_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_client_token`
--

LOCK TABLES `oauth_client_token` WRITE;
/*!40000 ALTER TABLE `oauth_client_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_client_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_code`
--

DROP TABLE IF EXISTS `oauth_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_code` (
  `code` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `authentication` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_code`
--

LOCK TABLES `oauth_code` WRITE;
/*!40000 ALTER TABLE `oauth_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_token`
--

DROP TABLE IF EXISTS `oauth_refresh_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_refresh_token` (
  `token_id` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `token` blob,
  `authentication` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_token`
--

LOCK TABLES `oauth_refresh_token` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_token` DISABLE KEYS */;
INSERT INTO `oauth_refresh_token` (`token_id`, `token`, `authentication`) VALUES ('b96e057b4e1c4920428e833db48d4c15',_binary '��\0sr\0Lorg.springframework.security.oauth2.common.DefaultExpiringOAuth2RefreshToken/�Gc��ɷ\0L\0\nexpirationt\0Ljava/util/Date;xr\0Dorg.springframework.security.oauth2.common.DefaultOAuth2RefreshTokens�\ncT�^\0L\0valuet\0Ljava/lang/String;xpt\0$b012d487-a908-43af-a8ef-53c5399c8bd6sr\0java.util.Datehj�KYt\0\0xpw\0\0a;tɎx',_binary '��\0sr\0Aorg.springframework.security.oauth2.provider.OAuth2Authentication�@bR\0L\0\rstoredRequestt\0<Lorg/springframework/security/oauth2/provider/OAuth2Request;L\0userAuthenticationt\02Lorg/springframework/security/core/Authentication;xr\0Gorg.springframework.security.authentication.AbstractAuthenticationTokenӪ(~nGd\0Z\0\rauthenticatedL\0authoritiest\0Ljava/util/Collection;L\0detailst\0Ljava/lang/Object;xp\0sr\0&java.util.Collections$UnmodifiableList�%1��\0L\0listt\0Ljava/util/List;xr\0,java.util.Collections$UnmodifiableCollectionB\0��^�\0L\0cq\0~\0xpsr\0java.util.ArrayListx����a�\0I\0sizexp\0\0\0	w\0\0\0	sr\0Borg.springframework.security.core.authority.SimpleGrantedAuthority\0\0\0\0\0\0�\0L\0rolet\0Ljava/lang/String;xpt\0\nROLE_adminsq\0~\0\rt\0apidocsq\0~\0\rt\0database/logsq\0~\0\rt\0systemsq\0~\0\rt\0user/addsq\0~\0\rt\0user/deletesq\0~\0\rt\0	user/editsq\0~\0\rt\0	user/viewsq\0~\0\rt\0userListxq\0~\0psr\0:org.springframework.security.oauth2.provider.OAuth2Request\0\0\0\0\0\0\0\0Z\0approvedL\0authoritiesq\0~\0L\0\nextensionst\0Ljava/util/Map;L\0redirectUriq\0~\0L\0refresht\0;Lorg/springframework/security/oauth2/provider/TokenRequest;L\0resourceIdst\0Ljava/util/Set;L\0\rresponseTypesq\0~\0$xr\08org.springframework.security.oauth2.provider.BaseRequest6(z>�qi�\0L\0clientIdq\0~\0L\0requestParametersq\0~\0\"L\0scopeq\0~\0$xpt\0webAppsr\0%java.util.Collections$UnmodifiableMap��t�B\0L\0mq\0~\0\"xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0\ngrant_typet\0passwordt\0usernamet\0adminxsr\0%java.util.Collections$UnmodifiableSet��я��U\0\0xq\0~\0	sr\0java.util.LinkedHashSet�l�Z��*\0\0xr\0java.util.HashSet�D�����4\0\0xpw\0\0\0?@\0\0\0\0\0t\0appxsq\0~\03w\0\0\0?@\0\0\0\0\0\0xsq\0~\0*?@\0\0\0\0\0\0w\0\0\0\0\0\0\0xppsq\0~\03w\0\0\0?@\0\0\0\0\0\0xsq\0~\03w\0\0\0?@\0\0\0\0\0\0xsr\0Oorg.springframework.security.authentication.UsernamePasswordAuthenticationToken\0\0\0\0\0\0�\0L\0credentialsq\0~\0L\0	principalq\0~\0xq\0~\0sq\0~\0sq\0~\0\0\0\0	w\0\0\0	q\0~\0q\0~\0q\0~\0q\0~\0q\0~\0q\0~\0q\0~\0q\0~\0q\0~\0xq\0~\0=sr\0java.util.LinkedHashMap4�N\\l��\0Z\0accessOrderxq\0~\0*?@\0\0\0\0\0w\0\0\0\0\0\0q\0~\0,q\0~\0-q\0~\0.q\0~\0/x\0psr\02org.springframework.security.core.userdetails.User\0\0\0\0\0\0�\0Z\0accountNonExpiredZ\0accountNonLockedZ\0credentialsNonExpiredZ\0enabledL\0authoritiesq\0~\0$L\0passwordq\0~\0L\0usernameq\0~\0xpsq\0~\00sr\0java.util.TreeSetݘP���[\0\0xpsr\0Forg.springframework.security.core.userdetails.User$AuthorityComparator\0\0\0\0\0\0�\0\0xpw\0\0\0	q\0~\0q\0~\0q\0~\0q\0~\0q\0~\0q\0~\0q\0~\0q\0~\0q\0~\0xpt\0admin');
/*!40000 ALTER TABLE `oauth_refresh_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xc_company`
--

DROP TABLE IF EXISTS `xc_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xc_company` (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `linkname` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系人名称',
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `mobile` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `intro` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '简介',
  `logo` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'logo',
  `identitypic` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '身份证照片',
  `worktype` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '工具性质',
  `businesspic` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '营业执照',
  `status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '企业状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xc_company`
--

LOCK TABLES `xc_company` WRITE;
/*!40000 ALTER TABLE `xc_company` DISABLE KEYS */;
INSERT INTO `xc_company` (`id`, `linkname`, `name`, `mobile`, `email`, `intro`, `logo`, `identitypic`, `worktype`, `businesspic`, `status`) VALUES ('1','张老师','传智播客','13333334444','abc@126.com','2006年创建！',NULL,NULL,NULL,NULL,NULL),('1232141425','M老师','传智教育','123456789','mm@qq.com',NULL,NULL,NULL,NULL,NULL,NULL),('2','李老师','博学谷','','',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `xc_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xc_company_user`
--

DROP TABLE IF EXISTS `xc_company_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xc_company_user` (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `company_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `xc_company_user_unique` (`company_id`,`user_id`) USING BTREE,
  KEY `FK_xc_company_user_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `FK_xc_company_user_company_id` FOREIGN KEY (`company_id`) REFERENCES `xc_company` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_xc_company_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `xc_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xc_company_user`
--

LOCK TABLES `xc_company_user` WRITE;
/*!40000 ALTER TABLE `xc_company_user` DISABLE KEYS */;
INSERT INTO `xc_company_user` (`id`, `company_id`, `user_id`) VALUES ('1','1','49'),('2','1232141425','52');
/*!40000 ALTER TABLE `xc_company_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xc_menu`
--

DROP TABLE IF EXISTS `xc_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xc_menu` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜单编码',
  `p_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父菜单ID',
  `menu_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '名称',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '请求地址',
  `is_menu` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否是菜单',
  `level` int DEFAULT NULL COMMENT '菜单层级',
  `sort` int DEFAULT NULL COMMENT '菜单排序',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `FK_CODE` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xc_menu`
--

LOCK TABLES `xc_menu` WRITE;
/*!40000 ALTER TABLE `xc_menu` DISABLE KEYS */;
INSERT INTO `xc_menu` (`id`, `code`, `p_id`, `menu_name`, `url`, `is_menu`, `level`, `sort`, `status`, `icon`, `create_time`, `update_time`) VALUES ('','xc_teachmanager_course_pic',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2022-09-28 08:35:25','2022-09-28 08:35:25'),('000000000000000000','root','0','系统根目录',NULL,'0',0,1,'1',NULL,'2022-09-28 08:35:25','2022-09-28 08:35:25'),('111111111111111111','xc_sysmanager','000000000000000000','系统管理',NULL,'1',1,10,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('222222222222222222','xc_teachmanager','000000000000000000','教学管理',NULL,'1',1,2,'1',NULL,'2022-09-28 08:35:25','2022-09-28 08:35:25'),('893288715881807872','xc_sysmanager_user','111111111111111111','用户管理',NULL,'1',2,1,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('893304960282787840','xc_sysmanager_user_add','893288715881807872','添加用户',NULL,'1',3,1,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('894396523532517376','xc_sysmanager_user_edit','893288715881807872','用户修改',NULL,'0',3,1,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('894473486712438784','xc_sysmanager_user_view','893288715881807872','用户列表',NULL,'1',3,2,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('894473651837992960','xc_sysmanager_user_delete','893288715881807872','用户删除',NULL,'0',3,4,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('894475142061621248','xc_sysmanager_role','111111111111111111','角色管理',NULL,'1',2,2,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('894475827880656896','xc_sysmanager_role_add','894475142061621248','角色添加',NULL,'0',3,1,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('894475985452269568','xc_sysmanager_role_edit','894475142061621248','角色编辑',NULL,'0',3,2,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('894476118730473472','xc_sysmanager_role_delete','894475142061621248','角色删除',NULL,'0',3,2,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('894476276402749440','xc_sysmanager_role_permission','894475142061621248','角色配权',NULL,'0',3,3,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('894476950951690240','xc_sysmanager_menu','111111111111111111','菜单管理',NULL,'1',2,2,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('894477107919323136','xc_sysmanager_menu_add','894476950951690240','菜单添加',NULL,'0',3,1,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('894477244926263296','xc_sysmanager_menu_edit','894476950951690240','菜单编辑',NULL,'0',3,2,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('894477420512411648','xc_sysmanager_menu_delete','894476950951690240','菜单删除',NULL,'0',3,2,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('894477851082883072','xc_sysmanager_doc','111111111111111111','文档查询',NULL,'1',2,9,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('894477995903811584','xc_sysmanager_log','111111111111111111','add',NULL,'1',2,10,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('894752734459199488','xc_sysmanager_company','111111111111111111','机构管理',NULL,'1',1,1,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('903459378655395840','xc_sysmanager_user_resetpwd','893288715881807872','密码重置',NULL,'1',3,2,'1','','2022-09-28 08:35:25','2022-09-28 08:35:25'),('903459378655395841','xc_teachmanager_course','222222222222222222','课程管理',NULL,'1',2,1,'1',NULL,'2022-09-28 08:35:25','2022-09-28 08:35:25'),('903459378655395842','xc_teachmanager_course_add','903459378655395841','添加课程',NULL,'1',3,1,'1',NULL,'2022-09-28 08:35:25','2022-09-28 08:35:25'),('903459378655395843','xc_teachmanager_course_del','903459378655395841','删除课程',NULL,NULL,NULL,NULL,NULL,NULL,'2022-09-28 08:35:25','2022-09-28 08:35:25'),('903459378655395845','xc_teachmanager_course_market','903459378655395841','编辑课程营销信息',NULL,NULL,NULL,NULL,NULL,NULL,'2022-09-28 08:35:25','2022-09-28 08:35:25'),('903459378655395846','xc_teachmanager_course_base','903459378655395841','编辑课程基础信息',NULL,NULL,NULL,NULL,NULL,NULL,'2022-09-28 08:35:25','2022-09-28 08:35:25'),('903459378655395847','xc_teachmanager_course_plan','903459378655395841','编辑课程计划',NULL,NULL,NULL,NULL,NULL,NULL,'2022-09-28 08:35:25','2022-09-28 08:35:25'),('903459378655395848','xc_teachmanager_course_publish','903459378655395841','发布课程',NULL,NULL,NULL,NULL,NULL,NULL,'2022-09-28 08:35:25','2022-09-28 08:35:25'),('903459378655395849','xc_teachmanager_course_list','903459378655395841','我的课程',NULL,NULL,NULL,NULL,NULL,NULL,'2022-09-28 08:35:25','2022-09-28 08:35:25'),('903459378655395850','course_find_list','903459378655395841','查询课程列表',NULL,NULL,NULL,NULL,'1',NULL,'2022-09-28 08:35:25','2022-09-28 08:35:25');
/*!40000 ALTER TABLE `xc_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xc_permission`
--

DROP TABLE IF EXISTS `xc_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xc_permission` (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `menu_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `xu_permission_unique` (`role_id`,`menu_id`) USING BTREE,
  KEY `fk_xc_permission_menu_id` (`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xc_permission`
--

LOCK TABLES `xc_permission` WRITE;
/*!40000 ALTER TABLE `xc_permission` DISABLE KEYS */;
INSERT INTO `xc_permission` (`id`, `role_id`, `menu_id`, `create_time`) VALUES ('11','20','222222222222222222','2022-09-28 08:34:56'),('12','20','903459378655395841','2022-09-28 08:34:56'),('13','20','903459378655395842','2022-09-28 08:34:56'),('14','20','903459378655395843','2022-09-28 08:34:56'),('15','20','903459378655395845','2022-09-28 08:34:56'),('16','20','903459378655395846','2022-09-28 08:34:56'),('17','20','903459378655395847','2022-09-28 08:34:56'),('18','20','903459378655395848','2022-09-28 08:34:56'),('19','20','903459378655395849','2022-09-28 08:34:56'),('89328714465778073617','17','111111111111111111','2022-09-28 08:34:56'),('8932871446577807366','6','111111111111111111','2022-09-28 08:34:56'),('8932871446577807367','6','903459378655395846','2022-09-28 08:34:56'),('8932871446577807368','8','111111111111111111','2022-09-28 08:34:56'),('8932887158818078726','6','893288715881807872','2022-09-28 08:34:56'),('8932887158818078728','8','893288715881807872','2022-09-28 08:34:56'),('8933049602827878406','6','893304960282787840','2022-09-28 08:34:56'),('8933049602827878408','8','893304960282787840','2022-09-28 08:34:56'),('8943965235325173766','6','894396523532517376','2022-09-28 08:34:56'),('8943965235325173768','8','894396523532517376','2022-09-28 08:34:56'),('8944734867124387846','6','894473486712438784','2022-09-28 08:34:56'),('8944734867124387848','8','894473486712438784','2022-09-28 08:34:56'),('8944736518379929606','6','894473651837992960','2022-09-28 08:34:56'),('8944736518379929608','8','894473651837992960','2022-09-28 08:34:56'),('8944751420616212488','8','894475142061621248','2022-09-28 08:34:56'),('8944758278806568968','8','894475827880656896','2022-09-28 08:34:56'),('8944759854522695688','8','894475985452269568','2022-09-28 08:34:56'),('8944761187304734728','8','894476118730473472','2022-09-28 08:34:56'),('8944762764027494408','8','894476276402749440','2022-09-28 08:34:56'),('8944769509516902408','8','894476950951690240','2022-09-28 08:34:56'),('8944771079193231368','8','894477107919323136','2022-09-28 08:34:56'),('8944772449262632968','8','894477244926263296','2022-09-28 08:34:56'),('8944774205124116488','8','894477420512411648','2022-09-28 08:34:56'),('89447785108288307217','17','894477851082883072','2022-09-28 08:34:56'),('8944778510828830726','6','894477851082883072','2022-09-28 08:34:56'),('8944778510828830728','8','894477851082883072','2022-09-28 08:34:56'),('89447799590381158417','17','894477995903811584','2022-09-28 08:34:56'),('8944779959038115846','6','894477995903811584','2022-09-28 08:34:56'),('8944779959038115848','8','894477995903811584','2022-09-28 08:34:56'),('89475273445919948817','17','894752734459199488','2022-09-28 08:34:56'),('8947527344591994888','8','894752734459199488','2022-09-28 08:34:56'),('8947692177635409926','6','903459378655395842','2022-09-28 08:34:56'),('8947692177635409930','6','903459378655395841','2022-09-28 08:34:56'),('903459378655395849','17','903459378655395849','2022-09-30 14:29:08');
/*!40000 ALTER TABLE `xc_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xc_role`
--

DROP TABLE IF EXISTS `xc_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xc_role` (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `role_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unique_role_name` (`role_name`) USING BTREE,
  UNIQUE KEY `unique_role_value` (`role_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xc_role`
--

LOCK TABLES `xc_role` WRITE;
/*!40000 ALTER TABLE `xc_role` DISABLE KEYS */;
INSERT INTO `xc_role` (`id`, `role_name`, `role_code`, `description`, `create_time`, `update_time`, `status`) VALUES ('17','学生','student',NULL,'2022-09-28 08:32:57','2022-09-28 08:32:57','1'),('18','老师','teacher',NULL,'2022-09-28 08:32:57','2022-09-28 08:32:57','1'),('20','教学管理员','teachmanager',NULL,'2022-09-28 08:32:57','2022-09-28 08:32:57','1'),('6','管理员','admin',NULL,'2022-09-28 08:32:57','2022-09-28 08:32:57','1'),('8','超级管理员','super',NULL,'2022-09-28 08:32:57','2022-09-28 08:32:57','1');
/*!40000 ALTER TABLE `xc_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xc_teacher`
--

DROP TABLE IF EXISTS `xc_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xc_teacher` (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '称呼',
  `intro` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '个人简介',
  `resume` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '个人简历',
  `pic` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '老师照片',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `xu_teacher_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `fk_xc_teacher_user_id` FOREIGN KEY (`user_id`) REFERENCES `xc_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xc_teacher`
--

LOCK TABLES `xc_teacher` WRITE;
/*!40000 ALTER TABLE `xc_teacher` DISABLE KEYS */;
/*!40000 ALTER TABLE `xc_teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xc_user`
--

DROP TABLE IF EXISTS `xc_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xc_user` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(96) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `salt` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `wx_unionid` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '微信unionid',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '昵称',
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userpic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '头像',
  `company_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `utype` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `birthday` datetime DEFAULT NULL,
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `cellphone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `qq` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户状态',
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unique_user_username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xc_user`
--

LOCK TABLES `xc_user` WRITE;
/*!40000 ALTER TABLE `xc_user` DISABLE KEYS */;
INSERT INTO `xc_user` (`id`, `username`, `password`, `salt`, `wx_unionid`, `nickname`, `name`, `userpic`, `company_id`, `utype`, `birthday`, `sex`, `email`, `cellphone`, `qq`, `status`, `create_time`, `update_time`) VALUES ('17b9d8be-cef3-400c-bec5-1478a6ef7ddc','o5PB1sytMXJGGv2x5OBP2uMzCpS8','o5PB1sytMXJGGv2x5OBP2uMzCpS8',NULL,'o5PB1sytMXJGGv2x5OBP2uMzCpS8','Mr.M','Mr.M','https://thirdwx.qlogo.cn/mmopen/vi_32/P8h3wxWDqCqfI0BmHxAYHEzppsaBp4xt7nscyiaQ2ZptEhzyKcEia7loT6pO6zExaM9FR7BnSguxqKYuIe5B3aEA/132',NULL,'101001',NULL,NULL,NULL,NULL,NULL,'1','2022-09-30 20:08:51',NULL),('46','super','$2a$10$TJ4TmCdK.X4wv/tCqHW14.w70U3CC33CeVncD3SLmyMXMknstqKRe',NULL,NULL,NULL,'超级管理员',NULL,NULL,'101003',NULL,'1',NULL,NULL,NULL,'1','2022-09-28 08:32:03',NULL),('48','admin','$2a$10$TJ4TmCdK.X4wv/tCqHW14.w70U3CC33CeVncD3SLmyMXMknstqKRe',NULL,NULL,NULL,'系统管理员',NULL,NULL,'101003',NULL,'1',NULL,NULL,NULL,'1','2022-09-28 08:32:03',NULL),('49','itcast','$2a$10$wLAyszibjsvqjEFLtgo43eJxKtYkD7wcZZhzNYNX/piFXsClxEERS',NULL,NULL,NULL,'test02',NULL,NULL,'101002',NULL,'1','','12345',NULL,'1','2022-09-28 08:32:03',NULL),('50','stu1','$2a$10$0pt7WlfTbnPDTcWtp/.2Mu5CTXvohnNQhR628qq4RoKSc0dGAdEgm',NULL,NULL,'大水牛','学生1','http://file.51xuecheng.cn/dddf',NULL,'101001','2022-09-28 19:28:46','1',NULL,NULL,NULL,'1','2022-09-28 08:32:03',NULL),('51','stu2','$2a$10$nxPKkYSez7uz2YQYUnwhR.z57km3yqKn3Hr/p1FR6ZKgc18u.Tvqm',NULL,NULL,NULL,'学生2',NULL,NULL,'101001',NULL,'1',NULL,NULL,NULL,'1','2022-09-28 08:32:03',NULL),('52','t1','$2a$10$0pt7WlfTbnPDTcWtp/.2Mu5CTXvohnNQhR628qq4RoKSc0dGAdEgm',NULL,NULL,NULL,'M老师',NULL,'1232141425','101002',NULL,'1',NULL,NULL,NULL,'','2022-09-28 08:32:03',NULL);
/*!40000 ALTER TABLE `xc_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xc_user_role`
--

DROP TABLE IF EXISTS `xc_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xc_user_role` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `creator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_xc_user_role_user_id` (`user_id`) USING BTREE,
  KEY `fk_xc_user_role_role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xc_user_role`
--

LOCK TABLES `xc_user_role` WRITE;
/*!40000 ALTER TABLE `xc_user_role` DISABLE KEYS */;
INSERT INTO `xc_user_role` (`id`, `user_id`, `role_id`, `create_time`, `creator`) VALUES ('1','46','8','2017-09-11 13:02:45','超级管理员'),('19','50','6','2017-09-12 14:20:20','超级管理员'),('2','48','6','2017-09-11 13:02:56','超级管理员'),('20','50','17','2017-09-12 14:20:20','超级管理员'),('2034706c-7d15-43fb-8b0d-bd581c7ace02','e63fb882-3226-4365-9711-d3fd467a4813','17',NULL,NULL),('21','52','20',NULL,NULL),('3','49','20','2017-09-11 13:03:12',NULL),('48d759c1-a597-4220-8ddf-91696638d91d','17b9d8be-cef3-400c-bec5-1478a6ef7ddc','17',NULL,NULL),('88f646ec-7257-4987-816e-92adfb68e0c1','e47ade0d-377d-4e58-99fc-6d5e2af5c148','17',NULL,NULL);
/*!40000 ALTER TABLE `xc_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-09 16:52:12
