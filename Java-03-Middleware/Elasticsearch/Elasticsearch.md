# 第01章_Elasticsearch简介

## 1. 简介

Elasticsearch是一款非常强大的开源的**分布式搜索引擎**，可以帮助我们从海量数据中快速找到需要的内容。

Elasticsearch结合Kibana、Logstash、Beats，被称为`Elastic Stack`（ELK技术栈），它被广泛应用在日志数据分析、实时监控等领域。

- Kibana：数据可视化
- Elasticsearch：存储、计算、搜索数据，是ELK的核心
- Logstash、Beats：数据抓取

Elasticsearch底层是基于Lucene来实现的。Lucene是一个Java语言的搜索引擎类库，是Apache公司的顶级项目，其优点是性能高（基于倒排索引），但其缺点是只限于Java语言开发、不支持水平扩展。所以Elasticsearch基于Lucene二次开发，它支持分布式、可水平扩展，且提供RESTful接口、能够被任何语言调用。

## 2. ES的一些概念

- Index：索引库，也就是相同类型文档的集合，类似MySQL中的Table
- Document：文档，类似于MySQL中的Row。注意ES中文档是JSON格式的。
- Field：字段，也就是文档中的各个字段，类似于MySQL中的Column
- Mapping：映射，是索引库中文档的字段约束信息。类似于MySQL的表结构(Schema)
- DSL：用来操作ES的JSON风格的请求语句。对应于MySQL中的SQL语句。

**注意**：MySQL擅长事务类型操作，可以确保数据的安全和一致性；而Elasticsearch擅长海量数据的搜索、分析、计算。所以两者并非竞争关系，往往是结合使用：

- 对安全性要求较高的写操作，使用MySQL实现
- 对查询性能要求较高的搜索需求，使用Elasticsearch实现
- 两者再基于某种方式，实现数据的同步，保证一致性

![image-20210720203534945](images/image-20210720203534945.png)

## 3. 倒排索引

### 3.1 正向索引

倒排索引是相对于MySQL这样的正向索引而提出的。例如MySQL中给商品id创建了索引（正向索引），那么根据id查询就会走索引，速度非常快。

然而，如果根据商品名称进行模糊查询，例如`"%手机%"`，那么索引就失效了，此时只能逐行遍历、全表扫描，效率极低。

**总结**：**正向索引**是最传统的，根据id索引的方式。但根据词条查询时，必须先逐条获取每个文档，然后判断文档中是否包含所需要的词条，是**根据文档找词条的过程**。

### 3.2 倒排索引

倒排索引中有一个非常重要的概念，词条(`Term`)：对文档数据或用户搜索数据，利用某种算法分词，得到的具备含义的词语就是词条。例如，`我是中国人`，就可以分为：`我`、`是`、`中国人`这样的几个词条。

**创建倒排索引的流程**如下：

1. 将每一个文档的数据利用算法分词，得到一个个词条
2. 创建表，每行数据包括词条、词条所在文档id、位置等信息
3. 因为词条的唯一性，我们就可以给词条创建索引，这就是倒排索引

![image-20210720200457207](images/image-20210720200457207.png)


**倒排索引的搜索流程**如下，以搜索`华为手机`为例：

1. 例如，用户输入`华为手机`进行搜索
2. 对用户输入内容**分词**，得到词条：`华为`、`手机`
3. 拿着词条在倒排索引中查找，可以得到包含词条的文档id：1、2、3
4. 拿着文档id到正向索引中查找具体文档

![image-20210720201115192](images/image-20210720201115192.png)

> 虽然要先查询倒排索引，再查询正向索引，但是无论是词条、还是文档id都建立了索引，所以无需全表扫描，查询速度非常快。

**总结**：**倒排索引**，是先找到用户要搜索的词条，根据词条得到文档id，然后根据id获取文档，是**根据词条找文档的过程**。


# 第02章_Elasticsearch安装

## 1. 安装Elasticsearch

### 1.1 创建网络

因为我们还需要部署kibana容器，所以需要让es和kibana容器互联。为此先创建一个网络：

```sh
docker network create es-net
```

### 1.2 拉取镜像

我们采用es的8.6.0版本的镜像：

```sh
docker pull elasticsearch:8.6.0
```

### 1.3 创建挂载点目录

```shell
mkdir -p /es/data
mkdir -p /es/plugins
chmod 777 /es/data
chmod 777 /es/plugins
```

### 1.4 运行容器

运行容器，部署单点es

```sh
docker run -d \
--name es \
--network es-net \
-p 9200:9200 \
-p 9300:9300 \
--privileged \
-v /es/data:/usr/share/elasticsearch/data \
-v /es/plugins:/usr/share/elasticsearch/plugins \
-e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
-e "discovery.type=single-node" \
elasticsearch:8.6.0
```

参数解释：

- `-e "cluster.name=es-docker-cluster"`：设置集群名称
- `-e "http.host=0.0.0.0"`：监听的地址，可以外网访问
- `-e "ES_JAVA_OPTS=-Xms512m -Xmx512m"`：内存大小
- `-e "discovery.type=single-node"`：非集群模式
- `--network es-net` ：加入一个名为es-net的网络中

### 1.5 修改elasticsearch.yml

```shell
cd ~
docker cp 容器id:/usr/share/elasticsearch/config/elasticsearch.yml /root/elasticsearch.yml
vi elasticsearch.yml
```

容器id指的是es实例的容器id。我们将yml文件中的一项配置修改成`xpack.security.enabled: false`

```shell
docker cp /root/elasticsearch.yml 容器id:/usr/share/elasticsearch/config/elasticsearch.yml
rm -rf /root/elasticsearch.yml
```

### 1.6 测试

（1）重启es容器：`docker restart es`

（2）浏览器访问`http://192.168.231.124:9200`成功

## 2. 安装Kibana

### 2.1 拉取镜像

Kibana可以给我们提供一个Elasticsearch的可视化界面。我们使用匹配的版本8.6.0

```shell
docker pull kibana:8.6.0
```

### 2.2 运行容器

```shell
docker run -d \
--name kibana \
--network es-net \
-p 5601:5601 \
-e ELASTICSEARCH_HOSTS=http://es:9200 \
kibana:8.6.0
```

### 2.3 测试

（1）访问`http://192.168.231.124:5601`成功

（2）Kibana中提供了一个DevTools界面，这个界面中可以编写DSL来操作Elasticsearch。

## 3. 安装IK分词器

### 3.1 安装步骤

注意，安装的IK分词器版本必须与ES的版本匹配。

（1）我们首先下载IK分词器，下载地址为 https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v8.6.0/elasticsearch-analysis-ik-8.6.0.zip

（2）然后在`/es/plugins`下创建一个名为`ik`的目录，并将`elasticsearch-analysis-ik-8.6.0.zip`上传到`ik`目录下并解压

```shell
mkdir -p /es/plugins/ik
cd /es/plugins/ik
yum install -y unzip zip
unzip elasticsearch-analysis-ik-8.6.0.zip
rm -rf elasticsearch-analysis-ik-8.6.0.zip
```

（3）重启es实例

```shell
chmod -R 777 /es/{data,plugins}
docker restart es
```

### 3.2 IK分词器简介

分词器的作用是：创建倒排索引时对文档分词；用户搜索时，对输入的内容分词。

由于默认的分词器无法根据中文语义来进行分词，所以我们需要使用IK分词器。IK分词器有两种模式：

- `ik_smart`：最少切分。例如，`上海程序员`就会被分词为`上海`、`程序员`
- `ik_max_word`：最细切分。例如，`上海程序员`就会被分词为`上海`、`程序员`、`程序`、`员`

### 3.3 扩展词词典

随着时代的更新，我们可能会产生一些新词汇，所以IK分词器提供了扩展词汇的功能，具体步骤如下：

（1）进入IK分词器的config目录

```sh
cd /es/plugins/ik/config
```

（2）修改xml配置文件`vi IKAnalyzer.cfg.xml`，在扩展词典部分添加：

```xml
    <!--用户可以在这里配置自己的扩展字典 -->
    <entry key="ext_dict">ext.dic</entry>
```

（3）新建一个文件`vi ext.dic`，并添加扩展词汇

```vi
奥力给
玛莎卡
家里蹲大学
```

（4）重启es，`docker restart es`

（5）测试：在Kibana提供的DevTools界面发送命令

