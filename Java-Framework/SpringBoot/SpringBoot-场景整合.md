# 第08章_环境准备

## 1. 云服务器

购买云服务器 https://cloud.tencent.com

**注意：一定要配置防火墙，放行端口**

![](images/20230922170124.png)

然后可以用XShell或windterm等远程登录工具登录云服务器。


## 2. 安装组件

我们一共需要安装docker、redis、kafka、prometheus、grafana这些组件。

### 2.1 安装docker

见Docker笔记。

### 2.2 通过docker-compose安装所有组件

创建`/prod`目录，在该目录下创建以下文件：

**prometheus.yml**

```yml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'redis'
    static_configs:
      - targets: ['redis:6379']

  - job_name: 'kafka'
    static_configs:
      - targets: ['kafka:9092']
```

**docker-compose.yml**

```yml
version: '3.9'

services:
  redis:
    image: redis:latest
    container_name: redis
    restart: always
    ports:
      - "6379:6379"
    networks:
      - backend

  zookeeper:
    image: bitnami/zookeeper:latest
    container_name: zookeeper
    restart: always
    environment:
      ALLOW_ANONYMOUS_LOGIN: yes
      ZOOKEEPER_CLIENT_PORT: 2181
      ZOOKEEPER_TICK_TIME: 2000
    networks:
      - backend

  kafka:
    image: bitnami/kafka:3.4.0
    container_name: kafka
    restart: always
    depends_on:
      - zookeeper
    ports:
      - "9092:9092"
    environment:
      ALLOW_PLAINTEXT_LISTENER: yes
      KAFKA_CFG_ZOOKEEPER_CONNECT: zookeeper:2181
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
    networks:
      - backend
  
  kafka-ui:
    image: provectuslabs/kafka-ui:latest
    container_name:  kafka-ui
    restart: always
    depends_on:
      - kafka
    ports:
      - "8080:8080"
    environment:
      KAFKA_CLUSTERS_0_NAME: dev
      KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS: kafka:9092
    networks:
      - backend

  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    restart: always
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    ports:
      - "9090:9090"
    networks:
      - backend

  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    restart: always
    depends_on:
      - prometheus
    ports:
      - "3000:3000"
    networks:
      - backend

networks:
  backend:
    name: backend
```

**启动环境**：

```shell
docker compose -f docker-compose.yml up -d
```

> 补充：redis的容器实例建议删除，然后按照Docker笔记中配置redis及其密码，否则redis服务器容易被攻击。

### 2.3 验证

- kafka-ui：访问`公网ip:8080`
- grafana：访问`公网ip:3000`，默认账号密码均为admin，第一次登录后需要修改密码(我们将密码修改为abc666)
- prometheus：访问`公网ip:9090`
- kafka：使用IDEA安装大数据插件，`公网ip:9092`
- redis：使用RedisInsight连接`公网ip:6379`，RedisInsight的下载地址为 https://redis.com/redis-enterprise/redis-insight/#insight-form


# 第09章_接口文档

## 1. OpenAPI 3 架构与 Swagger

![](images/20230922191615.png)

Swagger 可以快速生成**实时接口文档**，方便前后端开发人员进行协调沟通，它遵循 OpenAPI 规范。

## 2. 整合

**（1）导入场景**

```xml
<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
    <version>2.1.0</version>
</dependency>
```

**（2）查看接口文档**

访问`http://ip:端口/swagger-ui/index.html`即可查看

**（3）配置文件**

一般无需额外配置，直接使用，效果就已经很好。以下配置只需了解一下常见配置项即可，无需使用：

```properties
# /api-docs endpoint custom path 默认 /v3/api-docs
springdoc.api-docs.path=/api-docs

# swagger 相关配置在  springdoc.swagger-ui
# swagger-ui custom path
springdoc.swagger-ui.path=/swagger-ui.html
springdoc.show-actuator=true
```

## 3. 使用

### 3.1 常用注解

**（1）@Tag**

标注在controller类上，可以描述该controller的作用：

