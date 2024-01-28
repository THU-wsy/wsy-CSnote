# 1. Spring Security简介

## 1.1 简介

Spring Security是一个基于Spring开发的权限验证框架，其核心功能包括：

- **认证(Authentication)**：检查用户是否登录
- **授权(Authorization)**：用户的权限管理
- **攻击防护**：防护CSRF、SFA、XSS、CORS、SQL注入等

## 1.2 权限模型

权限模型主要有以下两类：

### 1、RBAC(Role Based Access Controll)

RBAC中有用户、角色、权限，以及它们之间关联的中间表：

（1）用户表（t_user）

|id|username|password|
|--|--------|--------|
|1 |zhangsan|123456  |
|2 |lisi    |123456  |

（2）角色表（t_role）

|id|role_name|
|--|---------|
|1 |admin    |
|2 |hr       |
|3 |common   |

（3）权限表（t_permission）

|id|perm        |
|--|------------|
|1 |file_r      |
|2 |file_w      |
|3 |file_x      |
|4 |order_query |
|5 |order_create|

（4）用户_角色表（t_user_role）

|id|username|role_name|
|--|--------|---------|
|1 |zhangsan|admin    |
|2 |zhangsan|common   |
|3 |lisi    |hr       |
|4 |lisi    |common   |

（5）角色_权限表（t_role_perm）

|id|role_name|perm        |
|--|---------|------------|
|1 |admin    |file_r      |
|2 |admin    |file_w      |
|3 |admin    |file_x      |
|4 |admin    |order_query |
|5 |admin    |order_create|
|6 |hr       |file_r      |

### 2、ACL(Access Controll List)

ACL中用户直接和权限挂钩，没有角色表：

（1）用户表（t_user）

|id|username|password|
|--|--------|--------|
|1 |zhangsan|123456  |
|2 |lisi    |123456  |

（2）权限表（t_permission）

|id|perm        |
|--|------------|
|1 |file_r      |
|2 |file_w      |
|3 |file_x      |
|4 |order_query |
|5 |order_create|

（3）用户_权限表（t_user_perm）

|id|username |perm        |
|--|---------|------------|
|1 |zhangsan |file_r      |
|2 |zhangsan |file_w      |
|3 |zhangsan |file_x      |
|4 |zhangsan |order_query |
|5 |zhangsan |order_create|
|6 |lisi     |file_r      |

## 1.3 常见的网络攻击

### 1、CSRF跨站请求伪造攻击

CSRF（Cross-site request forgery）：例如我们在某银行官网登录后进行转账，然后浏览器就会获得登录的Cookie信息，此时如果我们访问某个钓鱼网站并点击它的一个表单提交按钮（该表单底层实际上是会执行转账给一个黑客用户），由于携带了登录的Cookie信息，我们的银行账户余额就会被扣减。这就是CSRF攻击。

对于CSRF攻击，Spring Security就可以解决。当然，现在的浏览器安全性也很好，具有SameSite保护机制，即当用户在两个不同域名的站点操作时，默认情况下Cookie就会被自动屏蔽，所以也能防止CSRF攻击。

### 2、SFA会话固定攻击

SFA（Session fixation attack）：例如黑客在某银行官网登录后会获得一个JSESSIONID，而黑客的钓鱼网站中会编写一个js脚本，自动将访问的用户的JSESSIONID替换成黑客刚才获得的JSESSIONID。于是，当用户访问钓鱼网站后，再访问银行官网进行登录，此时，黑客刷新银行官网就能直接登录了（登录的是用户的银行账号，因为JSESSIONID相同），然后就能随意操作用户的银行账号。这就是SFA攻击。

对于SFA攻击，Spring Security同样可以解决。当然，现在的浏览器也有相应的保护机制，例如Tomcat发送的JSESSIONID默认是勾选了HttpOnly选项的，即一旦被设定，就无法被随意修改，所以黑客的js脚本就不起作用了，当然前提是用户先得正常访问一次银行官网获取JSESSIONID才行，如果直接先访问钓鱼网站，仍然存在安全隐患。

### 3、XSS跨站脚本攻击

XSS（Cross-site scripting）：指的是攻击者通过在合法网站中注入恶意脚本代码来攻击用户。例如，很多网站的发贴功能，实际上传的是用户评论内容对应的html格式文本，此时，黑客就可以在标签中执行一些恶意的js脚本来获取用户的各种信息。


# 2. Spring Security原理

## 2.1 过滤器链架构

Spring Security底层利用FilterChainProxy封装一系列过滤器链，实现各种安全拦截功能。

![](images/Snipaste20231009183311.png)

**FilterChainProxy**

![](images/Snipaste20231009183341.png)

**SecurityFilterChain**

![](images/Snipaste20231009183413.png)

**总结**：实际上，Spring Security只注册了一个Filter，也就是FilterChainProxy，而这个Filter内部，有一系列Spring Security自己实现的SecurityFilter，构成了过滤器链，来实现各种安全校验拦截。

## 2.2 SecurityContext

SecurityContext中保存了用户的认证信息，它实际上是依靠Session来存储的。

当一个请求到来时，会从Session中取出SecurityContext来读取认证信息；当请求结束时，会将SecurityContext保存到Session中。

因此，默认情况下，Spring Security的认证是基于Session的，一旦会话过期，认证信息也就消失了。

## 2.3 SpringBoot整合的自动配置原理

Security场景的自动配置类有两个：

- SecurityFilterAutoConfiguration，它的主要作用是给容器中放了DelegatingFilterProxyRegistrationBean组件
- SecurityAutoConfiguration，它开启了SecurityProperties属性绑定，绑定以`spring.security`为前缀的配置项。除此之外，它还导入了**SpringBootWebSecurityConfiguration**配置类。

SpringBootWebSecurityConfiguration有以下两个核心作用：

### 1、给容器中放了默认的SecurityFilterChain组件

