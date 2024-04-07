## 2. 环境搭建

### 2.1 基本软件安装

> 注意：如果Docker拉取镜像时域名解析失败，可以将`vi /etc/resolv.conf`中改为`nameserver 8.8.8.8`

Linux虚拟机上：

（1）安装docker，版本24.0.7

（2）使用docker安装mysql:8.0.27

（3）使用docker安装redis:7.2.0

（4）使用docker安装nacos:2.2.3

1. 拉取镜像

    ```sh
    docker pull nacos/nacos-server:v2.2.3
    ```

2. 启动容器实例

    ```sh
    docker run -d --name nacos \
    -p 8848:8848 \
    -p 9848:9848 \
    -p 9849:9849 \
    --restart=always \
    -e MODE=standalone \
    nacos/nacos-server:v2.2.3
    ```

（5）使用docker安装minio

（6）使用docker安装rabbitmq

（7）使用docker安装elasticsearch:8.6.0


### 2.2 项目结构创建

#### 1、创建父工程

创建一个新的Maven项目作为父工程，然后删除src目录。父工程pom文件如下：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.thuwsy.xuetang</groupId>
    <artifactId>xuetang</artifactId>
    <version>1.0-SNAPSHOT</version>

    <!--管理版本号-->
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <mybatis.spring.boot.version>3.0.2</mybatis.spring.boot.version>
        <spring.boot.version>3.0.2</spring.boot.version>
        <spring.cloud.version>2022.0.0</spring.cloud.version>
        <spring.cloud.alibaba.version>2022.0.0.0</spring.cloud.alibaba.version>
    </properties>

    <!-- 依赖版本管理 -->
    <dependencyManagement>
        <dependencies>
            <!-- SpringBoot -->
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-dependencies</artifactId>
                <version>${spring.boot.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!-- SpringCloud -->
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>${spring.cloud.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!-- SpringCloud Alibaba -->
            <dependency>
                <groupId>com.alibaba.cloud</groupId>
                <artifactId>spring-cloud-alibaba-dependencies</artifactId>
                <version>${spring.cloud.alibaba.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!-- mybatis-->
            <dependency>
                <groupId>org.mybatis.spring.boot</groupId>
                <artifactId>mybatis-spring-boot-starter</artifactId>
                <version>${mybatis.spring.boot.version}</version>
            </dependency>
        </dependencies>
    </dependencyManagement>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <version>${spring.boot.version}</version>
            </plugin>
        </plugins>
    </build>
</project>
```

#### 2、创建base模块

我们创建一个`xuetang-base`模块，主要用于添加公共的依赖。添加如下依赖：

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


```java
// 创建以下5个模块：

// - thumall-product(商品服务)
// - thumall-ware(仓储服务)
// - thumall-order(订单服务)
// - thumall-coupon(优惠券服务)
// - thumall-member(用户服务)

// （1）添加依赖

// ```xml
// <dependency>
//     <groupId>com.thuwsy.thumall</groupId>
//     <artifactId>thumall-common</artifactId>
//     <version>1.0-SNAPSHOT</version>
// </dependency>
// <dependency>
//     <groupId>org.springframework.boot</groupId>
//     <artifactId>spring-boot-starter-test</artifactId>
//     <scope>test</scope>
// </dependency>
// ```

// （2）主启动类

// ```java
// @SpringBootApplication
// public class ThumallProductApplication {
//     public static void main(String[] args) {
//         SpringApplication.run(ThumallProductApplication.class, args);
//     }
// }
// ```
```


#### 4、将该项目发布到github

![](images/Snipaste20240112140751.png)

在`.gitignore`中添加以下内容，来忽略一些文件：

```
### STS ###
.apt_generated
.factorypath
.settings
.springBeans
.sts4-cache

### IntelliJ IDEA ###
.idea
*.iws
*.iml
*.ipr
**/mvnw
**/mvnw.cmd
**/.mvn
**/target/
**/.gitignore

### NetBeans ###
/nbproject/private/
/nbbuild/
/dist/
/nbdist/
/.nb-gradle/
build/
logs/

### VS Code ###
.vscode/
```

然后发布到github

### 2.3 数据库初始化

连接到MySQL后，分别执行sql脚本：

```sql
CREATE DATABASE `xuetang_content` DEFAULT CHARACTER SET utf8mb4;
USE `xuetang_content`;
# 然后执行脚本xuetang_content.sql

CREATE DATABASE `xuetang_system` DEFAULT CHARACTER SET utf8mb4;
USE `xuetang_system`;
# 然后执行脚本xuetang_system.sql

CREATE DATABASE `xuetang_media` DEFAULT CHARACTER SET utf8mb4;
USE `xuetang_media`;
# 然后执行脚本xuetang_media.sql

CREATE DATABASE `xuetang_users` DEFAULT CHARACTER SET utf8mb4;
USE `xuetang_users`;
# 然后执行脚本xuetang_users.sql

```



## 3. MinIO的基本使用

### 3.1 MinIO的安装

（1）拉取镜像

```sh
docker pull minio/minio:RELEASE.2022-09-07T22-25-02Z
```

（2）创建挂载目录

```sh
mkdir -p /docker/minio/config
mkdir -p /docker/minio/data
```

（3）启动容器实例

```sh
docker run -d --name minio \
-p 9000:9000 -p 9090:9090 \
--restart=always \
-e "MINIO_ACCESS_KEY=minioadmin" \
-e "MINIO_SECRET_KEY=minioadmin" \
-v /docker/minio/data:/data \
-v /docker/minio/config:/root/.minio \
minio/minio:RELEASE.2022-09-07T22-25-02Z server \
/data --console-address ":9090" -address ":9000"
```

> 其中9090端口是控制台的端口，而9000是提供的API端口。容器启动后，访问`http://192.168.231.201:9090`即可查看控制台。

### 3.2 MinIO的使用

（1）首先在控制台创建一个桶，名称为`testbucket`。然后在Manage中将Access Policy修改为`public`。

（2）创建一个模块用于测试，添加以下依赖

```xml
<dependency>
    <groupId>io.minio</groupId>
    <artifactId>minio</artifactId>
    <version>8.5.7</version>
</dependency>
```

（3）测试类

```java
public class MyTests {
    // 连接minio的客户端
    static MinioClient minioClient = MinioClient.builder()
            .endpoint("http://192.168.231.201:9000")
            .credentials("minioadmin", "minioadmin")
            .build();

    @Test // 上传文件
    public void testUpload() throws Exception {
        UploadObjectArgs testbucket = UploadObjectArgs.builder()
                .bucket("testbucket") // 桶的名称
                .object("001/test001.png") // 桶下保存文件的路径
                .filename("E:\\haha.png") // 源文件的路径
                .build();
        minioClient.uploadObject(testbucket);
        System.out.println("上传成功");
    }

    @Test // 下载文件
    public void testDownload() throws Exception {
        InputStream is = minioClient.getObject(GetObjectArgs.builder()
                .bucket("testbucket")
                .object("001/test001.png")
                .build());
        // 使用工具类IOUtils拷贝流，实现文件下载
        FileOutputStream os = new FileOutputStream("E:\\lala.png");
        IOUtils.copy(is, os);
        System.out.println("下载成功");
    }

    @Test // 删除文件
    public void testDelete() throws Exception {
        minioClient.removeObject(RemoveObjectArgs.builder()
                .bucket("testbucket")
                .object("001/test001.png")
                .build());
        System.out.println("删除成功");
    }
}
```


##  4. 搜索模块

在ES中首先创建索引库：

```json
PUT /course-publish
{
  "mappings": {
    "properties": {
      "id": {
        "type": "keyword"
      },
      "companyId": {
        "type": "keyword"
      },
      "companyName": {
        "type": "text",
        "search_analyzer": "ik_smart",
        "analyzer": "ik_max_word"
      },
      "name": {
        "type": "text",
        "search_analyzer": "ik_smart",
        "analyzer": "ik_max_word"
      },
      "users": {
        "type": "text",
        "search_analyzer": "ik_smart",
        "analyzer": "ik_max_word"
      },
      "mt": {
        "type": "keyword"
      },
      "mtName": {
        "type": "keyword"
      },
      "st": {
        "type": "keyword"
      },
      "stName": {
        "type": "keyword"
      },
      "grade": {
        "type": "keyword"
      },
      "teachmode": {
        "type": "keyword"
      },
      "pic": {
        "type": "text",
        "index": false
      },
      "description": {
        "type": "text",
        "search_analyzer": "ik_smart",
        "analyzer": "ik_max_word"
      },
      "createDate": {
        "type": "date", 
        "format": "yyyy-MM-dd HH:mm:ss"
      },
      "status": {
        "type": "keyword"
      },
      "remark": {
        "type": "text",
        "index": false
      },
      "charge": {
        "type": "keyword"
      },
      "price": {
        "type": "scaled_float",
        "scaling_factor": 100
      },
      "originalPrice": {
        "type": "scaled_float", 
        "scaling_factor": 100
      },
      "validDays": {
        "type": "integer"
      }
    }
  }
}
```