- name：描述controller类的名称
- description：描述controller的作用

举例：

```java
@Tag(name = "部门", description = "部门的crud")
@RestController
public class DeptController {
}
```

**（2）@Parameter**

标注在参数上，可以描述参数：

- description：描述参数信息

举例：

```java
@Parameter(description = "部门id") Long id
```

**（3）@Parameters**

标注在参数上，作用是参数多重说明。

**（4）@Schema**

标注在实体类及其属性上，描述实体类信息：

- title：描述信息

举例：

```java
@Schema(title = "部门信息")
@Data
public class Dept {
    @Schema(title = "部门id")
    private Long id;
    @Schema(title = "部门名称")
    private String deptName;
}
```

**（5）@Operation**

标注在控制器方法上，用于描述方法的作用：

- summary：简要描述作用
- description：详细描述作用

举例：

```java
@Operation(summary = "按照id查询部门", description = "按照id查询部门，返回一个json类型的Dept对象")
@GetMapping("/dept/{id}")
public Dept getDept(@PathVariable("id") Long id) {
    return deptService.getDeptById(id);
}
```

**（6）@ApiResponse**

标注在控制器方法上，用于描述响应状态码等

### 3.2 Docket配置

如果我们有多个Controller，希望接口文档每个页面只展示一个Controller，这样看起来更加简单清楚。我们可以写一个配置类来进行配置：

```java
@Configuration
public class ApiUiConfig {
    @Bean
    public GroupedOpenApi employeeApi() {
        return GroupedOpenApi.builder()
                .group("员工管理")
                .pathsToMatch("/emp/**", "/emps")
                .build();
    }
    @Bean
    public GroupedOpenApi deptApi() {
        return GroupedOpenApi.builder()
                .group("部门管理")
                .pathsToMatch("/dept/**", "/depts")
                .build();
    }
}
```

### 3.3 OpenAPI配置

在配置类中添加组件配置OpenAPI，可以让界面展示更多额外信息：

```java
@Bean
public OpenAPI docsOpenAPI() {
    return new OpenAPI()
            .info(new Info()
                    .title("SpringBoot3-CRUD API")
                    .description("测试CRUD接口文档")
                    .version("v0.0.1")
                    .license(new License().name("Apache 2.0").url("http://springdoc.org")))
            .externalDocs(new ExternalDocumentation()
                    .description("哈哈 Wiki Documentation")
                    .url("https://springshop.wiki.github.org/docs"));
}
```

# 第10章_远程调用

## 1. RPC简介

**本地过程调用**，指的是在同一个JVM运行的不同方法间互相进行调用。

**远程过程调用**，简称RPC(Remote Procedure Call)，指的是`服务消费者`通过连接`服务提供者`的服务器进行请求/响应交互，来实现调用效果。

> 补充：API和SDK的区别
> - API是接口(Application Programming Interface)，它可以本地调用，也可以远程调用
> - SDK是工具包(Software Development Kit)，指的是本地导入jar包后，可以调用其中的方法

开发过程中，我们经常需要远程调用别人写的功能：

- 如果是内部微服务，可以通过依赖cloud、注册中心、openfeign等进行调用
- 如果是外部暴露的，可以发送http请求、或遵循外部协议进行调用

**SpringBoot提供了很多方式进行远程调用**：

（1）轻量级客户端方式

- RestTemplate：普通开发
- WebClient：响应式编程开发
- Http Interface：声明式编程

（2）Spring Cloud分布式解决方案

- Spring Cloud OpenFeign

（3）第三方框架

- Dubbo
- gRPC

## 2. WebClient

### 2.1 准备工作

我们先创建一个模块作为服务提供者，可以让服务消费者进行远程调用：

```java
@RestController
public class WeatherController {
    @GetMapping("/area-to-weather-date")
    public Weather getWeather(@RequestParam("area") String area,
                              @RequestHeader("userKey") String userKey) {
        if (!"wsy666".equals(userKey)) {
            return null;
        }
        return new Weather("晴朗", area);
    }
}
```