源码如下：

```java
@Bean
@Order(2147483642)
SecurityFilterChain defaultSecurityFilterChain(HttpSecurity http) throws Exception {
    ((AuthorizeHttpRequestsConfigurer.AuthorizedUrl)http.authorizeHttpRequests().anyRequest()).authenticated();
    http.formLogin();
    http.httpBasic();
    return (SecurityFilterChain)http.build();
}
```

提供了三个功能：

- 使得所有请求都需要登录认证
- 开启默认表单登录：即提供了一个默认登录页面，未经登录的所有请求都跳转到该页面
- 开启httpbasic方式的登录

> **注意**：这个默认的登录页面，以及使所有请求都要登录认证的特点，往往都不符合我们的业务需求。所以我们通常都会在配置类中自己配置一个SecurityFilterChain

### 2、使@EnableWebSecurity注解生效

该注解生效后，就会产生以下作用：

- 导入了WebSecurityConfiguration：web安全配置类
- 导入了HttpSecurityConfiguration：http安全配置类
- 开启了@EnableGlobalAuthentication：全局认证生效(该注解导入了AuthenticationConfiguration)


# 3. Spring Security案例实战

## 3.1 案例搭建

（1）创建SpringBoot模块

```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>3.0.2</version>
</parent>
```

（2）添加依赖

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-thymeleaf</artifactId>
</dependency>
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <optional>true</optional>
</dependency>
<dependency>
    <groupId>org.mybatis.spring.boot</groupId>
    <artifactId>mybatis-spring-boot-starter</artifactId>
    <version>3.0.2</version>
</dependency>
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <scope>runtime</scope>
</dependency>
```

（3）主启动类

```java
@MapperScan("com.thuwsy.security.mapper")
@SpringBootApplication
public class SecurityDemoApplication {
    public static void main(String[] args) {
        SpringApplication.run(SecurityDemoApplication.class, args);
    }
}
```

（4）前端页面

静态资源123.png，放在static目录下；

首页index.html，放在templates目录下：

```html
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>index</title>
</head>
<body>
Welcome!<br>
<a th:href="@{/read}">read</a><br>
<a th:href="@{/write}">write</a><br>
<a th:href="@{/execute}">execute</a><br>
<a th:href="@{/regist}">注册</a><br>
<a th:href="@{/login}">登录</a><br>
<form th:action="@{/doLogout}" method="post">
    <div><button type="submit">退出登录</button></div>
</form>
<br><img th:src="@{/123.png}"><br>
</body>
</html>
```

登录页login.html，放在templates目录下：

```html
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <title>login</title>
</head>
<body>
<form th:action="@{/doLogin}" method="post">
    <div>
        <label> username: <input type="text" name="username" /> </label>
    </div>
    <div>
        <label> password: <input type="password" name="password" /> </label>
    </div>
    <div><button type="submit">登录</button></div>
</form>
</body>
</html>
```

注册页regist.html，放在templates目录下：

```html
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <title>regist</title>
</head>
<body>
<form th:action="@{/doRegist}" method="post">
    <div>
        <label> username: <input type="text" name="username" /> </label>
    </div>
    <div>
        <label> password: <input type="password" name="password" /> </label>
    </div>
    <div>
        <label> role: <input type="text" name="role" /> </label>
    </div>
    <div><button type="submit">注册</button></div>
</form>
</body>
</html>
```

（5）数据库用户表及对应的实体类

```sql
CREATE DATABASE security_demo;
USE security_demo;
CREATE TABLE `account` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) UNIQUE NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `role` VARCHAR(50) NOT NULL DEFAULT 'common',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;
```

```java
@Data
public class Account implements Serializable {
    private Integer id;
    private String username;
    private String password;
    private String role;
}
```

（6）配置文件

```properties
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.type=com.zaxxer.hikari.HikariDataSource
spring.datasource.url=jdbc:mysql://localhost:3306/security_demo
spring.datasource.username=root
spring.datasource.password=abc666
```

（7）mapper层

```java
public interface AccountMapper {
    @Insert("insert into account values (null, #{username}, #{password}, #{role})")
    void insert(Account account);

    @Select("select * from account where username = #{username}")
    Account selectByName(@Param("username") String username);
}
```

（8）controller层

```java
@Controller
public class AccountController {
    @Autowired
    private AccountMapper accountMapper;

    @GetMapping("/")
    public String index() { return "index"; }

    @GetMapping("/regist")
    public String regist() { return "regist"; }

    @GetMapping("/login")
    public String login() { return "login"; }

    @GetMapping("/read")
    @ResponseBody
    public String read() { return "i am reading"; }

    @GetMapping("/write")
    @ResponseBody
    public String write() { return "i am writing"; }

    @GetMapping("/execute")
    @ResponseBody
    public String execute() { return "i am executing"; }
}
```

## 3.2 添加依赖

```xml
<!-- spring-security -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

## 3.3 配置类(核心)

```java
@EnableMethodSecurity // 开启方法级别的精确权限控制
@Configuration
public class SecurityConfig {
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        // 1. 设置需要认证的url
        http.authorizeHttpRequests(registry -> {
            registry.requestMatchers("/").permitAll() // 访问首页无需认证
                    .requestMatchers("/regist").permitAll() // 访问注册页无需认证
                    .requestMatchers("/doRegist").permitAll()
                    .requestMatchers("/*.png").permitAll() // 访问静态资源无需认证
                    .anyRequest().authenticated(); // 其余请求都需要认证(登录)
        });

        // 2. 表单登录相关配置
        // http.formLogin(); // 开启默认的表单登录(SpringSecurity提供默认的登录页)
        http.formLogin(conf -> {
            conf.loginPage("/login") // 将登录页设置为我们自己的登录页面
                    .loginProcessingUrl("/doLogin") // 登录表单提交的url
                    .defaultSuccessUrl("/") // 登录成功后跳转的页面
                    .usernameParameter("username") // 用户名的表单字段名称
                    .passwordParameter("password") // 密码的表单字段名称
                    .permitAll(); // 登录页允许所有人访问
        });

        // 3. 退出登录相关配置
        http.logout(conf -> {
            conf.logoutUrl("/doLogout") // 匹配到该url，则进行退出登录
                    .logoutSuccessUrl("/login") // 退出成功后跳转的地址，这里设置为登录界面
                    .permitAll();
        });

        return http.build();
    }

    @Bean // 密码加密器（对密码进行加密，提高安全性）
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
```

