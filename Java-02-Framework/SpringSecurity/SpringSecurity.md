# 第01章_SpringSecurity简介

## 1. 简介

安全框架用于保证系统资源的访问是被允许的，在请求到达资源之前安全框架会做一系列的验证工作，这些验证工作是通过一系列的过滤器完成。常见的安全框架有Apache Shiro、Spring Security、Sa-Token等。

Spring Security是一个基于Spring开发的安全框架，其底层主要是基于**Spring AOP**和**Servlet过滤器**来实现安全控制。核心功能包括：

- **认证(Authentication)**：验证`谁正在访问系统资源`，判断用户是否为合法用户。认证用户的常见方式是要求用户输入用户名和密码。
- **授权(Authorization)**：用户进行身份认证后，系统会控制`谁能访问哪些资源`，这个过程叫做授权。用户无法访问没有权限的资源。
- **攻击防护**：防护CSRF、SFA、XSS等常见攻击。

## 2. 权限模型

权限模型主要有以下两类：

### 2.1 RBAC(Role Based Access Controll)

RBAC是基于角色的访问控制，它是最广泛使用的权限模型。简单来说，RBAC的核心思想就是用户关联角色、角色关联权限。所以设计RBAC权限模型，就需要在数据库中创建用户、角色、权限表，以及它们之间关联的中间表：

（1）用户表（t_user）

|id|username|password|
|--|--------|--------|
|1 |zhangsan|123456  |
|2 |lisi    |123456  |

（2）角色表（t_role）

| id   | role_name |
| ---- | --------- |
| 1    | admin     |
| 2    | vip       |
| 3    | common    |

（3）权限表（t_permission）

| id   | perm         |
| ---- | ------------ |
| 1    | FILE_READ    |
| 2    | FILE_WRITE   |
| 3    | FILE_EXECUTE |

（4）用户_角色表（t_user_role）

| id   | username | role_name |
| ---- | -------- | --------- |
| 1    | zhangsan | admin     |
| 2    | zhangsan | vip       |
| 3    | lisi     | common    |

（5）角色_权限表（t_role_perm）

| id   | role_name | perm         |
| ---- | --------- | ------------ |
| 1    | admin     | FILE_READ    |
| 2    | admin     | FILE_WRITE   |
| 3    | admin     | FILE_EXECUTE |
| 4    | vip       | FILE_READ    |
| 5    | vip       | FILE_WRITE   |
| 6    | common    | FILE_READ    |

### 2.2 ACL(Access Controll List)

ACL是访问控制列表，该权限模型中用户直接和权限挂钩，而没有角色的概念：

（1）用户表（t_user）

|id|username|password|
|--|--------|--------|
|1 |zhangsan|123456  |
|2 |lisi    |123456  |

（2）权限表（t_permission）

| id   | perm         |
| ---- | ------------ |
| 1    | FILE_READ    |
| 2    | FILE_WRITE   |
| 3    | FILE_EXECUTE |

（3）用户_权限表（t_user_perm）

| id   | username | perm         |
| ---- | -------- | ------------ |
| 1    | zhangsan | FILE_READ    |
| 2    | zhangsan | FILE_WRITE   |
| 3    | zhangsan | FILE_EXECUTE |
| 4    | lisi     | FILE_READ    |

## 3. 常见的网络攻击

### 3.1 CSRF跨站请求伪造攻击

CSRF（Cross-site request forgery）：例如我们在某银行官网登录后进行转账，然后浏览器就会获得登录的Cookie信息，此时如果我们访问某个钓鱼网站并点击它的一个表单提交按钮（该表单底层实际上是会执行转账给一个黑客用户），由于携带了登录的Cookie信息，我们的银行账户余额就会被扣减。这就是CSRF攻击。

对于CSRF攻击，Spring Security就可以解决。当然，现在的浏览器安全性也很好，具有SameSite保护机制，即当用户在两个不同域名的站点操作时，默认情况下Cookie就会被自动屏蔽，所以也能防止CSRF攻击。

### 3.2 SFA会话固定攻击

SFA（Session fixation attack）：例如黑客在某银行官网登录后会获得一个JSESSIONID，而黑客的钓鱼网站中会编写一个js脚本，自动将访问的用户的JSESSIONID替换成黑客刚才获得的JSESSIONID。于是，当用户访问钓鱼网站后，再访问银行官网进行登录，此时，黑客刷新银行官网就能直接登录了（登录的是用户的银行账号，因为JSESSIONID相同），然后就能随意操作用户的银行账号。这就是SFA攻击。

对于SFA攻击，Spring Security同样可以解决。当然，现在的浏览器也有相应的保护机制，例如Tomcat发送的JSESSIONID默认是勾选了HttpOnly选项的，即一旦被设定，就无法被随意修改，所以黑客的js脚本就不起作用了，当然前提是用户先得正常访问一次银行官网获取JSESSIONID才行，如果直接先访问钓鱼网站，仍然存在安全隐患。

### 3.3 XSS跨站脚本攻击

XSS（Cross-site scripting）：指的是攻击者通过在合法网站中注入恶意脚本代码来攻击用户。例如，很多网站的发贴功能，实际上传的是用户评论内容对应的html格式文本，此时，黑客就可以在标签中执行一些恶意的js脚本来获取用户的各种信息。



# 第02章_SpringSecurity基本使用

## 1. 案例环境搭建

我们以一个简单的服务端渲染项目为例，模板引擎采用thymeleaf。

**（1）前端页面**

- 静态资源123.png，放在static目录下；
- 首页index.html，放在templates目录下：

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
<a th:href="@{/login}">登录</a><br>
<form th:action="@{/doLogout}" method="post">
    <div><button type="submit">退出登录</button></div>
