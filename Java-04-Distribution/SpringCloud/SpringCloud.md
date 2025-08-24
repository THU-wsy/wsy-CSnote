# 第01章_SpringCloud简介

## 1. 微服务架构

**微服务架构**是一种架构模式，它提倡将单一应用程序划分成一组小型服务，服务之间相互协调配合。每个服务运行在其独立的进程中，服务与服务间采用轻量级的通信机制互相协作（通常是基于HTTP协议的RESTful API）。每个服务都围绕着具体业务进行构建，并且能够被独立地部署到生产环境。除此之外，应当尽量避免统一、集中式的服务管理机制，对具体的一个服务而言，应该根据业务上下文来选择合适的语言、工具对其进行构建。

**Spring Cloud是分布式微服务架构的一站式解决方案**，是多种微服务架构实现技术的集合体。

## 2. Spring Cloud

### 2.1 Spring Cloud版本的命名规则

Spring Cloud采用了英国伦敦地铁站的名称来命名，并由地铁站名称字母A-Z依次类推的形式来发布迭代版本，例如Angel是第一个版本, Brixton是第二个版本。这是因为SpringCloud有很多子项目，需要管理它们的版本号，为了防止SpringCloud的版本号和子项目的版本号混淆，所以采用了这种命名方式。

> 注意：如今Spring Cloud版本已不再遵循上述命名规则，而是根据年份来命名。

### 2.2 版本选择

版本选择可以参考 https://github.com/alibaba/spring-cloud-alibaba/wiki/%E7%89%88%E6%9C%AC%E8%AF%B4%E6%98%8E

我们选用的版本如下：

- Spring Cloud：2022.0.0
- Spring Boot：3.0.2
- Spring Cloud Alibaba：2022.0.0.0

> 说明：Spring Cloud Alibaba的版本命名中，前3位是适配的Spring Cloud版本，最后一位是扩展版本。

我们选用的组件版本：

- Sentinel: 1.8.6
- Nacos: 2.2.3
- RocketMQ: 4.9.4
- Seata: 2.1.0

## 3. Spring Cloud Alibaba

以前Spring Cloud所使用的组件主要由Spring Cloud Netflix提供，但它现在已停更并进入维护模式，从而Spring Cloud Alibaba将其取而代之。

Spring Cloud Alibaba致力于提供微服务开发的一站式解决方案。此项目包含开发分布式应用微服务的必需组件，方便开发者通过Spring Cloud编程模型轻松使用这些组件来开发分布式应用服务。

英文官网：https://spring.io/projects/spring-cloud-alibaba#learn

中文文档：https://github.com/alibaba/spring-cloud-alibaba/blob/2022.x/README-zh.md

## 4. Dubbo

Dubbo从3.0开始已经不再与Spring Cloud Alibaba进行集成了，原因主要是与其发展方向定位有关。

- 最初，Dubbo定位是**微服务框架**，与SpringCloud定位相同。但没有撼动SpringCloud的地位，自己反而停止维护了。
- 后来，随着Spring Cloud Alibaba的大火，Dubbo又火爆了起来，因为它解决了Spring Cloud Alibaba通信效率低下的问题。此时Dubbo的定位是**RPC通信框架**。
- 现在，Dubbo已经逐步完善，定位又回到了**微服务框架**。此时的Dubbo，能够完美处理**超大规模的微服务应用**，而Spring Cloud只适用于中小规模的微服务应用。

## 5. SpringCloud组件的升级与替换

### 5.1 注册中心

- Eureka：由Netflix提供(已过时)
- ZooKeeper：由雅虎公司提供
- Consul：由HashiCorp公司提供
- Nacos：由Alibaba提供(推荐使用)

### 5.2 配置中心

- Config+Bus：由SpringCloud官方提供
- Nacos：由Alibaba提供(推荐使用)

### 5.3 负载均衡器

- Ribbon：由Netflix提供(已过时)
- LoadBalancer：由SpringCloud官方提供(推荐使用)

### 5.4 服务远程调用

- Feign：由Netflix提供(已过时)
- OpenFeign：由SpringCloud官方提供(推荐使用)

### 5.5 网关

- Zuul：由Netflix提供(已过时)
- Gateway：由SpringCloud官方提供(推荐使用)

### 5.6 服务降级、熔断、限流

- Hystrix：由Netflix提供(已过时)
- Resilience4j：国外使用较多
- Sentinel：由Alibaba提供(推荐使用)

### 5.7 处理分布式事务

- Seata：由Alibaba提供(推荐使用)

### 5.8 调用链跟踪

- Sleuth：由SpringCloud官方提供(不支持SpringBoot3)
- SkyWalking：由Apache提供(推荐使用)

### 5.9 消息驱动

- Stream：由SpringCloud官方提供(推荐使用)

## 6. 工程案例搭建

### 6.1 父工程搭建

（1）创建一个新的Maven项目作为父工程，然后删除src目录

（2）确认相关配置：

- 确认使用的Maven正确
    ![](images/20231006190357.png)
- 确认字符编码正确
    ![](images/20231006190518.png)
- 确认注解生效激活
    ![](images/20231006191129.png)
- 确认Java编译版本
    ![](images/20231006191300.png)