```json
GET /_analyze
{
  "analyzer": "ik_smart",
  "text": "玛莎卡，我就读于家里蹲大学，奥力给！"
}
```

- `GET`是请求方式
- `/_analyze`是请求路径，这里省略了`http://192.168.231.124:9200`，因为Kibana会帮我们补充
- 请求参数是JSON格式的，其中`analyzer`表示分词器类型，默认的分词器是`"standard"`，`text`是要分词的内容。

### 3.4 停用词词典

IK分词器也提供了强大的停用词功能，让我们在索引时就直接忽略当前的停用词汇表中的内容。像一些敏感词，或者一些无意义的语助词，就可以添加到停用词汇表中。具体步骤如下：

（1）进入IK分词器的config目录

```sh
cd /es/plugins/ik/config
```

（2）修改xml配置文件`vi IKAnalyzer.cfg.xml`，在扩展停止词部分添加：

```xml
    <!--用户可以在这里配置自己的扩展停止词字典-->
    <entry key="ext_stopwords">stopword.dic</entry>
```

（3）修改文件`vi stopword.dic`，添加停用词

```vi
我
啊
nnd
```

（4）重启es，`docker restart es`

（5）测试：在Kibana提供的DevTools界面发送命令

```json
GET /_analyze
{
  "analyzer": "ik_smart",
  "text": "玛莎卡，我就读于家里蹲大学，奥力给！"
}
```

# 第03章_ES的基本操作

## 1. Mapping属性

Mapping是对索引库中文档字段的约束，常见的Mapping属性包括：

- type：字段数据类型，常见的类型有：
  - 字符串：text（进行分词的文本）、keyword（不进行分词的文本）
  - 数值：long、integer、short、byte、double、float
  - 布尔：boolean
  - 日期：date
  - 对象：object
- index：是否创建索引，默认为true
- analyzer：使用哪种分词器
- properties：该字段的子字段

## 2. 命令操作ES

### 2.1 索引库的CRUD

#### 1、创建索引库

语法格式：

```json
PUT /索引库名 
{
  "mappings": {
    "properties": {
      "字段名1": {
        "type": "integer"
      },
      "字段名2": {
        "type": "text",
        "analyzer": "ik_smart"
      },
      "字段名3": {
        "type": "keyword",
        "index": false
      },
      "字段名4": {
        "type": "object", 
        "properties": {
          "子字段名": {
            "type": "keyword"
          },
          "子字段名": {
            "type": "keyword"
          }
        }
      }
    }
  }
}
```

例如，对于以下json文档：

```json
{
    "age": 18,
    "info": "清华大学数学系教授",
    "email": "wsy@qq.com",
    "name": {
        "firstName": "Shengyu",
        "lastName": "Wu"
    }
}
```

- `age`: type为integer；无需分词器；参与搜索(例如排序)，所以需要index为true
- `info`: type为text；需要分词器；参与搜索，所以需要index为true
- `email`: type为keyword；无需分词器；不参与搜索，所以index为false
- `name`: type为object，需要定义多个子字段

> 总结：每一个字段都需要指定type；不参与搜索的，设置index为false；需要分词的，则指定分词器。

示例：

```json
PUT /user 
{
  "mappings": {
    "properties": {
      "age": {
        "type": "integer"
      },
      "info": {
        "type": "text",
        "analyzer": "ik_smart"
      },
      "email": {
        "type": "keyword",
        "index": false
      },
      "name": {
        "type": "object", 
        "properties": {
          "firstName": {
            "type": "keyword"
          },
          "lastName": {
            "type": "keyword"
          }
        }
      }
    }
  }
}
```

#### 2、查找索引库

语法格式：`GET /索引库名`

#### 3、删除索引库

语法格式：`DELETE /索引库名`

#### 4、修改索引库

注意：索引库一旦创建，就**无法修改mapping中的已有字段**，因为重建倒排索引的代价是极大的。但是可以添加新的字段到mapping中。语法格式如下：

```json
PUT /索引库名/_mapping
{
  "properties": {
    "新字段名": {
      "type": "integer"
    }
  }
}
```

### 2.2 文档的CRUD

#### 1、新增文档

语法格式：

```json
POST /索引库名/_doc/文档id
{
  "字段名1": "值1",
  "字段名2": "值2",
  "字段名3": "值3",
  "字段名4": {
    "子字段名": "值",
    "子字段名": "值"
  }
}
```

#### 2、查询文档

语法格式：`GET /索引库名/_doc/文档id`

#### 3、删除文档

语法格式：`DELETE /索引库名/_doc/文档id`

#### 4、修改文档

修改文档有两种方式：全量修改、增量修改

**（1）全量修改**：就是直接覆盖原来的文档，其本质是根据指定的id删除文档，再新增一个相同id的文档。注意，如果指定的id本来就不存在，那么该操作就相当于新增文档。

```json
PUT /索引库名/_doc/文档id
{
  "字段名1": "值1",
  "字段名2": "值2",
  "字段名3": "值3",
  "字段名4": {
    "子字段名": "值",
    "子字段名": "值"
  }
}
```

**（2）增量修改**：就是只修改指定id的文档中的部分字段

```json
POST /索引库名/_update/文档id
{
  "doc": {
    "字段名1": "新值1",
    "字段名2": "新值2"
  }
}
```

## 3. 实战案例搭建

### 3.1 MySQL数据

在`192.168.231.101`虚拟机的MySQL中执行sql脚本`tb_hotel.sql`

### 3.2 搭建SpringBoot工程

#### 1、添加依赖

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
<dependency>
    <groupId>org.mybatis.spring.boot</groupId>
    <artifactId>mybatis-spring-boot-starter</artifactId>
    <version>3.0.0</version>
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
```

#### 2、配置文件

```properties
server.port=8080

spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.type=com.zaxxer.hikari.HikariDataSource
spring.datasource.url=jdbc:mysql://192.168.231.101:3306/es_test_db
spring.datasource.username=root
spring.datasource.password=abc666