</form>
<br><img th:src="@{/123.png}"><br>
</body>
</html>
```

- 登录页login.html，放在templates目录下：

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

**（2）Controller**

```java
@Controller
public class AccountController {
    @GetMapping("/")
    public String index() { return "index"; }

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

## 2. Security核心配置类

引入Spring Security依赖：

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

Spring Security中的常用组件有：

- `PasswordEncoder`是密码加密器，常用的实现类有`BCryptPasswordEncoder`，这个加密器对同一密码每次加密得到的结果都不同（使用了随机盐）。密码加密器主要有如下两个API：
  - `String encode(CharSequence rawPassword)`：用于将原始密码加密成密文
  - `boolean matches(CharSequence rawPassword, String encodedPassword)`：将原始密码`rawPassword`与密文`encodedPassword`匹配，如果是同一密码则返回true
- `UserDetailsService`是一个提供查询用户功能的service，它可以根据用户名查询用户，并返回UserDetails
- `UserDetails`代表用户信息，主要保存用户名、密码、权限等

```java
@EnableMethodSecurity // 开启方法级别的精确权限控制
@Configuration
public class SecurityConfig {

    @Bean // 密码加密器（对密码进行加密，提高安全性）
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean // 为了简便，我们直接在内存中配置用户信息
    public UserDetailsService userDetailsService(PasswordEncoder passwordEncoder) {
        // 每一个UserDetails就代表一个用户信息，其中包含用户名、密码、权限等
        UserDetails vipUser = User.withUsername("zhangsan")
                .password(passwordEncoder.encode("123456"))
                .authorities("FILE_READ", "FILE_WRITE", "FILE_EXECUTE")
                .build();
        UserDetails commonUser = User.withUsername("lisi")
                .password(passwordEncoder.encode("123456"))
                .authorities("FILE_READ")
                .build();

        // 创建一个基于内存的用户信息管理器作为UserDetailsService
        InMemoryUserDetailsManager manager = new InMemoryUserDetailsManager();
        manager.createUser(commonUser);
        manager.createUser(vipUser);
        return manager;
    }

    @Bean // 配置Security过滤器链
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        // 1. 关闭csrf防护，便于测试
        http.csrf(conf -> conf.disable());

        // 2. 配置需要认证的url
        http.authorizeHttpRequests(conf -> {
            conf.requestMatchers("/").permitAll() // 访问首页无需认证
                    .requestMatchers("/*.png").permitAll() // 访问静态资源无需认证
                    .anyRequest().authenticated(); // 其余请求都需要认证(登录)
        });

        // 3. 表单登录相关配置
        // http.formLogin(); // 开启默认的表单登录(SpringSecurity提供默认的登录页)
        http.formLogin(conf -> {
            conf.loginPage("/login") // 登录页url
                    .loginProcessingUrl("/doLogin") // 登录表单post提交的url
                    .defaultSuccessUrl("/") // 登录成功后跳转的页面
                    .usernameParameter("username") // 用户名的表单字段名称
                    .passwordParameter("password") // 密码的表单字段名称
                    .permitAll(); // 登录页允许所有人访问
        });

        // 4. 退出登录相关配置
        http.logout(conf -> {
            conf.logoutUrl("/doLogout") // 退出登录post提交的url
                    .logoutSuccessUrl("/login") // 退出成功后跳转的地址，这里设置为登录界面
                    .permitAll();
        });

        return http.build();
    }
}
```

> **注1**：如果我们没有自己注册组件UserDetailsService，即没有配置合法的用户信息，则默认的登录账号为user，登录密码会打印在控制台。
>
> **注2**：使用User类构建UserDetails对象时，除了上述`authorities()`指定权限，实际上还有`roles()`可以指定角色，但是并不推荐使用。

## 3. 授权功能

### 3.1 简介

如之前所述，User类可以通过`roles()`指定角色，也可以通过`authorities()`指定权限，看似Spring Security有角色和权限两种粒度的授权，但实际上Spring Security只有`authorities`这一种，因为对于`roles()`指定的角色，底层实际上会为其添加`ROLE_`前缀然后转化为`authorities`去判断权限。因此，Spring Security中的角色和权限，与我们所理解的RBAC中的角色和权限的关系是完全不一样的，事实上，Spring Security中只有权限的概念。因此，我们在使用User类构建UserDetails对象时，不推荐使用`roles()`指定角色，否则在后续进行权限判断时可能会遇到一些bug。

Spring Security的授权，支持以下两种方式：

### 3.2 基于url的授权

基于url的授权，就意味着拥有某个权限才能访问该路径，需要在配置类的SecurityFilterChain中进行配置，如下所示：

```java
http.authorizeHttpRequests(conf -> {
    // 基于url的授权
    conf.requestMatchers("/read").hasAuthority("FILE_READ");

    conf.requestMatchers("/").permitAll() // 访问首页无需认证
            .requestMatchers("/*.png").permitAll() // 访问静态资源无需认证
            .anyRequest().authenticated(); // 其余请求都需要认证(登录)
});
```

- `hasAuthority(String authority)`表示拥有该权限才能访问该路径
- `hasAnyAuthority(String... authorities)`表示拥有这些权限之一才能访问该路径
- `hasRole(String role)`表示拥有该角色才能访问该路径（不推荐使用）
- `hasAnyRole(String... roles)`表示拥有这些角色之一才能访问该路径（不推荐使用）

### 3.3 基于方法的授权

基于方法的授权，需要在Controller的方法上使用注解进行配置：

```java
@PreAuthorize("hasAnyAuthority('FILE_WRITE', 'FILE_EXECUTE')")
@GetMapping("/write")
@ResponseBody
public String write() { return "i am writing"; }

@PreAuthorize("hasAuthority('FILE_EXECUTE')")
@GetMapping("/execute")
@ResponseBody
public String execute() { return "i am executing"; }
```

注意事项：

1. 使用这些注解，首先必须在配置类上标注`@EnableMethodSecurity`
2. `@PreAuthorize`是在该方法执行之前就进行权限判断，还有一个注解`@PostAuthorize`是在该方法执行之后再进行权限判断
3. 在Controller类上也可以标注该注解，表示拥有该权限才能访问该类的方法。但是要注意，如果同时在类上和某个方法上标注该注解，则只以该方法上的注解为准，即该方法上的注解覆盖类上的注解。
4. 除了Controller以外，只要是由Spring管理的Bean都可以使用该注解来控制权限，例如service层同样也可以。



# 第03章_SpringSecurity原理

## 1. 过滤器链架构

Spring Security底层利用FilterChainProxy封装一系列过滤器链，实现各种安全拦截功能。**注意**：Spring Security只注册了一个Filter，也就是FilterChainProxy，而这个Filter内部，有一系列Spring Security自己实现的SecurityFilter，构成了过滤器链**SecurityFilterChain**，来实现各种安全校验拦截。

![](images/Snipaste20231009183413.png)

## 2. SecurityContextHolder

![image-20241031202907196](images/image-20241031202907196.png)

在Spring Security框架中，SecurityContextHolder是存储已认证用户详细信息的地方。通过SecurityContextHolder可以获取SecurityContext，进而获取Authentication，它表示用户的身份认证信息。Authentication包含了用户的以下信息：

- Principal：表示用户的实体对象
- Credentials：用户的凭证，通常是密码
- Authorities：用户的权限

**说明**：默认情况下，Spring Security的认证是基于Session的。当一个请求到来时，会从Session中取出SecurityContext来读取认证信息；当请求结束时，会将SecurityContext保存到Session中。

## 3. SpringBoot整合的自动配置原理

Security场景的自动配置类有两个：

- SecurityFilterAutoConfiguration，它的主要作用是给容器中放了DelegatingFilterProxyRegistrationBean组件
- SecurityAutoConfiguration，它开启了SecurityProperties属性绑定，绑定以`spring.security`为前缀的配置项。除此之外，它还导入了**SpringBootWebSecurityConfiguration**配置类。

SpringBootWebSecurityConfiguration有以下两个核心作用：

### 3.1 注册默认SecurityFilterChain组件

源码如下：

```java
@Bean
@Order(SecurityProperties.BASIC_AUTH_ORDER)
SecurityFilterChain defaultSecurityFilterChain(HttpSecurity http) throws Exception {
    http.authorizeHttpRequests((requests) -> requests.anyRequest().authenticated());
    http.formLogin(withDefaults());
    http.httpBasic(withDefaults());
    return http.build();
}
```

**效果**：使得所有请求都需要登录认证，并开启默认表单登录功能（提供了一个默认登录页，未经登录的所有请求都跳转到该页面）。

> **注意**：这个默认的登录页，以及使所有请求都要登录认证的特点，往往都不符合我们的业务需求。所以我们通常都会在配置类中自己配置一个SecurityFilterChain。

### 3.2 开启@EnableWebSecurity注解

该注解生效后，就会产生以下作用：

- 导入了WebSecurityConfiguration：web安全配置类
- 导入了HttpSecurityConfiguration：http安全配置类
- 开启了@EnableGlobalAuthentication：全局认证生效（该注解导入了AuthenticationConfiguration）



# 第04章_JWT

## 1. 两种用户校验方式

### 1.1 基于Session的校验

基于Session的校验是一种`有状态`服务。在之前，我们使用SpringSecurity提供的默认登录流程来完成的认证，就是基于Session的。SpringSecurity在用户登录之后，默认就会利用Session机制记录用户的登录状态，而我们每次请求，都会携带一个Cookie，其中存储了用于识别身份的JSESSIONID数据。

基于Session校验的**优点**有：

1. 可以即时撤销认证信息：由于Session在服务端管理，所以可以通过服务端手动删除的方法让其立即失效

基于Session校验的**缺点**有：

1. 难以分布式共享：在分布式系统中，多个服务器之间无法共享同一个用户的Session信息。当然我们也有相应的解决方案，通常就是将Session只保存一份到Redis中，实现**分布式Session**，每次用户信息校验时都从Redis中查询Session。
1. Cookie**无法防止CSRF攻击**：通常Session都是基于Cookie实现的，而Cookie则无法防止CSRF攻击。所以客户端浏览器可能会禁用Cookie，而这也就意味着无法使用Session了。

### 1.2 基于Token的校验

基于Token的校验是一种`无状态`服务。无状态服务是指在处理每个请求时，服务器本身不会维持任何与请求相关的状态信息。也就是说，用户在发起请求时，服务器不会记录该用户信息，而是通过用户携带的Token（令牌）来判断是哪一个用户。

简而言之，有状态和无状态服务的流程分别如下：

- 有状态：用户请求接口 -> 服务端从Session中读取用户信息 -> 然后根据当前的用户来处理业务并返回
- 无状态：用户携带Token请求接口 -> 服务端根据请求头中的Token解析得到用户信息 -> 然后根据当前的用户来处理业务并返回

JWT是Token的一种实现，我们通常都采用JWT令牌来实现基于Token的校验。

基于JWT校验的**优点**有：

1. 适用于**分布式系统**
2. **安全性更高**：JWT使用数字签名和加密算法保证Token的完整性和安全性，每次请求都会验证Token的合法性，然后从中解析得到用户的身份信息。
3. **能够防止CSRF攻击**：通常会将Token存放在localStorage（浏览器本地存储）中，而前端发送给后端的请求会在请求头中加上这个Token。所以不会出现CSRF漏洞，因为非法链接发起的请求是不会携带Token的。

基于JWT校验的**缺点**有：

1. **难以即时撤销认证信息**：虽然在Token中可以设置过期时刻的信息，但在这一时间之前，Token会一直有效。如果服务端想要让某个Token立即失效，就需要额外配置，例如将该Token保存到黑名单并存储在Redis中（当然，使用这种方案就意味着每次校验Token合法性时，都需要访问Redis判断它是否在黑名单中）。事实上，实际开发中用的最多的并不是黑名单方案，而是**白名单方案，也就是在JWT中只保存用户的uuid信息，而已登录用户的详细信息都保存在Redis中（类似于分布式Session的方案），而如果要让某个Token立即失效，只需从Redis中删除对应用户信息即可**。

> 注意：无论是Cookie还是Token，都无法避免XSS攻击。XSS中攻击者会用各种方式将恶意代码注入到其他用户的页面中，通过脚本来盗用信息。

## 2. JWT简介

### 2.1 简介

JSON Web Token（JWT）是一个开放标准，它定义了一种紧凑和自成一体的方式，用于在各方之间作为JSON对象安全地传输信息。这些信息可以被验证和信任，因为它是数字签名的。JWT可以使用密钥（使用HMAC算法）或使用RSA或ECDSA进行公钥/私钥对进行签名。

JWT令牌的格式如下：

![](images/Snipaste20240127200345.png)

一个JWT令牌由三部分组成：标头(Header)、有效载荷(Payload)和签名(Signature)。在传输的时候，会将JWT的前两部分分别进行Base64编码，然后用`.`进行连接形成最终需要传输的字符串。

1. 标头：包含一些元数据信息，比如JWT签名所使用的加密算法，以及类型（类型统一都是JWT）
2. 有效载荷：包括用户名称、令牌发布时间、过期时间、JWT的ID等，当然我们也可以自定义添加字段，我们的用户信息一般都在这里存放。
3. 签名：首先需要指定一个密钥，该密钥仅仅保存在服务器中，必须保证不能让其他用户知道。然后使用Header中指定的算法对Header和Payload进行Base64编码之后的结果通过密钥计算哈希值，然后就得出一个签名哈希。这个签名会用于之后验证内容是否被篡改。

### 2.2 加密的相关知识

#### 1、Base64编码

Base64就是64个字符的字符集，任何的符号都可以转换成这个字符集中的字符，这个转换过程就叫做Base64编码，编码之后就会生成只包含这64个字符的字符串。相反，如果需要原本的内容，我们也可以进行Base64解码。

> 注意：Base64只是一种信息的编码方式，而并不是加密算法，因为它可以解码得到原本的内容。

#### 2、对称加密和非对称加密

加密算法分为对称加密和非对称加密：

- 对称加密，就类似一把锁配了两把相同的钥匙，即通信的双方都各自拥有相同的私钥，使用该私钥进行加密和解密。
- 非对称加密，则是生成一个私钥和一个公钥，私钥由你自己保管，公钥则是交给你想发送的任何人。你向对方发送数据时，使用私钥进行加密，得到的加密字符串只能由公钥来解密；对方向你发送数据时，他需要使用公钥进行加密，得到的加密字符串只能由你自己的私钥来解密。

显然，非对称加密的安全性很高，因为即使对方的公钥被黑客窃取，黑客也无法解密对方发送给你的信息（因为只有你自己的私钥可以解密）。而对称加密的安全性就较低，一旦黑客窃取了对方的私钥，就能随意解密信息了。

> 常见的RSA算法就是一种非对称加密算法

#### 3、不可逆加密算法

经过不可逆加密算法得到的加密结果，是无法解密回去的。本质上，其就是一种哈希函数，用于对一段信息产生摘要，以防止被篡改。常见的不可逆加密算法有MD5，HMAC，SHA1，SHA2等。

### 2.3 JWT校验的整体流程

（1）用户首次登录，发送带有用户名和密码的post请求

（2）服务端验证用户名和密码，认证通过后会生成一个JWT令牌(其有效载荷包含用户的相关信息，但不会包含密码这类隐私信息)，然后将这个JWT令牌返回响应给用户

（3）用户的浏览器一般会将该JWT令牌保存到localStorage本地存储中(由前端代码控制)

（4）用户再次访问相关服务，会在请求头的`Authorization`字段中携带值`Bearer Token`，其中`Token`就是JWT令牌的内容，而`Bearer`是一种身份验证方式。身份验证方式默认有以下两种：

- `Basic`：基本的身份验证方式，它将用户名和密码进行Base64编码后，放在Authorization请求头中，用于向服务器验证用户身份。很显然这种方式非常不安全，密码容易被窃取。
- `Bearer`：基于令牌(Token)来验证用户身份

（5）服务端根据`Token`，就可以验证签名以及验证Token是否过期，如果Token合法，就可以获取用户的相关信息，然后进行业务处理并返回响应。

> 说明：JWT保证了很高的安全性，它能确保用户无法修改Token中用户的相关信息，从而以任意他人的身份访问服务器。因为JWT最后的加密签名，会用到服务器持有的秘钥，而用户在不知道秘钥的情况下，是不可能随意修改用户信息并得到正确的签名的。

## 3. JWT的基本使用

引入依赖：

```xml
<dependency>
    <groupId>com.auth0</groupId>
    <artifactId>java-jwt</artifactId>
    <version>4.4.0</version>
</dependency>
```

### 3.1 创建JWT令牌

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
                .withClaim("authorities", "FILE_READ")
                .withIssuedAt(new Date()) // JWT的颁发时间
                .withExpiresAt(new Date(2025-1900, Calendar.FEBRUARY, 1))//JWT的过期时间
                .sign(algorithm); // 使用加密算法完成签名