除此之外，我们还需要配置一个UserDetailsService，实现其`loadUserByUsername()`方法，表示在验证的时候通过自定义的方式，根据给定的用户名查询用户，并封装为UserDetails对象返回，然后由Spring Security将我们返回的对象与用户登录的信息对比进行核验：

```java
@Service
public class AuthorizeService implements UserDetailsService {
    @Autowired
    private AccountMapper accountMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Account account = accountMapper.selectByName(username);
        if (account == null)
            throw new UsernameNotFoundException("用户名或密码错误");
        return User.withUsername(username) // 用户名
                .password(account.getPassword()) // 密码
                .roles(account.getRole()) // 角色
                // .authorities("file_read") // 权限
                .build();
    }
}
```

> **说明**：如果我们没有注册组件UserDetailsService，即没有配置合法的用户信息，则默认的登录账号为user，登录密码会打印在控制台。


我们完善controller层，将注册的用户添加到数据库：

```java
@Autowired
private PasswordEncoder passwordEncoder;

@PostMapping("/doRegist")
public String doRegist(Account account) {
    // 对密码进行加密
    String encoded = passwordEncoder.encode(account.getPassword());
    account.setPassword(encoded);
    accountMapper.insert(account);
    return "redirect:/";
}
```

## 3.4 授权功能

SpringSecurity为我们提供了两种授权方式：

- 基于角色的授权：根据用户属于哪个角色来决定是否可以访问某个路径。
- 基于权限的授权：只要拥有某权限的用户，就可以访问某个路径。

> 两者只是概念上的不同，实际上使用起来效果差不多。

例如，我们希望角色为`common`的用户只能访问read，角色为`manager`的用户能访问read和write，角色为`boss`的用户则都可以访问。我们可以在controller的方法上用注解进行配置：

```java
@GetMapping("/read")
@ResponseBody
public String read() { return "i am reading"; }

@PreAuthorize("hasAnyRole('manager', 'boss')")
@GetMapping("/write")
@ResponseBody
public String write() { return "i am writing"; }

@PreAuthorize("hasRole('boss')")
@GetMapping("/execute")
@ResponseBody
public String execute() { return "i am executing"; }
```

- 注意，要使用该注解，必须在配置类上标注`@EnableMethodSecurity`
- `@PreAuthorize`是在该方法执行之前就进行权限判断，还有一个注解`@PostAuthorize`是在该方法执行之后再进行权限判断
- 除了controller以外，只要是由Spring管理的Bean都可以使用该注解来控制权限，例如service层同样也可以
- 如果采用基于权限的授权，则注解中内容的写法为`@PreAuthorize("hasAuthority('file_write')")`


## 3.5 测试

启动程序后，访问`http://localhost:8080`，然后点击注册按钮进行注册，先注册三个用户便于测试，密码均为`123456`，用户名和角色如下：

- 用户名`zhangsan`，角色`common`
- 用户名`lisi`，角色`manager`
- 用户名`wangwu`，角色`boss`

此时点击`read`，会跳转到登录页面：

- 输入错误的用户名密码，则登录失败
- 输入正确的用户名密码，则登录成功

登录成功后，可以根据所属的不同角色，尝试访问`read`、`write`、`execute`


## 3.6 补充知识

### 1、基于内存的用户认证

有时候做测试时，我们为了简便，可以直接在内存中配置合法的用户，进行认证。这样就无需再创建一个类来实现UserDetailsService接口，只需在Spring Security的配置类中，配置一个UserDetailsService的Bean即可，如下所示：

```java
@Bean // 直接在内存中配置合法用户
public UserDetailsService userDetailsService(PasswordEncoder passwordEncoder) {
    // 每一个UserDetails就代表一个用户信息，其中包含用户名、密码、角色、权限等
    UserDetails user1 = User.withUsername("zhangsan")
            .password(passwordEncoder.encode("123456"))
            .roles("common")
            .authorities("file_read")
            .build();
    UserDetails user2 = User.withUsername("superman")
            .password(passwordEncoder.encode("123456"))
            .roles("common", "manager", "boss")
            .authorities("file_read", "file_write", "file_execute")
            .build();
    // 创建一个基于内存的用户信息管理器作为UserDetailsService
    InMemoryUserDetailsManager manager = new InMemoryUserDetailsManager(user1, user2);
    return manager;
}
```

### 2、记住密码功能

登录后，如果关闭浏览器，则再次打开后仍需要重新登录。SpringSecurity为我们提供了一种优秀的实现，通过配置，可以为每个已经登陆的浏览器分配一个携带Token的Cookie，并且此Cookie默认会被保留14天，只要我们不清理浏览器的Cookie，那么下次携带此Cookie访问服务器将无需登陆，直接继续使用之前登陆的身份。

只需在配置类中注册SecurityFilterChain的Bean时额外添加以下配置即可：

```java
@Bean
public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    
    ...
    // 记住密码功能
    http.rememberMe(conf -> {
        conf.alwaysRemember(false) // 不要开启始终记住，需要配置为由用户自行勾选
                .rememberMeParameter("remember-me"); // 记住密码的表单字段
    });
    
    return http.build();
}
```

同时，在登录页面login.html添加`记住密码`的功能：

```html
<div>
    <label>
        <input type="checkbox" name="remember-me">
        <span>记住密码</span>
    </label>
</div>
```

