# 1. MyBatis-Plus简介

## 1.1 简介

MyBatis-Plus（简称 MP）是一个MyBatis的增强工具，在 MyBatis 的基础上只做增强不做改变，为简化开发、提高效率而生。

特点：
- 自动生成单表的CRUD功能
- 提供丰富的条件拼接方式
- 全自动ORM类型持久层框架

## 1.2 快速入门

**（1）创建boot工程**

**（2）导入MyBatis-Plus的场景启动器，代替MyBatis的场景启动器**

```xml
<dependency>
    <groupId>com.baomidou</groupId>
    <artifactId>mybatis-plus-boot-starter</artifactId>
    <version>3.5.3.1</version>
</dependency>
```

**（3）配置文件**

```properties
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.type=com.zaxxer.hikari.HikariDataSource
spring.datasource.url=jdbc:mysql://localhost:3306/ssm
spring.datasource.username=root
spring.datasource.password=abc666
```

**（4）主启动类上配置Mapper接口的扫描**

```java
@MapperScan("com.thuwsy.boot.mapper")
@SpringBootApplication
public class Boot305MpApplication {
    public static void main(String[] args) {
        SpringApplication.run(Boot305MpApplication.class, args);
    }
}
```

**（5）实体类和数据库表**

对数据库表User创建对应的实体类User：

```java
@Data
public class User {
    private Long id;
    private String name;
    private Integer age;
    private String email;
}
```

**（6）编写Mapper接口继承BaseMapper**

```java
public interface UserMapper extends BaseMapper<User> {
}
```

> MyBatis-Plus提供的BaseMapper接口，自带CRUD方法

**（7）测试**

```java
@SpringBootTest
class Boot305MpApplicationTests {
    @Autowired
    private UserMapper userMapper;

    @Test
    void contextLoads() {
        List<User> users = userMapper.selectList(null);
        users.forEach(System.out::println);
    }
}
```