        System.out.println(jwtToken);
        return jwtToken;
    }
}
```

控制台打印：

```sh
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJmMzVmMGJlNC1kNmYzLTQzYjgtODk3Mi04YTVkNDY5ZWVhYWYiLCJ1c2VySWQiOjIsInVzZXJuYW1lIjoibGlzaSIsImF1dGhvcml0aWVzIjoiRklMRV9SRUFEIiwiaWF0IjoxNzMwNDM2NDE5LCJleHAiOjE3MzgzMzkyMDB9.HTKPAQdewCwBETKvayBQiQaObQ75V4hPFyrX5ixY2C0
```

### 3.2 解析JWT令牌

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

```sh
{exp=1738339200, userId=2, iat=1730436574, jti="d5c2b2fc-6dc1-460f-9615-51feb3395ed3", authorities="FILE_READ", username="lisi"}
```



# 第05章_SpringSecurity整合JWT案例实战

## 1. 案例环境搭建

Spring Security中并没有为我们提供预设的JWT校验模块（只有其中的OAuth2模块才有），所以我们需要手动整合JWT。

### 1.1 引入依赖

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
    <artifactId>mybatis-plus-spring-boot3-starter</artifactId>
    <version>3.5.8</version>
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

### 1.2 配置文件

```yml
spring:
  # 数据源配置
  datasource:
    type: com.zaxxer.hikari.HikariDataSource
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://192.168.231.202:3306/jwt_demo
    username: root
    password: abc666
  # redis配置
  data:
    redis:
      host: 192.168.231.202
      port: 6379
      password: abc666
  # 自定义jwt信息
  security:
    jwt:
      key: 'abcdefgh' # 加密的私钥
      expire: 72    # jwt过期时间，单位:小时