如上，需要在传递参数area，以及请求头中携带userKey=wsy666，才可以远程调用该接口。

### 2.2 WebClient的使用

WebClient是非阻塞、响应式的HTTP客户端，调用`WebClient.create()`或者`WebClient.create(String baseUrl)`即可创建。

我们创建一个模块来实现服务消费者：

**（1）添加依赖**

注意WebClient属于响应式Web，所以需要导入spring-boot-starter-webflux，而不是spring-boot-starter-web

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-webflux</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>io.projectreactor</groupId>
    <artifactId>reactor-test</artifactId>
    <scope>test</scope>
</dependency>
```

**（2）controller**

```java
@RestController
public class WeatherClientController {
    @GetMapping("/weather")
    public Mono<String> weather(@RequestParam("area") String area) {
        // 远程调用流程：
        // 1. 创建WebClient
        WebClient client = WebClient.create();
        // 2. 准备数据
        Map<String, String> params = new HashMap<>();
        params.put("area", area);
        // 3. 发请求(远程调用api)
        Mono<String> mono = client.get() // 发起get请求
                .uri("http://127.0.0.1:8888/area-to-weather-date?area={area}", params)
                .accept(MediaType.APPLICATION_JSON) // 定义响应的内容类型为JSON
                .header("userKey", "wsy666") // 定义请求头
                .retrieve() // retrieve()方法用来声明如何提取响应数据
                .bodyToMono(String.class);// 返回值类型
        return mono;
    }
}
```

**（3）测试**

启动服务提供者和服务消费者，然后访问`http://localhost:8080/weather?area=shanghai`

## 3. Http Interface

Spring 允许我们通过定义接口的方式，给任意位置发送 http 请求，实现远程调用，可以用来简化 HTTP 远程访问，它同样需要响应式Web场景。使用方式如下：

**（1）添加依赖**

与之前的WebClient所需依赖相同

**（2）定义接口**

```java
public interface WeatherInterface {
    @GetExchange(url = "/area-to-weather-date", accept = "application/json")
    Mono<String> getWeather(@RequestParam("area") String area,
                            @RequestHeader("userKey") String userKey);
}
```

**（3）配置类**

```java
@Configuration
public class MyConfig {
    @Bean
    public WeatherInterface weatherInterface() {
        // 1. 创建WebClient
        WebClient client = WebClient.builder()
                .baseUrl("http://127.0.0.1:8888")
                .codecs(clientCodecConfigurer -> {
                    clientCodecConfigurer.defaultCodecs()
                            .maxInMemorySize(256 * 1024 * 1024);
                    // 响应数据量太大有可能超出BufferSize，所以这里设置的大一些
                }).build();
        // 2. 创建工厂
        HttpServiceProxyFactory factory = HttpServiceProxyFactory
                .builder(WebClientAdapter.forClient(client)).build();
        // 3. 获取代理对象
        WeatherInterface weatherAPI = factory.createClient(WeatherInterface.class);
        return weatherAPI;
    }
}
```

**（4）controller**

```java
@RestController
public class WeatherHttpController {
    @Autowired
    private WeatherInterface weatherInterface;

    @GetMapping("/weatherHttp")
    public Mono<String> weatherHttp(@RequestParam("area") String area) {
        // 测试调用
        Mono<String> result = weatherInterface.getWeather(area, "wsy666");
        return result;
    }
}
```

**（5）测试**

启动服务提供者和服务消费者，然后访问`http://localhost:8080/weatherHttp?area=shanghai`

# 第11章_可观测性

## 1. Actuator场景

可观测性(Observability)：对线上应用进行观测、监控、预警

- 健康状况(Health)：组件状态、存活状态等
- 运行指标(Metrics)：cpu、内存、垃圾回收、吞吐量、响应成功率等
- 链路追踪