# 4. JWT

## 4.1 两种校验方式

### 1、基于Session的校验

基于Session的校验是一种`有状态`服务。在之前，我们使用SpringSecurity提供的默认登录流程来完成的认证，就是基于Session的。SpringSecurity在用户登录之后，默认就会利用Session机制记录用户的登录状态，而我们每次请求，都会携带一个Cookie，其中存储了用于识别身份的JSESSIONID数据。

基于Session校验的**优点**有：

1. 可以即时撤销认证信息：由于Session在服务端管理，所以可以通过服务端手动删除的方法让其立即失效，能保证安全性

基于Session校验的**缺点**有：

1. 维护状态会增加服务器负担：因为服务端需要保存Session来维护会话信息，所以增加了服务器的负担
2. 无法分布式共享：在分布式系统中，多个微服务的服务器之间无法共享同一个用户的Session信息。如果选择在所有服务器都保存该Session信息，无疑大大加重了服务器负担，且Session的同步也有很大开销；通常我们会选择将Session只保存一份到Redis中，实现分布式Session，然而每次用户信息的校验都需要查询一次Redis，也有不小的开销。

### 2、基于Token的校验

基于Token的校验是一种`无状态`服务。无状态服务是指在处理每个请求时，服务器本身不会维持任何与请求相关的状态信息。也就是说，用户在发起请求时，服务器不会记录该用户信息，而是通过用户携带的Token（令牌）来判断是哪一个用户。

简而言之，有状态和无状态服务的流程分别如下：

- 有状态：用户请求接口 -> 服务端从Session中读取用户信息 -> 然后根据当前的用户来处理业务并返回
- 无状态：用户携带Token请求接口 -> 服务端根据请求头中的Token解析得到用户信息 -> 然后根据当前的用户来处理业务并返回

JWT是Token的一种实现，我们通常都采用JWT令牌来实现基于Token的校验。

基于JWT校验的**优点**有：

1. 节省服务器开销：服务器无需自己维护用户的会话信息
2. 安全性：JWT使用数字签名或加密算法保证Token的完整性和安全性。每次请求都会验证Token的合法性，然后从中解析得到用户的身份信息。
3. 适用于分布式系统

基于JWT校验的**缺点**有：

1. 难以即时撤销认证信息：一般Token在到达过期时间之前，会一直有效。如果服务端想要让该令牌立即失效，需要额外配置，例如将该Token保存到黑名单，存储在Redis中（当然，使用这种方案就意味着每次校验Token合法性时，都需要访问Redis判断它是否在黑名单中）

## 4.2 JWT简介

JSON Web Token（JWT）是一个开放标准，它定义了一种紧凑和自成一体的方式，用于在各方之间作为JSON对象安全地传输信息。这些信息可以被验证和信任，因为它是数字签名的。JWT可以使用密钥（使用HMAC算法）或使用RSA或ECDSA进行公钥/私钥对进行签名。

JWT令牌的格式如下：

![](images/Snipaste20240127200345.png)

一个JWT令牌由3部分组成：标头(Header)、有效载荷(Payload)和签名(Signature)。在传输的时候，会将JWT的前两部分分别进行Base64编码，然后后用`.`进行连接形成最终需要传输的字符串。

1. 标头：包含一些元数据信息，比如JWT签名所使用的加密算法，以及类型（类型统一都是JWT）
2. 有效载荷：包括用户名称、令牌发布时间、过期时间、JWT的ID等，当然我们也可以自定义添加字段，我们的用户信息一般都在这里存放。
3. 签名：首先需要指定一个密钥，该密钥仅仅保存在服务器中，必须保证不能让其他用户知道。然后使用Header中指定的算法对Header和Payload进行Base64编码之后的结果通过密钥计算哈希值，然后就得出一个签名哈希。这个会用于之后验证内容是否被篡改。

## 4.3 加密的相关知识

### 1、Base64编码

Base64就是包括小写字母a-z、大写字母A-Z、数字0-9、符号`+`和`/`一共64个字符的字符集（末尾还可能会有多个`=`用来凑够字节数）。任何的符号都可以转换成这个字符集中的字符，这个转换过程就叫做Base64编码，编码之后就会生成只包含上述64个字符的字符串。相反，如果需要原本的内容，我们也可以进行Base64解码。

> 注意：Base64只是一种信息的编码方式，而并不是加密算法，因为它可以解码得到原本的内容。

### 2、对称加密和非对称加密

加密算法分为对称加密和非对称加密：

- 对称加密，就类似一把锁配了两把相同的钥匙，即通信的双方都各自拥有相同的私钥，使用该私钥进行加密和解密。
- 非对称加密，则是生成一个私钥和一个公钥，私钥由你自己保管，公钥则是交给你想发送的任何人。你向对方发送数据时，使用私钥进行加密，得到的加密字符串只能由公钥来解密；对方向你发送数据时，他需要使用公钥进行加密，得到的加密字符串只能由你自己的私钥来解密。

显然，非对称加密的安全性很高，因为即使对方的公钥被黑客窃取，黑客也无法解密对方发送给你的信息（因为只有你自己的私钥可以解密）。而对称加密的安全性就较低，一旦黑客窃取了对方的私钥，就能随意解密信息了。

> 常见的RSA算法就是一种非对称加密算法

### 3、不可逆加密算法

经过不可逆加密算法得到的加密结果，是无法解密回去的。本质上，其就是一种哈希函数，用于对一段信息产生摘要，以防止被篡改。常见的不可逆加密算法有MD5，HMAC，SHA1，SHA2等。

## 4.4 JWT校验的整体流程

（1）用户首次登录，发送带有用户名和密码的post请求

（2）服务端验证用户名和密码，认证通过后会生成一个JWT令牌(其有效载荷包含用户的相关信息，但不会包含密码这类隐私信息)，然后将这个JWT令牌返回响应给用户