```

### 1.3 数据库表及相关实体类

#### 1、数据库表

```sql
CREATE DATABASE jwt_demo;
USE jwt_demo;

CREATE TABLE `db_account` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) UNIQUE NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) DEFAULT NULL,
  `register_time` DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;
```

#### 2、用户实体类

Spring Security会将认证的用户信息保存到UserDetails，所以我们的**用户实体类要实现UserDetails接口**：

```java
@Data
@TableName("db_account")
public class Account implements UserDetails {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String username;

    private String password;

    private String email;

    private Date registerTime;

    // 用户的权限信息，根据RBAC模型，需要通过数据库多表联查得到
    @TableField(exist = false)
    private List<String> perms;

    /**
     * 重写UserDetails的核心方法主要有：获取用户名、获取密码、获取权限
     * 只不过getUsername()和getPassword()已经被@Data注解所完成
     */
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        if (perms == null) {
            return new ArrayList<>();
        }
        // 通过stream将List<String>转为Collection<GrantedAuthority>
        return perms.stream().map(SimpleGrantedAuthority::new)
                .collect(Collectors.toList());
    }
}
```

#### 3、Mapper

```java
@Mapper
public interface AccountMapper extends BaseMapper<Account> {
}
```

#### 4、封装请求和响应

```java
/**
 * 封装登录的请求参数
 */