**（1）添加依赖**

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```

**（2）配置文件中暴露指标**

```properties
# 是否暴露所有端点信息，默认值就是true
management.endpoints.enabled-by-default=true
# 以web方式暴露的端点，默认只暴露health端点
management.endpoints.web.exposure.include=*
```

**（3）访问数据**

- 展示出所有可以用的监控端点，http://localhost:8080/actuator
- http://localhost:8080/actuator/beans
- http://localhost:8080/actuator/configprops
- http://localhost:8080/actuator/metrics
- http://localhost:8080/actuator/metrics/jvm.gc.pause

> 总结：http://localhost:8080/actuator/endpointName/detailPath

## 2. Endpoint

### 2.1 常用端点

**重点关注：threaddump、heapdump、metrics(运行时指标)、health(健康状况)**

- auditevents：暴露当前应用程序的审核事件信息。需要一个AuditEventRepository组件。
- beans：显示应用程序中所有Spring Bean的完整列表。
- caches：暴露可用的缓存。
- conditions：显示自动配置的所有条件信息，包括匹配或不匹配的原因。
- configprops：显示所有@ConfigurationProperties。
- env：暴露Spring的属性ConfigurableEnvironment
- flyway：显示已应用的所有Flyway数据库迁移。需要一个或多个Flyway组件。
- **health**：显示应用程序运行状况信息。
- httptrace：显示HTTP跟踪信息（默认情况下，最近100个HTTP请求-响应）。需要一个HttpTraceRepository组件。
- info：显示应用程序信息。
- integrationgraph：显示Spring integrationgraph。需要依赖spring-integration-core。
- loggers：显示和修改应用程序中日志的配置。
- liquibase：显示已应用的所有Liquibase数据库迁移。需要一个或多个Liquibase组件。
- **metrics**：显示当前应用程序的“指标”信息。
- mappings：显示所有@RequestMapping路径列表。
- scheduledtasks：显示应用程序中的计划任务。
- sessions：允许从Spring Session支持的会话存储中检索和删除用户会话。需要使用Spring Session的基于Servlet的Web应用程序。
- shutdown：使应用程序正常关闭。默认禁用该端点。
- startup：显示由ApplicationStartup收集的启动步骤数据。需要使用SpringApplication进行配置BufferingApplicationStartup。
- **threaddump**：执行线程转储。
- **heapdump**：返回hprof堆转储文件。
- jolokia：通过HTTP暴露JMX bean（需要引入Jolokia，不适用于WebFlux）。需要引入依赖jolokia-core。
- logfile：返回日志文件的内容（如果已设置logging.file.name或logging.file.path属性）。支持使用HTTPRange标头来检索部分日志文件的内容。
- prometheus：以Prometheus服务器可以抓取的格式公开指标。需要依赖micrometer-registry-prometheus。

### 2.2 定制健康监控端点HealthEndpoint

健康监控：返回存活、死亡

我们先定义一个组件MyHaha：

```java
@Component
public class MyHaha {
    public int check() {
        Random random = new Random();
        return random.nextInt(0, 2);
    }
}
```

然后定制一个健康监控端点，来监控该组件的健康状况：

```java
@Component
public class MyHahaHealthIndicator extends AbstractHealthIndicator {
    @Autowired
    private MyHaha myHaha;

    @Override // 自定义健康检查方法
    protected void doHealthCheck(Health.Builder builder) throws Exception {
        int check = myHaha.check();
        if (check == 1) {
            // 存活
            builder.up()
                    .withDetail("code", "1000")
                    .withDetail("msg", "活的很健康")
                    .withDetail("data", "我的名字叫haha")
                    .build();
        } else {
            // 下线
            builder.down()
                    .withDetail("code", "1111")
                    .withDetail("msg", "下线啦~~")
                    .withDetail("data", "我的名字叫haha，完蛋！")
                    .build();
        }
    }
}
```

> 定制健康端点，需要创建一个类来实现HealthIndicator接口，从而定制组件的健康状态对象(Health)返回。当然，也可以像上面一样，直接继承AbstractHealthIndicator。

除此之外，我们需要在配置文件中添加

```properties
# 是否暴露health端点，默认值就是true
management.endpoint.health.enabled=true
# 配置health端点总是显示详细信息，可显示每个模块的状态信息
management.endpoint.health.show-details=always
```

最后访问`http://localhost:8080/actuator/health`即可查看效果。