（3）父工程pom文件：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.wsy.cloud</groupId>
    <artifactId>spring-cloud-project</artifactId>
    <version>1.0-SNAPSHOT</version>

    <!--管理版本号-->
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <spring.boot.version>3.0.2</spring.boot.version>
        <spring.cloud.version>2022.0.0</spring.cloud.version>
        <spring.cloud.alibaba.version>2022.0.0.0</spring.cloud.alibaba.version>
        <mybatis.spring.boot.version>3.0.2</mybatis.spring.boot.version>
    </properties>

    <!--依赖版本管理-->
    <dependencyManagement>
        <dependencies>
            <!--SpringBoot 3.0.2-->
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-dependencies</artifactId>
                <version>${spring.boot.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!--SpringCloud 2022.0.0-->
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>${spring.cloud.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!--SpringCloud Alibaba 2022.0.0.0-->
            <dependency>
                <groupId>com.alibaba.cloud</groupId>
                <artifactId>spring-cloud-alibaba-dependencies</artifactId>
                <version>${spring.cloud.alibaba.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!-- mybatis-spring-boot-starter -->
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

### 6.2 实体类模块

#### 1、创建模块cloud-api-commons

#### 2、添加依赖

```xml
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <optional>true</optional>
</dependency>
<dependency>
    <groupId>cn.hutool</groupId>
    <artifactId>hutool-all</artifactId>
    <version>5.8.12</version>
</dependency>
```

#### 3、entities

主实体类Payment：

```java
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Payment {
    private Long id;
    private String serial;
}
```

Json封装体CommonResult：

```java
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommonResult<T> {
    private Integer code;
    private String message;
    private T data;

    public CommonResult(Integer code, String message) {
        this(code, message, null);
    }

    public CommonResult(T data) {
        this(200, "操作成功", data);
    }
}
```

#### 4、SQL建表

在spring_cloud_test库下创建payment表

```sql
CREATE TABLE `payment` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `serial` VARCHAR(200) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
```

#### 5、将该模块install到Maven仓库

对该模块执行maven命令clean install

### 6.3 服务提供者模块

#### 1、创建模块cloud-provider-payment8001

#### 2、添加依赖

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
<dependency>
    <groupId>org.mybatis.spring.boot</groupId>
    <artifactId>mybatis-spring-boot-starter</artifactId>
</dependency>
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <scope>runtime</scope>
</dependency>
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <optional>true</optional>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
</dependency>
<!-- 引入自己定义的api通用包 -->
<dependency>
    <groupId>com.wsy.cloud</groupId>
    <artifactId>cloud-api-commons</artifactId>
    <version>${project.version}</version>
</dependency>
```

#### 3、配置文件

```properties
# 端口号
server.port=8001
# 微服务名称
spring.application.name=cloud-provider-payment

# 配置数据源信息
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.type=com.zaxxer.hikari.HikariDataSource
spring.datasource.url=jdbc:mysql://localhost:3306/spring_cloud_test
spring.datasource.username=root
spring.datasource.password=abc666

# 配置整合MyBatis
mybatis.mapper-locations=classpath:/mapper/*.xml
mybatis.configuration.map-underscore-to-camel-case=true
mybatis.type-aliases-package=com.wsy.cloud.entities
```

#### 4、主启动类

```java
@MapperScan("com.wsy.cloud.mapper")
@SpringBootApplication
public class Payment8001 {
    public static void main(String[] args) {
        SpringApplication.run(Payment8001.class, args);
    }
}
```

#### 5、业务类

**（1）mapper**

```java
public interface PaymentMapper {
    int create(Payment payment);
    Payment getPaymentById(@Param("id") Long id);
}
```

```xml
<mapper namespace="com.wsy.cloud.mapper.PaymentMapper">
    <insert id="create">
        insert into payment (serial) values (#{serial})
    </insert>
    <select id="getPaymentById" resultType="com.wsy.cloud.entities.Payment">
        select id, serial from payment where id = #{id}
    </select>
</mapper>
```

**（2）service**

```java
public interface PaymentService {
    int create(Payment payment);
    Payment getPaymentById(Long id);
}
```

```java
@Service
public class PaymentServiceImpl implements PaymentService {
    @Autowired
    private PaymentMapper paymentMapper;

    @Override
    public int create(Payment payment) {
        return paymentMapper.create(payment);
    }

    @Override
    public Payment getPaymentById(Long id) {
        return paymentMapper.getPaymentById(id);
    }
}
```

**（3）controller**

```java
@RestController
@Slf4j
public class PaymentController {
    @Autowired
    private PaymentService paymentService;
    @Value("${server.port}")
    private String serverPort;

    @PostMapping("/payment/create")
    public CommonResult<Integer> create(@RequestBody Payment payment) {
        int result = paymentService.create(payment);
        log.info("插入操作返回结果：{}", result);
        if (result > 0) {
            return new CommonResult<>(200, "插入数据成功", result);
        }
        return new CommonResult<>(444, "插入数据失败", null);
    }

    @GetMapping("/payment/get/{id}")
    public CommonResult<Payment> getPaymentById(@PathVariable("id") Long id) {
        Payment payment = paymentService.getPaymentById(id);
        log.info("查询结果：{}", payment);
        if (payment != null) {
            return new CommonResult<>(200, "查询成功,port=" + serverPort, payment);
        }
        return new CommonResult<>(444, "这条记录不存在，id=" + id, null);
    }
}
```

### 6.4 服务消费者模块

#### 1、创建模块cloud-consumer-order80

#### 2、添加依赖

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <optional>true</optional>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
</dependency>
<!-- 引入自己定义的api通用包 -->
<dependency>
    <groupId>com.wsy.cloud</groupId>
    <artifactId>cloud-api-commons</artifactId>
    <version>${project.version}</version>
</dependency>
```

#### 3、配置文件

```properties
# 端口号
server.port=80
# 微服务名称
spring.application.name=cloud-consumer-order
```

#### 4、主启动类

```java
@SpringBootApplication
public class Order80 {
    public static void main(String[] args) {
        SpringApplication.run(Order80.class, args);
    }
}
```

#### 5、业务类

（1）在配置类ApplicationContextConfig中配置组件RestTemplate

```java
@Configuration
public class ApplicationContextConfig {
    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}
```

（2）controller

```java
@RestController
public class OrderController {
    public static final String PAYMENT_URL = "http://127.0.0.1:8001";

    @Autowired
    private RestTemplate restTemplate;

    // 客户端用浏览器应发送get请求
    @GetMapping("/consumer/payment/create")
    public CommonResult create(Payment payment) {
        // 调用postForObject()发送post请求进行远程调用
        return restTemplate.postForObject(PAYMENT_URL + "/payment/create",
                payment, CommonResult.class);
    }

    @GetMapping("/consumer/payment/get/{id}")
    public CommonResult getPayment(@PathVariable("id") Long id) {
        return restTemplate.getForObject(PAYMENT_URL +
                "/payment/get/" + id, CommonResult.class);
    }
}
```

### 6.5 补充：RestTemplate

RestTemplate提供了多种便捷访问远程Http服务的方法，是一种简单便捷访问RESTful服务的模板类，是Spring提供的用于访问Rest服务的**客户端模板工具集**。使用RestTemplate访问RESTful接口非常简单，只需注意三个参数的含义即可：

- url：REST请求地址
- request：请求参数
- responseType：HTTP响应被转换成的对象类型

**注意**：

- 上述`restTemplate.getForObject()`返回的对象为响应体中数据转化成的对象
- 还有一个方法`restTemplate.getForEntity()`，返回对象为ResponseEntity对象，包含了响应中的一些重要信息，比如响应头、响应状态码、响应体等。但这个方法并不是很常用。



# 第02章_Nacos注册中心

## 1. Nacos

### 1.1 注册中心简介

所有服务提供者将自己**提供服务的名称**和自己**主机详情**(ip、port、版本等)写入到某个统一的服务器的一个表中，这台服务器就称为**服务注册中心**，这个表称为**服务注册表**。

所有服务消费者需要调用微服务时，会首先从注册中心将服务注册表下载到本地，然后根据消费者本地设置好的**负载均衡策略**选择一个服务提供者进行调用，这个过程称为**服务发现**。

可以充当Spring Cloud服务注册中心的服务器有很多，如Eureka、ZooKeeper、Consul等，但Spring Cloud Alibaba中推荐使用的注册中心为Nacos。

RPC远程调用框架核心设计思想就是**使用注册中心管理每个服务与服务之间的依赖关系**。在任何RPC远程调用框架中，都会有一个注册中心，用于存放服务地址等相关信息。

### 1.2 Nacos简介

官方文档 https://nacos.io/zh-cn/docs/v2/what-is-nacos.html

Nacos的前4个字母分别是Naming和Configuration的前两个字母，最后的s表示Service。Nacos全称为Dynamic Naming and Configuration Service，它是一个更易于构建云原生应用的动态服务发现、配置管理和服务管理的平台。

简言之，**Nacos就是服务注册中心和配置中心的组合**，可以同时代替Eureka+Config+Bus。

> Nacos有**注册表缓存**功能，即如果消费者进行服务调用，就会把服务中心的服务注册表缓存到本地，所以如果此时Nacos宕机，当消费者调用注册表中的微服务API仍能成功。

### 1.3 Nacos安装

Nacos的下载地址为 https://github.com/alibaba/nacos/releases

我们下载的版本为nacos-server-2.2.3.zip，而后缀名为.tar.gz是用于Linux服务器上的。

进入解压后的文件夹找到如下相对文件夹nacos/bin，

- Windows系统在cmd中执行`startup.cmd -m standalone`命令即可启动Nacos服务器
- Linux系统执行`./startup.sh -m standalone`命令即可启动Nacos服务器

> -m standalone表示以单机而非集群的方式启动Nacos服务器

然后访问http://localhost:8848/nacos即可。

### 1.4 临时实例与持久实例

#### 1、临时实例

**Nacos默认会将注册的微服务设置为临时实例**，即服务实例仅会注册在Nacos内存，不会持久化到Nacos磁盘。临时实例的健康检测机制为**Client模式**，即Client主动向Server上报其健康状态，默认心跳间隔为5秒。

- 若在15秒内Server未收到Client心跳，则会将其标记为不健康状态
- 若在30秒内Server又收到了该Client的心跳，则重新将其恢复为健康状态，否则就将该实例从Server端内存中清除

#### 2、持久实例

对于持久实例，服务实例不仅会注册到Nacos内存，还会持久化到Nacos磁盘。持久实例的健康检测机制为**Server模式**，即Server会主动去检测Client的健康状态，默认每20秒检测一次，健康检测失败后该服务实例会被标记为不健康状态，但不会被清除，因为它是持久化在磁盘中的。

注意，要将微服务注册为持久实例，需要在配置文件中添加以下配置项：

```properties
spring.cloud.nacos.discovery.ephemeral=false
```

> 说明：一般Web微服务都**推荐注册为默认的临时实例**，而不是持久实例。而且持久实例的删除极为繁琐，可以参考官方文档。

### 1.5 Nacos和CAP

默认情况下，Nacos集群的数据一致性采用的是**AP模式**，但它也支持转换为CP模式，只需发送如下PUT请求即可切换为CP模式：

```shell
curl -X PUT 'localhost:8848/nacos/v1/ns/operator/switches?entry=serverMode&value=CP'
```

## 2. 案例实战

### 2.1 服务提供者

修改cloud-provider-payment8001

#### 1、添加依赖

```xml
<!-- nacos-discovery -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
</dependency>
```

#### 2、配置文件中配置Nacos地址

```properties
# 配置Nacos Server地址
spring.cloud.nacos.server-addr=127.0.0.1:8848
```

#### 3、补充说明

我们类似cloud-provider-payment8001再创建一个模块cloud-provider-payment8002，因为服务提供者要实现高可用，所以需要搭建集群。同时也便于我们后面演示客户端的**负载均衡功能**。

> 注意：对于一些其他的注册中心，需要在主启动类上标注@EnableDiscoveryClient注解才能开启服务注册与发现功能。但对于Nacos而言则可以省略该注解。

### 2.2 服务消费者

修改cloud-consumer-order80

#### 1、添加依赖

```xml
<!-- nacos-discovery -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
</dependency>
<!-- loadbalancer -->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-loadbalancer</artifactId>
</dependency>
```

#### 2、配置文件中配置Nacos地址

```properties
# 配置Nacos Server地址
spring.cloud.nacos.server-addr=127.0.0.1:8848
```

#### 3、修改业务类

（1）配置类中组件RestTemplate要添加@LoadBalanced注解来开启负载均衡功能：

```java
@Configuration
public class ApplicationContextConfig {
    @Bean
    @LoadBalanced
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}
```

（2）Controller中不再通过ip和port来远程调用，而是通过服务注册中心里的微服务名来调用服务提供者的API：

```java
@RestController
public class OrderController {
    public static final String PAYMENT_URL = "http://cloud-provider-payment";

    @Autowired
    private RestTemplate restTemplate;

    // 客户端用浏览器应发送get请求
    @GetMapping("/consumer/payment/create")
    public CommonResult create(Payment payment) {
        // 调用postForObject()发送post请求进行远程调用
        return restTemplate.postForObject(PAYMENT_URL + "/payment/create",
                payment, CommonResult.class);
    }

    @GetMapping("/consumer/payment/get/{id}")
    public CommonResult getPayment(@PathVariable("id") Long id) {
        return restTemplate.getForObject(PAYMENT_URL +
                "/payment/get/" + id, CommonResult.class);
    }
}
```

### 2.3 测试

- 启动Nacos、8001、8002、80
- 访问`http://localhost:8848/nacos`可以查看服务注册的情况
- 访问`http://localhost/consumer/payment/get/1`能正确获取数据（并且有负载均衡效果，即轮询端口8001和8002）

## 3. 获取注册表数据

### 3.1 DiscoveryClient

**在代码中注入DiscoveryClient组件**，就可以用它获取注册中心里所有微服务的信息。我们在cloud-consumer-order80中添加一个controller用于测试：

```java
@RestController
public class DiscoveryClientController {
    @Autowired
    private DiscoveryClient client;

    @GetMapping("/discovery/test")
    public Object discoveryTest() {
        // 获取注册中心所有微服务的名称
        List<String> services = client.getServices();
        for (String serviceName : services) {
            // 获取指定微服务名称的所有微服务实例
            List<ServiceInstance> instances = client.getInstances(serviceName);
            for (ServiceInstance instance : instances) {
                Map<String, Object> map = new HashMap<>();
                map.put("serviceName", serviceName);
                map.put("serviceId", instance.getServiceId());
                map.put("host", instance.getHost());
                map.put("port", instance.getPort());
                map.put("uri", instance.getUri());
                System.out.println(map);
            }
        }
        return client;
    }
}
```

### 3.2 测试

- 启动Nacos、8001、8002、80
- 访问`http://localhost:8848/nacos`可以查看服务注册的情况
- 访问`http://localhost/discovery/test`

页面返回：

```json
{
    "discoveryClients": [
        {
            "services": [
                "cloud-provider-payment",
                "cloud-consumer-order"
            ],
            "order": 0
        },
        {
            "services": [],
            "order": 0
        }
    ],
    "services": [
        "cloud-provider-payment",
        "cloud-consumer-order"
    ],
    "order": 0
}
```

控制台打印：

```
{port=8002, host=172.21.16.1, serviceName=cloud-provider-payment, serviceId=cloud-provider-payment, uri=http://172.21.16.1:8002}
{port=8001, host=172.21.16.1, serviceName=cloud-provider-payment, serviceId=cloud-provider-payment, uri=http://172.21.16.1:8001}
{port=80, host=172.21.16.1, serviceName=cloud-consumer-order, serviceId=cloud-consumer-order, uri=http://172.21.16.1:80}
```

## 4. Nacos集群和持久化

### 4.1 架构说明

![](images/Snipaste20231021212039.png)

默认Nacos使用嵌入式数据库derby实现数据的存储。所以，如果启动多个默认配置下的Nacos节点，数据存储是存在一致性问题的。为了解决这个问题，可以配置Nacos让它采用集中式存储的方式来支持集群化部署，目前只支持MySQL的存储。所以，我们需要将Nacos的数据源切换成MySQL。

> 说明：为了简便，我们只使用一个Nginx服务器，而不搭建Nginx集群。而Nacos节点要搭建3个，因为至少3个Nacos节点才能构成集群。

注意：Nacos2.0版本新增了gRPC的通信方式，所以**会多占用两个端口**(分别比主端口多1000和1001)，即默认端口为8848，还会占用9848端口和9849端口

- 其中偏移量为1000的端口是客户端gRPC请求服务端端口，用于客户端向服务端发起连接和请求
- 其中偏移量为1001的端口是服务端gRPC请求服务端端口，用于服务间同步等

### 4.2 Linux安装Nacos和集群配置

（1）将下载的nacos-server-2.2.3.tar.gz上传到Linux服务器的/opt目录下，然后解压，并将目录复制到/mynacos下便于操作

```shell
tar -zxvf /opt/nacos-server-2.2.3.tar.gz
cp -r /opt/nacos /mynacos/
```

（2）配置集群的ip和端口号

```shell
cd /mynacos/nacos/conf/
cp cluster.conf.example cluster.conf
vim cluster.conf
```

将其中的内容替换成以下配置（指明三台Nacos的ip和port用于搭建集群）：

```vim
192.168.231.101:3333
192.168.231.101:4444
192.168.231.101:5555
```

> 注1：不要使用连续的端口号，因为gRPC会额外占用2个端口
>
> 注2：Nacos的运行必须要有Java和Maven环境

### 4.3 切换MySQL数据源

（1）SQL脚本在/mynacos/nacos/conf/mysql-schema.sql

（2）将其复制到MySQL下的nacos_config数据库并执行

（3）`vim /mynacos/nacos/conf/application.properties`添加如下内容

```properties
spring.datasource.platform=mysql

db.num=1
db.url.0=jdbc:mysql://192.168.231.101:3306/nacos_config?characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true
db.user=root
db.password=abc666
```

### 4.4 搭建三台Nacos

由于我们在同一台机器上模拟3个Nacos节点，所以需要修改端口号(在实际应用中，一定是在不同机器上部署Nacos的，所以都使用默认的8848端口，就无需这一步的配置)。

（1）复制出三台Nacos

```shell
cp -r /mynacos/nacos /mynacos/nacos3333/
cp -r /mynacos/nacos /mynacos/nacos4444/
cp -r /mynacos/nacos /mynacos/nacos5555/
```

（2）修改端口号

```shell
vim /mynacos/nacos3333/nacos/conf/application.properties
vim /mynacos/nacos4444/nacos/conf/application.properties
vim /mynacos/nacos5555/nacos/conf/application.properties
```

分别修改`server.port`的值为3333、4444、5555

### 4.5 配置Nginx

修改Nginx的配置文件`vim /usr/local/nginx/conf/nginx.conf`，对外暴露端口1111：

```vim
worker_processes  1;

events {
    worker_connections  1024;
}

# nacos的grpc协议配置
stream {
    upstream nacoscluster-grpc { 
        # nacos2.0版本,grpc端口比主端口多1000
        server  192.168.231.101:4333 weight=1;
        server  192.168.231.101:5444 weight=1;
        server  192.168.231.101:6555 weight=1;
    }
    server {
        listen 2111;
        proxy_pass nacoscluster-grpc;
    }
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    sendfile        on;

    keepalive_timeout  65;

    #gzip  on;

    upstream cluster {
        server  192.168.231.101:3333;
        server  192.168.231.101:4444;
        server  192.168.231.101:5555;
    }

    server {
        listen       1111;
        server_name  localhost;

        location / {
            proxy_pass http://cluster;
            #root   html;
            #index  index.html index.htm;
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }
}
```

### 4.6 测试

（1）启动Nacos集群

```shell
/mynacos/nacos3333/nacos/bin/startup.sh
/mynacos/nacos4444/nacos/bin/startup.sh
/mynacos/nacos5555/nacos/bin/startup.sh
```

（2）启动Nginx

```shell
/usr/local/nginx/sbin/nginx
```

（3）通过Nginx访问Nacos，访问`http://192.168.231.101:1111/nacos`

（4）创建一个配置文件Data ID后，在数据库的config_info表中能找到记录

（5）对于微服务，只需将配置文件中Nacos的地址修改为`192.168.231.101:1111`，启动后查看Nacos即可发现微服务已经注册



# 第03章_Nacos配置中心

## 1. 配置中心

### 1.1 配置中心简介

由于每个微服务都需要必要的配置信息才能运行，所以一套集中式的、动态的配置管理设施是必不可少的，这就是**配置中心**，它为各个不同微服务应用的所有环境提供了一个中心化的外部配置。

分布式配置的架构分为**服务端**和**客户端**两部分：

- 服务端也称为**分布式配置中心**，用来**连接保存配置文件数据的服务器**并为客户端提供获取配置信息、加密/解密信息等访问接口。
- 客户端则是普通的微服务，可以在启动的时候**从配置中心获取和加载配置信息**。

**配置中心的作用**：

- 集中管理配置文件
- 不同环境不同配置，分环境部署(如dev、test、prod、beta、release)
- 不需要在每个微服务部署的机器上编写配置文件，微服务会向配置中心统一拉取自己的配置信息
- 运行期间动态调整配置：当配置发生变动时，服务不需要重启即可感知到配置的变化并应用新的配置

> 说明：如果Nacos中的配置文件和本地application.properties中有相同的配置项，则会按Nacos中配置的生效，因为在设计上SpringBoot遵循外部化配置优先的原则。

### 1.2 Nacos和Config的区别

Nacos服务器**自身就作为配置中心**，它将配置文件数据保存到**数据库**服务器中。除此之外，Nacos支持动态配置刷新，我们只需在类上**标注`@RefreshScope`注解**，该类中读取的配置信息就是Nacos中最新的配置。

> Nacos会记录配置文件的历史版本默认保留30天，此外还有一键回滚功能，回滚操作将会触发配置更新。

而Spring Cloud Config架构中，需要我们自己**创建一个微服务来作为配置中心**，并且一般将配置文件数据保存到**GitHub**。除此之外，虽然Config也支持配置刷新，但它不仅需要`@RefreshScope`注解，还需要我们手动给每个微服务发送POST请求来让它们读取新的配置，过于繁琐，一般需要配合Spring Cloud Bus消息总线来实现大范围的配置刷新。

## 2. 案例实战

### 2.1 创建数据集

我们在Nacos的配置列表中创建配置（数据集）：

![image-20250416110443193](images/image-20250416110443193.png)

### 2.2 创建模块nacos-config-client3377

### 2.3 添加依赖

```xml
<!-- nacos-config -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-config</artifactId>
</dependency>
<!-- nacos-discovery -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
```

### 2.4 配置文件

```yaml
server:
  port: 3377
spring:
  application:
    name: nacos-config-client
  cloud:
    nacos:
      # Nacos地址
      server-addr: 127.0.0.1:8848
  config:
    # 要导入的数据集，格式为 nacos:DataID
    import:
      - nacos:nacos-config-client.yaml
```

**注意**：当我们添加了Nacos配置中心的依赖后，如果没有导入数据集则会报错。为此我们可以添加如下配置，来关闭导入检查：

```properties
spring.cloud.nacos.config.import-check.enabled=false
```

### 2.5 主启动类

```java
@SpringBootApplication
public class NacosConfigClientMain3377 {
    public static void main(String[] args) {
        SpringApplication.run(NacosConfigClientMain3377.class, args);
    }
}
```

### 2.6 业务类

```java
@RestController
public class ConfigClientController {
    @Value("${config.info}")
    private String configInfo;

    @GetMapping("/config/info")
    public String getConfigInfo() {
        return configInfo;
    }
}
```

## 3. 配置动态刷新

我们上面的案例中尚不支持配置动态刷新，也就是说，如果我们修改了Nacos中的配置文件，则应用并不能够监听到最新的值。要支持配置动态刷新，有以下两种方式：

### 3.1 方式一：@RefreshScope

在需要读取最新配置值的类上标注`@RefreshScope`注解，就可以使当前类下的配置支持Nacos的动态刷新功能：

```java
@RestController
@RefreshScope
public class ConfigClientController {
    @Value("${config.info}")
    private String configInfo;

    @GetMapping("/config/info")
    public String getConfigInfo() {
        return configInfo;
    }
}
```

### 3.2 方式二(推荐)：@ConfigurationProperties支持动态刷新

使用SpringBoot提供的注解`@ConfigurationProperties`进行属性绑定，就自动支持配置动态刷新：

```java
@ConfigurationProperties(prefix = "config")
@Component
public class ConfigClientProperties {
    private String info;

    public String getInfo() {
        return info;
    }
    public void setInfo(String info) {
        this.info = info;
    }
}
```

```java
@RestController
public class ConfigClientController {
    @Autowired
    private ConfigClientProperties configClientProperties;

    @GetMapping("/config/info")
    public String getConfigInfo() {
        return configClientProperties.getInfo();
    }
}
```

## 4. 数据隔离

Nacos数据模型Key是由三元组唯一确定的：Namespace、Group、DataId

- 默认的命名空间名称是public，对应的命名空间ID为空字符串
- 默认的Group是DEFAULT_GROUP

> Namespace和Group的作用是相同的，用于划分不同的区域，只不过Namespace的范围更大。一般用Namespace来划分test、prod等环境，用Group来划分各个微服务，用DataId来划分各种配置文件。

我们可以在配置文件中指定Namespace和Group，从而实现数据隔离：

```yaml
server:
  port: 3377
spring:
  application:
    name: nacos-config-client
  cloud:
    nacos:
      server-addr: 127.0.0.1:8848
      config:
        # 指定命名空间ID
        namespace: test
  config:
    import:
      # 使用参数的方式指定group
      - nacos:database.yaml?group=CONFIG_CLIENT_GROUP
      - nacos:common.yaml?group=CONFIG_CLIENT_GROUP
```



# 第04章_LoadBalancer负载均衡器

## 1. LoadBalancer简介

### 1.1 LoadBalancer

LoadBalancer是SpringCloud负载均衡器的唯一实现，它替换了Ribbon（以前使用的一种负载均衡器）。主要功能是提供**客户端的软件负载均衡算法**。

LoadBalancer在工作时分成两步：

- 首先选择服务注册中心，它会优先选择在同一个区域内负载较少的server
- 然后从server中下载服务注册表到本地，再根据用户指定的负载均衡策略，从本地的服务注册表中选择一个地址。注意，LoadBalancer只提供两种负载均衡策略
  - 轮询，这是**默认**使用的策略
  - 随机

### 1.2 负载均衡

**负载均衡**指的是将用户请求分摊到不同的服务器上处理，以提高系统整体的并发处理能力以及可靠性。负载均衡主要分为以下两种：

- **服务端负载均衡**：当服务端收到外部请求后，会负载均衡地选择一台机器转发请求，这就是服务端负载均衡。主要应用在系统外部请求和网关层之间。可以通过硬件来实现，例如F5；也可以通过软件来实现，例如Nginx。
- **客户端负载均衡**：当客户端要发送请求时，会从自己本地维护的服务器地址列表中负载均衡地选择一个服务器进行请求的发送，这就是客户端负载均衡。主要应用于系统内部的不同服务之间，可以使用现成的负载均衡组件来实现。Spring Cloud中的LoadBalancer就是典型的客户端负载均衡。

## 2. LoadBalancer的使用

### 2.1 配合RestTemplate使用

这种方式我们之前已经使用过，只需添加LoadBalancer依赖

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-loadbalancer</artifactId>
</dependency>
```

然后在注册RestTemplate时标注@LoadBalanced注解来开启负载均衡功能即可：

```java
@Configuration
public class ApplicationContextConfig {
    @Bean
    @LoadBalanced
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}
```

### 2.2 配合OpenFeign使用

只需添加OpenFeign和LoadBalancer的依赖，就自动开启了OpenFeign的负载均衡：

```xml
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

> 注意：OpenFeign底层默认会整合LoadBalancer来实现负载均衡。



# 第05章_OpenFeign服务远程调用

## 1. OpenFeign简介

### 1.1 简介

OpenFeign是一个**声明式REST客户端**，它可以将服务提供者提供的RESTful服务伪装成接口，服务消费者只需使用OpenFeign接口+注解的方式，就可以直接调用提供者提供的RESTful服务，而**无需再使用RestTemplate**。

OpenFeign的@FeignClient注解可以解析SpringMVC的@RequestMapping注解下的接口，并通过**动态代理**的方式产生实现类，实现类中做负载均衡并调用远程服务。

### 1.2 OpenFeign的底层实现技术

Feign远程调用的底层实现技术默认采用JDK的URLConnection，同时也支持HttpClient和OkHttp。然而URLConnection不支持连接池，通信效率很低。

所以OpenFeign中直接将底层的**默认实现改为了HttpClient**，同时也支持OkHttp。用户可根据业务需求选择要使用的远程调用底层实现技术。

### 1.3 使用步骤

#### 1、依赖

引入OpenFeign和LoadBalancer的依赖，因为OpenFeign底层默认使用LoadBalancer来做客户端负载均衡：

```xml
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

> 说明：OpenFeign和LoadBalancer是**针对服务消费端做负载均衡地远程调用**，所以服务提供端代码无需任何改动。

#### 2、@EnableFeignClients

在主启动类上需要标注@EnableFeignClients注解，来开启OpenFeign的注解驱动。可以使用以下属性来指定扫描feign接口所在的包：

```java
@EnableFeignClients(basePackages = "com.wsy.cloud.feign")
```

#### 3、@FeignClient

在feign接口上标注@FeignClient注解，其value属性用于指定要调用的微服务的名称。

接口方法的声明要与远程调用的控制器方法相同（方法名可以不同，但我们并不推荐这么做），并且标注@RequestMapping来指定对应的请求路径和请求方式。事实上，**OpenFeign沿用了SpringMVC的那一套注解**，只不过此时这些注解的作用并不是用于接收请求和请求参数，而是用于**填充相应请求参数然后发送请求**。

服务消费者调用该feign接口，就能实现负载均衡地远程调用。

## 2. 案例实战

> 我们创建一个新的服务消费者，用OpenFeign来远程调用服务提供者8001和8002

### 2.1 创建模块cloud-consumer-feign-order80

### 2.2 添加依赖

```xml
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
<!-- nacos-discovery -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
<!-- 引入自己定义的api通用包 -->
<dependency>
    <groupId>com.wsy.cloud</groupId>
    <artifactId>cloud-api-commons</artifactId>
    <version>${project.version}</version>
</dependency>
```

### 2.3 配置文件

```properties
# 端口号
server.port=80
# 微服务名称
spring.application.name=cloud-consumer-feign-order
# 配置Nacos Server地址
spring.cloud.nacos.server-addr=127.0.0.1:8848
```

### 2.4 主启动类

> 标注@EnableFeignClients注解，来开启OpenFeign的注解驱动

```java
@SpringBootApplication
@EnableFeignClients(basePackages = "com.wsy.cloud.feign")
public class OrderFeignMain80 {
    public static void main(String[] args) {
        SpringApplication.run(OrderFeignMain80.class, args);
    }
}
```

### 2.5 业务类

#### 1、rpc接口

rpc接口标注@FeignClient注解，然后定义远程调用的方法：

```java
@FeignClient(value = "cloud-provider-payment")
public interface PaymentFeignClient {
    @PostMapping("/payment/create")
    CommonResult<Integer> create(@RequestBody Payment payment);

    @GetMapping("/payment/get/{id}")
    CommonResult<Payment> getPaymentById(@PathVariable("id") Long id);
}
```

#### 2、controller

直接调用rpc接口中的方法实现远程调用：

```java
@RestController
public class OrderFeignController {
    @Autowired
    private PaymentFeignClient paymentFeignClient;

    // 客户端用浏览器应发送get请求
    @GetMapping("/consumer/payment/create")
    public CommonResult<Integer> create(Payment payment) {
        return paymentFeignClient.create(payment);
    }

    @GetMapping("/consumer/payment/get/{id}")
    public CommonResult<Payment> getPayment(@PathVariable("id") Long id) {
        return paymentFeignClient.getPaymentById(id);
    }
}
```

### 2.6 测试

- 启动Nacos、8001、8002、80
- 访问`http://localhost:8848/nacos`可以查看服务注册的情况
- 访问`http://localhost/consumer/payment/create?serial=haha666`能正确创建新记录(可在数据库中查看)
- 访问`http://localhost/consumer/payment/get/1`能正确获取信息(并且有负载均衡效果，即轮询端口8001和8002)

## 3. OpenFeign超时控制

### 3.1 设置OpenFeign客户端的超时控制

在cloud-consumer-feign-order80的配置文件中添加：

```properties
# 连接超时时间(单位ms)
spring.cloud.openfeign.client.config.default.connect-timeout=2000
# 读超时时间(单位ms)
spring.cloud.openfeign.client.config.default.read-timeout=5000
```

- 连接超时时间，即consumer连接上provider的时间阈值，主要由网络状况决定
- 读超时时间，即consumer发起请求直到收到provider的响应的这段时间的阈值，主要由provider的业务处理时长决定

> 说明：OpenFeign默认的connectTimeout为10秒，默认的readTimeout为60秒

### 3.2 超时场景模拟

（1）服务提供者8001中添加睡眠程序

```java
@GetMapping("/payment/feign/timeout")
public String paymentFeignTimeout() {
    // 暂停6秒钟
    try {
        TimeUnit.SECONDS.sleep(6);
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
    return serverPort;
}
```

（2）服务消费者cloud-consumer-feign-order80添加对应的远程调用方法

在PaymentFeignClient中添加：

```java
@GetMapping("/payment/feign/timeout")
String paymentFeignTimeout();
```

在OrderFeignController中添加：

```java
@GetMapping("/consumer/payment/feign/timeout")
public String paymentFeignTimeout() {
    return paymentFeignClient.paymentFeignTimeout();
}
```

（3）测试

- 启动Nacos、8001、80
- 访问`http://localhost:8001/payment/feign/timeout`正确
- 但访问`http://localhost/consumer/payment/feign/timeout`却得到一个错误页

**原因：我们设置了OpenFeign客户端的读超时时间为5秒，但是服务端处理需要6秒钟，所以返回报错**。

## 4. OpenFeign重试机制

远程调用超时失败后，OpenFeign**默认不会进行重试**。但我们也可以配置重试器来进行重试，详细参考OpenFeign官方文档。



# 第06章_Gateway网关

## 1. Gateway简介

### 1.1 概述

网关是系统唯一对外的入口，介于客户端和服务器之间，用于对请求进行鉴权、限流、路由、监控等功能。

以前使用的网关主要是Netflix公司的Zuul，但它的1.0版本已经停止维护，2.0版本刚推出的时候又不开源，所以SpringCloud自研了Gateway来作为网关。

Spring Cloud Gateway 是 SpringCloud 的一个全新项目，它旨在为微服务架构提供一种简单有效的**统一的API路由管理方式**，以及基于**Filter链**的方式提供网关的基本功能。为了提升网关的性能，Spring Cloud Gateway是**基于WebFlux框架实现**的，而WebFlux框架底层则使用了高性能的**Reactor模式通信框架Netty**。

**微服务架构中网关的位置**：

![](images/Snipaste20231018150041.png)

### 1.2 Gateway和Zuul的对比

Zuul的1.0版本是一个基于Servlet2.5的阻塞I/O的API网关，且不支持任何长连接(如WebSocket)，性能相对较差。

而Spring Cloud Gateway建立在Spring Framework、Project Reactor和Spring Boot之上，基于WebFlux框架，使用**异步非阻塞API**，它还**支持WebSocket**，并且与Spring紧密集成拥有更好的开发体验。

> WebFlux是一个典型**异步非阻塞**的框架，它的核心是基于Reactor的相关API实现的。相对于传统的web框架来说，它可以运行在诸如Netty，Undertow及支持Servlet3.1的容器上(Servlet3.1之后才有异步非阻塞的支持)。

### 1.3 三大核心概念

**（1）Route(路由)**

路由是构建网关的基本模块，它由一个路由ID、一个目标地址URI、一组断言工厂和一组过滤器组成。如果断言为true，则请求将经由Filter链被路由到目标URI。

**（2）Predicate(断言)**

断言即一个条件判断，根据当前HTTP请求进行指定规则的匹配，例如根据HTTP请求头、请求时间、请求参数等。只有匹配上规则时，断言才为true。

- 一个路由规则可以包含多个断言
- 如果一个路由规则中有多个断言，则需要同时满足才能匹配
- 如果一个请求可以匹配多个路由，则映射第一个匹配成功的路由

**（3）Filter(过滤器)**

Filter是**对请求或响应进行处理**的逻辑部分。当请求的断言为true时，会被路由到设置好的过滤器。过滤器可以对请求或响应进行处理，例如给请求额外添加一个请求参数、给响应额外添加header等。

### 1.4 Gateway工作流程

![](images/Snipaste20231018152307.png)

1. **路由判断**：客户端的请求到达网关后，先经过 Gateway Handler Mapping 处理，这里面会做断言（Predicate）判断，看下符合哪个路由规则，这个路由映射后端的某个服务。
2. **请求过滤**：然后请求到达Gateway Web Handler，这里面有很多过滤器，组成过滤器链，这些过滤器可以对请求进行拦截和修改，比如添加请求头、参数校验等等。然后将请求转发到实际的后端服务。这些过滤器逻辑上可以称作Pre-Filters。
3. **服务处理**：后端服务会对请求进行处理。
4. **响应过滤**：后端处理完结果后，返回给 Gateway 的过滤器再次做处理，逻辑上可以称作Post-Filters。
5. **响应返回**：响应经过过滤处理后，返回给客户端。

> 在pre类型的过滤器中可以做参数校验、权限校验、流量监控、日志输出、协议转换等
>
> 在post类型的过滤器中可以做响应内容、响应头的修改、日志输出、流量监控等

## 2. 案例实战

### 2.1 创建模块cloud-gateway9527

### 2.2 添加依赖

**注意，使用Spring Cloud Gateway，一定不能添加WebMvc场景**。除此之外，必须添加LoadBalancer依赖，才能使用Gateway集成LoadBalancer后的负载均衡功能。

```xml
<!-- gateway -->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-gateway</artifactId>
</dependency>
<!-- nacos-discovery -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
</dependency>
<!-- loadbalancer -->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-loadbalancer</artifactId>
</dependency>
```

### 2.3 主启动类

```java
@SpringBootApplication
public class GateWayMain9527 {
    public static void main(String[] args) {
        SpringApplication.run(GateWayMain9527.class, args);
    }
}
```

### 2.4 配置文件

我们希望9527网关能做以下路由映射：

- 当请求路径为`/payment/get/**`时，路由到服务提供者8001或8002
- 当请求路径为`/guonei`时，路由到国内的百度新闻

```yml
server:
  port: 9527
spring:
  application:
    name: cloud-gateway
  cloud:
    nacos:
      # Nacos Server地址
      server-addr: 127.0.0.1:8848
    gateway:
      # 开启从注册中心动态创建路由的功能，即可以利用微服务名进行路由
      discovery:
        locator:
          enabled: true
      # 配置路由信息
      routes:
        - id: payment_route # 路由id，必须唯一
          uri: lb://cloud-provider-payment # 目标地址
          predicates: # 断言
            - Path=/payment/get/** # 请求路径匹配该Path时，断言为true
        - id: guonei_route
          uri: http://news.baidu.com
          predicates:
            - Path=/guonei
```

- 注1：我们需要开启从注册中心动态创建路由的功能，这样Gateway才能根据注册中心上的微服务名创建动态路由。
- 注2：**uri的协议如果为lb，就表示启用Gateway集成LoadBalancer的负载均衡功能**
- 注3：当我们访问网关时，请求路径将被拼接到目标uri之后。例如我们访问`http://localhost:9527/payment/get/2`，则由于请求路径为`/payment/get/2`，所以它会匹配路由id为payment_route的路由(因为其断言为true)，然后将请求路径拼接到目标uri之后，即访问`lb://cloud-provider-payment/payment/get/2`

### 2.5 测试

- 启动Nacos、8001、8002、9527
- 访问`http://localhost:9527/payment/get/2`成功
- 访问`http://localhost:9527/guonei`成功

## 3. Route Predicate Factories

### 3.1 简介

Spring Cloud Gateway将路由匹配作为Spring WebFlux HandlerMapping基础架构的一部分。Spring Cloud Gateway包含许多内置的Route Predicate工厂。所有这些Predicate都与HTTP请求的不同属性匹配。多个Route Predicate工厂可以**通过逻辑and**进行组合使用。

Spring Cloud Gateway创建Route对象时，使用RoutePredicateFactory创建Predicate对象，Predicate对象可以赋值给Route。

> **总结：Predicate就是为了实现一组匹配规则，当断言为true时才将请求进行路由**。

### 3.2 Predicate测试案例搭建

（1）创建模块cloud-gateway-predicate-test9528

（2）添加依赖(同9527)

（3）主启动类

（4）配置文件

```yml
server:
  port: 9528
spring:
  application:
    name: cloud-gateway-predicate-test
  cloud:
    nacos:
      server-addr: 127.0.0.1:8848
    gateway:
      discovery:
        locator:
          enabled: true
      # 配置路由信息
      routes:
        - id: route1
          uri: lb://cloud-provider-payment
          predicates:
            - Path=/payment/get/1
            - After=2023-10-18T15:10:03.685+08:00[Asia/Shanghai]
        - id: route2
          uri: lb://cloud-provider-payment
          predicates:
            - Path=/payment/get/2
            - Before=2023-10-18T15:10:03.685+08:00[Asia/Shanghai]
        - id: route3
          uri: lb://cloud-provider-payment
          predicates:
            - Path=/payment/get/3
            - Between=2023-10-18T15:10:03.685+08:00[Asia/Shanghai], 2024-10-18T15:10:03.685+08:00[Asia/Shanghai]
        - id: route4
          uri: lb://cloud-provider-payment
          predicates:
            - Path=/payment/get/4
            - Cookie=username, wsy
        - id: route5
          uri: lb://cloud-provider-payment
          predicates:
            - Path=/payment/get/5
            - Header=thu, \d+  # 请求头要有thu属性并且值为自然数
        - id: route6
          uri: lb://cloud-provider-payment
          predicates:
            - Path=/payment/get/6
            - Host=localhost:9528
        - id: route7
          uri: lb://cloud-provider-payment
          predicates:
            - Path=/payment/get/7
            - Method=GET
        - id: route8
          uri: lb://cloud-provider-payment
          predicates:
            - Path=/payment/get/8
        - id: route9
          uri: lb://cloud-provider-payment
          predicates:
            - Path=/payment/get/9
            - Query=thu, \d+ # 请求参数要有thu，并且值为自然数
        - id: route10_high
          uri: lb://cloud-provider-payment
          predicates:
            - Path=/payment/get/10
            - Weight=group666, 9
        - id: route10_low
          uri: http://www.baidu.com
          predicates:
            - Path=/payment/get/10
            - Weight=group666, 1
        - id: route11
          uri: lb://cloud-provider-payment
          predicates:
            - Path=/payment/get/11
            - RemoteAddr=172.21.16.1/24
        - id: route12
          uri: lb://cloud-provider-payment
          predicates:
            - Path=/payment/get/12
            - XForwardedRemoteAddr=192.168.111.111
```

（5）测试：启动Nacos、8001、8002、9528

### 3.3 常用的Route Predicate Factory

#### 1、After

After接收一个时间参数。对于在该时间之后的请求，断言为true。

测试：访问`http://localhost:9528/payment/get/1`成功，因为现在的时间确实在指定时间之后。

#### 2、Before

Before接收一个时间参数。对于在该时间之前的请求，断言为true。

测试：访问`http://localhost:9528/payment/get/2`失败，因为现在的时间并不在指定时间之前。

#### 3、Between

Between接收两个时间参数。对于在这两个时间之间的请求，断言为true。

测试：访问`http://localhost:9528/payment/get/3`成功。

#### 4、Cookie

Cookie接收两个参数，一个是Cookie name，一个是正则表达式。路由规则会通过获取对应的Cookie name对应的值和正则表达式去匹配，如果匹配则返回true。

测试：用Postman携带一个`username=wsy`的Cookie访问`http://localhost:9528/payment/get/4`成功，若不携带则访问失败。

#### 5、Header

Header接收两个参数，一个是请求头属性名称，一个是正则表达式。当请求的请求头中这个属性对应的值和正则表达式匹配则返回true。

测试：用Postman携带一个key为thu，value为自然数的请求头，访问`http://localhost:9528/payment/get/5`成功

#### 6、Host

Host接收的参数是一组匹配的域名列表。如果请求头中的Host值在这组域名列表中，则断言为true。

测试：访问`http://localhost:9528/payment/get/6`成功，但访问`http://127.0.0.1:9528/payment/get/6`失败

#### 7、Method

请求方式必须为指定的方式才返回true

测试：访问`http://localhost:9528/payment/get/7`成功

#### 8、Path

请求路径必须为指定Path才返回true

测试：访问`http://localhost:9528/payment/get/8`成功

#### 9、Query

Query接收两个参数，一个是请求参数的名称，一个是对应的值(可以是正则表达式)。当请求携带该请求参数，并且其值与正则表达式匹配，则返回true。

测试：访问`http://localhost:9528/payment/get/9?thu=666`成功

#### 10、Weight

Weight接收两个参数，一个是分组名称，一个是权重。当一个请求匹配多个同组路由，根据Weight指定的权重决定最终的路由。

测试：访问`http://localhost:9528/payment/get/10`，有90%几率成功，有10%几率失败

#### 11、RemoteAddr

RemoteAddr接收的参数是一组ip地址。当客户端ip在指定的ip地址中时，断言为true。

例如，`RemoteAddr=172.21.16.1/24`就表示客户端ip为172.21.16.x时可以访问。

测试：访问`http://172.21.16.1:9528/payment/get/11`成功

#### 12、XForwarded Remote Addr

XForwarded Remote Addr接收的参数是一组ip地址。当请求头中的最后一个X-Forwarded-For的值在指定的ip地址中时，断言为true。

测试：访问`http://localhost:9528/payment/get/12`失败，但用Postman添加请求头`X-Forwarded-For: 192.168.111.111`后访问成功

### 3.4 自定义Route Predicate Factory

（1）创建模块cloud-gateway-predicate-define9529

（2）添加依赖(同9527)

（3）主启动类

（4）配置文件

```yml
server:
  port: 9529
spring:
  application:
    name: cloud-gateway-predicate-define
  cloud:
    nacos:
      server-addr: 127.0.0.1:8848
    gateway:
      discovery:
        locator:
          enabled: true
```

#### 1、自定义Auth认证

需求：当请求头中携带有用户名和密码的key-value对，且用户名与配置文件中Auth路由断言工厂中指定的username相同，密码与Auth路由断言工厂中指定的password相同时，才能通过认证，允许访问。

（1）创建Auth断言工厂

**注意**：该类的类名由两部分构成，后面必须是RoutePredicateFactory，前面为功能前缀，用于在配置文件中指定断言名称。

```java
@Component
public class AuthRoutePredicateFactory extends AbstractRoutePredicateFactory<AuthRoutePredicateFactory.Config> {
    public AuthRoutePredicateFactory() {
        super(Config.class);
    }
    
    @Override
    public Predicate<ServerWebExchange> apply(Config config) {
        return exchange -> {
            // 获取请求头中的所有header
            HttpHeaders headers = exchange.getRequest().getHeaders();
            // 获取指定用户名(key)对应的密码(value)
            List<String> pwd = headers.get(config.getUsername());
            return pwd.contains(config.getPassword());
        };
    }
    
    @Override
    public List<String> shortcutFieldOrder() {
        return Arrays.asList("username", "password");
    }
    
    public static class Config {
        private String username;
        private String password;
        public String getUsername() {
            return username;
        }
        public String getPassword() {
            return password;
        }
        public void setUsername(String username) {
            this.username = username;
        }
        public void setPassword(String password) {
            this.password = password;
        }
    }
}
```

（2）配置文件中添加路由

```yml
spring:
  cloud:
    gateway:
      routes:
        - id: auth_route
          uri: lb://cloud-provider-payment
          predicates:
            - Path=/payment/get/1
            - Auth=wsy, 666
```

> 如上，当请求路径为`/payment/get/1`且请求头中携带`wsy: 666`时断言才为true

（3）测试

- 启动Nacos、8001、8002、9529
- 访问`http://localhost:9529/payment/get/1`失败
- Postman中携带请求头`wsy: 666`访问成功

#### 2、自定义Token认证

需求：当请求中携带一个token请求参数，且参数值与配置文件中Token路由断言工厂指定的Token值匹配才能通过认证。

（1）创建Token断言工厂

```java
@Component
public class TokenRoutePredicateFactory extends AbstractRoutePredicateFactory<TokenRoutePredicateFactory.Config> {
    public TokenRoutePredicateFactory() {
        super(Config.class);
    }

    @Override
    public Predicate<ServerWebExchange> apply(Config config) {
        return exchange -> {
            // 获取请求中的所有请求参数
            MultiValueMap<String, String> params = exchange.getRequest().getQueryParams();
            List<String> values = params.get("token");
            return values.contains(config.getToken());
        };
    }

    @Override
    public List<String> shortcutFieldOrder() {
        return Arrays.asList("token");
    }

    public static class Config {
        private String token;
        public String getToken() {
            return token;
        }
        public void setToken(String token) {
            this.token = token;
        }
    }
}
```

（2）配置文件中添加路由

```yml
spring:
  cloud:
    gateway:
      routes:
        - id: token_route
          uri: lb://cloud-provider-payment
          predicates:
            - Path=/payment/get/2
            - Token=haha
```

> 如上，当请求路径为`/payment/get/2`且含有请求参数`token=haha`时断言才为true

（3）测试

- 启动Nacos、8001、8002、9529
- 访问`http://localhost:9529/payment/get/2`失败
- 访问`http://localhost:9529/payment/get/2?token=haha`成功

## 4. GatewayFilter Factories

### 4.1 简介

网关过滤器工厂允许以某种方式**修改传入的HTTP请求或返回的HTTP响应**，分别称为pre类型和post类型。网关过滤工厂主要作用在某个具体的路由。Spring Cloud Gateway包含了很多内置的网关过滤器工厂。

### 4.2 GatewayFilter测试案例搭建

#### 1、服务提供者

> 新创建一个服务提供者，因为需要用于测试输出请求头等信息

（1）创建模块cloud-gateway-provider9500

（2）添加依赖

```xml
<!-- nacos-discovery -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
```

（3）配置文件

```properties
server.port=9500
spring.application.name=cloud-gateway-provider
spring.cloud.nacos.server-addr=127.0.0.1:8848
```

（4）主启动类

```java
@SpringBootApplication
public class GatewayProvider9500 {
    public static void main(String[] args) {
        SpringApplication.run(GatewayProvider9500.class, args);
    }
}
```

（5）业务类

```java
@RestController
public class ProviderController {
    @GetMapping("/add/header/test")
    public String headerHandler(HttpServletRequest request) {
        String value = request.getHeader("my-header");
        return "请求头my-header: " + value;
    }
    @GetMapping("/add/param/test")
    public String paramHandler(HttpServletRequest request) {
        String value = request.getParameter("color");
        return "请求参数color=" + value;
    }
    @GetMapping("/response/header/test")
    public String responseHeaderHandler() {
        return "ok";
    }
    @GetMapping("/all/test")
    public String allHandler(HttpServletRequest request) {
        String v1 = request.getHeader("wsy-header");
        String v2 = request.getParameter("wsy-param");
        return "wsy-header: " + v1 + ", wsy-param=" + v2;
    }
}
```

#### 2、Gateway

（1）创建模块cloud-gateway-filter-test9530

（2）添加依赖

```xml
<!-- gateway -->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-gateway</artifactId>
</dependency>
<!-- nacos-discovery -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
</dependency>
<!-- loadbalancer -->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-loadbalancer</artifactId>
</dependency>
```

（3）主启动类

```java
@SpringBootApplication
public class GateWayMain9530 {
    public static void main(String[] args) {
        SpringApplication.run(GateWayMain9530.class, args);
    }
}
```

（4）配置文件

```yml
server:
  port: 9530
spring:
  application:
    name: cloud-gateway-filter-test
  cloud:
    nacos:
      server-addr: 127.0.0.1:8848
    gateway:
      discovery:
        locator:
          enabled: true
      # 配置路由信息
      routes:
        - id: route1
          uri: lb://cloud-gateway-provider
          predicates:
            - Path=/add/header/test
          filters:
            - AddRequestHeader=my-header, wsy
        - id: route2
          uri: lb://cloud-gateway-provider
          predicates:
            - Path=/add/param/test
          filters:
            - AddRequestParameter=color, red
        - id: route3
          uri: lb://cloud-gateway-provider
          predicates:
            - Path=/response/header/test
          filters:
            - AddResponseHeader=my-response, 666
        - id: route4
          uri: lb://cloud-gateway-provider
          predicates:
            - Path=/param/test
          filters:
            - PrefixPath=/add
        - id: route5
          uri: lb://cloud-gateway-provider
          predicates:
            - Path=/*/*/add/param/test
          filters:
            - StripPrefix=2
        - id: route6
          uri: lb://cloud-gateway-provider
          predicates:
            - Path=/api/add/param/test
          filters:
            - RewritePath=/api/?(?<segment>.*), /$\{segment}
```


#### 3、测试

启动Nacos、9500、9530，做接下来的测试

### 4.3 常用的GatewayFilter Factory

#### 1、AddRequestHeader

AddRequestHeader接收两个参数，例如`AddRequestHeader=my-header, wsy`，就会给当前请求添加请求头`my-header: wsy`

测试：访问`http://localhost:9530/add/header/test`

#### 2、AddRequestParameter

AddRequestParameter接收两个参数，例如`AddRequestParameter=color, red`，就会给当前请求添加请求参数`color=red`

测试：访问`http://localhost:9530/add/param/test`

#### 3、AddResponseHeader

AddResponseHeader接收两个参数，例如`AddResponseHeader=my-response, 666`，就会给响应添加响应头`my-response: 666`

测试：打开F12，访问`http://localhost:9530/response/header/test`，查看响应头中有`my-response: 666`

#### 4、PrefixPath

PrefixPath给请求路径添加前缀，例如请求路径为`/param/test`，则设置`PrefixPath=/add`后，真正的请求路径就变成了`/add/param/test`

测试：访问`http://localhost:9530/param/test`

#### 5、StripPrefix

StripPrefix给请求路径去掉前缀，例如请求路径为`/aaa/bbb/add/param/test`，则设置`StripPrefix=2`后，就会去掉前2级前缀，真正的请求路径就变成了`/add/param/test`

测试：访问`http://localhost:9530/aaa/bbb/add/param/test`

#### 6、RewritePath

RewritePath可以将请求路径的一部分，替换成指定路径。例如请求路径为`/api/add/param/test`，则设置`RewritePath=/api/?(?<segment>.*), /$\{segment}`后，就会将请求路径中的`/api`抹去，真正的请求路径就变成了`/add/param/test`

测试：访问`http://localhost:9530/api/add/param/test`

> 说明：RewritePath支持正则表达式

### 4.4 Default Filters

前面都是针对某一个具体的路由来配置GatewayFilter，我们也可以在配置文件中配置Default Filters将其应用到所有的路由上。

（1）创建模块cloud-gateway-filter-default9531

（2）添加依赖(同9530)

（3）主启动类

（4）配置文件

```yml
server:
  port: 9531
spring:
  application:
    name: cloud-gateway-filter-default
  cloud:
    nacos:
      server-addr: 127.0.0.1:8848
    gateway:
      discovery:
        locator:
          enabled: true
      # 配置default-filters
      default-filters:
        - AddRequestHeader=wsy-header, 123
      # 配置路由信息
      routes:
        - id: my_route
          uri: lb://cloud-gateway-provider
          predicates:
            - Path=/all/test
          filters:
            - AddRequestParameter=wsy-param, 456
```

（5）测试

启动Nacos、9500、9531，访问`http://localhost:9531/all/test`，发现请求头和请求参数都添加了，说明正确触发了我们设置的默认过滤器。

### 4.5 自定义GatewayFilter Factory

（1）创建模块cloud-gateway-filter-define9532

（2）添加依赖(同9530)

（3）主启动类

（4）自定义GatewayFilter Factory

我们自己创建一个给请求添加请求头的网关过滤器工厂，注意该类的类名由两部分构成，后面必须是GatewayFilterFactory，前面为功能前缀，用于在配置文件中指定过滤器名称：

```java
@Component
public class MyHeaderGatewayFilterFactory extends AbstractNameValueGatewayFilterFactory {
    @Override
    public GatewayFilter apply(NameValueConfig config) {
        return (exchange, chain) -> {
            ServerHttpRequest req = exchange.getRequest().mutate()
                    .header(config.getName(), config.getValue())
                    .build();
            ServerWebExchange exc = exchange.mutate().request(req).build();
            return chain.filter(exc);
        };
    }
}
```

（5）配置文件

```yml
server:
  port: 9532
spring:
  application:
    name: cloud-gateway-filter-define
  cloud:
    nacos:
      server-addr: 127.0.0.1:8848
    gateway:
      discovery:
        locator:
          enabled: true
      routes:
        - id: define_route
          uri: lb://cloud-gateway-provider
          predicates:
            - Path=/all/test
          filters:
            - MyHeader=wsy-header, haha
```

（6）测试

启动Nacos、9500、9532，访问`http://localhost:9532/all/test`，发现请求头已成功添加。

## 5. Global Filters

### 5.1 简介

全局过滤器是应用于所有路由上的Filter，同样有pre类型和post类型，与前面的Default Filters很类似。只不过Spring Cloud Gateway中已经定义好了很多GlobalFilter，且这些GlobalFilter无需任何配置和声明，只要符合应用条件就会自动生效。

> 例如我们之前使用的uri协议为lb，它就自动使用了Gateway的负载均衡全局过滤器。

### 5.2 自定义Global Filter

自定义GlobalFilter可以提供更多功能，例如全局日志记录、统一网关鉴权等。只需编写一个组件，实现GlobalFilter和Ordered接口即可，无需在具体的路由规则中进行配置。

（1）创建模块cloud-gateway-filter-global9533

（2）添加依赖(同9530)

（3）主启动类

（4）配置文件

```yml
server:
  port: 9533
spring:
  application:
    name: cloud-gateway-filter-global
  cloud:
    nacos:
      server-addr: 127.0.0.1:8848
    gateway:
      discovery:
        locator:
          enabled: true
      routes:
        - id: global_route
          uri: lb://cloud-gateway-provider
          predicates:
            - Path=/all/test
```

（5）自定义GlobalFilter

```java
@Component
public class MyGlobalFilter implements GlobalFilter, Ordered {
    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        String uname = exchange.getRequest().getQueryParams().getFirst("uname");
        if (uname == null) {
            // 如果请求参数中没有uname，则禁止登录
            exchange.getResponse().setStatusCode(HttpStatus.NOT_ACCEPTABLE);
            return exchange.getResponse().setComplete();
        }
        // 如果请求参数中有uname，视为已登录，直接放行
        return chain.filter(exchange);
    }

    @Override // Filter的优先级
    public int getOrder() {
        return 0;
    }
}
```

（6）测试

- 启动Nacos、9500、9533
- 访问`http://localhost:9533/all/test`失败
- 访问`http://localhost:9533/all/test?uname=11`成功

## 6. 跨域配置

### 6.1 跨域概述

为了安全，浏览器中启用了一种称为**同源策略**的安全机制，禁止从一个域名页面中请求另一个域名下的资源。当两个请求的**访问协议、域名、端口号**这三者都相同时，才称它们是**同源**请求，否则就称为**跨域**请求。

CORS(Cross-Origin Resource Sharing)跨域资源共享，是一种允许当前域的资源被其他域的脚本请求访问的机制。事实上，一个非简单的跨域请求，实际上会经历以下两步：

1. 首先向服务器发送一个**预检请求**（Request Method为**OPTIONS**）；然后服务器会响应是否允许跨域（通过在响应头设置`Access-Control-Allow-Origin`等信息）；
2. 只有收到了允许跨域的响应后，接下来才会向服务器发送**真正的请求**。

### 6.2 跨域问题模拟

（1）创建模块cloud-gateway-cross-origin9534

（2）添加依赖(同9530)

（3）主启动类

（4）配置文件

```yml
server:
  port: 9534
spring:
  application:
    name: cloud-gateway-cross-origin
  cloud:
    nacos:
      server-addr: 127.0.0.1:8848
    gateway:
      discovery:
        locator:
          enabled: true
      routes:
        - id: cross_route
          uri: lb://cloud-gateway-provider
          predicates:
            - Path=/all/test
```

（5）在`classpath:/static/`下放一个abc.html页面

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="https://s3.pstatp.com/cdn/expire-1-M/jquery/3.3.1/jquery.min.js"></script>
    <script>
        function access() {
            $.get("http://localhost:9534/all/test", function (data) {
                alert(data)
            });
        }
    </script>
</head>
<body>
    <button onclick="access()">访问</button>
</body>
</html>
```

（6）测试

- 启动Nacos、9500、9534
- 右键用浏览器打开abc.html，打开F12，点击访问按钮，发现发生了跨域问题

![](images/Snipaste20231101204200.png)

### 6.3 跨域问题的解决方案

在Gateway中添加一个配置类：

```java
@Configuration
public class CorsConfig {
    @Bean
    public CorsWebFilter corsFilter() {
        CorsConfiguration config = new CorsConfiguration();
        config.addAllowedMethod("*");
        config.addAllowedOrigin("*");
        config.addAllowedHeader("*");

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource(new PathPatternParser());
        source.registerCorsConfiguration("/**", config);
        return new CorsWebFilter(source);
    }
}
```



# 第07章_Sentinel流量治理

## 1. Sentinel简介

### 1.1 概述

官方文档 https://sentinelguard.io/zh-cn/docs/introduction.html

随着微服务的流行，服务和服务之间的稳定性变得越来越重要。Sentinel是面向分布式、多语言异构化服务架构的**流量治理组件**，主要以流量为切入点，从流量路由、流量控制、流量整形、熔断降级、系统自适应过载保护、热点流量防护等多个维度来帮助开发者保障微服务的稳定性。

Sentinel的主要特性：

![](images/Snipaste20231022153355.png)

> 说明：Sentinel也支持与Gateway进行整合，在网关入口处进行流控。

Sentinel分为两个部分：

- 核心库(Java客户端)：不依赖任何框架/库，能够运行于所有Java运行时环境，同时对Dubbo、Spring Cloud等框架也有较好的支持
- 控制台(Dashboard)：主要负责管理推送规则、监控、管理机器信息等，它的默认占用端口是8080

### 1.2 安装Sentinel控制台

（1）下载地址 https://github.com/alibaba/Sentinel/releases

（2）将sentinel-dashboard-1.8.6.jar下载到本地

（3）执行以下命令启动(注意要有java环境，且8080端口不能被占用)

```cmd
java -jar sentinel-dashboard-1.8.6.jar
```

> 可以使用以下参数
> - `-Dserver.port=8080`来指定控制台端口号
> - `-Dsentinel.dashboard.auth.username=sentinel`来指定登录账号
> - `-Dsentinel.dashboard.auth.password=sentinel`来指定登录密码

（4）访问Sentinel管理界面`http://localhost:8080`，默认账号密码均为sentinel

### 1.3 三个重要概念

#### 1、服务降级

服务降级指的是当用户的请求由于各种原因被拒后，系统返回一个事先设定好的、用户可以接受的结果。

发生服务降级的情况有：程序运行异常、超时、服务熔断触发服务降级、线程池/信号量打满等。

**一般服务降级处理逻辑都是编写在服务消费端**，而不是服务提供端。

#### 2、服务熔断

服务熔断是应对服务雪崩的一种微服务链路保护机制，它指的是当某个微服务出错或者请求访问达到阈值时，会熔断该微服务一段时间，对于在这段时间内的请求都会直接返回服务降级的结果，当检测到该节点正常后再逐渐恢复调用链路。

> **服务雪崩**，就是发生级联的故障。分布式系统中的微服务会有许多互相调用的依赖关系，一旦某个节点发生异常，调用该微服务的请求都会被阻塞，于是整条链路就都被阻塞了，就会占用越来越多的系统资源，进而引起系统崩溃，这就是服务雪崩。

**熔断的三种状态**：

- 熔断关闭：即不对服务进行熔断
- 熔断打开：即对服务进行熔断，请求不会再调用当前服务，熔断打开状态将持续一定的时间(称之为**熔断时长**)，之后就进入熔断半开状态
- 熔断半开：此时第一个请求会调用当前服务，如果该请求符合指定的成功条件，则关闭熔断；否则就再次进入熔断打开状态

**服务熔断流程**：

1. 当请求达到阈值时(例如出现异常率达到阈值)，断路器就会开启，进入熔断打开状态
2. 在熔断打开状态内，所有的请求不会再调用当前服务的主逻辑，而是会直接调用服务降级的方法
3. 经过熔断时长后，进入熔断半开状态
4. 处于熔断半开状态，会让第一个请求调用当前服务主逻辑，如果该请求符合指定的成功条件，就关闭断路器、恢复服务主逻辑；否则，继续开启断路器，回到步骤2

#### 3、服务限流

服务限流就是对访问流量进行控制。Sentinel实现流控的原理是监控应用流量的QPS或并发线程数等指标，当达到指定的阈值时对再到来的请求进行控制，以避免被瞬时的流量高峰冲垮，从而保障应用的高可用性。

## 2. 服务降级案例实战

### 2.1 Sentinel式服务降级

> 使用Sentinel式服务降级，核心就是用注解@SentinelResource来定义资源和服务降级方法

#### 1、创建模块cloud-consumer-sentinel81

#### 2、添加依赖

```xml
<!-- nacos-discovery -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
</dependency>
<!-- sentinel -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-sentinel</artifactId>
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
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
<dependency>
    <groupId>com.wsy.cloud</groupId>
    <artifactId>cloud-api-commons</artifactId>
    <version>${project.version}</version>
</dependency>
```

#### 3、配置文件

应用启动后，底层还会启动一个Http Server，用于和Sentinel控制台进行交互，默认占用的端口号为8719（可以通过配置项`spring.cloud.sentinel.transport.port`进行修改）。比如Sentinel控制台添加了一个流控规则，就会把规则数据push给这个Http Server接收。

```properties
server.port=81
spring.application.name=cloud-consumer-sentinel
# Nacos注册中心地址
spring.cloud.nacos.server-addr=127.0.0.1:8848
# Sentinel Dashboard地址
spring.cloud.sentinel.transport.dashboard=127.0.0.1:8080
```

> 注意：**Sentinel默认开启懒加载**，所以当微服务启动后，只有访问一次微服务后，该微服务才会出现在Sentinel控制台上。如果不想使用懒加载，则可以设置`spring.cloud.sentinel.eager=true`开启饥饿加载。

#### 4、主启动类

```java
@SpringBootApplication
@EnableFeignClients
public class SentinelMain81 {
    public static void main(String[] args) {
        SpringApplication.run(SentinelMain81.class, args);
    }
}
```

#### 5、业务类

**PaymentFeignClient接口**：

```java
@FeignClient(value = "cloud-provider-payment")
public interface PaymentFeignClient {
    @GetMapping("/payment/get/{id}")
    CommonResult<Payment> getPaymentById(@PathVariable("id") Long id);
}
```

**PaymentController**：在控制层通过@SentinelResource定义资源和服务降级方法

```java
@RestController
public class PaymentController {
    @Autowired
    private PaymentFeignClient paymentFeignClient;

    @GetMapping("/consumer/payment/{id}")
    @SentinelResource(value = "payment",
            fallbackClass = PaymentFallback.class,
            fallback = "paymentFallbackMethod")
    public CommonResult<Payment> getPayment(@PathVariable("id") Long id) {
        CommonResult<Payment> res = paymentFeignClient.getPaymentById(id);
        if (res.getData() == null) {
            throw new NullPointerException("该id没有对应记录");
        }
        return res;
    }
}
```

> 说明：value用于定义资源名称，fallbackClass指定服务降级类，fallback指定服务降级方法。

**PaymentFallback**：创建一个服务降级类，用于统一定义服务降级方法

```java
public class PaymentFallback {
    public static CommonResult<Payment> paymentFallbackMethod(Long id, Throwable e) {
        Payment payment = new Payment(id, "");
        return new CommonResult<>(44444, "异常:" + e, payment);
    }
}
```

> 注意：这里的服务降级方法定义在PaymentController之外的类中，所以方法必须声明为public static。详见后面的@SentinelResource注解详解。

#### 6、Sentinel配置

![](images/Snipaste20231024143313.png)

#### 7、测试

- 启动Nacos、Sentinel、8001、8002、81
- 访问`http://localhost:81/consumer/payment/1`正确得到结果；如果快速访问，则返回错误码为44444的信息

### 2.2 OpenFeign式服务降级

#### 1、创建模块cloud-consumer-sentinel82

#### 2、添加依赖(同81)

#### 3、配置文件

> 需要激活Sentinel对OpenFeign的支持

```properties
server.port=82
spring.application.name=cloud-consumer-sentinel
# Nacos服务注册中心地址
spring.cloud.nacos.server-addr=127.0.0.1:8848
# Sentinel Dashboard地址
spring.cloud.sentinel.transport.dashboard=127.0.0.1:8080
# 激活Sentinel对OpenFeign的支持
feign.sentinel.enabled=true
```

#### 4、主启动类(同81)

#### 5、业务类

**PaymentFeignClient**：

```java
@FeignClient(value = "cloud-provider-payment", fallback = PaymentFeignClientFallback.class)
public interface PaymentFeignClient {
    @GetMapping("/payment/get/{id}")
    CommonResult<Payment> getPaymentById(@PathVariable("id") Long id);
}
```

> @FeignClient的fallback属性指定一个服务降级类（**该类必须实现该接口，且在IoC容器中**），当远程调用超时或者失败时，就会调用对应的服务降级方法。

**PaymentFeignClientFallback**：

```java
@Component
public class PaymentFeignClientFallback implements PaymentFeignClient {
    @Override
    public CommonResult<Payment> getPaymentById(Long id) {
        Payment payment = new Payment(id, "");
        return new CommonResult<>(4444, "服务降级", payment);
    }
}
```

**PaymentController**：

```java
@RestController
public class PaymentController {
    @Autowired
    private PaymentFeignClient paymentFeignClient;

    @GetMapping("/consumer/payment/{id}")
    public CommonResult<Payment> getPayment(@PathVariable("id") Long id) {
        CommonResult<Payment> res = paymentFeignClient.getPaymentById(id);
        if (res.getData() == null) {
            throw new NullPointerException("该id没有对应记录");
        }
        return res;
    }
}
```

#### 6、测试

- 启动Nacos、Sentinel、8001、8002、82
- 访问`http://localhost:82/consumer/payment/1`正确得到结果
- 关闭8001和8002，再次访问上述url，得到服务降级的结果（返回错误码为4444的信息）

## 3. @SentinelResource

### 3.1 测试案例搭建

#### 1、创建模块cloud-sentinel-test83

#### 2、添加依赖

```xml
<!-- nacos-discovery -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
</dependency>
<!-- sentinel-datasource-nacos 后续做持久化会使用-->
<dependency>
    <groupId>com.alibaba.csp</groupId>
    <artifactId>sentinel-datasource-nacos</artifactId>
</dependency>
<!-- sentinel -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-sentinel</artifactId>
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
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
```

#### 3、配置文件

```properties
server.port=83
spring.application.name=cloud-sentinel-test
# Nacos注册中心地址
spring.cloud.nacos.server-addr=127.0.0.1:8848
# Sentinel Dashboard地址
spring.cloud.sentinel.transport.dashboard=127.0.0.1:8080
```

#### 4、主启动类

```java
@SpringBootApplication
public class SentinelMain83 {
    public static void main(String[] args) {
        SpringApplication.run(SentinelMain83.class, args);
    }
}
```

### 3.2 @SentinelResource详解

@SentinelResource用于定义资源和服务降级方法，注意它标注的方法权限不能是private。该注解主要有以下核心属性：

（1）**value**：用于定义资源名称，不能为空

（2）**fallback**和**fallbackClass**：fallback用于指定**处理异常的方法名称**，它可以针对所有类型的异常进行处理，该方法需要满足以下条件：

- 访问权限为public
- 返回值类型与原方法返回值类型一致
- 参数列表与原方法一致，或者最后可以额外添加一个参数，其类型为Throwable
- 该方法默认需要和原方法在同一个类中。如果希望定义在其他类中，则必须用fallbackClass属性来指定对应的类，并且此时该方法必须为static，否则无法解析。

### 3.3 资源名

在Sentinel中，除了用@SentinelResource注解的value属性指定资源名称，还会有默认的资源名称（默认资源名就是请求地址）。对于这两种资源名，降级方法的调用有所不同。

我们在cloud-sentinel-test83中创建一个controller用于测试：

```java
@RestController
public class ResourceNameController {
    @GetMapping("/test/detail")
    @SentinelResource(value = "detail", fallback = "myFallback")
    public String getDetail() {
        return "ok! detail!";
    }

    @GetMapping("/test/nothing")
    @SentinelResource(value = "nothing")
    public String getNothing() {
        return "ok! nothing!";
    }

    public String myFallback() {
        return "出错啦!";
    }
}
```

#### 1、指定资源名

我们在Sentinel控制台根据指定资源名设置流控规则如下：

![](images/Snipaste20231023193801.png)

![](images/Snipaste20231023193734.png)

由于我们是根据@SentinelResource中的value属性作为资源名设置的规则，所以服务降级会调用@SentinelResource中指定的逻辑：

- 如果指定了降级方法，则会调用降级方法
- 否则，就返回一个Error Page，因为BlockException被直接抛出了

**测试**：

- 启动Nacos、Sentinel、83
- 快速访问`http://localhost:83/test/detail`，限流后调用myFallback并返回
- 快速访问`http://localhost:83/test/nothing`，限流后返回Error Page(错误码500)

#### 2、默认资源名

去掉上面根据指定资源名称限流的流控规则，然后添加以下规则（按请求地址限流）：

![](images/Snipaste20231105174050.png)

![](images/Snipaste20231105174117.png)

**测试**：

- 快速访问`http://localhost:83/test/detail`，限流后返回`Blocked by Sentinel (flow limiting)`
- 快速访问`http://localhost:83/test/nothing`，限流后返回`Blocked by Sentinel (flow limiting)`

**总结**：通过请求地址来限流，将会返回Sentinel自带的默认限流处理信息`Blocked by Sentinel (flow limiting)`，而不会经过@SentinelResource中指定的降级方法。

## 4. 流控规则

### 4.1 基本介绍

流控规则是用于完成服务流控的。服务流控就是对访问流量的控制，也称为服务限流。Sentinel实现流控的原理是监控应用流量的QPS或并发线程数等指标，当达到指定的阈值时对再到来的请求进行控制，以避免被瞬时的流量高峰冲垮，从而保障应用的高可用性。

![](images/Snipaste20231105182252.png)

**资源名**：唯一名称，默认资源名是请求路径

**针对来源**：Sentinel可以针对调用者进行限流，填写微服务名，默认default(不区分来源)

**阈值类型/单机阈值**：

- QPS(每秒钟的请求数量)：当调用该API的QPS达到阈值时，进行限流
- 并发线程数：当调用该API的线程数达到阈值时，进行限流

**流控模式**：

- 直接：API达到限流条件时，直接限流
- 关联：当关联的资源达到阈值时，就限流自己
- 链路：只记录指定链路上的流量（指定资源从入口资源进来的流量，如果达到阈值，就进行限流）

**流控效果**：

- 快速失败：直接失败，抛异常
- Warm Up：根据coldFactor(冷加载因子，默认3)的值，从`阈值/codeFactor`开始，经过预热时长，才达到设置的QPS阈值
- 排队等待：匀速排队，让请求以匀速的速度通过，阈值类型必须设置为QPS，否则无效

### 4.2 测试代码

我们在cloud-sentinel-test83中创建一个controller用于测试：

```java
@RestController
public class FlowController {
    @GetMapping("/testA")
    public String testA() {
        return "-----testA";
    }
    @GetMapping("/testB")
    public String testB() {
        return "-----testB";
    }
}
```

然后启动Nacos、Sentinel、83

### 4.3 流控模式

#### 1、直接

**系统默认的流控模式是直接，流控效果是快速失败**。我们进行如下配置，

![](images/Snipaste20231022164202.png)

如果快速访问`http://localhost:83/testA`，就会报错`Blocked by Sentinel (flow limiting)`

> 阈值类型也可以用并发线程数来进行测试，如果设置为1，就表示同时只能处理1个线程，超过了则进行限流。

#### 2、关联

关联模式下，当对关联资源的访问达到自己设定的阈值时，就会对自己进行限流。例如A关联了B，则当对B的访问达到阈值时，就会限流A。我们进行如下配置，

![](images/Snipaste20231022193205.png)

测试方式如下：利用postman每隔0.3秒发送一个请求到/testB，然后我们浏览器访问/testA会发现被限流了

![](images/Snipaste20231105201144.png)

#### 3、链路

在链路模式下，当对一个资源有多种访问路径时，可以对某一路径的访问进行限流，而其他访问路径不限流。例如资源名为/common，使用链路的流控模式，配置入口资源为/test1，则通过/test1/common访问会根据阈值进行限流，而通过/test2/common则不会限流。

### 4.4 流控效果

#### 1、快速失败

快速失败是默认的流控效果：直接失败，抛出异常。

#### 2、Warm Up

Warm Up方式，即预热方式(或者称为冷启动方式)。当服务长期处于低水位的情况下，系统为该服务分配的各种软硬件资源都会很少(如缓存空间、线程数量等)，此时如果流量突然增加，直接把系统拉升到高水位可能瞬间把系统压垮。所以可以通过冷启动，让通过的流量缓慢增加，在一定时间内逐渐增加到阈值上限，给冷系统一个预热的时间，避免冷系统被压垮。如果还是超出了阈值，就会对请求执行快速失败的效果，进行降级处理。

默认coldFactor为3，假如设置的阈值为threshold，则当没有流量的时候，QPS阈值就是`threshold/coldFactor`；一旦有流量后，就会经过指定的预热时间，QPS阈值会慢慢上升到`threshold`；如果又有一段时间没有流量，QPS阈值又会降低到最初的`threshold/coldFactor`。

配置方式：

![](images/Snipaste20231022202844.png)

进行了如上配置，则初始的QPS阈值为10/3=3，一旦有流量访问后，就会经过5秒的预热，逐渐达到最高阈值10。快速访问`http://localhost:83/testB`即可看出效果。

> 应用场景：秒杀系统在开启的瞬间，会有很多流量上来，很有可能把系统打死，预热方式就是为了保护系统，慢慢把流量放进来，慢慢把阀值增长到设置的阀值。

#### 3、排队等待

排队等待方式，也称为匀速排队，该方式会严格控制请求通过的间隔时间，让请求以均匀的速度通过，它是漏斗算法的改进。不同的是，当流量超过设定阈值时，漏斗算法会直接将再进来的请求丢弃，而排队等待算法则是将请求缓存起来，后面慢慢处理。注意这种方式的**阈值类型必须设置为QPS**，否则无效。

配置方式：

![](images/Snipaste20231022204024.png)

上面设置的含义是：/testA只能接受每秒1次请求，超过的话就排队等待，每个请求等待的最长超时时间为20000毫秒。

测试：使用postman每隔0.3秒发送请求，会发现请求会每隔1秒均匀地被响应。

> 应用场景：主要用于处理**间隔性突发的流量**。假如某一秒有大量请求到来，而接下来几秒处于空闲状态，我们就希望系统能在接下来的空闲期间逐渐处理这些请求，而不是在第一秒直接拒绝多余的请求。


## 5. 熔断规则

### 5.1 基本介绍

Sentinel熔断降级会在调用链路中某个资源出现不稳定状态时，对这个资源的调用进行熔断降级，避免影响到其它的资源而导致级联错误。当资源被熔断降级后，在接下来的熔断时长之内，对该资源的调用都自动熔断（默认行为是抛出DegradeException）。

### 5.2 测试代码

我们在cloud-sentinel-test83中创建一个controller用于测试：

```java
@RestController
public class DegradeController {
    @GetMapping("/testD")
    public String testD() {
        try {
            TimeUnit.SECONDS.sleep(1);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return "-----testD";
    }

    @GetMapping("/testE")
    public String testE() {
        int a = 10 / 0;
        return "-----testE";
    }
}
```

然后启动Nacos、Sentinel、83

### 5.3 熔断策略：慢调用比例

慢调用比例(SLOW_REQUEST_RATIO)。选择以慢调用比例作为阈值，需要设置允许的慢调用RT（即最大的响应时间），请求的响应时间大于该值则统计为慢调用。**当单位统计时长内请求数目大于设置的最小请求数目，并且慢调用的比例大于阈值，则接下来的熔断时长内请求会自动被熔断**。经过熔断时长后熔断器会进入探测恢复状态（HALF-OPEN状态，即半开状态），若接下来的一个请求响应时间小于设置的慢调用RT则结束熔断，若大于设置的慢调用RT则会再次被熔断。

![](images/Snipaste20231022213943.png)

进行了以上配置，则表示请求响应时间大于200ms的请求就是慢调用。当1秒内请求数大于5，并且这些请求中慢调用的比例大于0.8，则接下来的1秒内(熔断时长)请求会自动被熔断。

JMeter压力测试：

![](images/Snipaste20231023123940.png)

![](images/Snipaste20231105175706.png)

启动后，每秒发送10个请求，且每个请求都是慢调用(因为代码中睡眠了1秒，请求响应时间必然大于200ms)，从而发生熔断降级，使用浏览器访问`http://localhost:83/testD`会返回`Blocked by Sentinel (flow limiting)`。

当我们停止JMeter，经过1秒(熔断时长)后，发送一个请求可以正确访问，但此时仍处于HALF-OPEN状态，并没有结束熔断(因为这个请求的响应时间超过了RT=200ms)，所以如果我们1秒内发送2次请求，第1次请求将正确响应，但此时就已经触发了HALF-OPEN机制，从而接下来1秒内的请求都将被自动熔断，所以第2次请求将返回`Blocked by Sentinel (flow limiting)`

### 5.4 熔断策略：异常比例

异常比例(ERROR_RATIO)。**当单位统计时长内请求数目大于设置的最小请求数目，并且异常的比例大于阈值，则接下来的熔断时长内请求会自动被熔断**。经过熔断时长后熔断器会进入探测恢复状态（HALF-OPEN），若接下来的一个请求成功完成(没有发生异常)则结束熔断，否则继续熔断。

![](images/Snipaste20231023132655.png)

进行了以上配置，当1秒内请求数大于5，并且这些请求中出现异常的比例大于0.2，则接下来的3秒内(熔断时长)请求会自动被熔断。

启动JMeter每秒发送10个请求，且每个请求都发生异常，从而发生熔断降级，使用浏览器访问`http://localhost:83/testE`会返回`Blocked by Sentinel (flow limiting)`。

当我们停止JMeter，经过3秒(熔断时长)后，发送一个请求就能正确访问(即返回异常的错误页)，但此时仍处于HALF-OPEN状态，并没有结束熔断(因为这个请求出现了异常)，所以如果我们在3秒内又立即发送请求，该请求就会被熔断(返回`Blocked by Sentinel (flow limiting)`)，这正是因为HALF-OPEN机制。

### 5.5 熔断策略：异常数

异常数(ERROR_COUNT)。**当单位统计时长内的异常数目超过阈值之后会自动进行熔断**。经过熔断时长后熔断器会进入探测恢复状态（HALF-OPEN），若接下来的一个请求成功完成(没有发生异常)则结束熔断，否则继续熔断。

![](images/Snipaste20231023135622.png)

进行了以上配置，当1秒内异常数大于5，则接下来的3秒内(熔断时长)请求会自动被熔断。

## 6. 热点规则

### 6.1 基本介绍

热点规则是用于实现热点参数限流的规则。热点参数限流会统计传入参数中的热点参数，并根据配置的限流阈值与模式，对包含热点参数的资源调用进行限流。热点参数限流可以看做是一种特殊的流量控制，仅对包含热点参数的资源调用生效。Sentinel 利用 LRU 策略统计最近最常访问的热点参数，结合令牌桶算法来进行参数级别的流控。

> 注意：**热点参数限流仅支持QPS模式**。

### 6.2 基本使用步骤

**核心思想**：对于@SentinelResource标注的资源，若方法有参数，则这些参数会依次传入Sentinel API（索引分别是0、1、2...），从而可以用于热点规则判断。

我们在cloud-sentinel-test83中创建一个controller用于测试：

```java
@RestController
public class ParamFlowController {
    @GetMapping("/testHotKey")
    @SentinelResource(value = "testHotKey", fallback = "hotKeyFallback")
    public String testHotKey(
            @RequestParam(value = "p0", required = false) String p0,
            @RequestParam(value = "p1", required = false) String p1) {
        return "----testHotKey";
    }

    public String hotKeyFallback(String p0, String p1) {
        return "----hotKeyFallback";
    }
}
```

在Sentinel控制台新增热点规则：

![](images/Snipaste20231023170814.png)

如上配置，表示当访问资源testHotKey且携带的参数p0有值时，每秒请求不能超过1次，否则会触发限流（即在窗口时长内超过单机阈值就限流）。

**测试**：

- 快速访问`http://localhost:83/testHotKey?p0=1`，触发限流
- 而快速访问`http://localhost:83/testHotKey?p1=1`则不会触发限流

### 6.3 参数例外项

上面的案例限流了热点参数p0，但有时我们希望如果热点参数取到一个特殊值，例如当`p0=vip`时，限流的阈值能提高，则我们可以进行如下配置：

![](images/Snipaste20231023172602.png)

测试：

- 快速访问`http://localhost:83/testHotKey?p0=1`，触发限流
- 快速访问`http://localhost:83/testHotKey?p0=vip`则不会触发限流(除非你能一秒点击200次以上)

> 注意：参数例外项的配置中，参数类型只能是String、int、double、long、float、char、byte

## 7. Sentinel规则持久化

一旦我们重启微服务，Sentinel规则就会消失，所以生产环境需要将配置规则进行持久化。我们可以**将规则持久化到Nacos保存**，这样只要刷新cloud-sentinel-test83的某个访问地址，Sentinel控制台就会显示该规则，只要Nacos里面的配置不删除，针对83的Sentinel规则就不会消失。除此之外，只需修改Nacos里面的配置文件，对应Sentinel的规则也会立即修改生效。这种规则持久化的方式也称为Push模式。

### 7.1 修改模块cloud-sentinel-test83

### 7.2 添加依赖

```xml
<!-- sentinel-datasource-nacos 持久化 -->
<dependency>
    <groupId>com.alibaba.csp</groupId>
    <artifactId>sentinel-datasource-nacos</artifactId>
</dependency>
```

### 7.3 添加Nacos数据源配置

以下我们使用的是Nacos集群，所以还要记得将Nacos服务注册中心的地址修改为`192.168.231.101:1111`。

```properties
# Nacos数据源配置
spring.cloud.sentinel.datasource.ds1.nacos.server-addr=192.168.231.101:1111
spring.cloud.sentinel.datasource.ds1.nacos.data-id=${spring.application.name}-flow
spring.cloud.sentinel.datasource.ds1.nacos.group-id=DEFAULT_GROUP
spring.cloud.sentinel.datasource.ds1.nacos.data-type=json
## 规则类型为流控规则
spring.cloud.sentinel.datasource.ds1.nacos.rule-type=flow
```

> 其中ds1是数据源名称，可以自定义

### 7.4 在Nacos中添加配置规则

访问`http://192.168.231.101:1111/nacos`

![](images/Snipaste20231111211631.png)

- resource：资源名称
- limitApp：来源应用
- grade：阈值类型，0表示线程数，1表示QPS
- count：单机阈值
- strategy：流控模式，0表示直接，1表示关联，2表示链路
- controlBehavior：流控效果，0表示快速失败，1表示Warm Up，2表示排队等待
- clusterMode：是否集群

### 7.5 测试

- 启动Nacos集群、Sentinel、83
- 访问`http://localhost:83/test/detail`后，查看Sentinel的流控规则，发现已有资源名为detail的规则
- 快速访问上述url，正确触发降级方法
- 修改Nacos中的配置文件cloud-sentinel-test-flow，例如修改`"count": 5`，发布后查看Sentinel控制台，发现流控规则也已经修改了

> 注意：如果在Sentinel控制台修改流控规则，并不会使Nacos中的配置文件也同步修改。如果想实现这一点，需要改造Sentinel控制台源码。



# 第08章_Seata处理分布式事务

## 1. Seata简介

### 1.1 简介

官网 http://seata.io/zh-cn/

Seata是一款开源的分布式事务解决方案，致力于在微服务架构下提供高性能和简单易用的分布式事务服务。Seata提供了 AT、TCC、SAGA 和 XA 事务模式，为用户打造一站式的分布式事务解决方案。

> 一次业务操作需要跨多个数据源或需要跨多个系统进行远程调用，就会产生分布式事务问题。

我们只需要使用一个`@GlobalTransactional`注解标注在业务方法上，即可控制分布式事务。

### 1.2 核心术语

**XID**：Transaction ID，全局唯一的事务ID

**TC**：Transaction Coordinator，事务协调者，维护全局和分支事务的状态，驱动全局事务提交或回滚。

**TM**：Transaction Manager，事务管理器，定义全局事务的范围，开始全局事务、提交或回滚全局事务。

**RM**：Resource Manager，资源管理器，管理分支事务处理的资源，与TC交谈以注册分支事务和报告分支事务的状态，并驱动分支事务提交或回滚。

> 简单来说，Seata Server就是TC，标注了@GlobalTransactional的业务就是TM，而每个需要被调用的数据库就是RM

### 1.3 分布式事务的处理过程

![](images/Snipaste20231024174003.png)

1. TM向TC申请开启一个分布式事务(TM向TC注册全局事务记录)，全局事务创建成功并生成一个全局唯一的XID；
2. XID在微服务调用链路的上下文中传播；
3. RM向TC注册分支事务，将其纳入XID对应全局事务的管辖；
4. TM通知TC提交/回滚事务，事务一阶段结束；
5. TC汇总事务信息，决定分布式事务是提交还是回滚；
6. TC通知所有RM提交/回滚资源，事务二阶段结束。

### 1.4 Seata的安装

下载地址 https://github.com/seata/seata/releases

（1）解压`apache-seata-2.1.0-incubating-bin.tar.gz`到当前文件夹

（2）双击`seata-server.bat`即可启动Seata服务器

（3）访问http://127.0.0.1:7091可以进入Seata控制台，默认账号和密码为seata

## 2. Seata分布式事务模式

### 2.1 Seata XA模式

![](images/Snipaste20231025133019.png)

XA(Unix Transaction)是一种基于XA协议的分布式事务处理模式。在Seata定义的分布式事务框架内，利用数据库对XA协议的支持，以XA协议的机制来管理分支事务的一种事务模式。它是**两阶段提交模型(2PC)**。注意，这种模式要求数据库必须支持XA协议。

**整体运行机制**：

- 一阶段 prepare 行为：XA分支事务完成后，执行XA prepare，由数据库对XA协议的支持来保证`可回滚`和`持久化`
- 二阶段 commit 行为：执行XA分支的commit
- 二阶段 rollback 行为：执行XA分支的rollback

**缺点**：

- 回滚日志无法自动清理，需要手工清理
- 多线程下对同一个数据库中的数据进行修改，存在ABA问题

### 2.2 Seata AT模式

AT(Automatic Transaction)模式是**Seata默认的分布式事务模型**，由XA模式演变而来，通过**全局锁**对XA模式中的问题进行了改进，并实现了回滚日志的自动清理。它也是**两阶段提交模型(2PC)**。

**整体运行机制**：

- 一阶段 prepare 行为：业务数据和回滚日志记录在同一个本地事务中提交，并释放本地锁和连接资源
- 二阶段 commit 行为：马上成功结束，自动异步批量清理回滚日志
- 二阶段 rollback 行为：通过回滚日志，自动生成补偿操作，完成数据回滚

**缺点**：

- 通过全局锁进行控制，性能较低，不适合高并发场景
- 全局commit/rollback阶段以及回滚日志的清除过程，是完全自动化的，无法实现定制化过程

### 2.3 Seata TCC模式

TCC(Try Confirm/Cancel)同样是**两阶段提交模型(2PC)**，它与AT模式的区别在于：AT模式是**全自动**的，只能应用于支持本地ACID事务的关系型数据库；而TCC模式则需要**自定义**分支事务，所以不依赖于底层数据源的事务支持。

**整体运行机制**：

- 一阶段 prepare 行为：调用自定义的 prepare 逻辑
- 二阶段 commit 行为：调用自定义的 commit 逻辑
- 二阶段 rollback 行为：调用自定义的 rollback 逻辑

> 总结：TCC 模式支持把**自定义**的分支事务纳入到全局事务的管理中

### 2.4 Seata Saga模式

对于架构复杂、业务流程较多的系统，一般不适合使用2PC的分布式事务模式，因为这种系统一般无法提供TM、TC、RM三种接口。所以我们可以选择Saga模式，**它不是2PC的**，而是一种**长事务解决方案**。

Saga模式是Seata提供的长事务解决方案，在Saga模式下，业务流程中每个参与者都提交本地事务，**当出现某一个参与者失败则补偿前面已经成功的参与者**，一阶段正向服务和二阶段补偿服务都由业务开发实现。

![](images/Snipaste20231025141029.png)

**整体运行机制**：对于一个流程很长的复杂业务，会包含很多子流程(事务)，每个子流程都让它们真实提交它们真正的执行结果，只有当前子流程执行成功后才能执行下一个子流程。若所有子流程全部执行成功，则整个业务流程成功；只要有一个子流程执行失败，则可采用两种补偿方式：

- 向后恢复：对于其前面所有成功的子流程，其执行结果全部撤销
- 向前恢复：重试失败的子流程直到其成功

**与2PC模式的区别**：

- Saga模式的所有分支事务是串行执行的，而2PC则是并行执行的
- Saga模式没有TC，它是通过子流程间的消息传递来完成全局事务管理的；而2PC则具有TC，它是通过TC来完成全局事务管理的


## 3. 实战案例-数据库搭建

### 3.1 业务说明

我们将创建三个服务，一个订单服务，一个库存服务，一个账户服务。

当用户下单时，会在订单服务中创建一个订单，然后通过远程调用库存服务来扣减下单商品的库存，再通过远程调用账户服务来扣减用户账户里面的余额，最后在订单服务中修改订单状态为已完成。

> 总结：下订单-->减库存-->扣余额-->改状态

### 3.2 创建业务数据库

```sql
CREATE DATABASE seata_order;
CREATE DATABASE seata_storage;
CREATE DATABASE seata_account;
```

- seata_order：存储订单的数据库
- seata_storage：存储库存的数据库
- seata_account：存储账户信息的数据库

### 3.3 创建业务数据表

（1）seata_order库下建t_order表

```sql
CREATE TABLE t_order (
  `id` BIGINT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT(11) DEFAULT NULL COMMENT '用户id',
  `product_id` BIGINT(11) DEFAULT NULL COMMENT '产品id',
  `count` INT(11) DEFAULT NULL COMMENT '数量',
  `money` DECIMAL(11,0) DEFAULT NULL COMMENT '金额',
  `status` INT(1) DEFAULT NULL COMMENT '订单状态：0：创建中；1：已完结' 
) ENGINE=INNODB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
```

（2）seata_storage库下建t_storage表

```sql
CREATE TABLE t_storage (
 `id` BIGINT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `product_id` BIGINT(11) DEFAULT NULL COMMENT '产品id',
 `total` INT(11) DEFAULT NULL COMMENT '总库存',
 `used` INT(11) DEFAULT NULL COMMENT '已用库存',
 `residue` INT(11) DEFAULT NULL COMMENT '剩余库存'
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO seata_storage.t_storage(`id`, `product_id`, `total`, `used`, `residue`)
VALUES ('1', '1', '100', '0', '100');
```

（3）seata_account库下建t_account表

```sql
CREATE TABLE t_account (
  `id` BIGINT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'id',
  `user_id` BIGINT(11) DEFAULT NULL COMMENT '用户id',
  `total` DECIMAL(10,0) DEFAULT NULL COMMENT '总额度',
  `used` DECIMAL(10,0) DEFAULT NULL COMMENT '已用余额',
  `residue` DECIMAL(10,0) DEFAULT '0' COMMENT '剩余可用额度'
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO seata_account.t_account(`id`, `user_id`, `total`, `used`, `residue`)
VALUES ('1', '1', '1000', '0', '1000');
```

### 3.4 创建回滚日志表

在上述三个库中，各自都要创建回滚日志表，建表sql如下（也可查询官方文档）：

```sql
DROP TABLE IF EXISTS `undo_log`;
CREATE TABLE `undo_log` (
                            `id` bigint(20) NOT NULL AUTO_INCREMENT,
                            `branch_id` bigint(20) NOT NULL,
                            `xid` varchar(100) NOT NULL,
                            `context` varchar(128) NOT NULL,
                            `rollback_info` longblob NOT NULL,
                            `log_status` int(11) NOT NULL,
                            `log_created` datetime NOT NULL,
                            `log_modified` datetime NOT NULL,
                            `ext` varchar(100) DEFAULT NULL,
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
```

## 4. 实战案例-微服务搭建

### 4.1 订单模块

#### 1、创建模块seata-order-service2001

#### 2、添加依赖

注意seata的依赖需要我们自己手动引入匹配的版本（与Seata Server版本一致）：

```xml
<!-- nacos-discovery -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
</dependency>
<!-- seata -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-seata</artifactId>
    <exclusions>
        <exclusion>
            <groupId>io.seata</groupId>
            <artifactId>seata-spring-boot-starter</artifactId>
        </exclusion>
    </exclusions>
</dependency>
<dependency>
    <groupId>org.apache.seata</groupId>
    <artifactId>seata-spring-boot-starter</artifactId>
    <version>2.1.0</version>
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
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
<dependency>
    <groupId>org.mybatis.spring.boot</groupId>
    <artifactId>mybatis-spring-boot-starter</artifactId>
</dependency>
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <scope>runtime</scope>
</dependency>
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <optional>true</optional>
</dependency>
```

#### 3、配置文件

`application.yaml`：

```yml
server:
  port: 2001
spring:
  application:
    name: seata-order-service
  cloud: # Nacos相关配置
    nacos:
      server-addr: 127.0.0.1:8848
  datasource: # 数据源相关配置
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/seata_order
    username: root
    password: abc666
mybatis: # MyBatis相关配置
  mapper-locations: classpath:/mapper/*.xml
  configuration:
    map-underscore-to-camel-case: true
  type-aliases-package: com.wsy.cloud.entities
```

在类路径下还要创建一个配置文件`file.conf`，用于指定Seata Server的地址：

```conf
service {
  #transaction service group mapping
  vgroupMapping.default_tx_group = "default"
  #only support when registry.type=file, please don't set multiple addresses
  default.grouplist = "127.0.0.1:8091"
  #degrade, current not support
  enableDegrade = false
  #disable seata
  disableGlobalTransaction = false
}
```

#### 4、主启动类

```java
@SpringBootApplication
@EnableFeignClients
@MapperScan("com.wsy.cloud.mapper")
public class SeataOrderMainApp2001 {
    public static void main(String[] args) {
        SpringApplication.run(SeataOrderMainApp2001.class, args);
    }
}
```

#### 5、业务类

（1）实体类entities

```java
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommonResult<T> {
    private Integer code;
    private String message;
    private T data;

    public CommonResult(Integer code, String message) {
        this(code, message, null);
    }

    public CommonResult(T data) {
        this(200, "操作成功", data);
    }
}
```

```java
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order {
    private Long id;
    private Long userId;
    private Long productId;
    private Integer count;
    private BigDecimal money;
    private Integer status; //0表示订单创建中，1表示订单已完结
}
```

（2）mapper

```java
public interface OrderMapper {
    // 创建订单
    void create(Order order);
    // 修改订单金额
    void update(@Param("userId") Long userId, @Param("status") Integer status);
}
```

```xml
<mapper namespace="com.wsy.cloud.mapper.OrderMapper">
    <insert id="create">
        insert into t_order (`id`, `user_id`, `product_id`, `count`, `money`, `status`)
        values (null, #{userId}, #{productId}, #{count}, #{money}, 0)
    </insert>
    <update id="update">
        update t_order set status = 1
        where user_id = #{userId} and status = #{status}
    </update>
</mapper>
```

（3）service

OrderService：

```java
public interface OrderService {
    void create(Order order);
}
```

StorageService：

```java
@FeignClient("seata-storage-service")
public interface StorageService {
    // 扣减库存
    @PostMapping("/storage/decrease")
    CommonResult decrease(@RequestParam("productId") Long productId,
                          @RequestParam("count") Integer count);
}
```

AccountService：

```java
@FeignClient("seata-account-service")
public interface AccountService {
    // 扣减账户余额
    @PostMapping("/account/decrease")
    CommonResult decrease(@RequestParam("userId") Long userId,
                          @RequestParam("money") BigDecimal money);
}
```

OrderServiceImpl：使用一个`@GlobalTransactional`注解标注在业务方法上，即可开启全局分布式事务

```java
@Service
@Slf4j
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private StorageService storageService;
    @Autowired
    private AccountService accountService;
    /**
     * 下订单->减库存->减余额->改状态
     */
    @Override
    @GlobalTransactional
    public void create(Order order) {
        log.info("====>创建订单");
        orderMapper.create(order);
        log.info("====>扣减库存");
        storageService.decrease(order.getProductId(), order.getCount());
        log.info("====>扣减余额");
        accountService.decrease(order.getUserId(), order.getMoney());
        log.info("====>修改状态");
        orderMapper.update(order.getUserId(), 0);
        log.info("====>下单结束!success!");
    }
}
```

（4）controller

```java
@RestController
public class OrderController {
    @Autowired
    private OrderService orderService;
    
    @GetMapping("/order/create")
    public CommonResult create(Order order) {
        orderService.create(order);
        return new CommonResult(200, "订单创建成功！");
    }
}
```

### 4.2 库存模块

#### 1、创建模块seata-storage-service2002

#### 2、添加依赖(同订单模块)

#### 3、配置文件

`application.yaml`：

```yml
server:
  port: 2002
spring:
  application:
    name: seata-storage-service
  cloud: # Nacos相关配置
    nacos:
      server-addr: 127.0.0.1:8848
  datasource: # 数据源相关配置
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/seata_storage
    username: root
    password: abc666
mybatis: # MyBatis相关配置
  mapper-locations: classpath:/mapper/*.xml
  configuration:
    map-underscore-to-camel-case: true
  type-aliases-package: com.wsy.cloud.entities
```

在类路径下还要创建一个配置文件`file.conf`，用于指定Seata Server的地址：

```conf
service {
  #transaction service group mapping
  vgroupMapping.default_tx_group = "default"
  #only support when registry.type=file, please don't set multiple addresses
  default.grouplist = "127.0.0.1:8091"
  #degrade, current not support
  enableDegrade = false
  #disable seata
  disableGlobalTransaction = false
}
```

#### 4、主启动类

```java
@SpringBootApplication
@EnableFeignClients
@MapperScan("com.wsy.cloud.mapper")
public class SeataStorageServiceApplication2002 {
    public static void main(String[] args) {
        SpringApplication.run(SeataStorageServiceApplication2002.class, args);
    }
}
```

#### 5、业务类

（1）实体类entities

```java
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommonResult<T> {
    private Integer code;
    private String message;
    private T data;

    public CommonResult(Integer code, String message) {
        this(code, message, null);
    }

    public CommonResult(T data) {
        this(200, "操作成功", data);
    }
}
```

```java
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Storage {
    private Long id;
    private Long productId;
    private Integer total; // 总库存
    private Integer used; // 已用库存
    private Integer residue; // 剩余库存
}
```

（2）mapper

```java
public interface StorageMapper {
    // 扣减库存
    void decrease(@Param("productId") Long productId, @Param("count") Integer count);
}
```

```xml
<mapper namespace="com.wsy.cloud.mapper.StorageMapper">
    <update id="decrease">
        update t_storage
        set used = used + #{count},
            residue = residue - #{count}
        where product_id = #{productId}
    </update>
</mapper>
```

（3）service

StorageService：

```java
public interface StorageService {
    void decrease(Long productId, Integer count);
}
```

StorageServiceImpl：

```java
@Service
@Slf4j
public class StorageServiceImpl implements StorageService {
    @Autowired
    private StorageMapper storageMapper;
    @Override
    public void decrease(Long productId, Integer count) {
        log.info("====>StorageService中开始扣减库存");
        storageMapper.decrease(productId, count);
    }
}
```

（4）controller

```java
@RestController
public class StorageController {
    @Autowired
    private StorageService storageService;
    @PostMapping("/storage/decrease")
    public CommonResult decrease(@RequestParam("productId") Long productId,
                          @RequestParam("count") Integer count) {
        storageService.decrease(productId, count);
        return new CommonResult(200, "扣减库存成功！");
    }
}
```

### 4.3 账户模块

#### 1、创建模块seata-account-service2003

#### 2、添加依赖(同订单模块)

#### 3、配置文件

`application.yaml`：

```yml
server:
  port: 2003
spring:
  application:
    name: seata-account-service
  cloud: # Nacos相关配置
    nacos:
      server-addr: 127.0.0.1:8848
  datasource: # 数据源相关配置
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/seata_account
    username: root
    password: abc666
mybatis: # MyBatis相关配置
  mapper-locations: classpath:/mapper/*.xml
  configuration:
    map-underscore-to-camel-case: true
  type-aliases-package: com.wsy.cloud.entities
```

在类路径下还要创建一个配置文件`file.conf`，用于指定Seata Server的地址：

```conf
service {
  #transaction service group mapping
  vgroupMapping.default_tx_group = "default"
  #only support when registry.type=file, please don't set multiple addresses
  default.grouplist = "127.0.0.1:8091"
  #degrade, current not support
  enableDegrade = false
  #disable seata
  disableGlobalTransaction = false
}
```

#### 4、主启动类

```java
@SpringBootApplication
@EnableFeignClients
@MapperScan("com.wsy.cloud.mapper")
public class SeataAccountMainApp2003 {
    public static void main(String[] args) {
        SpringApplication.run(SeataAccountMainApp2003.class, args);
    }
}
```

#### 5、业务类

（1）实体类entities

```java
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommonResult<T> {
    private Integer code;
    private String message;
    private T data;

    public CommonResult(Integer code, String message) {
        this(code, message, null);
    }

    public CommonResult(T data) {
        this(200, "操作成功", data);
    }
}
```

```java
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Account {
    private Long id;
    private Long userId;
    private BigDecimal total; // 总额度
    private BigDecimal used; // 已用额度
    private BigDecimal residue; // 剩余额度
}
```

（2）mapper

```java
public interface AccountMapper {
    // 扣减账户余额
    void decrease(@Param("userId") Long userId, @Param("money") BigDecimal money);
}
```

```xml
<mapper namespace="com.wsy.cloud.mapper.AccountMapper">
    <update id="decrease">
        update t_account
        set residue = residue - #{money},
            used = used + #{money}
        where user_id = #{userId}
    </update>
</mapper>
```

（3）service

AccountService：

```java
public interface AccountService {
    void decrease(Long userId, BigDecimal money);
}
```

AccountServiceImpl：

```java
@Service
@Slf4j
public class AccountServiceImpl implements AccountService {
    @Autowired
    private AccountMapper accountMapper;
    @Override
    public void decrease(Long userId, BigDecimal money) {
        log.info("====>AccountService中开始扣减余额");
        accountMapper.decrease(userId, money);
        // 模拟出现异常，验证是否全局事务回滚
        int a = 10 / 0;
    }
}
```

（4）controller

```java
@RestController
public class AccountController {
    @Autowired
    private AccountService accountService;

    @PostMapping("/account/decrease")
    public CommonResult decrease(@RequestParam("userId") Long userId,
                          @RequestParam("money") BigDecimal money) {
        accountService.decrease(userId, money);
        return new CommonResult(200, "扣减账户余额成功！");
    }
}
```

### 4.4 测试

启动Nacos、Seata、2003、2002、2001。

下单：`http://localhost:2001/order/create?userId=1&productId=1&count=10&money=100`

根据AccountServiceImpl中的异常，我们发现事务全局回滚，数据库中的表没有变化。

接下来将AccountServiceImpl中的`int a = 10 / 0;`注释掉，再次访问上述url，能正确下单，数据库中的表发生了变化。

## 5. AT模式深入理解

### 5.1 AT模式的整体工作机制

我们以一个示例来进行说明。假设有一个数据库表product，它有三个字段：

- id: 类型是bigint(20)，主键
- name: 类型是varchar(100)
- since: 类型是varchar(100)

分支事务执行如下业务逻辑：

```sql
update product set name = 'GTS' where name = 'TXC';
```

#### 一阶段-prepare

（1）解析SQL：得到SQL的类型(`UPDATE`)、表(`product`)、条件(`where name = 'TXC'`)等相关信息

（2）查询前镜像：根据解析得到的条件信息，生成查询语句，定位数据，从而得到**前镜像**(before image)。即生成以下查询语句：

```sql
select id, name, since from product where name = 'TXC';
```

得到前镜像：

| id   | name | since |
| ---- | ---- | ----- |
| 1    | TXC  | 2014  |

（3）执行业务SQL：更新这条记录的name为'GTS'

（4）查询后镜像：根据前镜像的结果，通过**主键**定位数据，从而得到**后镜像**(after image)。即通过以下sql语句：

```sql
select id, name, since from product where id = 1;
```

得到后镜像：

| id   | name | since |
| ---- | ---- | ----- |
| 1    | GTS  | 2014  |

（5）插入回滚日志：把前后镜像数据以及业务SQL相关的信息组成一条回滚日志记录，插入到UNDO_LOG表中

（6）提交前，向TC注册分支，并且获取该表中需要修改的记录的**全局行锁**。即获取product表中主键值为1的记录的全局行锁。

（7）本地事务提交：业务数据的更新和前面步骤中生成的UNDO LOG一并提交

（8）将本地事务提交的结果上报给TC


#### 二阶段-commit

（1）收到TC的分支提交请求，把请求放入一个异步任务的队列中，马上返回提交成功的结果给TC

（2）异步任务阶段的分支提交请求将异步和批量地删除相应UNDO LOG记录

#### 二阶段-rollback

（1）收到TC的分支回滚请求，开启一个本地事务，执行以下操作

（2）通过XID和Branch ID查找到相应的UNDO LOG记录

（3）数据校验：拿UNDO LOG中的**后镜像与当前数据进行比较**，如果有不同，说明数据被当前全局事务之外的动作做了修改。这种情况，需要根据配置策略来做处理。

（4）根据UNDO LOG中的前镜像和业务SQL的相关信息生成并执行回滚的语句：

```sql
update product set name = 'TXC' where id = 1;
```

（5）提交本地事务，然后把本地事务的执行结果（即分支事务回滚的结果）上报给TC，并删除相应UNDO LOG记录

### 5.2 AT模式的写隔离

**前提条件**：

- 一阶段本地事务**写操作前**，需要确保先拿到**本地锁**。拿不到本地锁，就无法执行本地数据库写操作。
- 一阶段本地事务**提交前**，需要确保先拿到**全局锁**。拿不到全局锁，就无法提交本地事务。
- 拿全局锁的尝试被限制在一定范围内(默认是10次)，超出范围将放弃尝试，然后回滚本地事务，释放本地锁。

我们以一个示例来说明AT模式的写隔离。两个全局事务tx1和tx2，分别对a表的m字段进行更新操作，m的初始值1000。

（1）tx1先开始，开启本地事务，拿到本地锁，更新操作`m = 1000 - 100 = 900`。本地事务提交前，先拿到该记录的全局锁，本地提交释放本地锁。

（2）tx2后开始，开启本地事务，拿到本地锁，更新操作`m = 900 - 100 = 800`。本地事务提交前，尝试拿该记录的全局锁，tx1全局提交前，该记录的全局锁被tx1持有，tx2需要重试等待全局锁。

（3）如果tx1二阶段全局提交，就会释放全局锁。tx2拿到全局锁后就可以提交本地事务。

![](images/Snipaste20231112142309.png)

（4）如果tx1二阶段全局回滚，则tx1需要重新获取该数据的本地锁，进行反向补偿的更新操作，实现分支的回滚。此时，如果tx2仍在等待该数据的全局锁，同时持有本地锁，则tx1无法获取本地锁进行回滚。直到tx2尝试获取全局锁超时，tx2就会放弃全局锁并回滚本地事务释放本地锁，此时tx1可以获取本地锁，回滚最终成功。

![](images/Snipaste20231112142701.png)

> 因为整个过程全局锁在tx1结束前一直是被tx1持有的，所以不会发生脏写的问题。

### 5.3 AT模式的读隔离

**前提条件**：

- `普通select`的执行需要获取该记录的**本地读锁**
- `select ... for update`的执行需要同时获取该记录的**本地读锁与全局读锁**

Seata(AT模式)的默认全局隔离级别是**读未提交**，所以，对于本地事务隔离级别在其之上的数据库来说，使用时就需要注意。

出于总体性能上的考虑，Seata目前并没有对所有select语句都进行读隔离。只有`select ... for update`会申请全局读锁，如果其他事务持有全局写锁，就会立刻回滚`select ... for update`的本地执行并释放本地锁，然后再重试执行`select ... for update`。这个过程中，查询是被阻塞的，直到拿到全局读锁，这样就能保证读到的相关数据一定是已经提交的。

所以，若某个数据库的隔离级别是读已提交，此时**就需要在select语句后添加for update**，来告知Seata要对该读操作进行有效隔离。

![](images/Snipaste20231112143638.png)




# 第09章_SkyWalking调用链跟踪

## 1. SkyWalking简介

### 1.1 调用链跟踪系统

随着分布式系统规模越来越大，各微服务间的调用关系也变得越来越复杂。一般情况下，一个由客户端发起的请求在后端系统中会经过许多不同的微服务调用才能完成最终处理，而这些调用过程形成了一个复杂的分布式服务调用链路。链路中的任何一环出现高延时或错误都会引起整个请求最后的失败。

因此，就需要使用**分布式服务跟踪系统**，来快速发现定位问题、判断故障影响范围、以及分析各部分调用链路的性能。Spring Cloud Alibaba经常会使用SkyWalking作为调用链跟踪系统。

> 补充：Spring Cloud Sleuth也提供了调用链跟踪，其底层是基于zipkin的。然而Spring Cloud Sleuth不支持Spring Boot 3.0及后续的版本，只支持Spring Boot 2.x，因此我们不使用它作为调用链跟踪系统。

### 1.2 SkyWalking

官网地址 https://skywalking.apache.org

SkyWalking是由国内开源爱好者吴晟开源并提交到Apache孵化器的产品，现在已是Apache的顶级项目。它是一个开源的APM(应用性能管理系统)和OAP(可观测性分析平台)。

SkyWalking通过在被检测应用中插入探针，以无侵入方式自动收集所需指标，并自动推送到OAP系统平台。OAP会将收集到的数据存储到指定的存储介质Storage。UI系统通过调用OAP提供的接口，可以实现对相应数据的查询。

### 1.3 系统架构

SkyWalking系统整体由四部分构成：

- Agent：探针，**无侵入收集**，是被插入到被监测应用中的一个进程，它会将收集到的监控指标自动推送给OAP系统。
- OAP：Observability Analysis Platform，可观测性分析平台，它包含一个收集器Collector，能够将来自于Agent的数据收集并存储到相应的存储介质Storage。
- Storage：数据中心，用于存储由OAP系统收集到的链路数据，支持H2、MySQL、ElasticSearch等。默认使用H2(测试使用)，**推荐使用ElasticSearch**(生产使用)。
- UI：一个独立运行的可视化Web平台，它通过调用OAP系统提供的接口，可以对存储在Storage中的数据进行多维度查询。

### 1.4 核心术语

- trace(轨迹)：跟踪单元是从客户端所发起的请求抵达被跟踪系统的边界开始，到被跟踪系统向客户返回响应为止的过程，这个过程称为一个trace。
- span(跨度)：每个trace中会调用若干个服务，为了记录调用了哪些服务，以及每次调用所消耗的时间等信息，在每次调用服务时，埋入一个调用记录，这样两个调用记录之间的区域称为一个span。一个trace由若干个有序的span组成。
- segment(片段)：一个trace的一个片段，可以由多个span组成。

跟踪系统一般会为每个trace、span和segment都指定一个**唯一标识**，即traceId、spanId、segmentId。

### 1.5 SkyWalking的其他功能

SkyWalking还具有告警功能，即用户可提前设置好告警规则，一旦调用过程出现符合告警规则的调用，则会触发相应的Webhooks的执行，并在UI控制台的告警页面中显示相应的告警信息，以通知管理员目前出现的问题。

SkyWalking除了为客户端提供了探针Agent外，还提供了相应的API，用于在代码中对调用跟踪进行处理。

> 这些功能的使用详情可以参考官网。

## 2. ElasticSearch安装

我们使用Docker安装并启动ElasticSearch，详见ElasticSearch笔记

```shell
docker start es
```

浏览器访问 http://192.168.231.101:9200 测试成功


## 3. SkyWalking安装

（1）官网下载 https://www.apache.org/dyn/closer.cgi/skywalking/9.6.0/apache-skywalking-apm-9.6.0.tar.gz

（2）解压到当前文件夹（为了简便，我们直接在windows上安装SkyWalking）

（3）修改config目录下的application.yml配置文件

```yml
storage:
  selector: ${SW_STORAGE:elasticsearch}
```

```yml
storage:
  elasticsearch:
    namespace: ${SW_NAMESPACE:""}
    clusterNodes: ${SW_STORAGE_ES_CLUSTER_NODES:192.168.231.101:9200}
```

（4）启动SkyWalking，双击bin目录下的startup.bat（不仅会启动OAP Server，也会启动UI Server）

（5）访问`http://localhost:8080`即可查看UI界面

> 注意：生产环境下，为了方便，很多公司一般不搭建SkyWalking集群。因为SW纯粹属于性能检测模块，并非业务模块，所以SW短暂的宕机对于业务是没有影响的。

## 4. Agent安装

（1）官网下载 https://www.apache.org/dyn/closer.cgi/skywalking/java-agent/9.0.0/apache-skywalking-java-agent-9.0.0.tgz

（2）解压到当前文件夹

> 我们将来会将该文件夹复制到微服务程序下，让它被SkyWalking跟踪

## 5. 案例实战

### 5.1 SkyWalking跟踪微服务

（1）将Agent解压的文件夹skywalking-agent分别复制到微服务2001、2002、2003下

![image-20250419190003010](images/image-20250419190003010.png)

（2）分别修改skywalking-agent目录下的config目录下的agent.config配置文件，将以下配置项中的`Your_ApplicationName`修改为任意的名称

```properties
agent.service_name=${SW_AGENT_NAME:Your_ApplicationName}
```

- 我们对于2001，使用名称sw-order
- 我们对于2002，使用名称sw-storage
- 我们对于2003，使用名称sw-account

> 除此之外，还要修改collector.backend_service属性中的OAP Server的IP地址。由于我们都是在同一台本地机器上运行，所以无需修改。

（3）在运行的`-jar`参数前添加参数`-javaagent:${path}`，其中`${path}`指的是skywalking-agent目录下skywalking-agent.jar的路径。我们在IDEA中运行测试，可以使用如下方式：

![image-20250419190442126](images/image-20250419190442126.png)

![image-20250419190541493](images/image-20250419190541493.png)

![image-20250419190808487](images/image-20250419190808487.png)

上图中的参数是：

```shell
-javaagent:E:\TmpProject\spring-cloud-project\seata-order-service2001\skywalking-agent\skywalking-agent.jar
```

> 注意：2001、2002、2003都要配置

### 5.2 测试

- 启动Nacos、Seata、ElasticSearch、SkyWalking、2003、2002、2001
- 访问`http://localhost:8080`即可查看UI界面
- 访问`http://localhost:2001/order/create?userId=1&productId=1&count=10&money=100`下单
- 此时在UI界面中就可以看到调用链的跟踪了



# 第10章_Stream消息驱动

## 1. Stream简介

### 1.1 概述

Spring Cloud Stream是一个用来为微服务应用构建消息驱动能力的框架。在实际开发中，可能我们会用到RabbitMQ、Kafka等多种消息中间件，Spring Cloud Stream就是为了屏蔽底层消息中间件的差异，降低切换成本，为我们提供统一的消息编程模型。

Spring Cloud Stream为一些供应商的消息中间件产品提供了个性化的自动化配置实现，引用了**发布-订阅、消费组、分区**这三个核心概念。Stream中的消息通信方式遵循了发布-订阅模式。

> 注意：Spring Cloud Stream默认只支持RabbitMQ和Kafka，而在Spring Cloud Alibaba中还可以使用RocketMQ与之整合。

### 1.2 模型图

![](images/Snipaste20231020183155.png)

![](images/Snipaste20231113211000.png)

（1）**Destination Binders**：它用于集成外部消息系统

（2）**Bindings**：是外部消息系统和微服务应用之间的桥梁，它是由Destination Binders创建出来的。Bindings有以下两种类型：

- Input Bindings：输入管道，消费者通过Input Bindings连接Binder，而Binder与MQ连接。所以，消费者通过Input Bindings从MQ中读取数据。
- Output Bindings：输出管道，生产者通过Output Bindings连接Binder，而Binder与MQ连接。所以，生产者通过Output Bindings向MQ写入数据。

（3）**Message**：消息，是一种生产者和消费者使用的规范数据结构，用于与Binders通信（从而通过外部消息系统与其他应用程序通信）。

## 2. Stream整合RocketMQ

### 2.1 安装并启动RocketMQ

我们使用Docker安装并启动RocketMQ，详见RocketMQ笔记

```shell
docker start rmqnamesrv
docker start rmqbroker
docker start rmqadmin
```

访问`http://192.168.231.101:8081`即可查看控制台信息


### 2.2 消息生产者

#### 1、创建模块cloud-stream-rocketmq-provider8801

#### 2、添加依赖

```xml
<!-- stream-rocketmq -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-stream-rocketmq</artifactId>
</dependency>
<!-- nacos-discovery -->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
```

#### 3、配置文件

```yml
server:
  port: 8801
spring:
  application:
    name: cloud-stream-rocketmq-provider
  cloud:
    nacos:
      server-addr: 127.0.0.1:8848
    # 定义方法名，用于后面指定bindings(管道)名称
    function:
      definition: myProducer
    # stream相关配置
    stream:
      # 绑定RocketMQ
      rocketmq:
        binder:
          name-server: 192.168.231.101:9876
      bindings:
        # 创建管道，输出管道名称格式：<方法名>-out-<index>
        myProducer-out-0:
          # 指定写入到输出管道中消息的主题、类型
          destination: wsy-topic
          content-type: application/json
```

#### 4、主启动类

```java
@SpringBootApplication
public class Stream8801 {
    public static void main(String[] args) {
        SpringApplication.run(Stream8801.class, args);
    }
}
```

#### 5、业务类

使用StreamBridge往指定信道发送消息，注意输出管道的名称要与配置文件中所指定的bindings名称对应：

```java
@RestController
public class ProducerController {
    // 输出管道名称，要与配置文件中所指定的bindings名称对应
    public static final String OUT = "myProducer-out-0";
    @Autowired
    private StreamBridge bridge;

    @GetMapping("/send/message")
    public String sendMessage() {
        String message = "hello!";
        // 使用MessageBuilder创建消息
        Message<String> msg = MessageBuilder.withPayload(message).build();
        // 使用StreamBridge将消息写到Output Bindings
        bridge.send(OUT, msg);
        return message;
    }
}
```

### 2.3 消息消费者

#### 1、创建模块cloud-stream-rocketmq-consumer9801

#### 2、添加依赖(同8801)

#### 3、配置文件

```yml
server:
  port: 9801
spring:
  application:
    name: cloud-stream-rocketmq-consumer
  cloud:
    nacos:
      server-addr: 127.0.0.1:8848
    # 定义方法名，用于后面指定bindings(管道)名称
    function:
      definition: myConsumer
    # stream相关配置
    stream:
      # 绑定RocketMQ
      rocketmq:
        binder:
          name-server: 192.168.231.101:9876
      bindings:
        # 创建管道，输入管道名称格式：<方法名>-in-<index>
        myConsumer-in-0:
          # 指定从输入管道中订阅的消息的主题、类型
          destination: wsy-topic
          content-type: application/json
```

#### 4、主启动类

```java
@SpringBootApplication
public class Stream9801 {
    public static void main(String[] args) {
        SpringApplication.run(Stream9801.class, args);
    }
}
```

#### 5、业务类

- 消费方法的方法名必须与配置文件中定义的方法名相同
- 该消费方法的返回值类型必须是`Consumer<T>`，其中T是生产者发送的消息类型，且需要标注@Bean注解交给容器管理

```java
@Component
public class MessageConsumer {
    @Bean
    public Consumer<Message<String>> myConsumer() {
        return msg -> {
            System.out.println("收到消息" + msg.getPayload());
        };
    }
}
```

### 2.4 测试

- 启动Nacos、RocketMQ、8801、9801
- 访问`http://localhost:8801/send/message`成功，且消费者控制台成功打印消费信息