@Data
public class LoginParams {
    private String username;
    private String password;
    // 还可以定义验证码等参数...
}
```

```java
/**
 * 封装统一的响应信息
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class R<T> {
    private int code;
    private T data;
    private String msg;

    public static <T> R<T> ok(T data) {
        return new R<>(200, data, "success");
    }
    public static <T> R<T> ok() {
        return new R<>(200, null, "success");
    }
    public static <T> R<T> fail(int code, String msg) {
        return new R<>(code, null, msg);
    }
}
```

## 2. JWT相关

### 2.1 JWT工具类

```java
@Component
public class JwtUtil {
    // Jwt令牌签名的秘钥
    @Value("${spring.security.jwt.key}")
    private String key;

    // 令牌的过期时间，以小时为单位
    @Value("${spring.security.jwt.expire}")
    private int expire;

    @Autowired
    private StringRedisTemplate template;

    /**
     * 创建JWT令牌
     * @param userJson 用户的公开信息所对应的json串
     * @return JWT令牌
     */
    public String createJwt(String userJson) {
        // 1. 加密算法
        Algorithm algorithm = Algorithm.HMAC256(key);
        // 2. 创建JWT令牌
        return JWT.create()
                .withJWTId(UUID.randomUUID().toString()) // 保存JWT的id
                .withClaim("userInfo", userJson) // 保存用户的公开信息
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
     * 从解析完的JWT中提取用户的公开信息并返回
     * @param decodedJWT 解析完的JWT
     * @return 用户的公开信息所对应的json串
     */
    public String toUser(DecodedJWT decodedJWT) {
        return decodedJWT.getClaims().get("userInfo").asString();
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

### 2.2 JWT校验过滤器

我们需要一个用于对请求头中JWT令牌进行校验的过滤器，如果JWT令牌合法，即该用户是已登录状态，就将用户信息保存到SecurityContext中

```java
// 继承OncePerRequestFilter表示每次请求过滤一次
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
            // 2. 如果jwt合法，则获取用户的公开信息，并转换为UserDetails对象
            String userJson = jwtUtil.toUser(decodedJWT);
            Account user = JSONObject.parseObject(userJson, Account.class);

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

> 注意：我们还需要将该过滤器在配置类中加入Security的过滤器链。详见Security配置类。

## 3. 用户认证相关

### 3.1 创建UserDetailsService

首先需要创建一个类，实现UserDetailsService接口，其作用是根据username去数据库查询用户信息，然后封装成UserDetails返回。

```java
@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    @Autowired
    private AccountMapper accountMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 1. 根据用户名从数据库查找用户
        LambdaQueryWrapper<Account> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Account::getUsername, username);
        Account account = accountMapper.selectOne(wrapper);
        if (account == null) {
            throw new UsernameNotFoundException("用户名或密码错误");
        }

        // 2. 从数据库查询用户的权限信息，采用RBAC模型需要多表联查
        // 这里我们为了简便，直接给予用户权限
        account.setPerms(List.of("FILE_READ", "FILE_WRITE"));

        // 3. 返回UserDetails对象
        return account;
    }
}
```

### 3.2 创建处理登录请求的controller

```java
@RestController
@RequestMapping("/api/auth")
public class AuthController {
    @Autowired
    private AccountService accountService;