### 2.3 定制指标监控端点MetricsEndpoint

指标监控：次数、率

我们定义一个组件MyHello：

```java
@Component
public class MyHello {
    private Counter counter = null; // 计数器

    /**
     * 通过有参构造器注入meterRegistry，来保存和统计所有指标
     * @param meterRegistry
     */
    public MyHello(MeterRegistry meterRegistry) {
        // 得到一个名叫MyHello.hello的计数器
        counter = meterRegistry.counter("MyHello.hello");
    }
    public void hello() {
        System.out.println("hello");
        // 该方法被调用，计数器就加一
        counter.increment();
    }
}
```

我们要监控它的hello()方法被调用了多少次，所以再写一个controller：

```java
@RestController
public class HelloController {
    @Autowired
    private MyHello myHello;

    @GetMapping("/hello")
    public String hello() {
        // 业务方法
        myHello.hello();
        return "haha";
    }
}
```

多次访问`http://localhost:8080/hello`后，可以查看`http://localhost:8080/actuator/metrics/MyHello.hello`中的监控指标。

## 3. 监控案例

### 3.1 Prometheus和Grafana

我们之前已经安装过Prometheus和Grafana，接下来将使用SpringBoot整合Prometheus和Grafana来完成线上应用指标监控系统

![](images/Snipaste20231015200555.png)

整合流程如下：

### 3.2 部署SpringBoot应用到服务器

（1）添加依赖

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
<dependency>
    <groupId>io.micrometer</groupId>
    <artifactId>micrometer-registry-prometheus</artifactId>
</dependency>
```

（2）配置文件

```properties
server.port=9999
# 暴露所有端点信息
management.endpoints.enabled-by-default=true
# 以web方式暴露
management.endpoints.web.exposure.include=*
```

（3）测试

访问`http://localhost:9999/actuator/prometheus`能返回prometheus格式的所有指标，就表示成功

（4）将该SpringBoot工程打成jar包，上传到服务器

（5）服务器配置java环境

```shell
mkdir -p /opt/java
cd /opt/java
wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz
tar -xzf jdk-17_linux-x64_bin.tar.gz -C /opt/java/
vim /etc/profile
######### 末尾加入以下内容
export JAVA_HOME=/opt/java/jdk-17.0.8
export PATH=$PATH:$JAVA_HOME/bin
#########
source /etc/profile
```

（6）cd到我们自己工程jar包所在的目录，执行以下命令后台启动java应用：

```shell
nohup java -jar boot3-14-actuator-0.0.1-SNAPSHOT.jar > output.log 2>&1 &
```

（7）测试

- 用浏览器访问`公网ip:9999/actuator/prometheus`
- 如果在本机访问，可以直接访问内网ip，这样速度更快，如下测试
  ```shell
  curl http://10.0.8.3:9999/actuator/prometheus
  ```

### 3.3 配置Prometheus拉取数据

（8）配置Prometheus拉取数据，修改prometheus.yml配置文件，`vim /prod/prometheus.yml`，在scrape_configs属性下添加如下内容：

```yml
  - job_name: 'spring-boot-demo'
    metrics_path: '/actuator/prometheus' #指定抓取的路径
    static_configs:
      - targets: ['10.0.8.3:9999']
        labels:
          nodename: 'app-demo'
```

（9）重启prometheus，`docker restart prometheus`，然后访问`http://公网ip:9090/targets`，确保prometheus已经能够拉取我们应用的指标数据

### 3.4 配置Grafana监控面板

（10）访问`http://公网ip:3000`，添加prometheus数据源

![](images/Snipaste20231015211220.png)

（11）添加监控面板。可以去dashboard市场找一个自己喜欢的面板添加。

![](images/Snipaste20231015211609.png)

![](images/Snipaste20231015212021.png)

![](images/Snipaste20231015211817.png)