（3）用户的浏览器一般会将该JWT令牌保存到LocalStorage本地存储中(由前端代码控制)

（4）用户再次访问相关服务，会在请求头的`Authorization`字段中携带值`Bearer Token`，其中`Token`就是JWT令牌的内容，而`Bearer`是一种身份验证方式。身份验证方式默认有以下两种：

- `Basic`：基本的身份验证方式，它将用户名和密码进行Base64编码后，放在Authorization请求头中，用于向服务器验证用户身份。很显然这种方式非常不安全，密码容易被窃取。
- `Bearer`：基于令牌(Token)来验证用户身份

（5）服务端根据`Token`，就可以验证签名以及验证Token是否过期，如果Token合法，就可以从中得到用户的相关信息，然后进行业务处理并返回响应。

> 说明：JWT保证了很高的安全性，它能确保用户无法修改Token中用户的相关信息，从而以任意他人的身份访问服务器。因为JWT最后的加密签名，会用到服务器持有的秘钥，而用户在不知道秘钥的情况下，是不可能随意修改用户信息并得到正确的签名的。

## 4.5 JWT的基本使用

### 1、添加依赖

```xml
<dependency>
    <groupId>com.auth0</groupId>
    <artifactId>java-jwt</artifactId>
    <version>4.4.0</version>
</dependency>
```

### 2、创建JWT令牌

```java
public class Main {
    public static void main(String[] args) {
        String jwtToken = createJwt();
    }
    public static String createJwt() {
        // 1. 指定jwt使用的秘钥
        String jwtKey = "abcdefgh";
        // 2. 指定jwt使用的加密算法（需要传递秘钥）
        Algorithm algorithm = Algorithm.HMAC256(jwtKey);
        // 3. 创建jwt
        String jwtToken = JWT.create()
                .withJWTId(UUID.randomUUID().toString()) // 保存JWT的id
                .withClaim("userId", 2) // 保存自定义的数据
                .withClaim("username", "lisi")
                .withClaim("authorities", "rwx")
                .withIssuedAt(new Date()) // JWT的颁发时间
                .withExpiresAt(new Date(2024, Calendar.FEBRUARY, 1)) // JWT的过期时间
                .sign(algorithm); // 使用加密算法完成签名

        System.out.println(jwtToken);
        return jwtToken;
    }
}
```

控制台打印：

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiIyN2E0MmUwOC0zMGE5LTQxZDktODMyYy00ZWYwOWVkNmViODMiLCJ1c2VySWQiOjIsInVzZXJuYW1lIjoibGlzaSIsImF1dGhvcml0aWVzIjoicnd4IiwiaWF0IjoxNzA2MzYyMzI3LCJleHAiOjYxNjY0ODYwODAwfQ.oSJ8lQLKXFL-BHIpoH58eX-w9_bdRqG0ibgvEbIlGMU
```

### 3、解析JWT令牌

```java
public static void main(String[] args) {
    String jwtToken = createJwt();
    resolveJwt(jwtToken);
}

public static void resolveJwt(String jwtToken) {
    // 1. 指定jwt使用的秘钥
    String jwtKey = "abcdefgh";
    // 2. 指定jwt使用的加密算法（需要传递秘钥）
    Algorithm algorithm = Algorithm.HMAC256(jwtKey);
    // 3. 验证并解析JWT
    JWTVerifier jwtVerifier = JWT.require(algorithm).build();
    DecodedJWT decodedJWT = jwtVerifier.verify(jwtToken);
    // 4. 打印保存的信息
    Map<String, Claim> claims = decodedJWT.getClaims();
    System.out.println(claims);
}
```

控制台打印：

```
{exp=61664860800, userId=2, iat=1706362746, jti="c69f305b-887f-4e98-aab8-ccd3137467f9", authorities="rwx", username="lisi"}
```

# 5. Spring Security整合JWT案例实战

SpringSecurity中并没有为我们提供预设的JWT校验模块（只有其中的OAuth2模块才有），这里我们只能手动进行整合。

## 5.1 依赖、配置文件、主启动类

```xml
<!-- spring-security -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
<!-- jwt -->
<dependency>
    <groupId>com.auth0</groupId>
    <artifactId>java-jwt</artifactId>
    <version>4.4.0</version>
</dependency>
<!-- fastjson -->
<dependency>
    <groupId>com.alibaba.fastjson2</groupId>
    <artifactId>fastjson2</artifactId>
    <version>2.0.44</version>
</dependency>
<!-- lombok -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
</dependency>
<!-- web -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
<!-- mybatis-plus -->
<dependency>
    <groupId>com.baomidou</groupId>
    <artifactId>mybatis-plus-boot-starter</artifactId>
    <version>3.5.3.1</version>
</dependency>
<!-- mysql -->
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
</dependency>
<!-- redis -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-redis</artifactId>
</dependency>
<!-- test -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
</dependency>
```

```yml
spring:
  # 数据源配置
  datasource:
    type: com.zaxxer.hikari.HikariDataSource
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/jwt_test
    username: root
    password: abc666
  # redis配置
  data:
    redis:
      host: 192.168.231.120
      port: 6379
      password: abc666
  # 自定义jwt信息
  security:
    jwt:
      key: 'abcdefgh' # 加密的私钥
      expire: 72    # jwt过期时间，单位:小时
```

```java
@MapperScan("com.thuwsy.security.mapper")
@SpringBootApplication
public class SecurityJwtApplication {
    public static void main(String[] args) {
        SpringApplication.run(SecurityJwtApplication.class, args);
    }
}
```

## 5.2 从数据库认证用户

### 1、数据库表

```sql
CREATE DATABASE jwt_test;
USE jwt_test;

CREATE TABLE `db_account` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) UNIQUE NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) DEFAULT NULL,
  `authorities` VARCHAR(255) NOT NULL,
  `register_time` DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;