    @PostMapping("/login")
    public R<String> login(@RequestBody LoginParams loginParams) {
        String token = accountService.login(loginParams);
        if (token == null) {
            return R.fail(401, "用户名或密码错误");
        } else {
            return R.ok(token);
        }
    }
}
```

### 3.3 创建处理登录请求的service

```java
public interface AccountService {
    String login(LoginParams loginParams);
}
```

```java
@Service
public class AccountServiceImpl implements AccountService {
    // SpringSecurity中使用AuthenticationManager验证账号密码
    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtUtil jwtUtil;

    @Override
    public String login(LoginParams loginParams) {
        // 1. 传入要验证的用户名和密码
        UsernamePasswordAuthenticationToken authenticationToken =
                new UsernamePasswordAuthenticationToken(
                        loginParams.getUsername(),
                        loginParams.getPassword()
                );
        
        // 2. 调用AuthenticationManager的authenticate()方法验证用户名和密码
        // 其底层会调用UserDetailsService的loadUserByUsername()方法获取用户
        Account account = null;
        try {
            Authentication authentication = authenticationManager.authenticate(authenticationToken);
            // 3. 获取用户信息
            account = (Account) authentication.getPrincipal();
            if (account == null) {
                return null;
            }
        } catch (Exception e) {
            return null;
        }

        // 4. 根据用户的公开信息创建JWT令牌并返回（注意一定要将隐私信息置空）
        account.setPassword(null);
        String userJson = JSON.toJSONString(account);
        return jwtUtil.createJwt(userJson);
    }
}
```

### 3.4 在配置类中注册AuthenticationManager

我们需要在配置类中注册AuthenticationManager，将它与UserDetailsService、PasswordEncoder关联，只有这样才能使用AuthenticationManager验证账号密码。详见Security配置类。

### 3.5 SpringSecurity认证的底层原理

SpringSecurity进行用户登录认证的**核心原理**是：调用`AuthenticationManager`的`authenticate()`进行认证，该方法接收一个`Authentication`参数，认证通过后也返回一个`Authentication`对象。`Authentication`是一个接口，主要用于保存用户的主体、密码、权限等信息，它的API如下：

- `Object getPrincipal()`：用户的主体信息，一般保存一个UserDetails对象
- `Object getCredentials()`：用户的密码
- `Collection<? extends GrantedAuthority> getAuthorities()`：用户的权限
- `Object getDetails()`：该请求的一些其他信息
- `boolean isAuthenticated()`：该用户是否已认证
- `void setAuthenticated(boolean isAuthenticated)`：设置该用户的认证状态

其他核心类：

- `AuthenticationManager`是一个接口，我们通常使用它的一个常用实现类`ProviderManager`
- `ProviderManager`可以通过有参构造器创建，它的有参构造器接收一个或多个`AuthenticationProvider`类型的参数
- `AuthenticationProvider`也是一个接口，其作用是绑定`UserDetailsService`和`PasswordEncoder`。我们一般使用它的一个常用实现类`DaoAuthenticationProvider`

**认证的核心流程**：

首先，我们通过UsernamePasswordAuthenticationToken将用户填写的用户名和密码存储下来，并设置用户的认证状态为false，然后返回一个`Authentication`对象：

```java
UsernamePasswordAuthenticationToken authenticationToken =
        new UsernamePasswordAuthenticationToken(
                loginParams.getUsername(),
                loginParams.getPassword()
        );
```

然后调用`authenticationManager.authenticate(authenticationToken)`进行认证，该方法底层执行了以下逻辑：

1. 底层实际上调用其内部的`AuthenticationProvider`进行认证
2. 然后首先调用它绑定的`UserDetailsService`的`loadUserByUsername()`方法，即根据username查找用户并返回`UserDetails`对象
3. 然后判断`UserDetails`用户是否合法，即调用其`isEnabled()`、`isCredentialsNonExpired()`、`isAccountNonLocked()`、`isAccountNonExpired()`判断是否合法
4. 接下来会验证密码是否正确，也就是将一开始传入的`Authentication`中的原始密码，和`UserDetails`中保存的数据库中的密文，通过绑定的`PasswordEncoder`中的`matches()`方法进行密码校验
5. 最终，如果认证失败则抛出异常。如果认证成功，就将`Authentication`中的用户认证状态设置为true，并返回。

## 4. Security核心配置类

```java
@EnableMethodSecurity
@Configuration
public class SecurityConfig {
    @Autowired
    private UserDetailsServiceImpl userDetailsServiceImpl;
    @Autowired
    private JwtAuthenticationFilter jwtAuthenticationFilter;
    @Autowired
    private JwtUtil jwtUtil;

    @Bean // 密码加密器（对密码进行加密，提高安全性）
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /**
     * 注册AuthenticationManager，将它与UserDetailsService、PasswordEncoder关联
     */
    @Bean
    public AuthenticationManager authenticationManager(PasswordEncoder passwordEncoder) {
        // 它是AuthenticationProvider的一个常用实现类
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        // 关联使用的UserDetailsService
        provider.setUserDetailsService(userDetailsServiceImpl);
        // 关联使用的密码加密器
        provider.setPasswordEncoder(passwordEncoder);
        // 将AuthenticationProvider放入AuthenticationManager中
        return new ProviderManager(provider);
    }

    /**
     * 配置Security过滤器链
     */
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        // 1. 关闭csrf防护，便于测试
        http.csrf(conf -> conf.disable());

