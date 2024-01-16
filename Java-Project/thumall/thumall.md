## 2. 环境搭建

### 2.1 基本软件安装

docker安装mysql、redis

### 2.2 项目结构创建

#### 1、创建父工程

创建一个新的Maven项目作为父工程，然后删除src目录。父工程pom文件如下：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.thuwsy.thumall</groupId>
    <artifactId>thumall</artifactId>
    <version>1.0-SNAPSHOT</version>

    <!--管理版本号-->
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>

    <!--依赖版本管理-->
    <dependencyManagement>
        <dependencies>
            <!--SpringBoot 3.0.2-->
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-dependencies</artifactId>
                <version>3.0.2</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!--SpringCloud 2022.0.0-->
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>2022.0.0</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!--SpringCloud Alibaba 2022.0.0.0-->
            <dependency>
                <groupId>com.alibaba.cloud</groupId>
                <artifactId>spring-cloud-alibaba-dependencies</artifactId>
                <version>2022.0.0.0</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <version>3.0.2</version>
            </plugin>
        </plugins>
    </build>
</project>
```

#### 2、创建common模块

我们创建一个`thumall-common`模块，主要用于添加公共的依赖。添加如下依赖：

```xml
<!-- web -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
<!-- mybatis -->
<dependency>
    <groupId>org.mybatis.spring.boot</groupId>
    <artifactId>mybatis-spring-boot-starter</artifactId>
    <version>3.0.2</version>
</dependency>
<!-- mysql -->
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <scope>runtime</scope>
</dependency>
<!-- druid -->
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>druid-spring-boot-3-starter</artifactId>
    <version>1.2.18</version>
</dependency>
<!-- nacos-discovery -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
</dependency>
<!-- nacos-config -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-config</artifactId>
</dependency>
<!-- 支持bootstrap配置文件 -->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-bootstrap</artifactId>
</dependency>
<!-- openfeign -->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-openfeign</artifactId>
</dependency>
<!-- loadbalancer -->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-loadbalancer</artifactId>
</dependency>
```

#### 3、创建子模块

创建以下5个模块：

- thumall-product(商品服务)
- thumall-ware(仓储服务)
- thumall-order(订单服务)
- thumall-coupon(优惠券服务)
- thumall-member(用户服务)

（1）添加依赖

```xml
<dependency>
    <groupId>com.thuwsy.thumall</groupId>
    <artifactId>thumall-common</artifactId>
    <version>1.0-SNAPSHOT</version>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
</dependency>
```

（2）主启动类

```java
@SpringBootApplication
public class ThumallProductApplication {
    public static void main(String[] args) {
        SpringApplication.run(ThumallProductApplication.class, args);
    }
}
```

#### 4、将该项目发布到github

![](images/Snipaste20240109140833.png)

在`.gitignore`中添加以下内容，来忽略一些文件：

```
**/mvnw
**/mvnw.cmd
**/.mvn

**/target/
.idea
**/.gitignore
```

然后发布到github

### 2.3 数据库初始化

连接到MySQL后，分别执行sql脚本：

```sql
CREATE DATABASE `thumall_oms` DEFAULT CHARACTER SET utf8mb4;
USE `thumall_oms`;
# 然后执行脚本thumall_oms.sql

CREATE DATABASE `thumall_pms` DEFAULT CHARACTER SET utf8mb4;
USE `thumall_pms`;
# 然后执行脚本thumall_pms.sql

CREATE DATABASE `thumall_sms` DEFAULT CHARACTER SET utf8mb4;
USE `thumall_sms`;
# 然后执行脚本thumall_sms.sql

CREATE DATABASE `thumall_ums` DEFAULT CHARACTER SET utf8mb4;
USE `thumall_ums`;
# 然后执行脚本thumall_ums.sql

CREATE DATABASE `thumall_wms` DEFAULT CHARACTER SET utf8mb4;
USE `thumall_wms`;
# 然后执行脚本thumall_wms.sql
```

## 3. RuoYi框架

### 3.1 后端运行

（1）从RuoYi官网下载前后端分离框架`RuoYi-Vue`（SpringBoot 3版本）并复制文件夹到IDEA中，然后在父工程的pom文件中添加`<module>ruoyi</module>`进行聚合，并刷新maven。注意，上述内容是后端maven工程，不包括`ruoyi-ui`。

> 可以直接解压`ruoyi.zip`得到文件夹，复制到项目中。

（2）创建数据库`ry-vue`并导入数据脚本`ry_20230706.sql`和`quartz.sql`

（3）修改数据库连接，编辑`resources`目录下的`application-druid.yml`

```yml
# 数据源配置
spring:
    datasource:
        type: com.alibaba.druid.pool.DruidDataSource
        driverClassName: com.mysql.cj.jdbc.Driver
        druid:
            # 主库数据源
            master:
                url: jdbc:mysql://192.168.231.200:3306/ry-vue?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8
                username: root
                password: abc666