```

### 2、实体类

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("db_account")
public class Account implements Serializable {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String username;
    private String password;
    private String email;
    private String authorities;
    private Date registerTime;
}
```

### 3、mapper

```java
public interface AccountMapper extends BaseMapper<Account> {
}
```

### 4、service中需要注册一个UserDetailsService

（1）自定义AccountService接口，继承UserDetailsService接口

```java
public interface AccountService extends UserDetailsService {
    Account findAccountByUsername(String username);
}
```

（2）AccountServiceImpl

```java
@Service
public class AccountServiceImpl implements AccountService {
    @Autowired
    private AccountMapper accountMapper;

    // 通过用户名查找用户
    @Override
    public Account findAccountByUsername(String username) {
        LambdaQueryWrapper<Account> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Account::getUsername, username);
        return accountMapper.selectOne(wrapper);
    }

    /**
     * UserDetailsService接口的方法，我们需要返回一个UserDetails
     * 我们只需指定password，Spring Security底层会自动帮我们校验密码
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 1. 先从数据库查找用户
        Account account = findAccountByUsername(username);
        if (account == null) {
            throw new UsernameNotFoundException("用户名或密码错误");
        }

        // 2. 封装UserDetails信息
        // 传递给UserDetails校验的密码
        String password = account.getPassword();

        // 我们希望向JWT中保存用户的更多信息，而不仅仅只是一个username
        // 所以可以将account转为json字符串保存，注意要将敏感信息置空，例如密码
        account.setPassword(null);
        String accountString = JSON.toJSONString(account);

        // 3. 创建UserDetails
        return User.withUsername(accountString) // 用户的公开信息
                .password(password) // 用于校验的密码
                .authorities(account.getAuthorities()) // 用户的权限
                .build();
    }
}
```

### 5、统一响应结果

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
public class RestResponse<T> implements Serializable {
    private int code;
    private T data;
    private String message;

    public static <T> RestResponse<T> success(T data) {
        return new RestResponse<>(200, data, "请求成功");
    }
    public static <T> RestResponse<T> success() {
        return success(null);
    }
    public static <T> RestResponse<T> failure(int code, String message) {
        return new RestResponse<>(code, null, message);
    }

    public String asJsonString() {
        // 将该对象转化为json字符串（注意null值也要写入json字符串）
        return JSONObject.toJSONString(this, JSONWriter.Feature.WriteNulls);
    }
}
```

## 5.3 JWT工具类

```java
@Component
public class JwtUtil {
    // 用于给Jwt令牌签名校验的秘钥
    @Value("${spring.security.jwt.key}")
    private String key;

    // 令牌的过期时间，以小时为单位
    @Value("${spring.security.jwt.expire}")
    private int expire;

    @Autowired
    private StringRedisTemplate template;

    /**
     * 根据UserDetails创建JWT令牌
     */
    public String createJwt(UserDetails user) {
        // 1. 加密算法
        Algorithm algorithm = Algorithm.HMAC256(key);
        // 2. 创建JWT令牌
        return JWT.create()
                .withJWTId(UUID.randomUUID().toString()) // 保存JWT的id
                .withClaim("accountInfo", user.getUsername()) // 保存用户的公开信息
                .withIssuedAt(new Date()) // JWT颁发的时间
                .withExpiresAt(expireTime()) // JWT过期的时间
                .sign(algorithm); // 使用加密算法完成签名
    }