        // 2. 设置需要认证的url
        http.authorizeHttpRequests(conf -> conf
                .requestMatchers("/api/auth/**").permitAll() // 登录相关的url无需认证
                .anyRequest().authenticated() // 其余请求都需要认证(登录)
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

        // 5. 使用基于token的校验，就需要将session改为无状态
        http.sessionManagement(conf -> conf
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
        );

        // 6. 将我们自定义的JwtAuthenticationFilter加入过滤器链
        // 注意，检验JWT的过滤器一定要在登录认证的过滤器之前
        http.addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
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
            writer.write(JSON.toJSONString(R.ok("退出登录成功")));
        } else {
            writer.write(JSON.toJSONString(R.fail(400, "退出登录失败")));
        }
    }

    // 用户未登录时的处理方法
    private void onUnauthorized(HttpServletRequest request,
                                HttpServletResponse response,
                                AuthenticationException exception)
            throws IOException, ServletException {

        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(JSON.toJSONString(R.fail(401, exception.getMessage())));
    }

    // 用户权限不足访问时的处理方法
    private void onAccessDeny(HttpServletRequest request,
                              HttpServletResponse response,
                              AccessDeniedException exception)
            throws IOException, ServletException {

        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(JSON.toJSONString(R.fail(403, exception.getMessage())));
    }
}
```

## 5. 测试Controller

### 5.1 Security工具类

我们首先封装一个工具类，用于获取用户的公开信息：

```java
@Slf4j
public class SecurityUtil {
    public static Account getAccount() {
        try {
            // 从SecurityContext中获取封装的用户信息
            return (Account) SecurityContextHolder
                    .getContext()
                    .getAuthentication()
                    .getPrincipal();
        } catch (Exception e) {
            log.error("获取当前登录用户的身份出错：{}", e.getMessage());
            return null;
        }
    }
}
```

### 5.2 Controller测试方法

接下来写几个controller方法用于测试：

```java
@RestController
@RequestMapping("/api/test")
public class TestController {
    @PreAuthorize("hasAuthority('FILE_READ')")
    @GetMapping("/read")
    public R<String> read() {
        return R.ok("拥有读权限");
    }

    @PreAuthorize("hasAuthority('FILE_FLUSH')")
    @GetMapping("/flush")
    public R<String> flush() {
        return R.ok("拥有flush权限");
    }

    @GetMapping("/list")
    public R<Account> list() {
        // 返回已登录的用户信息
        Account account = SecurityUtil.getAccount();
        return R.ok(account);
    }
}
```

## 6. 测试

### 6.1 给数据库注册用户信息

为了简便，我们没有实现注册功能，直接在数据库中新增合法用户即可。首先我们需要一个测试类，帮助我们生成密码：

```java
@SpringBootTest
class SecurityJwtApplicationTests {
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Test
    public void test() {
        System.out.println(passwordEncoder.encode("123456"));
        System.out.println(passwordEncoder.encode("123456"));
    }
}
```

然后在数据库中添加两个用户

![image-20241101144829321](images/image-20241101144829321.png)

### 6.2 测试未登录

发送get请求给`http://localhost:8080/api/test/list`，响应结果如下：

```json
{
    "code": 401,
    "data": null,
    "msg": "Full authentication is required to access this resource"
}
```

### 6.3 测试登录

发送post请求给`http://localhost:8080/api/auth/login`，请求体为json数据

```json
{
    "username": "zhangsan",
    "password": "123456"
}
```

响应结果如下：

```json
{
    "code": 200,
    "data": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI4MWQyNGJjNi01NWExLTQ4NWUtOWY2OC04OWNlM2U0YjZmMjYiLCJ1c2VySW5mbyI6IntcImFjY291bnROb25FeHBpcmVkXCI6dHJ1ZSxcImFjY291bnROb25Mb2NrZWRcIjp0cnVlLFwiYXV0aG9yaXRpZXNcIjpbe1wiYXV0aG9yaXR5XCI6XCJGSUxFX1JFQURcIn0se1wiYXV0aG9yaXR5XCI6XCJGSUxFX1dSSVRFXCJ9XSxcImNyZWRlbnRpYWxzTm9uRXhwaXJlZFwiOnRydWUsXCJlbWFpbFwiOlwienNAcXEuY29tXCIsXCJlbmFibGVkXCI6dHJ1ZSxcImlkXCI6MSxcInBlcm1zXCI6W1wiRklMRV9SRUFEXCIsXCJGSUxFX1dSSVRFXCJdLFwicmVnaXN0ZXJUaW1lXCI6XCIyMDI0LTExLTAxIDE0OjQ3OjA2XCIsXCJ1c2VybmFtZVwiOlwiemhhbmdzYW5cIn0iLCJpYXQiOjE3MzA0NDM4NDYsImV4cCI6MTczMDcwMzA0Nn0.tPJf1ghPxx1H0DjyRcDpYHwPnp_0W6qdRuckAccoP-8",
    "msg": "success"
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
        "registerTime": "2024-11-01T06:47:06.000+00:00",
        "perms": [
            "FILE_READ",
            "FILE_WRITE"
        ],
        "authorities": [
            {
                "authority": "FILE_READ"
            },
            {
                "authority": "FILE_WRITE"
            }
        ],
        "enabled": true,
        "accountNonLocked": true,
        "accountNonExpired": true,
        "credentialsNonExpired": true
    },
    "msg": "success"
}
```

### 6.4 测试权限

发送get请求给`http://localhost:8080/api/test/read`，注意需要携带请求头`Authorization`，对应的值`Bearer Token`，Token就是上述登录成功后返回的令牌。响应结果如下：

```json
{
    "code": 200,
    "data": "拥有读权限",
    "msg": "success"
}
```

而如果发送get请求给`http://localhost:8080/api/test/flush`，则响应：

```json
{
    "code": 403,
    "data": null,
    "msg": "Access Denied"
}
```

### 6.5 测试退出登录

发送post请求给`http://localhost:8080/api/auth/logout`，注意需要携带请求头`Authorization`，对应的值`Bearer Token`，Token就是上述登录成功后返回的令牌。响应结果如下：

```json
{
    "code": 200,
    "data": "退出登录成功",
    "msg": "success"
}
```

此时，在Redis中执行`keys *`可以查看到：

```sh
1) "jwt:blacklist:81d24bc6-55a1-485e-9f68-89ce3e4b6f26"
```