mybatis.mapper-locations=classpath:/mapper/*.xml
mybatis.configuration.map-underscore-to-camel-case=true
mybatis.type-aliases-package=com.thuwsy.es.pojo
```

#### 3、主启动类

```java
@MapperScan("com.thuwsy.es.mapper")
@SpringBootApplication
public class HotelDemoApplication {
    public static void main(String[] args) {
        SpringApplication.run(HotelDemoApplication.class, args);
    }
}
```

#### 4、实体类

Hotel类对应于MySQL中的表：

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Hotel implements Serializable {
    private Long hotelId;
    private String hotelName;
    private String hotelAddress;
    private Integer hotelPrice;
    private Integer hotelScore;
    private String hotelBrand;
    private String hotelCity;
    private String hotelStarName;
    private String hotelBusiness;
    private String hotelLatitude;
    private String hotelLongitude;
    private String hotelPic;
}
```

HotelDoc类对应于ES中的索引库：

```java
@Data
@NoArgsConstructor
public class HotelDoc implements Serializable {
    private Long hotelId;
    private String hotelName;
    private String hotelAddress;
    private Integer hotelPrice;
    private Integer hotelScore;
    private String hotelBrand;
    private String hotelCity;
    private String hotelStarName;
    private String hotelBusiness;
    private String hotelLocation;
    private String hotelPic;

    public HotelDoc(Hotel hotel) {
        this.hotelId = hotel.getHotelId();
        this.hotelName = hotel.getHotelName();
        this.hotelAddress = hotel.getHotelAddress();
        this.hotelPrice = hotel.getHotelPrice();
        this.hotelScore = hotel.getHotelScore();
        this.hotelBrand = hotel.getHotelBrand();
        this.hotelCity = hotel.getHotelCity();
        this.hotelStarName = hotel.getHotelStarName();
        this.hotelBusiness = hotel.getHotelBusiness();
        this.hotelLocation = hotel.getHotelLatitude() + ", " + hotel.getHotelLongitude();
        this.hotelPic = hotel.getHotelPic();
    }
}
```

#### 5、业务类

HotelMapper

```java
public interface HotelMapper {
    List<Hotel> selectAll();
}
```

对应的mapper映射文件：

```xml
<mapper namespace="com.thuwsy.es.mapper.HotelMapper">
    <select id="selectAll" resultType="com.thuwsy.es.pojo.Hotel">
        select * from tb_hotel
    </select>
</mapper>
```

## 4. API操作ES

### 4.1 简介

ES官方提供了各种不同语言的客户端用来操作ES。这些客户端的本质就是组装DSL语句，通过http请求发送给ES。我们使用ES的Java客户端，步骤如下：

（1）添加依赖（注意ES的依赖要与ES的版本一致）

```xml
<dependency>
    <groupId>co.elastic.clients</groupId>
    <artifactId>elasticsearch-java</artifactId>
    <version>8.6.0</version>
</dependency>
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>2.12.3</version>
</dependency>
<dependency>
    <groupId>jakarta.json</groupId>
    <artifactId>jakarta.json-api</artifactId>
    <version>2.0.1</version>
</dependency>
```

（2）配置文件中添加ES相关配置

```properties
elasticsearch.host=192.168.231.124
elasticsearch.port=9200
```

（3）配置类初始化ElasticsearchClient

```java
@Configuration
public class ElasticsearchConfig {
    @Value("${elasticsearch.host}")
    private String host;
    @Value("${elasticsearch.port}")
    private Integer port;

    @Bean // 初始化ES客户端
    public ElasticsearchClient client() {
        // 1. Create the low-level client
        RestClient restClient = RestClient.builder(new HttpHost(host, port)).build();
        // 2. Create the transport with a Jackson mapper
        RestClientTransport transport = new RestClientTransport(restClient, new JacksonJsonpMapper());
        // 3. Create the API client
        return new ElasticsearchClient(transport);
    }
}
```

### 4.2 索引库的CRUD

#### 1、创建索引库

根据业务，我们的索引库结构如下：

```json
{
  "mappings": {
    "properties": {
      "hotelId": {
        "type": "keyword"
      },
      "hotelName": {
        "type": "text",
        "analyzer": "ik_max_word",
        "copy_to": "hotelAll"
      },
      "hotelAddress": {
        "type": "keyword",
        "index": false
      },
      "hotelPrice": {
        "type": "integer"
      },
      "hotelScore": {
        "type": "integer"
      },
      "hotelBrand": {
        "type": "keyword",
        "copy_to": "hotelAll"
      },
      "hotelCity": {
        "type": "keyword",
        "copy_to": "hotelAll"
      },
      "hotelStarName": {
        "type": "keyword"
      },
      "hotelBusiness": {
        "type": "keyword"
      },
      "hotelLocation": {
        "type": "geo_point"
      },
      "hotelPic": {
        "type": "keyword",
        "index": false
      },
      "hotelAll": {
        "type": "text",
        "analyzer": "ik_max_word"
      }
    }
  }
}
```

- `"geo_point"`是一个地理坐标数据类型，是由纬度和经度确定的一个点，例如`"32.8752345, 120.2981576"`，其中前一个是纬度、后一个是经度
- `hotelAll`是我们自定义的一个组合字段，其目的是将多个字段的值，利用`copy_to`合并，提供给用户搜索

我们将上述json保存到resources目录下的文件`hotel.json`中，然后使用API来创建索引库：

```java
@SpringBootTest
@Slf4j
class HotelDemoApplicationTests {
    @Autowired
    private ElasticsearchClient client;

    @Test
    public void createHotelIndex() throws IOException {
        // 1. 获取json字符串
        InputStream inputStream = getClass().getClassLoader()
                .getResourceAsStream("hotel.json");
        // 2. 发起请求：创建索引库
        CreateIndexResponse response = client.indices().create(builder -> builder
                .index("hotel") // 索引库名称
                .withJson(inputStream) // json内容
        );
        // 打印响应信息
        log.info("创建索引库是否成功? {}", response.acknowledged());
    }
}
```

#### 2、查找索引库

查找指定索引库：

```java
@Test
public void getHotelIndex() throws IOException {
    // 1. 发起请求：查找索引库
    GetIndexResponse response = client.indices().get(builder -> builder
            .index("hotel"));
    // 打印响应信息
    response.result().forEach((k, v) ->
            log.info("key={}, value={}", k, v));
}
```

判断指定索引库是否存在：

```java
@Test
public void existsHotelIndex() throws IOException {
    // 1. 发起请求：判断索引库是否存在
    BooleanResponse response = client.indices().exists(builder -> builder
            .index("hotel"));
    // 打印响应信息
    log.info("索引库是否存在? {}", response.value());
}
```

#### 3、删除索引库

```java
@Test
public void deleteHotelIndex() throws IOException {
    // 1. 发起请求：删除索引库
    DeleteIndexResponse response = client.indices().delete(builder -> builder
            .index("hotel"));
    // 打印响应信息
    log.info("删除索引库是否成功? {}", response.acknowledged());
}
```

> 说明：索引库只能新增字段，不能修改字段。而在实际生产中，我们基本也不会更改索引库，所以就不演示update的相关API。

### 4.3 文档的CRUD

#### 1、新增文档

```java
@Test
public void addDocument() throws IOException {
    // 1. 根据id查询MySQL数据，这里为了方便我们直接new
    Hotel hotel = new Hotel(11L, "name", "addr", 400, 5, "brand", "city", "star", "buzz", "33.1", "88.8", "pic-url");
    // 2. 转换为ES中对应的文档类型
    HotelDoc hotelDoc = new HotelDoc(hotel);

    // 3. 发起请求：新增文档
    IndexResponse response = client.index(builder -> builder
            .index("hotel") // 索引库名称
            .id(hotelDoc.getHotelId().toString()) // 文档id
            .document(hotelDoc) // 文档内容
    );
    // 打印响应信息
    log.info("result: {}", response.result());
}
```

#### 2、查询文档

我们先演示简单的根据id查询文档，文档的更多复杂查询会在后续演示。

```java
@Test
public void getDocument() throws IOException {
    // 1. 发起请求：根据id查询文档
    GetResponse<HotelDoc> response = client.get(builder -> builder
                    .index("hotel") // 索引库名称
                    .id("11") // 要查询的文档id
            , HotelDoc.class);
    // 2. 判断是否查找到
    if (response.found()) {
        // 3. 转换为对应的实体类
        HotelDoc hotelDoc = response.source();
        log.info("查找到：{}", hotelDoc);
    } else {
        log.info("没有查找到！");
    }
}
```

#### 3、删除文档

```java
@Test
public void deleteDocument() throws IOException {
    // 1. 发起请求：删除文档
    DeleteResponse response = client.delete(builder -> builder
            .index("hotel") // 索引库名称
            .id("11") // 要删除的文档id
    );
    // 打印响应信息
    log.info("result: {}", response.result());
}
```

#### 4、修改文档

修改文档分为全量修改和增量修改。全量修改的API与新增文档的API一致，我们以下演示增量修改：

```java
@Test
public void updateDocument() throws IOException {
    // 1. 使用Map构建需要修改的字段内容
    HashMap<String, Object> map = new HashMap<>();
    map.put("hotelName", "apple");
    map.put("hotelAddress", "Shanghai");

    // 2. 发起请求：更新文档
    UpdateResponse<HotelDoc> response = client.update(builder -> builder
                    .index("hotel") // 索引库名称
                    .id("11") // 要修改的文档id
                    .doc(map) // 修改的字段内容
            , HotelDoc.class);
    // 打印响应信息
    log.info("result: {}", response.result());
}
```

#### 5、批量新增文档

我们使用`client.bulk()`来批量新增文档：

```java
@SpringBootTest
@Slf4j
class HotelDemoApplicationTests {
    @Autowired
    private ElasticsearchClient client;
    @Autowired
    private HotelMapper hotelMapper;
    
    @Test
    public void addAllDocuments() throws IOException {
        // 1. 先从MySQL中查询出全部数据
        List<Hotel> hotels = hotelMapper.selectAll();
        // 2. 创建BulkRequest的建造器
        BulkRequest.Builder br = new BulkRequest.Builder();

        for (Hotel hotel : hotels) {
            HotelDoc hotelDoc = new HotelDoc(hotel); // 转化为ES对应的文档实体类
            // 3. 添加文档
            br.operations(op -> op.index(builder -> builder
                    .index("hotel") // 索引库名称
                    .id(hotelDoc.getHotelId().toString()) // 文档id
                    .document(hotelDoc) // 文档内容
            ));
        }

        // 4. 发送请求：批量新增文档
        BulkResponse response = client.bulk(br.build());
        // 打印响应信息
        log.info("是否发生错误? {}", response.errors());
    }
}
```

#### 6、批量删除文档

```java
@Test
public void deleteSomeDocuments() throws IOException {
    // 1. 要删除的文档id集合
    List<Integer> list = List.of(1, 2, 3, 5, 8);
    // 2. 创建BulkRequest的建造器
    BulkRequest.Builder br = new BulkRequest.Builder();

    for (Integer i : list) {
        // 3. 添加要删除的文档id
        br.operations(op -> op.delete(builder -> builder
                .index("hotel") // 索引库名称
                .id(i.toString()) // 文档id
        ));
    }

    // 4. 发送请求：批量删除文档
    BulkResponse response = client.bulk(br.build());
    // 打印响应信息
    log.info("是否发生错误? {}", response.errors());
}
```

# 第04章_DSL方式高级查询

Elasticsearch提供了基于JSON的DSL（Domain Specific Language）来定义查询。查询的语法基本一致：

```json
GET /索引库名称/_search
{
  "query": {
    "查询类型": {
      "查询条件": "条件值"
    }
  }
}
```

## 1. 查询所有文档

> 一般这种查询只在测试的时候使用

查询类型为`match_all`：

```json
GET /hotel/_search
{
  "query": {
    "match_all": {}
  }
}
```

## 2. 全文检索查询

全文检索查询会利用分词器对用户输入内容分词，然后去倒排索引库中匹配。基本流程如下：

- 对用户搜索的内容做分词，得到词条
- 根据词条去倒排索引库中匹配，得到文档id
- 根据文档id找到文档，返回给用户

> 全文检索查询的常用场景是用户在搜索框中进行查询。

### 2.1 单字段全文检索查询

单字段全文检索查询的查询类型是`match`：

```json
GET /hotel/_search
{
  "query": {
    "match": {
      "hotelName": "如家商旅"
    }
  }
}
```

对于我们用copy_to复制到的自定义字段`hotelAll`，也可以使用单字段全文检索查询：

```json
GET /hotel/_search
{
  "query": {
    "match": {
      "hotelAll": "外滩如家"
    }
  }
}
```

### 2.2 多字段全文检索查询

多字段全文检索查询的查询类型是`multi_match`，只要任意一个字段符合条件就算符合查询条件：

```json
GET /hotel/_search
{
  "query": {
    "multi_match": {
      "query": "外滩如家",
      "fields": ["hotelBrand", "hotelName", "hotelCity"]
    }
  }
}
```

可以看到，该查询与前面单字段查询`hotelAll`的结果是一样的，因为我们将`hotelBrand`、`hotelName`、`hotelCity`三个字段利用copy_to拷贝到了`hotelAll`字段中。

> 注意：搜索字段越多，对查询性能影响越大，因此建议采用`copy_to`，然后单字段查询的方式。

## 3. 精确查询

根据精确词条值查找数据，一般是查找keyword、数值、日期、boolean等类型字段，所以不会对搜索条件进行分词。

### 3.1 term查询

term查询根据词条精确值查询，即用户输入的内容跟字段值完全匹配时才认为符合条件。

```json
GET /hotel/_search
{
  "query": {
    "term": {
      "hotelCity": {
        "value": "上海"
      }
    }
  }
}
```

### 3.2 range查询

range查询根据数值范围查询，可以是数值、日期的范围。

```json
GET /hotel/_search
{
  "query": {
    "range": {
      "hotelPrice": {
        "gt": 1000,
        "lte": 2000
      }
    }
  }
}
```

> `gt`、`gte`、`lt`、`lte`分别表示`大于`、`大于等于`、`小于`、`小于等于`

## 4. 地理坐标查询

地理坐标查询，就是根据经纬度查询。

### 4.1 矩形范围查询

查询时，需要指定矩形的**左上**、**右下**两个点的坐标，然后画出一个矩形，落在该矩形内的都是符合条件的点。查询类型是`geo_bounding_box`：

```json
GET /hotel/_search
{
  "query": {
    "geo_bounding_box": {
      "hotelLocation": {
        "top_left": {
          "lat": 31.1,
          "lon": 121.5
        },
        "bottom_right": {
          "lat": 30.9,
          "lon": 121.7
        }
      }
    }
  }
}
```

### 4.2 距离查询

查询到指定中心点小于某个距离值的所有点，查询类型是`geo_distance`：

```json
GET /hotel/_search
{
  "query": {
    "geo_distance": {
      "distance": "15km",
      "hotelLocation": "31.21, 121.5"
    }
  }
}
```

## 5. 复合查询

复合查询可以将上述简单查询组合起来，实现更复杂的搜索逻辑。

### 5.1 算分函数查询

当我们利用match查询时，文档结果会根据与搜索词条的关联度进行打分，返回结果时按照分值`_score`降序排列。打分时使用的算法是BM25算法。

但是，有时候我们想人为控制分数，这就需要用到算分函数。

![image-20210721191544750](images/image-20210721191544750.png)

算分函数查询的流程如下：

1. 根据**原始条件**查询搜索文档，并且计算相关性算分，称为**原始算分**（query score）
2. 根据**过滤条件**，找到符合过滤条件的文档，基于**算分函数**运算，得到**函数算分**（function score）
3. 对于这些符合过滤条件的文档，将**原始算分**和**函数算分**基于**运算模式**做运算，得到最终结果，作为相关性算分。

举例：让`如家`这个品牌的酒店排名靠前一些

```json
GET /hotel/_search
{
  "query": {
    "function_score": {
      "query": {"match_all": {}},
      "functions": [
        {
          "filter": {
            "term": {
              "hotelBrand": "如家"
            }
          },
          "weight": 20
        }
      ],
      "boost_mode": "sum"
    }
  }
}
```

> 以上，我们将每个`如家`品牌的酒店打分都加了20分。

### 5.2 布尔查询

布尔查询是一个或多个查询子句的组合，每一个子句就是一个**子查询**。子查询的组合方式有：

- must：必须匹配每个子查询，类似`与`
- should：选择性匹配子查询，类似`或`
- must_not：必须不匹配，**不参与算分**
- filter：必须匹配，**不参与算分**

注意：计算相关性算分，必然会消耗性能，有时某些字段完全没必要计算相关性算分，这时我们就可以用`filter`或`must_not`。

> 一般来说，对于搜索框关键字的搜索，是全文检索查询，需要使用`must`参与算分；而其他过滤条件，可以采用`filter`不参与算分。

**举例**：搜索名字包含`如家`，价格不高于400，在坐标`31.21, 121.5`周围`10km`范围内的酒店

**分析**：

- 名称搜索，属于全文检索查询，应该参与算分，放到`must`中
- 价格不高于400，用`range`查询，属于过滤条件，不参与算分，放到`must_not`中
- 周围10km范围内，用`geo_distance`查询，属于过滤条件，不参与算分，放到filter中

```json
GET /hotel/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "hotelName": "如家"
          }
        }
      ],
      "must_not": [
        {
          "range": {
            "hotelPrice": {
              "gt": 400
            }
          }
        }
      ],
      "filter": [
        {
          "geo_distance": {
            "distance": "10km",
            "hotelLocation": "31.21, 121.5"
          }
        }
      ]
    }
  }
}
```

## 6. 搜索结果处理-排序

Elasticsearch默认是根据相关度算分`_score`来排序，但是也支持自定义方式对搜索结果进行排序（此时就不会进行相关度算分）。可以排序字段类型有：keyword类型、数值类型、地理坐标类型、日期类型等。

### 6.1 普通字段排序

keyword、数值、日期类型排序的语法基本一致。注意，排序条件是一个数组，当第一个条件相等时，再按照第二个条件排序，以此类推。

举例：酒店数据按照用户评分降序排序，评分相同的再按照价格升序排序

```json
GET /hotel/_search
{
  "query": {"match_all": {}},
  "sort": [
    {
      "hotelScore": "desc"
    },
    {
      "hotelPrice": "asc"
    }
  ]
}
```

### 6.2 地理坐标排序

举例：酒店数据按照到你的位置坐标`31.034661, 121.612282`的距离升序排序

```json
GET /hotel/_search
{
  "query": {"match_all": {}},
  "sort": [
    {
      "_geo_distance": {
        "hotelLocation": "31.034661, 121.612282",
        "order": "asc",
        "unit": "km"
      }
    }
  ]
}
```

> 注意：所指定的中心点位置的字段，必须是`geo_point`类型

## 7. 搜索结果处理-分页

### 7.1 分页的基本使用

Elasticsearch默认情况下只返回前10条数据。如果要查询更多数据就需要修改分页参数了。可以通过修改from、size参数来控制要返回的分页结果：

- from：从第几个文档开始
- size：返回几个文档

示例：

```json
GET /hotel/_search
{
  "query": {"match_all": {}},
  "from": 50,
  "size": 20,
  "sort": [
    { "hotelPrice": "asc" }
  ]
}
```

> 注意：无论`from`和`size`写在什么位置，都是先进行`sort`排序，再进行分页截取。

### 7.2 深度分页问题

如果要查询第900到第1000条数据，ES底层会查询0到1000条数据，然后再截取第900到第1000条。这么设计的原因在于：ES一般都会通过集群部署，例如10个节点，那么如果想得到排序最靠后的1000条数据，并不能只查每个节点的后100条数据，而必须查询每个节点的后1000条数据，再进行汇总、排序、截取。

因此，当查询分页深度较大时，对内存和CPU会产生很大的压力。所以，Elasticsearch禁止`from+size`超过10000的请求。

> 如果我们真的有`from+size`超过10000的查询需求，则可以使用`search after`：它在分页时需要排序，原理是从上一次的排序值开始，查询下一页数据。

## 8. 搜索结果处理-高亮

对查询结果进行高亮显示，主要做以下两步：

- 前端页面提供一个标签，例如`<em>`，并编写其CSS样式作为高亮
- Elasticsearch查询后给文档中的所有关键字添加`<em>`标签即可

**注意**：

- 高亮是对关键字高亮，因此**搜索条件必须带有关键字**，而不能是范围查询。
- 默认情况下，**高亮的字段，必须与搜索指定的字段一致**，否则无法高亮
- 如果要对非搜索字段高亮，则需要添加一个属性：`required_field_match=false`

示例：

```json
GET /hotel/_search
{
  "query": {
    "match": {
      "hotelAll": "如家"
    }
  },
  "highlight": {
    "fields": {
      "hotelName": {
        "pre_tags": "<em>", 
        "post_tags": "</em>", 
        "require_field_match": "false"
      }
    }
  }
}
```

# 第05章_API方式高级查询

ES查询的响应信息是一个JSON字符串，其中`hits`就是命中的结果，主要包含以下结构：

- `total`：总条数，其中的`value`是具体的总条数值
- `max_score`：所有结果中得分最高的文档的相关性算分
- `hits`：搜索结果的文档数组，其中的每个文档都是一个json对象，其中的`_source`代表文档中的原始数据，也是json对象

因此，对于查询结果我们都需要进行解析，为了简便，我们将其封装成一个方法，便于调用：

```java
@SpringBootTest
@Slf4j
public class HotelQueryTests {
    @Autowired
    private ElasticsearchClient client;

    private void handleResponse(SearchResponse<HotelDoc> response) {
        // 解析响应
        HitsMetadata<HotelDoc> metadata = response.hits();

        // 1. 获取查询到的文档总数
        log.info("查询到的文档总数为：{}", metadata.total().value());
        // 2. 获取所有的文档
        List<Hit<HotelDoc>> list = metadata.hits();
        for (Hit<HotelDoc> hit : list) {
            // 3. 获取每个文档，并转化为对应的实体类
            HotelDoc hotelDoc = hit.source();
            log.info("hotelDoc = {}", hotelDoc);
        }
    }
}
```

## 1. 查询所有文档

```java
@Test
public void matchAll() throws IOException {
    // 1. 发起请求：查询所有文档
    SearchResponse<HotelDoc> response = client.search(builder -> builder
                    .index("hotel") // 索引库名称
            , HotelDoc.class);
    // 2. 解析查询结果
    handleResponse(response);
}
```

## 2. 全文检索查询

### 2.1 单字段全文检索查询

```java
@Test
public void match() throws IOException {
    String searchText = "如家商旅"; // 要搜索的内容
    // 1. 发起请求：单字段全文检索查询
    SearchResponse<HotelDoc> response = client.search(builder -> builder
                    .index("hotel") // 索引库名称
                    .query(q -> q.match(e -> e   // match查询
                            .field("hotelName") // 查询字段
                            .query(searchText))) // 要搜索的内容
            , HotelDoc.class);
    // 2. 解析查询结果
    handleResponse(response);
}
```

### 2.2 多字段全文检索查询

```java
@Test
public void multiMatch() throws IOException {
    String searchText = "外滩如家"; // 要搜索的内容
    // 1. 发起请求：多字段全文检索查询
    SearchResponse<HotelDoc> response = client.search(builder -> builder
                    .index("hotel")
                    .query(q -> q.multiMatch(e -> e   // multi-match查询
                            .fields("hotelBrand", "hotelName", "hotelCity")
                            .query(searchText)))
            , HotelDoc.class);
    // 2. 解析查询结果
    handleResponse(response);
}
```

## 3. 精确查询

### 3.1 term查询

```java
@Test
public void term() throws IOException {
    String searchText = "上海"; // 要搜索的内容
    // 1. 发起请求：term查询
    SearchResponse<HotelDoc> response = client.search(builder -> builder
                    .index("hotel")
                    .query(q -> q.term(e -> e   // term查询
                            .field("hotelCity") // 查询字段
                            .value(searchText))) // 要搜索的内容
            , HotelDoc.class);
    // 2. 解析查询结果
    handleResponse(response);
}
```

### 3.2 range查询

```java
@Test
public void range() throws IOException {
    // 1. 发起请求：range查询
    SearchResponse<HotelDoc> response = client.search(builder -> builder
                    .index("hotel")
                    .query(q -> q.range(e -> e   // range查询
                            .field("hotelPrice") // 查询字段
                            .gt(JsonData.of(1000))
                            .lte(JsonData.of(2000))))
            , HotelDoc.class);
    // 2. 解析查询结果
    handleResponse(response);
}
```

## 4. 布尔查询

```java
@Test
public void bool() throws IOException {
    // 查找名称包含"如家"，且价格不超过400的酒店
    String searchText = "如家";
    Double maxPrice = 400.0;

    // 1. 子查询1
    Query byHotelName = MatchQuery.of(builder -> builder
            .field("hotelName")
            .query(searchText)
    )._toQuery();
    // 2. 子查询2
    Query byHotelPrice = RangeQuery.of(builder -> builder
            .field("hotelPrice")
            .gt(JsonData.of(maxPrice))
    )._toQuery();

    // 3. 发起请求：布尔查询
    SearchResponse<HotelDoc> response = client.search(builder -> builder
                    .index("hotel")
                    .query(q -> q.bool(e -> e   // bool查询
                            .must(byHotelName)
                            .mustNot(byHotelPrice)))
            , HotelDoc.class);
    // 4. 解析查询结果
    handleResponse(response);
}
```

## 5. 搜索结果处理-排序

```java
@Test
public void sort() throws IOException {
    // 1. 搜索品牌为"如家"的酒店，并按评分降序、相同则按价格升序
    SearchResponse<HotelDoc> response = client.search(builder -> builder
                    .index("hotel")
                    .query(q -> q.term(e -> e
                            .field("hotelBrand")
                            .value("如家")))
                    .sort(s -> s.field(e -> e
                                    .field("hotelScore")
                                    .order(SortOrder.Desc)))
                    .sort(s -> s.field(e -> e
                            .field("hotelPrice")
                            .order(SortOrder.Asc)))
            , HotelDoc.class);
    // 2. 解析查询结果
    handleResponse(response);
}
```

## 6. 搜索结果处理-分页

```java
@Test
public void page() throws IOException {
    SearchResponse<HotelDoc> response = client.search(builder -> builder
                    .index("hotel")
                    .query(q -> q.term(e -> e
                            .field("hotelBrand")
                            .value("如家")))
                    .sort(s -> s.field(e -> e
                            .field("hotelScore")
                            .order(SortOrder.Desc)))
                    .from(10)
                    .size(5)
            , HotelDoc.class);
    // 解析查询结果
    handleResponse(response);
}
```

> 注意：无论`from`和`size`写在什么位置，都是先进行`sort`排序，再进行分页截取。

## 7. 搜索结果处理-高亮

注意，高亮的查询结果解析有所不同，因为高亮的结果是保存在`hits`中的`highlight`结构中的。

```java
@Test
public void highlight() throws IOException {
    SearchResponse<HotelDoc> response = client.search(builder -> builder
                    .index("hotel")
                    .query(q -> q.match(e -> e
                            .field("hotelAll")
                            .query("如家")))
                    .highlight(h -> h.fields("hotelName", e -> e
                            .preTags("<em>")
                            .postTags("</em>")
                            .requireFieldMatch(false)))
            , HotelDoc.class);
    // 解析查询结果
    handleHighlightResponse(response);
}

private void handleHighlightResponse(SearchResponse<HotelDoc> response) {
    // 解析响应
    HitsMetadata<HotelDoc> metadata = response.hits();

    // 1. 获取查询到的文档总数
    log.info("查询到的文档总数为：{}", metadata.total().value());
    // 2. 获取所有的文档
    List<Hit<HotelDoc>> list = metadata.hits();
    for (Hit<HotelDoc> hit : list) {
        // 3. 获取每个文档，并转化为对应的实体类
        HotelDoc hotelDoc = hit.source();
        // 4. 获取高亮信息
        Map<String, List<String>> highlightMap = hit.highlight();
        String newHotelName = highlightMap.get("hotelName").get(0);
        hotelDoc.setHotelName(newHotelName);

        log.info("hotelDoc = {}", hotelDoc);
    }
}
```

## 8. 其他

### 8.1 过滤字段

我们可以通过过滤字段，使得返回的响应信息中，只包含指定的字段。

```java
@Test
public void filter() throws IOException {
    SearchResponse<HotelDoc> response = client.search(builder -> builder
                    .index("hotel")
                    .query(q -> q.term(e -> e
                            .field("hotelBrand")
                            .value("如家")))
                    .source(s -> s.filter(f -> f
                            .includes("hotelName", "hotelBrand")))
            , HotelDoc.class);
    // 解析查询结果
    handleResponse(response);
}
```

### 8.2 模糊查询

```java
@Test
public void fuzzy() throws IOException {
    SearchResponse<HotelDoc> response = client.search(builder -> builder
                    .index("hotel")
                    .query(q -> q.fuzzy(e -> e   // 模糊查询
                            .field("hotelBrand") // 查询字段
                            .value("如家哈哈") // 需要模糊查询的关键词
                            // fuzziness代表可以与关键词有误差的字符数，可选值为0、1、2
                            .fuzziness("2")
                    ))
            , HotelDoc.class);
    // 解析查询结果
    handleResponse(response);
}
```

# 第06章_数据聚合

## 1. 简介

聚合（aggregations）可以让我们极其方便的实现对数据的统计、分析、运算。聚合常见有三类：

（1）**桶（Bucket）聚合**：用来对文档做分组

- `terms`：按照文档字段值分组，例如按照`酒店品牌值`分组
- `date_histogram`：按照日期阶梯分组，例如一周为一组

（2）**度量（Metric）聚合**：用以计算一些统计值

- `avg`：求平均值
- `max`：求最大值
- `min`：求最小值
- `stats`：包含count、max、min、avg、sum统计信息

（3）**管道（pipeline）聚合**：以其它聚合的结果为基础做聚合

> **注意**：参加聚合的字段必须是keyword、日期、数值、布尔类型

## 2. DSL方式Bucket聚合

### 2.1 基本语法

```json
GET /hotel/_search
{
  "size": 0, //设置size为0，结果中就不包含文档，只包含聚合结果
  "aggs": { //定义聚合
    "brandAgg": { //定义聚合名称
      "terms": { //指定聚合的类型
        "field": "hotelBrand", //参与聚合的字段
        "size": 20 //希望获取的聚合结果数量
      }
    }
  }
}
```

### 2.2 聚合结果排序

默认情况下，Bucket聚合会统计Bucket内的文档数量，记为`_count`，并且按照`_count`降序排序。我们也可以指定order属性，自定义聚合的排序方式：

```json
GET /hotel/_search
{
  "size": 0,
  "aggs": {
    "brandAgg": {
      "terms": {
        "field": "hotelBrand",
        "size": 20,
        "order": {
          "_count": "asc" //按照_count升序排序
        }
      }
    }
  }
}
```

### 2.3 限定聚合范围

默认情况下，Bucket聚合是对索引库的所有文档做聚合。但通常我们需要限定要聚合的文档范围，为此，我们只需添加query条件即可：

```json
GET /hotel/_search
{
  "query": {
    "range": {
      "hotelPrice": {
        "gte": 1000 //只对1000元及以上的文档做聚合
      }
    }
  }, 
  "size": 0,
  "aggs": {
    "brandAgg": {
      "terms": {
        "field": "hotelBrand",
        "size": 20,
        "order": {
          "_count": "asc"
        }
      }
    }
  }
}
```

## 3. DSL方式Metric聚合

### 3.1 基本语法

我们使用Bucket聚合对酒店按照品牌分组，形成了一个个桶。然后我们就可以对桶内的酒店做运算，例如获取每个品牌的用户评分的min、max、avg等值。此时就需要使用Metric聚合，比较常用的类型是`stats`，它里面包含了`count、min、max、avg、sum`统计信息。

```json
GET /hotel/_search
{
  "size": 0,
  "aggs": {
    "brandAgg": {
      "terms": {
        "field": "hotelBrand",
        "size": 20
      },
      "aggs": { //定义子聚合，即分组后对每组分别进行计算
        "scoreStats": { //定义聚合名称
          "stats": { //指定聚合的类型
            "field": "hotelScore" //参与聚合的字段
          }
        }
      }
    }
  }
}
```

### 3.2 根据子聚合结果进行排序

例如，我们按照每个桶的酒店平均分降序排序：

```json
GET /hotel/_search
{
  "size": 0,
  "aggs": {
    "brandAgg": {
      "terms": {
        "field": "hotelBrand",
        "size": 20,
        "order": {
          "scoreStats.avg": "desc" //根据scoreStats中的avg值降序排序
        }
      },
      "aggs": {
        "scoreStats": {
          "stats": {
            "field": "hotelScore"
          }
        }
      }
    }
  }
}
```

## 4. API方式聚合

### 4.1 Bucket聚合

```java
@Slf4j
@SpringBootTest
public class HotelAggregationsTests {
    @Autowired
    private ElasticsearchClient client;

    @Test
    public void bucket() throws IOException {
        // 限定聚合范围：只对1000元及以上的酒店文档做聚合
        Query query = RangeQuery.of(r -> r
                .field("hotelPrice")
                .gte(JsonData.of(1000))
        )._toQuery();

        // 发送查询请求
        SearchResponse<Void> response = client.search(builder -> builder
                        .index("hotel")
                        .query(query)
                        .size(0)
                        .aggregations("brandAgg", a -> a  // 聚合名称
                                .terms(t -> t  // 聚合类型
                                        .field("hotelBrand"))) // 参与聚合的字段
                , Void.class);

        // 解析聚合结果
        StringTermsAggregate brandAgg = response.aggregations()
                .get("brandAgg")
                .sterms(); // 注意类型
        List<StringTermsBucket> buckets = brandAgg.buckets().array();
        for (StringTermsBucket bucket : buckets) {
            log.info("key:{}, docCount:{}",
                    bucket.key()._toJsonString(), bucket.docCount());
        }
    }
}
```

### 4.2 Metric聚合

```java
@Slf4j
@SpringBootTest
public class HotelAggregationsTests {
    @Autowired
    private ElasticsearchClient client;

    @Test
    public void metric() throws IOException {
        // 发送查询请求
        SearchResponse<Void> response = client.search(builder -> builder
                        .index("hotel")
                        .size(0)
                        .aggregations("brandAgg", a -> a
                                .terms(t -> t.field("hotelBrand"))
                                .aggregations("scoreStats", e -> e  // 子聚合
                                        .stats(s -> s.field("hotelScore"))))
                , Void.class);
        
        // 解析聚合结果
        StringTermsAggregate brandAgg = response.aggregations()
                .get("brandAgg")
                .sterms(); // 注意类型
        List<StringTermsBucket> buckets = brandAgg.buckets().array();
        for (StringTermsBucket bucket : buckets) {
            // 获取每个bucket的统计值
            StatsAggregate scoreStats = bucket.aggregations()
                    .get("scoreStats")
                    .stats();
            long count = scoreStats.count();
            double max = scoreStats.max();
            double min = scoreStats.min();
            double avg = scoreStats.avg();
            double sum = scoreStats.sum();

            log.info("key:{}, docCount:{}, count:{}, max:{}, min:{}, avg:{}, sum:{}",
                    bucket.key()._toJsonString(), bucket.docCount(),
                    count, max, min, avg, sum
            );
        }
    }
}
```

# 第07章_其他功能

## 1. 自动补全

### 1.1 拼音分词器

根据用户输入的字母，提示完整词条的功能，就是自动补全。因为需要根据拼音字母来推断，所以要用到拼音分词功能。拼音分词器的安装步骤如下：

（1）下载相应版本的拼音分词器 https://github.com/medcl/elasticsearch-analysis-pinyin/releases/download/v8.6.0/elasticsearch-analysis-pinyin-8.6.0.zip

（2）然后在`/es/plugins`下创建一个名为`pinyin`的目录，并将`elasticsearch-analysis-pinyin-8.6.0.zip`上传到`pinyin`目录下并解压

```shell
mkdir -p /es/plugins/pinyin
cd /es/plugins/pinyin
yum install -y unzip zip
unzip elasticsearch-analysis-pinyin-8.6.0.zip
rm -rf elasticsearch-analysis-pinyin-8.6.0.zip
```

（3）重启es实例

```shell
chmod -R 777 /es/{data,plugins}
docker restart es
```

（4）测试：发送请求

```json
POST /_analyze
{
  "text": ["如家酒店"],
  "analyzer": "pinyin"
}
```

会发现拼音分词将其分词为：`ru`、`jia`、`jiu`、`dian`、`rjjd`

### 1.2 自定义分词器

默认的拼音分词器会将每个汉字单独分为拼音，而我们希望的是每个词条形成一组拼音，所以需要对拼音分词器做个性化定制，形成自定义分词器。

Elasticsearch中分词器（analyzer）的组成包含三部分：

- `character filters`：在tokenizer之前对文本进行处理。例如删除字符、替换字符。
- `tokenizer`：将文本按照一定的规则切割成词条（term）。例如ik_smart分词、keyword（不分词）
- `tokenizer filter`：将tokenizer输出的词条做进一步处理。例如大小写转换、同义词处理、拼音处理等。

文档分词时会依次由这三部分来处理文档，例如：

![image-20210723210427878](images/image-20210723210427878.png)

需要在创建索引库的时候声明自定义分词器（这个自定义的分词器只对当前索引库生效），语法如下：

```json
PUT /user
{
  "settings": {
    "analysis": {
      "analyzer": { //自定义分词器
        "my_analyzer": { //自定义名称
          "tokenizer": "ik_max_word",
          "filter": "my_pinyin"
        }
      },
      "filter": { //自定义tokenizer filter
        "my_pinyin": { //自定义名称
          "type": "pinyin",
          "keep_full_pinyin": false,
          "keep_joined_full_pinyin": true,
          "keep_original": true,
          "limit_first_letter_length": 16,
          "remove_duplicated_term": true,
          "none_chinese_pinyin_tokenize": false
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "info": {
        "type": "text",
        "analyzer": "my_analyzer",
        "search_analyzer": "ik_smart"
      }
    }
  }
}
```

**注意**：上述mapping中我们定义的info字段，在建倒排索引时使用`my_analyzer`分词器，而对于搜索文本只使用`ik_smart`分词、并不使用拼音分词。原因是为了避免用户搜索到同音字，例如用户搜索`狮子`，如果对搜索内容进行拼音分词，可能会搜出有关`虱子`的文档。**总结：对于搜索文本，不要使用拼音分词器**。

测试：

```json
POST /user/_analyze
{
  "text": ["如家酒店"],
  "analyzer": "my_analyzer"
}
```

### 1.3 自动补全查询

Elasticsearch提供了Completion Suggester查询来实现自动补全功能，这个查询会匹配以用户输入内容开头的词条并返回。为了提高补全查询的效率，对于文档中字段的类型有一些约束：

- 参与补全查询的字段必须是completion类型
- 字段的内容一般是用来补全的多个词条形成的数组

例如，创建以下索引库：

```json
PUT /news
{
  "mappings": {
    "properties": {
      "news_title": {
        "type": "completion"
      }
    }
  }
}
```

然后插入以下文档：

```json
POST /news/_doc
{
  "news_title": ["Sony", "WH-1000XM3"]
}

POST /news/_doc
{
  "news_title": ["SK-II", "PITERA"]
}

POST /news/_doc
{
  "news_title": ["Nintendo", "switch"]
}
```

自动补全的查询测试：

```json
GET /news/_search
{
  "suggest": {
    "my_title_search": { //自定义查询名称
      "text": "s", //查询文本
      "completion": {
        "field": "news_title", //查询的字段
        "skip_duplicates": true, //跳过重复的
        "size": 10 //获取前10条结果
      }
    }
  }
}
```

如上，当查询文本是`s`时，会返回以s开头的三条信息`Sony`、`SK-II`、`switch`；如果我们将查询文本改为`so`，则只返回`Sony`。这就是自动补全。

### 1.4 案例演示

#### 1、创建索引库并设置自定义拼音分词器

注意：需要添加一个completion类型的字段，用于自动补全。

```json
PUT /foods
{
  "settings": {
    "analysis": {
      "analyzer": {
        "text_analyzer": {
          "tokenizer": "ik_max_word",
          "filter": "my_pinyin"
        },
        "completion_analyzer": {
          "tokenizer": "keyword",
          "filter": "my_pinyin"
        }
      },
      "filter": {
        "my_pinyin": {
          "type": "pinyin",
          "keep_full_pinyin": false,
          "keep_joined_full_pinyin": true,
          "keep_original": true,
          "limit_first_letter_length": 16,
          "remove_duplicated_term": true,
          "none_chinese_pinyin_tokenize": false
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "foodId": {
        "type": "keyword"
      },
      "foodName": {
        "type": "text",
        "analyzer": "text_analyzer",
        "search_analyzer": "ik_smart"
      },
      "foodCity": {
        "type": "keyword"
      },
      "foodSuggestion": {
        "type": "completion",
        "analyzer": "completion_analyzer"
      }
    }
  }
}
```

#### 2、实体类

注意：我们需要在实体类中添加一个`foodSuggestion`字段用于自动补全，类型为`List<String>`，然后将`foodName`、`foodCity`等需要自己补全的信息放到里面。

```java
@Data
@NoArgsConstructor
public class Food implements Serializable {
    private Long foodId;
    private String foodName;
    private String foodCity;
    private List<String> foodSuggestion;
    public Food(Long foodId, String foodName, String foodCity) {
        this.foodId = foodId;
        this.foodName = foodName;
        this.foodCity = foodCity;
        this.foodSuggestion = Arrays.asList(foodName, foodCity);
    }
}
```

#### 3、批量导入数据

```java
@SpringBootTest
@Slf4j
public class FoodsTests {
    @Autowired
    private ElasticsearchClient client;

    @Test
    public void addFoods() throws IOException {
        // 准备数据
        List<Food> list = new ArrayList<>();
        list.add(new Food(1L, "烤冷面", "吉林"));
        list.add(new Food(2L, "章鱼小丸子", "上海"));
        list.add(new Food(3L, "红烧肉", "上海"));
        list.add(new Food(4L, "过桥米线", "上海"));
        list.add(new Food(5L, "烤鸭", "北京"));
        list.add(new Food(6L, "螺蛳粉", "广西"));
        list.add(new Food(7L, "白切鸡", "广东"));
        list.add(new Food(8L, "回锅肉", "四川"));
        list.add(new Food(9L, "驴肉火烧", "河北"));

        BulkRequest.Builder br = new BulkRequest.Builder();
        for (Food food : list) {
            br.operations(op -> op.index(builder -> builder
                    .index("foods")
                    .id(food.getFoodId().toString())
                    .document(food)
            ));
        }
        BulkResponse response = client.bulk(br.build());
        log.info("是否发生错误? {}", response.errors());
    }
}
```

#### 4、自动补全查询

```java
@SpringBootTest
@Slf4j
public class FoodsTests {
    @Autowired
    private ElasticsearchClient client;

    @Test
    public void completionQuery() throws IOException {
        String searchText = "h"; // 查询文本
        // 发起自动补全查询的请求
        SearchResponse<Void> response = client.search(builder -> builder
                        .index("foods")
                        .suggest(s -> s.suggesters("food_search", f -> f
                                .text(searchText)
                                .completion(c -> c
                                        .field("foodSuggestion")
                                        .skipDuplicates(Boolean.TRUE)
                                        .size(10))))
                , Void.class);
        // 解析响应信息
        List<CompletionSuggestOption<Void>> list = response
                .suggest()
                .get("food_search")
                .get(0)
                .completion()
                .options(); // 得到所有补全查询的信息
        for (CompletionSuggestOption<Void> s : list) {
            String text = s.text(); // 获取补全查询的文本内容
            log.info(text);
        }
    }
}
```

## 2. ES与MySQL的数据同步

Elasticsearch中的数据来自于MySQL数据库，因此MySQL数据发生改变时，Elasticsearch也必须跟着改变，这就是**数据同步**。常见的数据同步方案有以下三种：

### 2.1 同步调用

同步调用：微服务A写入MySQL后，再远程调用微服务B来更新Elasticsearch。

- 优点：实现简单
- 缺点：业务耦合度高

### 2.2 异步通知

异步通知：微服务A写入MySQL后，发送消息给MQ；微服务B一直监听MQ，收到消息后更新Elasticsearch。

- 优点：低耦合
- 缺点：依赖MQ的可靠性

### 2.3 监听binlog

监听binlog：MySQL开启binlog功能后，完成增删改操作都会记录在binlog中，使用中间件canal可以监听binlog的变化，实时更新Elasticsearch。

- 优点：完全解耦合
- 确定：开启binlog会增加MySQL负担，实现复杂度高


# 第08章_ES集群

## 1. 简介

单机的Elasticsearch做数据存储，必然面临两个问题：海量数据存储问题、单点故障问题。

- 对于海量数据存储问题，我们可以将索引库从逻辑上拆分为N个分片，存储到多个节点
- 对于单点故障问题，我们可以将分片数据在不同节点进行备份

例如，集群中有三个节点：

- node1：保存分片1，以及分片2的副本
- node2：保存分片2，以及分片3的副本
- node3：保存分片3，以及分片1的副本

## 2. 集群的搭建

为了简便，我们在一台虚拟机上利用docker搭建三个ES节点构成集群(注意虚拟机至少要有4G内存)：

### 2.1 创建挂载点目录

```shell
mkdir -p /es-cluster/es01/data
mkdir -p /es-cluster/es01/plugins
mkdir -p /es-cluster/es02/data
mkdir -p /es-cluster/es02/plugins
mkdir -p /es-cluster/es03/data
mkdir -p /es-cluster/es03/plugins
chmod 777 /es-cluster/es01/{data,plugins}
chmod 777 /es-cluster/es02/{data,plugins}
chmod 777 /es-cluster/es03/{data,plugins}
```

### 2.2 编写docker-compose.yml

```sh
vi /es-cluster/docker-compose.yml
```

编写以下内容：

```yml
version: '1.0'
services:
  es01:
    image: elasticsearch:8.6.0
    container_name: es01
    ports:
      - 9201:9200
      - 9301:9300
    environment:
      node.name: es01
      cluster.name: es-docker-cluster
      discovery.seed_hosts: es01,es02,es03
      cluster.initial_master_nodes: es01,es02,es03
      ES_JAVA_OPTS: -Xms512m -Xmx512m
      xpack.security.enabled: false 
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - /es-cluster/es01/data:/usr/share/elasticsearch/data
      - /es-cluster/es01/plugins:/usr/share/elasticsearch/plugins
    networks:
      - elastic-net

  es02:
    image: elasticsearch:8.6.0
    container_name: es02
    ports:
      - 9202:9200
      - 9302:9300
    environment:
      node.name: es02
      cluster.name: es-docker-cluster
      discovery.seed_hosts: es01,es02,es03
      cluster.initial_master_nodes: es01,es02,es03
      ES_JAVA_OPTS: -Xms512m -Xmx512m
      xpack.security.enabled: false
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - /es-cluster/es02/data:/usr/share/elasticsearch/data
      - /es-cluster/es02/plugins:/usr/share/elasticsearch/plugins
    networks:
      - elastic-net

  es03: 
    image: elasticsearch:8.6.0
    container_name: es03
    ports:
      - 9203:9200
      - 9303:9300
    environment:
      node.name: es03
      cluster.name: es-docker-cluster
      discovery.seed_hosts: es01,es02,es03
      cluster.initial_master_nodes: es01,es02,es03
      ES_JAVA_OPTS: -Xms512m -Xmx512m
      xpack.security.enabled: false
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - /es-cluster/es03/data:/usr/share/elasticsearch/data
      - /es-cluster/es03/plugins:/usr/share/elasticsearch/plugins
    networks:
      - elastic-net

networks:
  elastic-net:
    driver: bridge
```

### 2.3 启动集群

启动es集群需要修改一些linux系统权限，`vi /etc/sysctl.conf`，添加下面的内容：

```sh
vm.max_map_count=262144
```

然后执行命令，让配置生效：

```sh
sysctl -p
```

启动集群：

```sh
cd /es-cluster
docker compose -f docker-compose.yml up -d
```

停止容器实例：

```shell
cd /es-cluster
docker compose -f docker-compose.yml stop
```

### 2.4 测试

- 访问`http://192.168.231.124:9201`成功
- 访问`http://192.168.231.124:9202`成功
- 访问`http://192.168.231.124:9203`成功

创建索引库测试：使用Postman发送`PUT`请求给`http://192.168.231.124:9201/my_test`，json内容为

```json
{
  "settings": {
    "number_of_shards": 3, //分片数量
    "number_of_replicas": 1 //每个分片的副本数量
  },
  "mappings": {
    "properties": {
      "id": {
        "type": "keyword"
      },
      "name": {
        "type": "keyword"
      }
    }
  }
}
```

插入数据：使用Postman发送`POST`请求给`http://192.168.231.124:9201/my_test/_doc/123`，json内容为

```json
{
  "id": "123",
  "name": "thu"
}
```

查询数据：浏览器分别访问以下url，都能正确查询到数据，说明集群功能正常：

- `http://192.168.231.124:9201/my_test/_doc/123`
- `http://192.168.231.124:9202/my_test/_doc/123`
- `http://192.168.231.124:9203/my_test/_doc/123`

## 3. ES集群深入理解

### 3.1 节点的职责

Elasticsearch集群中的节点有不同的职责划分：

![image-20210723223008967](images/image-20210723223008967.png)

默认情况下，集群中的任何一个节点都同时具备上述四种角色。但是生产上，集群一定要将职责分离：

- master节点：对CPU要求高，但是内存要求低
- data节点：对CPU和内存要求都高
- coordinating节点：对网络带宽、CPU要求高

职责分离可以让我们根据不同节点的需求分配不同的硬件去部署，而且避免业务之间的互相干扰。一个典型的ES集群职责划分如下：

![image-20210723223629142](images/image-20210723223629142.png)

### 3.2 脑裂问题

脑裂是因为集群中的节点失联导致的，例如

1. 集群中主节点node1因网络原因去其他节点失联
2. 此时node2和node3就会认为node1已经宕机，从而进行选主
3. 假设node3当选主节点，此时集群继续对外提供服务，即node2和node3自成集群，node1自成集群，两个集群数据不同步
4. 当网络恢复后，因为集群中有两个master节点，集群状态不一致，出现脑裂问题

解决脑裂的方案是：要求选票超过`(eligible节点数量+1)/2`才能当选为主，因此eligible节点数量最好是奇数。不过在ES7及之后，这已经成为默认配置，所以不会发生脑裂问题。

### 3.3 集群分片存储原理

Elasticsearch会通过hash算法来计算文档应该存储到哪个分片：

```
shard = hash(_routing) % number_of_shards
```

- `_routing`默认是文档的id
- 该算法与分片数量有关，因此索引库一旦创建，分片数量不能修改

新增文档的流程如下：

1. 新增一个id=1的文档
2. 对id做hash运算并取余，假如得到的是0，则应该存储到`shard-0`
3. `shard-0`的主分片在node1节点，将数据路由到node1
4. 保存文档
5. 同步给`shard-0`的副本`replica-2`，该副本在另一个节点上
6. 返回结果给coordinating-node节点

### 3.4 集群查询原理

Elasticsearch的查询分成两个阶段：

1. `scatter phase`：分散阶段，coordinating node会把请求分发到每一个分片
2. `gather phase`：聚集阶段，coordinating node汇总data node的搜索结果，并处理为最终结果集返回给用户

### 3.5 集群的故障转移

集群的master节点会监控集群中的节点状态，如果发现有节点宕机，会立即将宕机节点的分片数据迁移到其它节点，确保数据安全，这就是故障转移。