    // 计算JWT过期的时间
    private Date expireTime() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.HOUR, expire);
        return calendar.getTime();
    }

    /**
     * 解析请求头中的JWT令牌
     */
    public DecodedJWT resolveJwt(String headerToken) {
        // 1. 将请求头中的内容，去掉"Bearer "前缀，转换为标准的JWT令牌
        String token = convertToken(headerToken);
        if (token == null) return null;

        // 2. 根据私钥和加密算法，得到JWT校验器
        Algorithm algorithm = Algorithm.HMAC256(key);
        JWTVerifier jwtVerifier = JWT.require(algorithm).build();

        // 3. 进行token校验
        try {
            // 首先，验证token的签名正确(如果token被人篡改，则会校验失败，抛出JWTVerificationException)
            DecodedJWT decodedJWT = jwtVerifier.verify(token);

            // 其次，验证token不在Redis的黑名单中
            if (isInvalidToken(decodedJWT.getId()))
                return null;

            // 最后，验证token没有过期
            Date expiresAt = decodedJWT.getExpiresAt();
            return new Date().after(expiresAt) ? null : decodedJWT;

        } catch (JWTVerificationException e) {
            return null;
        }
    }

    // 将请求头中的内容，去掉"Bearer "前缀，转换为标准的JWT令牌
    private String convertToken(String headerToken) {
        if (headerToken == null || !headerToken.startsWith("Bearer "))
            return null;
        return headerToken.substring(7);
    }

    // 判断该jwtId是否在Redis的黑名单中
    private boolean isInvalidToken(String jwtId) {
        return Boolean.TRUE.equals(template.hasKey("jwt:blacklist:" + jwtId));
    }

    /**
     * 从解析完的JWT中提取用户的公开信息，封装为UserDetails返回
     */
    public UserDetails toUser(DecodedJWT decodedJWT) {
        // 1. 获取用户的公开信息
        Map<String, Claim> claims = decodedJWT.getClaims();
        String accountString = claims.get("accountInfo").asString();
        Account account = JSONObject.parseObject(accountString, Account.class);

        // 2. 封装为UserDetails
        return User.withUsername(accountString) // 用户的公开信息
                .password("******") // 密码随意设置即可，因为JWT中根本没有保存密码信息
                .authorities(account.getAuthorities()) // 用户的权限
                .build();
    }

    /**
     * 当用户退出登录时，删除该Token，也就是让该Token失效。返回值代表是否成功删除。
     */
    public boolean invalidateJwt(String headerToken) {
        // 1. 将请求头中的内容，去掉"Bearer "前缀，转换为标准的JWT令牌
        String token = convertToken(headerToken);
        if (token == null) return false;

        // 2. 根据私钥和加密算法，得到JWT校验器
        Algorithm algorithm = Algorithm.HMAC256(key);
        JWTVerifier jwtVerifier = JWT.require(algorithm).build();

        // 3. 删除token前，首先要确保该token是合法的
        try {
            // 首先，验证token的签名正确
            DecodedJWT decodedJWT = jwtVerifier.verify(token);

            // 然后将该token添加到Redis的黑名单中，就表示删除了该token
            return deleteToken(decodedJWT.getId(), decodedJWT.getExpiresAt());

        } catch (JWTVerificationException e) {
            return false;
        }
    }

    /**
     * 将该token添加到Redis的黑名单中
     * @param jwtId jwt的ID
     * @param expiresAt jwt过期的时间
     * @return 添加到黑名单中是否成功
     */
    private boolean deleteToken(String jwtId, Date expiresAt) {
        // 1. 如果该token已经在Redis黑名单中，则无需重复添加
        if (isInvalidToken(jwtId)) {
            return false;
        }

        // 2. 设置Redis中这个key的过期时间，等于jwt的过期日期减掉现在的日期
        Date now = new Date();
        long expire = Math.max(expiresAt.getTime() - now.getTime(), 0);

        // 3. 向Redis的黑名单中添加该key
        template.opsForValue()
                .set("jwt:blacklist:" + jwtId, "", expire, TimeUnit.MILLISECONDS);
        return true;
    }
}
```

## 5.4 JWT校验过滤器

我们需要一个用于对请求头中Jwt令牌进行校验的过滤器，结合SpringSecurity的机制，给用户配置登录状态，将用户信息保存到SecurityContext中

```java
// 继承OncePerRequestFilter表示每次请求过滤一次，用于快速编写JWT校验规则
@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {
    @Autowired
    private JwtUtil jwtUtil;

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
            throws ServletException, IOException {

        // 1. 首先从请求头中取出JWT并解析
        String headerToken = request.getHeader("Authorization");
        DecodedJWT decodedJWT = jwtUtil.resolveJwt(headerToken);

        if (decodedJWT != null) {
            // 2. 如果jwt合法，则获取用户的公开信息
            UserDetails user = jwtUtil.toUser(decodedJWT);

            // 3. 创建Authentication（与Spring Security源码的写法类似）
            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
            authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

            // 4. 将配置好的Authentication保存到SecurityContext，表示已完成验证
            SecurityContextHolder.getContext().setAuthentication(authentication);
        }

        // 5. 最后放行，执行下一个过滤器
        filterChain.doFilter(request, response);
    }
}
```

## 5.5 Security配置类

```java
@Configuration
@EnableMethodSecurity
public class SecurityConfig {
    @Autowired
    private JwtUtil jwtUtil;
    @Autowired
    private JwtAuthenticationFilter jwtAuthenticationFilter;

    @Bean // 密码加密器（对密码进行加密，提高安全性）
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        // 1. 设置需要认证的url
        http.authorizeHttpRequests(conf -> conf
                .requestMatchers("/api/auth/**").permitAll() // 登录相关的url无需认证
                .anyRequest().authenticated() // 其余请求都需要认证(登录)
        );

        // 2. 表单登录相关配置
        http.formLogin(conf -> conf
                .loginProcessingUrl("/api/auth/login") // 登录表单提交post请求的url
                .successHandler(this::onAuthenticationSuccess) // 登录成功后的处理方法
                .failureHandler(this::onAuthenticationFailure) // 登录失败后的处理方法
                .usernameParameter("username") // 用户名的参数名称
                .passwordParameter("password") // 密码的参数名称
        );

        // 3. 退出登录相关配置
        http.logout(conf -> conf
                .logoutUrl("/api/auth/logout") // 退出登录提交post请求的url
                .logoutSuccessHandler(this::onLogoutSuccess) // 退出登录成功后的处理方法
        );

        // 4. 认证或授权失败时的处理方式
        http.exceptionHandling(conf -> conf
                // 用户未登录时的处理方法
                .authenticationEntryPoint(this::onUnauthorized)
                // 用户权限不足访问时的处理方法
                .accessDeniedHandler(this::onAccessDeny)
        );

        // 5. 关闭CSRF防护
        http.csrf(conf -> conf.disable());

        // 6. 使用基于token的校验，就需要将session改为无状态
        http.sessionManagement(conf -> conf
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
        );