```

（4）修改Redis连接，编辑`resources`目录下的`application.yml`

```yml
spring:
  data:
    # redis 配置
    redis:
      # 地址
      host: 192.168.231.200
      # 端口，默认为6379
      port: 6379
      # 数据库索引
      database: 0
      # 密码
      password: abc666
```

（5）修改服务器配置，编辑`resources`目录下的`application.yml`

```yml
# 开发环境配置
server:
  # 服务器的HTTP端口，默认为8080
  port: 8080
  servlet:
    # 应用的访问路径
    context-path: /
```

（6）运行`com.ruoyi.RuoYiApplication.java`，成功后可以通过`http://localhost:8080`访问，但是不会出现静态页面，可以继续参考下面步骤部署ruoyi-ui前端，然后通过前端地址来访问。

### 3.2 前端运行

（1）用VS Code打开`ruoyi-ui`目录，执行以下命令：

```sh
# 进入项目目录
cd ../ruoyi-ui

# 安装依赖
npm install --registry=https://registry.npmmirror.com

# 本地开发 启动项目
npm run dev
```

（2）浏览器访问`http://localhost:80`成功，默认账号和密码分别为`admin`,`admin123`。若能正确展示登录页面，并能成功登录，菜单及页面展示正常，则表明环境搭建成功。

### 3.3 逆向工程代码生成

大部分项目里其实有很多代码都是重复的，几乎每个基础模块的代码都有增删改查的功能，而这些功能都是大同小异，如果这些功能都要自己去写，将会大大浪费我们的精力降低效率。所以这种重复性的代码可以使用代码生成。

（1）在`ruoyi-generator`模块中resources目录下的`generator.yml`配置：

```yml
# 代码生成
gen:
  # 作者
  author: wsy
  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool
  packageName: com.thuwsy.thumall.order
  # 自动去除表前缀，默认是false
  autoRemovePre: true
  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）
  tablePrefix: oms_
```

（2）由于只能逆向工程生成若依数据库下的表，所以我们在数据库`ry-vue`下执行sql脚本`thumall_oms.sql`。注意：若依的逆向工程生成代码要求**表和字段必须有`comment`备注**。

（3）重启后端项目，然后`系统工具 -> 代码生成 -> 导入对应表`，选择所有以`oms_`为前缀的表，导入后全选并生成代码，得到一个压缩包，解压后保存到一个临时文件夹内，例如`order`。

（4）重复`（1）-（3）`的过程，将`product`, `coupon`, `member`, `ware`模块的代码也一并生成。

（5）最后在`ry-vue`执行sql脚本`delete_generator.sql`来删除上述这些无用的表。

### 3.4 导入逆向工程生成的代码

逆向工程生成的压缩包中主要有三部分：

- main目录：后端相关代码
- vue目录：前端相关代码
- sql脚本：数据库脚本

我们首先导入main目录中的代码，以product模块为例，其他模块类似：

（1）导入代码

将main目录中的代码复制替换`thumall-product`模块中的main目录。

（2）添加依赖

```xml
<dependency>
    <groupId>com.ruoyi</groupId>
    <artifactId>ruoyi-common</artifactId>
    <version>3.8.6</version>
</dependency>
```

（3）配置文件application.yml

```yml
server:
  port: 7001

spring:
  application:
    name: thumall-product
  # 数据源配置
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource
    druid:
      driver-class-name: com.mysql.cj.jdbc.Driver
      url: jdbc:mysql://192.168.231.200:3306/thumall_pms
      username: root
      password: abc666
  cloud:
    nacos:
      discovery:
        server-addr: 127.0.0.1:8848 # nacos注册中心地址

# mybatis配置
mybatis:
  mapper-locations: classpath:/mapper/**/*.xml
  type-aliases-package: com.thuwsy.thumall.**.domain
  configuration:
    map-underscore-to-camel-case: true
```

在resources目录下创建`META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports`，并写入：

```txt
com.alibaba.druid.spring.boot3.autoconfigure.DruidDataSourceAutoConfigure
```

（4）主启动类

```java
@MapperScan("com.thuwsy.thumall.product.mapper")
@SpringBootApplication
public class ThumallProductApplication {
    public static void main(String[] args) {
        SpringApplication.run(ThumallProductApplication.class, args);
    }
}
```

（5）业务类

注意，若依逆向工程生成的代码的控制器类上`@RequestMapping`注解可能有相同的value值，一定要将其改为不同的。

（6）测试

启动项目后，访问`http://localhost:7001/product/attr/list`成功。注意，SpringSecurity默认的账号为`user`，密码启动时在控制台打印。