然后发送get请求给`http://localhost:8080/api/test/list`，此时即使我们携带之前的Token，也只能得到如下响应：

```json
{
    "code": 401,
    "data": null,
    "msg": "Full authentication is required to access this resource"
}
```



# 第06章_OAuth2.0

## 1. OAuth2.0简介

### 1.1 简介

OAuth（Open Authorization）是一个开放的授权标准，允许用户让第三方应用访问该用户在本应用中的数据，而无需将账号密码提供给第三方应用，OAuth通过颁发令牌的方式进行授权，所以OAuth是安全的。

每一个令牌授权一个特定网站在特定时间访问特定资源，OAuth让用户可以授权第三方网站访问他们存储在另外服务提供者的某些特定信息，而非所有内容。为简化客户端开发提供了特定的授权流，包括Web应用、桌面应用、移动端应用等。

> 说明：OAuth2.0是OAuth的延续版本，并不向前兼容，完全废弃了OAuth1.0

### 1.2 OAuth2.0中的角色

1. 认证服务器（Authorization Server）：负责验证资源拥有者的身份并向客户端颁发访问令牌。
2. 资源服务器（Resource Server）：存储受保护的资源，接收并验证客户端的访问令牌，以决定是否允许访问资源。
3. 客户端应用（Client）：通常是一个Web应用，它需要携带访问令牌来请求资源服务器的资源。
4. 资源拥有者（Resource Owner）：即用户，他具有访问资源的账号与密码。

### 1.3 OAuth2.0的四种授权模式

1. **授权码**：指的是客户端应用先申请一个授权码，然后再用该授权码获取令牌。这种方式是最常用，最复杂，也是最安全的。授权码通过前端传送，令牌则是存储在后端，而且所有与资源服务器的通信都在后端完成，这就避免了令牌泄漏。
2. **隐藏式**：适用于纯前端应用，此时由于没有后端，只能将令牌存储在前端。这种方式直接向前端颁发令牌，而没有授权码这个中间步骤，所以称为隐藏式。
3. **密码式**：直接将用户在资源服务器的账号与密码告诉该客户端应用，然后以此申请令牌。这种方式风险很大，只适用于用户高度信任的客户端应用。
4. **凭证式**：适用于没有前端的命令行应用，即在命令行下请求令牌。这种方式给出的令牌是针对客户端应用的，而不是针对用户的，即有可能多个用户共享同一个令牌。

## 2. OAuth2.0案例实战

### 2.1 Gitee的OAuth2.0授权登录流程

QQ、微信、微博、GitHub、Gitee等平台都提供了OAuth2.0授权认证，我们以Gitee为例接入OAuth2.0（因为Gitee无需审核、便于调试，而像QQ、微信都需要有备案域名），接入文档：https://gitee.com/api/v5/oauth_doc#/

Gitee的OAuth2.0授权认证提供了`授权码模式`和`密码模式`，我们推荐使用更加安全的`授权码模式`。整个授权登录流程如下：

1. 应用通过浏览器将用户引导到Gitee三方认证页面（GET请求，携带参数`client_id`和`redirect_uri`）
2. Gitee要求用户对应用进行授权
3. 用户同意授权，则Gitee认证服务器会回调地址`redirect_uri`，并通过参数`code`传递**用户授权码**
4. **应用携带用户授权码，向Gitee认证服务器请求令牌**`access_token`（POST请求）
5. Gitee认证服务器返回令牌
6. **应用携带令牌，向Gitee资源服务器请求访问用户数据**
7. Gitee资源服务器返回用户数据
8. 应用使用Gitee的用户数据完成登录

![image-20241025172502447](images/image-20241025172502447.png)

> 说明：在这个案例中，认证服务器和资源服务器都由Gitee提供，客户端应用指的就是我们自己的SpringBoot应用，资源拥有者指的就是要登录的用户。

### 2.2 Gitee创建应用

![image-20241025180459294](images/image-20241025180459294.png)

> 说明：Gitee创建应用完成后，会得到**Client ID**和**Client Secret**，将来用于SpringSecurity的配置。

### 2.3 SpringSecurity整合OAuth2.0

（1）引入依赖

```xml
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-oauth2-client</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-security</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
</dependencies>
```

（2）配置文件

```yaml
spring:
  security:
    oauth2:
      client:
        registration:
          # OAuth授权平台
          gitee:
            client-id: f33ca4de7b5e7b84792b30a738734ebae112046eb7d702b93dd135057aeb9216
            client-secret: 20ad7cd087bddc0903b29fc0a76b73a151a80bf9074f10f29de8afe42480a390
            # 授权模式采用授权码模式
            authorization-grant-type: authorization_code
            # 回调地址
            redirect-uri: '{baseUrl}/{action}/oauth2/code/{registrationId}'
            client-name: gitee
            provider: gitee
            # 权限范围，可配置项在码云应用信息中查看
            scope:
              - user_info
        provider:
          gitee:
            # 申请用户授权的地址
            authorization-uri: https://gitee.com/oauth/authorize
            # 申请令牌的地址
            token-uri: https://gitee.com/oauth/token
            # 申请访问用户信息的地址
            user-info-uri: https://gitee.com/api/v5/user
            # 码云用户信息中的用户名字段
            user-name-attribute: name
```

（3）测试Controller

```java
@RestController
public class IndexController {
    // 只有使用第三方登录的用户才能访问此接口，否则会由于参数类型不匹配而报错
    @GetMapping("/")
    public String index(
            @RegisteredOAuth2AuthorizedClient OAuth2AuthorizedClient authorizedClient,
            @AuthenticationPrincipal OAuth2User oAuth2User) {
        System.out.println("userName:" + oAuth2User.getName());
        System.out.println("clientName:" + authorizedClient.getClientRegistration().getClientName());
        System.out.println("userAttributes:" + oAuth2User.getAttributes());
        return "success";
    }
}
```

项目启动后访问 http://localhost:8080/login 