        // 7. 将我们自定义的JwtAuthenticationFilter加入过滤器链
        http.addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }


    // 登录成功后的处理方法
    private void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication)
            throws IOException, ServletException {

        response.setContentType("application/json;charset=utf-8");
        PrintWriter writer = response.getWriter();
        // 1. 获取登录后的用户信息
        User user = (User) authentication.getPrincipal();
        // 2. 根据用户信息，创建JWT令牌
        String token = jwtUtil.createJwt(user);
        // 3. 将令牌颁发给用户
        if (token == null) {
            writer.write(RestResponse.failure(403, "登录验证频繁，请稍后再试").asJsonString());
        } else {
            writer.write(RestResponse.success(token).asJsonString());
        }
    }

    // 退出登录成功后的处理方法
    private void onLogoutSuccess(HttpServletRequest request,
                                HttpServletResponse response,
                                Authentication authentication)
            throws IOException, ServletException {

        response.setContentType("application/json;charset=utf-8");
        PrintWriter writer = response.getWriter();
        // 1. 获取请求头中的token内容
        String headerToken = request.getHeader("Authorization");
        // 2. 令该token失效，也就是将该token添加到Redis的黑名单中
        if (jwtUtil.invalidateJwt(headerToken)) {
            writer.write(RestResponse.success("退出登录成功").asJsonString());
        } else {
            writer.write(RestResponse.failure(400, "退出登录失败").asJsonString());
        }
    }

    // 登录失败后的处理方法
    private void onAuthenticationFailure(HttpServletRequest request,
                                        HttpServletResponse response,
                                        AuthenticationException exception)
            throws IOException, ServletException {

        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(RestResponse.failure(401, exception.getMessage()).asJsonString());
    }

    // 用户未登录时的处理方法
    private void onUnauthorized(HttpServletRequest request,
                               HttpServletResponse response,
                               AuthenticationException exception)
            throws IOException, ServletException {

        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(RestResponse.failure(401, exception.getMessage()).asJsonString());
    }

    // 用户权限不足访问时的处理方法
    private void onAccessDeny(HttpServletRequest request,
                             HttpServletResponse response,
                             AccessDeniedException exception)
            throws IOException, ServletException {

        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(RestResponse.failure(403, exception.getMessage()).asJsonString());
    }
}
```

## 5.6 controller

我们首先封装一个工具类，用于获取用户的公开信息：

```java
@Slf4j
public class SecurityUtil {
    public static Account getAccount() {
        try {
            // 1. 从SecurityContext中获取封装的用户信息
            User user = (User) SecurityContextHolder
                    .getContext()
                    .getAuthentication()
                    .getPrincipal();
            // 2. 我们将用户的所有公开信息，都封装在了username中
            String accountString = user.getUsername();
            // 3. 将json转换为对应的实体类
            return JSONObject.parseObject(accountString, Account.class);
        } catch (Exception e) {
            log.error("获取当前登录用户的身份出错：{}", e.getMessage());
            return null;
        }
    }
}
```

接下来写几个controller方法用于测试：

```java
@RestController
@RequestMapping("/api/test")
public class TestController {
    @PreAuthorize("hasAnyAuthority('r', 'w')")
    @GetMapping("/read")
    public RestResponse<String> read() {
        return RestResponse.success("拥有读权限");
    }

    @PreAuthorize("hasAuthority('w')")
    @GetMapping("/write")
    public RestResponse<String> write() {
        return RestResponse.success("拥有写权限");
    }

    @GetMapping("/list")
    public RestResponse<Account> list() {
        // 返回已登录的用户信息
        Account account = SecurityUtil.getAccount();
        return RestResponse.success(account);
    }
}
```

## 5.7 测试

### 1、给数据库注册用户信息

为了简便，我们没有实现注册功能，直接在数据库中新增合法用户即可。首先我们需要一个测试类，帮助我们生成密码：

```java
@SpringBootTest
public class SecurityJwtTests {
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Test
    public void test() {
        System.out.println(passwordEncoder.encode("123456"));
        System.out.println(passwordEncoder.encode("123456"));
    }
}
```

然后在数据库中添加两个用户，权限分别为`r`和`w`

![](images/Snipaste20240128155328.png)

### 2、测试未登录

发送get请求给`http://localhost:8080/api/test/list`，响应结果如下：

```json
{
    "code": 401,
    "data": null,
    "message": "Full authentication is required to access this resource"
}
```

### 3、测试登录

发送post请求给`http://localhost:8080/api/auth/login?username=zhangsan&password=123456`，响应结果如下：

```json
{
    "code": 200,
    "data": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJmZmI5YzVlNi02OGMyLTQ0MjAtYTJjZS05OThhMGQxMGNhNmIiLCJhY2NvdW50SW5mbyI6IntcImF1dGhvcml0aWVzXCI6XCJyXCIsXCJlbWFpbFwiOlwienNAcXEuY29tXCIsXCJpZFwiOjEsXCJyZWdpc3RlclRpbWVcIjpcIjIwMjQtMDEtMTEgMTU6NTI6MDdcIixcInVzZXJuYW1lXCI6XCJ6aGFuZ3NhblwifSIsImlhdCI6MTcwNjQyODcwNywiZXhwIjoxNzA2Njg3OTA3fQ.o6lbE5NfDTn1-gELLTzwBjlkiJZ3eAhMrZDQrnXlsgs",
    "message": "请求成功"
}
```

然后发送get请求给`http://localhost:8080/api/test/list`，注意需要携带请求头`Authorization`，对应的值`Bearer Token`，Token就是上述登录成功后返回的令牌。响应结果如下：

```json
{
    "code": 200,
    "data": {
        "id": 1,
        "username": "zhangsan",
        "password": null,
        "email": "zs@qq.com",
        "authorities": "r",
        "registerTime": "2024-01-11T07:52:07.000+00:00"
    },
    "message": "请求成功"
}
```

### 4、测试权限

发送get请求给`http://localhost:8080/api/test/read`，注意需要携带请求头`Authorization`，对应的值`Bearer Token`，Token就是上述登录成功后返回的令牌。响应结果如下：

```json
{
    "code": 200,
    "data": "拥有读权限",
    "message": "请求成功"
}
```

而如果发送get请求给`http://localhost:8080/api/test/write`，则响应：

```json
{
    "code": 403,
    "data": null,
    "message": "Access Denied"
}
```

### 5、测试退出登录

发送post请求给`http://localhost:8080/api/auth/logout`，注意需要携带请求头`Authorization`，对应的值`Bearer Token`，Token就是上述登录成功后返回的令牌。响应结果如下：

```json
{
    "code": 200,
    "data": "退出登录成功",
    "message": "请求成功"
}
```

此时，在Redis中执行`keys *`可以查看到：

```sh
1) "jwt:blacklist:ffb9c5e6-68c2-4420-a2ce-998a0d10ca6b"
```

然后发送get请求给`http://localhost:8080/api/test/list`，此时即使我们携带之前的Token，也只能得到如下响应：

```json
{
    "code": 401,
    "data": null,
    "message": "Full authentication is required to access this resource"
}
```

> 除此之外，我们也可以登录lisi的账号进一步做权限测试








