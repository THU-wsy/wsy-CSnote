# 1. MyBatis简介

## 1.1 项目架构

**单体架构**

![](images/20230803211526.png)

**分布式架构**

一个项目（对应IDEA中的一个project），拆分成很多个模块（module），每一个模块都运行在自己的Tomcat上。每个模块都可以看成是一个单体架构的应用，模块之间可以互相调用。

![](images/20230803211639.png)

## 1.2 ORM

ORM（Object-Relational Mapping，对象-关系映射）是一种将数据库和面向对象编程语言中的对象之间进行转换的技术。它将对象和关系型数据库的概念进行映射（一个类对应一张表，类的属性对应表的字段，类的一个对象对应表的一条记录），于是我们就可以**通过方法调用进行数据库操作**。

ORM框架通常有半自动和全自动两种方式：

- 半自动 ORM 通常需要程序员手动编写 SQL 语句
- 全自动 ORM 则是将实体类和数据表进行自动映射，使用 API 进行数据库操作时，会自动生成执行 SQL 语句并将查询结果转换成实体对象

> 常见的半自动 ORM 框架包括 MyBatis 等；常见的全自动 ORM 框架包括 Hibernate、Spring Data JPA、MyBatis-Plus 等。

## 1.3 MyBatis

MyBatis最初是Apache的一个开源项目**iBatis**，之后该项目的开发团队转投Google Code旗下，于是iBatis3.x正式更名为MyBatis。MyBatis与其他持久化层技术的对比：

- **开发效率：Hibernate>Mybatis>JDBC**
- **运行效率：JDBC>Mybatis>Hibernate**

## 1.4 MyBatis的工作原理

对于1.x和2.x版本，iBatis进行数据库操作的方式如下：

1. 无需创建Mapper接口，只需要有Mapper映射文件即可，在该xml文件中直接编写sql语句
2. Mapper映射文件的名称空间namespace没有任何要求，随意声明一个字符串即可
3. 如果要使用SQL语句，只需创建出SqlSession对象后，调用它的CRUD方法即可。

```xml
<mapper namespace="abc">
    <select id="666" resultType="com.thuwsy.pojo.Student">
        select * from student where sid = #{id}
    </select>
</mapper>
```

```java
// SqlSession提供的常见CRUD方法有：selectOne、selectList、insert、delete、update
// 这些CRUD方法，本质上就是去映射文件中查找对应的SQL语句，然后执行
// 以selectOne为例：
// 第一个参数是一个String，传入SQL语句对应的namespace.id
// 第二个参数是一个Object，传入SQL语句需要的参数
Student student = sqlSession.selectOne("abc.666", 1);
```

3.x版本后改名为MyBatis，使用方式也有所改变，MyBatis操作数据库的方式实际上是对iBatis的封装和优化。我们需要创建Mapper接口，而在执行`sqlSession.getMapper(UserMapper.class)`时，底层会**使用JDK动态代理帮我们创建一个UserMapper接口的代理对象**。当我们调用Mapper接口的方法时，实际调用的是这个代理对象中的方法，在底层这个代理对象会根据接口全类名和方法名（拼接成字符串`接口全类名.方法名`），并使用iBatis的方式查找并执行SQL语句。**因此在Mapper映射文件中namespace必须是接口的全类名，而SQL语句id必须是方法名**。

> 说明：Mapper接口里的方法可以重载，但是对应Mapper映射文件中的id不允许重复，也就是这多个重载方法只能对应同一个SQL语句。虽然我们也可以使用动态SQL来对这些重载方法进行区分，但一般来说我们还是并不推荐对Mapper接口进行方法重载。

# 2. 日志框架

## 2.1 简介

在开发中我们禁止使用sout来打印日志信息，因为不方便统一管理和定位问题。我们应该使用日志框架，它不仅能灵活指定输出位置，还能设定级别进行统一管理，便于我们基于日志分析问题：

- 错误（Error）：表示程序运行出错，比如抛异常等情况。
- 警告（Warning）：表示程序运行过程中有潜在风险，但此时并没有报错。
- 信息（Info）：表示程序运行过程中完成了一个关键动作，需要以程序运行信息的形式告知开发者。
- 调试（Debug）：表示程序运行过程中更加细致的信息，协助程序员调试程序。

我们可以通过在配置文件中指定某一个日志级别来控制系统要打印的内容，日志框架会打印**当前指定级别**的日志和比当前指定级别**更严重**的级别的日志。

## 2.2 Logback日志框架

**1、导入依赖**

```xml
<!-- 日志 -->
<dependency>
    <groupId>ch.qos.logback</groupId>
    <artifactId>logback-classic</artifactId>
    <version>1.2.3</version>
</dependency>
```

**2、引入配置文件**

Logback要求配置文件名称必须是`logback.xml`，存放路径在main/resources目录下。下面是配置文件示例：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration debug="true">
    <!-- 指定日志输出的位置，ConsoleAppender表示输出到控制台 -->
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <!-- 日志输出的格式 -->
            <!-- 按照顺序分别是：时间、日志级别、线程名称、打印日志的类、日志主体内容、换行 -->
            <pattern>[%d{HH:mm:ss.SSS}] [%-5level] [%thread] [%logger] [%msg]%n</pattern>
            <charset>UTF-8</charset>
        </encoder>
    </appender>

    <!-- 设置全局日志级别。日志级别按顺序分别是：TRACE、DEBUG、INFO、WARN、ERROR -->
    <!-- 指定任何一个日志级别都只打印当前级别和后面级别的日志。 -->
    <root level="INFO">
        <!-- 指定打印日志的appender，这里通过“STDOUT”引用了前面配置的appender -->
        <appender-ref ref="STDOUT" />
    </root>

    <!-- 根据特殊需求指定局部日志级别，可以是包名或全类名。 -->
    <logger name="com.thuwsy" level="DEBUG" additivity="false">
        <appender-ref ref="STDOUT" />
    </logger>

</configuration>
```

## 2.3 Lombok

```xml
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.24</version>
</dependency>
```

使用Lombok注解就可以省略生成setter、getter方法等固定格式代码的繁琐操作，提高开发效率。其底层原理是将自动生成的代码织入字节码文件中，从而实现**源代码没有，但是字节码文件有**。

![](images/20230803214107.png)

|注解|作用|
|---|---|
|`@Data`|生成getter方法、setter方法、toString()、equals()、canEqual()、hashCode()|
|`@AllArgsConstructor`|生成全参构造器|
|`@NoArgsConstructor`|生成无参构造器|
|`@Slf4j`|生成日志对象|
|`@Getter`|生成getter方法|
|`@Setter`|生成setter方法|
|`@ToString`|生成toString()方法|
|`@Accessors(chain = true)`|字段的setter方法调用后会返回当前对象，即开启setter方法的链式调用|
|`@Builder`|开启建造者模式|

# 3. MyBatis基本使用

## 3.1 环境搭建

### 3.1.1 创建Maven工程

```xml
<!-- mybatis依赖 -->
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis</artifactId>
    <version>3.5.7</version>
</dependency>
<!-- junit5测试 -->
<dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter-api</artifactId>
    <version>5.3.1</version>
    <scope>test</scope>
</dependency>
<!-- MySQL驱动 -->
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.28</version>
</dependency>
<dependency>
    <groupId>ch.qos.logback</groupId>
    <artifactId>logback-classic</artifactId>
    <version>1.2.3</version>
</dependency>
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.24</version>
</dependency>
```

### 3.1.2 核心配置文件

MyBatis核心配置文件，习惯上命名为`mybatis-config.xml`，放在src/main/resources目录下。将来整合 Spring 之后这个配置文件可以省略。

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <!--
        MyBatis核心配置文件中，标签的顺序：
        properties, settings, typeAliases, typeHandlers,
        objectFactory, objectWrapperFactory, reflectorFactory,
        plugins, environments, databaseIdProvider, mappers
    -->

    <!--引入properties文件-->
    <properties resource="jdbc.properties"></properties>

    <!--设置类的别名，默认是类名的首字母小写（事实上不区分大小写）-->
    <typeAliases>
        <package name="com.thuwsy.mybatis.pojo"/>
    </typeAliases>

    <!--设置连接数据库的环境-->
    <environments default="development">
        <environment id="development">
            <transactionManager type="JDBC"/>
            <dataSource type="POOLED">
                <property name="driver" value="${jdbc.driver}"/>
                <property name="url" value="${jdbc.url}"/>
                <property name="username" value="${jdbc.username}"/>
                <property name="password" value="${jdbc.password}"/>
            </dataSource>
        </environment>
    </environments>

    <!--引入Mapper映射文件-->
    <mappers>
        <package name="com.thuwsy.mybatis.mapper"/>
    </mappers>
</configuration>
```

注意：使用子标签package批量引入Mapper映射文件，必须保证**Mapper接口所在的包要和Mapper映射文件所在的包最终的路径相同**，并且**Mapper接口名要和Mapper映射文件名相同**。如上，必须把Mapper接口(如`UserMapper`)创建到`main/java/com/thuwsy/mybatis/mapper/`目录下，必须把对应的Mapper映射文件(如`UserMapper.xml`)创建到`main/resources/com/thuwsy/mybatis/mapper/`目录下。

### 3.1.3 Mapper映射文件

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.thuwsy.mybatis.mapper.UserMapper">
    <!-- 对应的方法：int updateUser(); -->
    <update id="updateUser">
        update t_user set username = 'root', password = '123' where id = 3
    </update>
</mapper>
```

- namespace必须指定**Mapper接口的全类名**
- SQL语句的**id**必须与接口中对应的**方法名**相同

### 3.1.4 其他配置文件

`logback.xml`：存放在main/resources目录下

`jdbc.properties`：存放在main/resources目录下

```properties
jdbc.driver=com.mysql.cj.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/ssm
jdbc.username=root
jdbc.password=abc666
```

### 3.1.5 测试

```java
public class MyBatisTest {

    private SqlSession sqlSession;

    // junit5会在每一个@Test方法前执行@BeforeEach方法
    @BeforeEach
    public void init() throws IOException {
        // 获取核心配置文件的输入流
        InputStream is = Resources.getResourceAsStream("mybatis-config.xml");
        // 获取SqlSessionFactory对象
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        // 获取sql的会话对象SqlSession，是MyBatis提供的操作数据库的对象。true表示开启自动提交事务。
        sqlSession = sqlSessionFactory.openSession(true);
    }

    // junit5会在每一个@Test方法后执行@AfterEach方法
    @AfterEach
    public void clear() {
        // 关闭SqlSession
        sqlSession.close();
    }

    @Test
    public void testUpdateUser() {
        // 获取UserMapper的代理实现类对象
        UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
        // 调用UserMapper接口中的方法
        userMapper.updateUser();
    }
}
```

- SqlSession代表Java程序和数据库之间的会话，不依赖Web服务器，属于持久化层。（HttpSession是Java程序和浏览器之间的会话，工作在Web服务器上，属于表述层）
- SqlSessionFactory是生产SqlSession的工厂。
- 工厂模式：如果创建某一个对象，使用的过程基本固定，那么我们就可以把创建这个对象的相关代码封装到一个工厂类中，以后都使用这个工厂类来生产我们需要的对象。

## 3.2 给SQL语句传参

给SQL语句传参有两种方式：`${}`和`#{}`

- `${}`的本质是**字符串拼接**，所以如果为字符串类型或日期类型的字段进行赋值时，需要手动加单引号。
- `#{}`的本质是**占位符赋值**，即会被解析成`?`然后进行占位符赋值。

> **说明**：通常不会采用`${}`的方式传值，除非某些特定场景。

### 3.2.1 单个简单类型的参数

若mapper接口中的方法参数为单个简单类型，则可以使用`${}`和`#{}`以任意的名称获取参数的值。但建议使用`@Param`注解。

### 3.2.2 多个简单类型的参数

若mapper接口中的方法参数为多个时，MyBatis会自动将这些参数放在一个map中，以arg0, arg1...为键，以参数为值，同时也以param1, param2...为键，以参数为值；因此只需要通过`${}`和`#{}`访问map集合的键就可以获取相对应的值。但建议使用`@Param`注解。

```xml
<!-- User checkLogin(String username, String password); -->
<select id="checkLogin" resultType="User">
    select * from t_user where username = #{param1} and password = #{param2}
</select>
```

### 3.2.3 Map集合类型的参数

若mapper接口中的方法参数为一个map时，只需要通过`${}`和`#{}`访问Map集合的键就可以获取相对应的值。

> 使用场景：有很多零散的参数需要传递，但是没有对应的实体类类型可以使用，而使用@Param注解一个一个传入又太麻烦了，所以可以封装到Map中。

```xml
<!-- int deleteByNameAndId(Map<String, Object> map); -->
<delete id="deleteByNameAndId">
    delete from t_user where id = #{id} and username = #{name}
</delete>
```

### 3.2.4 实体类类型的参数

若mapper接口中的方法参数为一个实体类对象时，可以使用`${}`和`#{}`，通过访问实体类对象中的属性名获取属性值。注意该属性名要与该实体类中的getter方法对应，因为其底层原理是会根据传入的参数`#{age}`，加工成`getAge()`方法，通过反射在实体类对象中调用这个方法，从而获取到对应的数据，然后填充到`#{}`解析后的问号占位符的位置。


```xml
<!-- int insertUser(User user); -->
<insert id="insertUser">
    insert into t_user values (null, #{username}, #{password}, #{age}, #{gender}, #{email})
</insert>
```

### 3.2.5 使用@Param标识参数

可以通过@Param注解标识mapper接口中的方法参数。此时，会将这些参数放在Map集合中，以@Param注解的value属性值为键，以参数为值，同时也以param1, param2...为键，以参数为值。只需要通过`${}`和`#{}`访问Map集合的键就可以获取相对应的值。

```java
int updateNameById(@Param("name") String name, @Param("id") Integer id);
```

```xml
<update id="updateNameById">
    update t_user set username = #{name} where id = #{id}
</update>
```

## 3.3 查询语句

> 注意：对于增删改操作，返回的结果是受影响的行数，用int或long接收即可。下面我们着重讨论查询语句的查询结果。

### 3.3.1 查询一个实体类对象

```xml
<!-- User getUserById(@Param("id") Integer id); -->
<select id="getUserById" resultType="User">
    select * from t_user where id = #{id}
</select>
```

注1：当查询的数据为多条时，不能使用实体类作为返回值，否则会抛出异常TooManyResultsException。

注2：查询的标签select必须设置属性resultType或resultMap，用于设置实体类和数据库表的映射关系。
- resultType：自动映射，用于属性名和表中字段名一致的情况
- resultMap：自定义映射，用于一对多或多对一或字段名和属性名不一致的情况

### 3.3.2 查询一个List集合

```xml
<!-- List<User> getAllUser(); -->
<select id="getAllUser" resultType="User">
    select * from t_user
</select>
```

> 如果查询结果是一个List集合，resultType中只需写泛型的类型即可(全类名或者别名)。

### 3.3.3 查询单个数据

```xml
<!-- Integer getCount(); -->
<select id="getCount" resultType="Integer">
    select count(*) from t_user
</select>
```

> 注意：在MyBatis中，对于Java中常用的类型都设置了类型别名。例如，若返回值为Integer，则resultType中可以写`Integer`、`int`(不区分大小写)；若返回值为int，则resultType中可以写`_Integer`、`_int`(不区分大小写)。当然写全类名如`java.lang.Integer`肯定也是没问题的。

### 3.3.4 查询一条数据为map集合

```xml
<!-- Map<String, Object> getUserByIdToMap(@Param("id") Integer id); -->
<select id="getUserByIdToMap" resultType="Map">
    select * from t_user where id = #{id}
</select>
```

### 3.3.5 查询多条数据为map集合

将表中的数据以map集合的方式查询，一条数据对应一个map；若有多条数据，就会产生多个map集合，此时可以将这些map放在一个list集合中获取。

```xml
<!-- List<Map<String, Object>> getAllUserToMap(); -->
<select id="getAllUserToMap" resultType="Map">
    select * from t_user
</select>
```

## 3.4 特殊SQL

### 3.4.1 模糊查询

**方式1(推荐)：**

```xml
<!-- List<User> getUserByLike(@Param("mohu") String mohu);-->
<select id="getUserByLike" resultType="User">
    select * from t_user where username like "%"#{mohu}"%"
</select>
```

**方式2：**

```xml
<select id="getUserByLike" resultType="User">
    select * from t_user where username like '%${mohu}%'
</select>
```

注意：不能使用`'%#{mohu}%'`，因为`#{}`本质上会被解析成`?`，而在引号内的`?`默认会被认为是字符串的一部分，而并不是占位符。

### 3.4.2 批量删除

```xml
<!-- void deleteMoreUser(@Param("ids") String ids);-->
<delete id="deleteMoreUser">
    delete from t_user where id in(${ids})
</delete>
```

注意：不能使用`in(#{ids})`，因为`#{ids}`本质是占位符赋值，例如`String ids = "1,2"`，则`in(#{ids})`会被解析为`in('1,2')`，这显然不对。而`in(${ids})`则会被正确的解析为`in(1,2)`。

### 3.4.3 动态设置表名

```xml
<!-- List<User> getUserList(@Param("tableName") String tableName);-->
<select id="getUserList" resultType="User">
    select * from ${tableName}
</select>
```

注意：显然表名不能用引号包裹，所以自然也无法使用`#{}`的方式。

### 3.4.4 主键回显

获取自增长的主键：

```xml
<!-- void insertUser(User user); -->
<insert id="insertUser" useGeneratedKeys="true" keyProperty="id">
    insert into t_user values (null, #{username}, #{password}, #{age}, #{gender}, #{email})
</insert>
```

- 设置`useGeneratedKeys="true"`表示使用主键回显功能
- keyProperty表明要将主键的值放在实体类对象的哪个属性中。必须设置该属性是因为，增删改操作统一的返回值是受影响的行数，因此**只能将获取的自增主键值放在传输的参数User对象的某个属性中**。

# 4. resultMap

## 4.1 处理字段和属性的映射

若数据库表中的字段名和实体类中的属性名不一致，我们有以下三种处理方法：

### 方式1：设置别名

为查询的字段来设置别名，和属性名保持一致

```xml
<!-- Emp getEmpByEmpId(@Param("empId") Integer empId); -->
<select id="getEmpByEmpId" resultType="Emp">
    select emp_id empId, emp_name empName, age, gender from t_emp where emp_id = #{empId}
</select>
```

### 方式2：配置下划线映射小驼峰

当字段符合MySQL的规范(即使用下划线连接)，而属性符合Java的规范(即使用小驼峰)，此时可以在MyBatis的核心配置文件中设置一个全局配置，从而自动将下划线映射为小驼峰。

```xml
<settings>
    <!-- 将下划线映射为驼峰 -->
    <setting name="mapUnderscoreToCamelCase" value="true"/>
</settings>
```

只要满足该命名规范并进行了上述全局配置，则正常编写sql语句即可：

```xml
<select id="getEmpByEmpId" resultType="Emp">
    select * from t_emp where emp_id = #{empId}
</select>
```

### 方式3：使用resultMap自定义映射

我们首先使用resultMap自定义映射关系，属性`id`唯一标识了该resultMap，属性`type`则表示需要定义映射的实体类。常用子标签如下：

- id：设置主键的映射关系
- result：设置普通字段的映射关系
- association：设置多对一的映射关系
- collection：设置一对多的映射关系

这些子标签中的属性`column`表示映射关系中数据库表中的字段名，而`property`表示映射关系中实体类中的属性名。

```xml
<resultMap id="empResultMap" type="Emp">
    <!-- id来处理主键的映射关系 -->
    <id column="emp_id" property="empId"></id>
    <!-- result来处理普通字段的映射关系 -->
    <result column="emp_name" property="empName"></result>
    <result column="age" property="age"></result>
    <result column="gender" property="gender"></result>
</resultMap>
```

然后，我们在编写sql语句时，只需要在属性`resultMap`中指定自定义映射的唯一标识id即可：

```xml
<select id="getEmpByEmpId" resultMap="empResultMap">
    select * from t_emp where emp_id = #{empId}
</select>
```

## 4.2 处理多对一映射

**对一关系，指的是查询出来的多个字段只对应于实体类对象的一个属性**。例如一个Emp类中有一个属性`private Dept dept;`用于表示所在部门的信息，那么我们查询出来的关于部门的信息(如部门id，部门名称等多个字段)就需要封装到一个部门对象中，然后对应到Emp类的dept属性。

处理多对一映射的方式有以下3种：

### 方式1：级联

利用resultMap自定义映射结合多表查询的sql语句，注意其中关于部门的属性名，直接用`dept.deptId`的方式，这就是级联。

```xml
<!-- Emp getEmpAndDeptByEmpId(@Param("empId") Integer empId); -->
<resultMap id="empAndDeptResultMap" type="Emp">
    <id column="emp_id" property="empId"></id>
    <result column="emp_name" property="empName"></result>
    <result column="age" property="age"></result>
    <result column="gender" property="gender"></result>
    <result column="dept_id" property="dept.deptId"></result>
    <result column="dept_name" property="dept.deptName"></result>
</resultMap>

<select id="getEmpAndDeptByEmpId" resultMap="empAndDeptResultMap">
    select t_emp.*, t_dept.*
    from t_emp left join t_dept
    on t_emp.dept_id = t_dept.dept_id
    where t_emp.emp_id = #{empId}
</select>
```

### 方式2：association

association可以处理多对一的映射关系，注意association用于处理实体类类型的属性。

```xml
<resultMap id="empAndDeptResultMap" type="Emp">
    <id column="emp_id" property="empId"></id>
    <result column="emp_name" property="empName"></result>
    <result column="age" property="age"></result>
    <result column="gender" property="gender"></result>
    <association property="dept" javaType="Dept">
        <id column="dept_id" property="deptId"></id>
        <result column="dept_name" property="deptName"></result>
    </association>
</resultMap>

<select id="getEmpAndDeptByEmpId" resultMap="empAndDeptResultMap">
    select t_emp.*, t_dept.*
    from t_emp left join t_dept
    on t_emp.dept_id = t_dept.dept_id
    where t_emp.emp_id = #{empId}
</select>
```

说明：association标签的属性property指明了要处理的Emp类中的属性名是dept，javaType指明了该属性名的实体类类型是Dept。然后在子标签中，指明查询字段和Dept类中的属性之间的对应关系。

### 方式3：分步查询

不再通过多表查询从一条sql语句中获取所有信息，而是分成多步来查询，具体而言：第一步是在员工表中查询员工信息，第二步是根据所查到的`dept_id`再到部门表中查询该部门的信息。


## 4.3 处理一对多映射

**对多关系，指的是实体类对象的一个属性，对应多条查询记录**。例如Dept类中有一个属性`private List<Emp> emps;`用于表示该部门所有员工的信息，那么我们查询出来的多条记录中，关于员工信息的字段就需要封装到该属性中。

处理一对多映射的方式有以下2种：

### 方式1：collection

collection可以处理一对多的映射关系，注意collection用于处理集合类型的属性。

```xml
<resultMap id="deptAndEmpResultMap" type="Dept">
    <id column="dept_id" property="deptId"></id>
    <result column="dept_name" property="deptName"></result>
    <!-- ofType用于设置集合类型的属性中存储的数据的类型 -->
    <collection property="emps" ofType="Emp">
        <id column="emp_id" property="empId"></id>
        <result column="emp_name" property="empName"></result>
        <result column="age" property="age"></result>
        <result column="gender" property="gender"></result>
    </collection>
</resultMap>

<select id="getDeptAndEmpByDeptId" resultMap="deptAndEmpResultMap">
    select t_dept.*, t_emp.*
    from t_dept left join t_emp
    on t_dept.dept_id = t_emp.dept_id
    where t_dept.dept_id = #{deptId}
</select>
```

说明：collection标签的属性property指明了要处理的Dept类中的属性名是emps，ofType指明了该属性是一个集合，其中的每个对象的类型是Emp。然后在子标签中，指明查询字段和Emp类中的属性之间的对应关系。

### 方式2：分步查询

不再通过多表查询从一条sql语句中获取所有信息，而是分成多步来查询，具体而言：第一步是在部门表中查询部门信息，第二步是根据部门id，到员工表中查询相关员工信息。

## 4.4 拓展：resultMap简化

在MyBatis核心配置文件中添加如下配置，可以简化resultMap，也就是在resultMap中可以省略符合驼峰映射规则的**result子标签**：

```xml
<!--开启resultMap自动映射 -->
<setting name="autoMappingBehavior" value="FULL"/>
```

此时，4.2节方式2中的resultMap，可以简写为如下形式：

```xml
<resultMap id="empAndDeptResultMap" type="Emp">
    <id column="emp_id" property="empId"></id>
    <!-- <result column="emp_name" property="empName"></result>
    <result column="age" property="age"></result>
    <result column="gender" property="gender"></result> -->
    <association property="dept" javaType="Dept">
        <id column="dept_id" property="deptId"></id>
        <!-- <result column="dept_name" property="deptName"></result> -->
    </association>
</resultMap>
```

# 5. 动态SQL

MyBatis的动态SQL技术是一种根据特定条件动态拼装SQL语句的功能。

## 5.1 if标签

if标签可以通过test属性的表达式（这是一种OGNL表达式）进行判断，若表达式的结果为true，则if标签中的内容会拼接到SQL中。**注意在test属性的表达式中只可以访问实体类的属性，而不可以访问数据库表的字段**。

```xml
<!-- List<Emp> getEmpByCondition(Emp emp); -->
<select id="getEmpByCondition" resultType="Emp">
    select * from t_emp where 1 = 1
    <if test="empName != null and empName != ''">
        and emp_name = #{empName}
    </if>
    <if test="age != null">
        and age = #{age}
    </if>
    <if test="gender != null">
        and gender = #{gender}
    </if>
</select>
```

> 说明：如果仅使用if标签，为了拼接不产生问题，一般都需要在where后添加`1=1`之类的恒成立条件。

## 5.2 where标签

where标签一般结合if标签一起使用：

- 若where标签中有条件成立，会自动生成where关键字
- 若where标签中没有任何一个条件成立，则where没有任何功能，即不会生成where关键字
- 会自动将where标签中拼接完后的内容前多余的and/or去掉，但是内容后多余的and/or无法去掉

```xml
<select id="getEmpByCondition" resultType="Emp">
    select * from t_emp
    <where>
        <if test="empName != null and empName != ''">
            and emp_name = #{empName}
        </if>
        <if test="age != null">
            and age = #{age}
        </if>
        <if test="gender != null">
            and gender = #{gender}
        </if>
    </where>
</select>
```

## 5.3 trim标签

对于在trim标签中拼接完后的内容，可以设置属性来在前面或后面添加或删除一些内容：

- prefix、suffix：在内容前面或后面添加指定内容(如果标签中的if条件都不满足，则不会添加前后缀)
- prefixOverrides、suffixOverrides：在内容前面或后面去掉指定内容，可以使用`|`来分隔有可能的多个值

```xml
<select id="getEmpByCondition" resultType="Emp">
    select * from t_emp
    <trim prefix="where" suffixOverrides="and">
        <if test="empName != null and empName != ''">
            emp_name = #{empName} and
        </if>
        <if test="age != null">
            age = #{age} and
        </if>
        <if test="gender != null">
            gender = #{gender} and
        </if>
    </trim>
</select>
```

## 5.4 choose、when、otherwise标签

在多个分支条件中，仅执行一个：

- 从上到下依次执行条件判断
- 遇到的第一个满足条件的分支会被采纳
- 被采纳分支后面的分支都将不被考虑
- 如果所有的when分支都不满足，那么就执行otherwise分支

when就相当于if/else if，而otherwise就相当于else。所以when至少设置一个，otherwise最多设置一个。

```xml
<!-- List<Emp> getEmpByChoose(Emp emp); -->
<select id="getEmpByChoose" resultType="Emp">
    select * from t_emp
    <where>
        <choose>
            <when test="empName != null and empName != ''">
                emp_name = #{empName}
            </when>
            <when test="age != null">
                age = #{age}
            </when>
            <when test="gender != null">
                gender = #{gender}
            </when>
        </choose>
    </where>
</select>
```

## 5.5 foreach标签

foreach标签的属性：
- collection：设置要循环的数组或集合
- item：表示在迭代过程中每一个元素的别名。对于List或数组，代表每个元素值；对于Map，代表每个键值对的value值。
- index：表示在迭代过程中的位置。对于List或数组，代表每个元素的下标值；对于Map，代表每个键值对的key值。
- separator：设置每次循环的数据之间的分隔符（分隔符的前后会默认添加一个空格，所以可以放心设置`"or"`这样的分隔符，无需自己手动添加空格）
- open：给全部循环完成后的内容添加前缀
- close：给全部循环完成后的内容添加后缀


### 5.5.1 批量插入

```xml
<!-- void insertMoreEmp(@Param("emps") List<Emp> emps); -->
<insert id="insertMoreEmp">
    insert into t_emp values
    <foreach collection="emps" item="emp" separator=",">
        <!-- 在foreach标签内部如果需要引用遍历的每个具体对象，则需要使用item属性声明名称 -->
        (null, #{emp.empName}, #{emp.age}, #{emp.gender}, null)
    </foreach>
</insert>
```

### 5.5.2 批量更新

上面批量插入的例子本质上是一条SQL语句，而实现批量更新则需要多条SQL语句拼起来，用分号分开。也就是一次性发送多条SQL语句让数据库执行，此时需要在数据库连接信息的URL地址中设置参数`?allowMultiQueries=true`。对应的foreach标签如下：

```xml
<!-- int updateEmployeeBatch(@Param("empList") List<Emp> empList); -->
<update id="updateEmployeeBatch">
    <foreach collection="empList" item="emp" separator=";">
        update t_emp set emp_name=#{emp.empName} where emp_id = #{emp.empId}
    </foreach>
</update>
```

### 5.5.3 批量删除

方式1：

```xml
<!-- void deleteMoreEmp(@Param("empIds") Integer[] empIds); -->
<delete id="deleteMoreEmp">
    delete from t_emp where emp_id in
    <foreach collection="empIds" item="empId" separator="," open="(" close=")">
        #{empId}
    </foreach>
</delete>
```

方式2：

```xml
<delete id="deleteMoreEmp">
    delete from t_emp where
    <foreach collection="empIds" item="empId" separator="or">
        emp_id = #{empId}
    </foreach>
</delete>
```

## 5.6 sql标签

sql标签可以记录一段公共的sql片段，在使用的地方通过include标签进行引入即可。

```xml
<!-- List<Emp> getAllEmp(); -->
<sql id="empColumns">
    emp_id, emp_name, age, gender, dept_id
</sql>
<select id="getAllEmp" resultType="Emp">
    select <include refid="empColumns"></include>
    from t_emp
</select>
```

## 5.7 set标签

案例场景：实际开发时，要对一个实体类对象进行更新，但往往不是更新所有字段，而是只更新一部分字段。此时页面上的表单往往只会给需要修改的字段提供表单项。如果我们直接拿整个Emp对象去更新数据库，那么某些在表单项上没有的字段则会被更新为null，这显然是不符合需求的。所以我们需要在Mapper映射文件中对update语句的set子句进行定制，这时候就可以使用动态SQL的set标签。

```xml
<!-- void updateEmployeeDynamic(Emp emp); -->
<update id="updateEmployeeDynamic">
    update t_emp
    <!-- set emp_name = #{empName}, emp_salary = #{empSalary} -->
    <!-- 使用set标签动态管理set子句，可以自动去掉两端多余的逗号 -->
    <set>
        <if test="empName != null and empName != ''">
            emp_name = #{empName},
        </if>
        <if test="empSalary &lt; 3000">
            emp_salary = #{empSalary},
        </if>
    </set>
    where emp_id = #{empId}
</update>
```

# 6. Mybatis缓存

## 6.1 一级缓存

**一级缓存是SqlSession级别的**，通过同一个SqlSession查询的数据会被缓存，下次查询相同的数据，就会从缓存中直接获取，不会从数据库重新访问。Mybatis的一级缓存是默认开启的。

**使一级缓存失效的五种情况**：

1. 不同的SqlSession对应不同的一级缓存
2. 同一个SqlSession但是查询条件不同
3. 同一个SqlSession两次查询期间执行了任何一次增删改操作(增删改操作会自动清空一级、二级缓存)
4. 同一个SqlSession两次查询期间手动清空了缓存(`sqlSession.clearCache();`)
5. 同一个SqlSession两次查询期间提交了事务

## 6.2 二级缓存

**二级缓存是SqlSessionFactory级别**，通过同一个SqlSessionFactory创建的SqlSession查询的结果会被缓存；此后若再次执行相同的查询语句，结果就会从缓存中获取。

**二级缓存开启的条件**：

1. 在核心配置文件中，设置全局配置属性`cacheEnabled="true"`，由于其默认为true，所以我们不需要设置
2. 在Mapper映射文件中设置标签`<cache></cache>`
3. 二级缓存必须在SqlSession关闭之后有效（因为SqlSession关闭之后，一级缓存中的数据才会写入二级缓存）
4. 查询的数据所转换的实体类类型必须实现序列化接口

**使二级缓存失效的情况**：

- 两次查询之间执行了任意的增删改，会使一级和二级缓存同时失效

**二级缓存的相关配置**

在mapper映射文件中添加的cache标签可以设置一些属性：

- eviction属性：缓存回收策略，默认是LRU
- flushInterval属性：刷新间隔，单位毫秒。默认情况是不设置，也就是没有刷新间隔，缓存仅仅调用语句时刷新。
- size属性：正整数，代表缓存最多可以存储多少个对象，太大容易导致内存溢出。
- readOnly属性：只读， true/false。
  - true：只读缓存，会给所有调用者返回缓存对象的相同实例。因此这些对象不能被修改，这提供了很重要的性能优势。
  - false：读写缓存，会返回缓存对象的拷贝（通过序列化）。这会慢一些，但是安全，因此默认是false。

## 6.3 MyBatis缓存查询的顺序

MyBatis缓存查询的顺序是：

- 先查询二级缓存，因为二级缓存中可能会有其他程序已经查出来的数据，可以拿来直接使用。
- 如果二级缓存没有命中，再查询一级缓存
- 如果一级缓存也没有命中，则查询数据库
- SqlSession关闭之后，一级缓存中的数据会写入二级缓存

# 7. 逆向工程

MyBatis的逆向工程是一种**自动化生成持久层代码和映射文件的工具**，它可以根据数据库表结构生成对应的实体类、Mapper映射文件、Mapper接口等代码。**注意：逆向工程只能生成单表的crud，多表查询依然需要我们自己编写**。

（1）安装MyBatisX插件

![](images/20230912214531.png)

（2）IDEA中连接数据库

![](images/20230912214812.png)

![](images/20230912215106.png)

![](images/20230912215432.png)

（3）选择要逆向生成的表，右键使用MyBatis插件即可

![](images/20230912215615.png)

![](images/20230912215915.png)

![](images/20230912220227.png)

# 8. 分页插件

## 8.1 插件机制

MyBatis对插件进行了标准化的设计，提供了一套可扩展的插件机制。插件可以在语句执行过程中进行拦截，并允许通过自定义处理程序来拦截和修改SQL语句。底层实际上是使用JDK动态代理，为需要拦截的接口生成代理对象来实现的。

如果我们想自定义插件，则只需要实现Interceptor接口并重写`intercept()`方法，然后使用注解`@Intercepts`来标注需要拦截的接口方法，最后在MyBatis的核心配置文件中配置我们编写的插件即可。

> PageHelper是MyBatis中著名的分页插件，它支持多种数据库。

## 8.2 PageHelper的配置

添加依赖

```xml
<dependency>
    <groupId>com.github.pagehelper</groupId>
    <artifactId>pagehelper</artifactId>
    <version>5.2.0</version>
</dependency>
```

在MyBatis核心配置文件中配置插件

```xml
<plugins>
    <!--设置分页插件-->
    <plugin interceptor="com.github.pagehelper.PageInterceptor">
        <property name="helperDialect" value="mysql"/>
    </plugin>
</plugins>
```

其中，com.github.pagehelper.PageInterceptor 是 PageHelper 插件的名称，helperDialect属性用于指定数据库类型（因为分页插件支持多种数据库）

## 8.3 PageHelper的使用

（1）在查询之前使用`PageHelper.startPage(int pageNum, int pageSize)`开启分页功能

- pageNum：第几页（页码从1开始递增）
- pageSize：每页的记录数

**注意**：开启分页功能后，就会在SQL语句后面自动**附加LIMIT子句**并查询**总记录数**（所以自己写的SQL语句一定不能以分号`;`结尾）。分页功能对原有的Mapper接口、SQL语句没有任何影响，这个效果称之为非侵入式，也可以说是可插拔的。

> 自动附加其实就是`LIMIT index, pageSize`子句，其中`index=(pageNum-1)*pageSize`

（2）然后正常使用SQL语句查询，获取对象的List集合

（3）接下来使用PageInfo封装分页相关数据

```java
// list是分页查询得到的数据，navigatePages是导航分页的页码数
PageInfo<T> pageInfo = new PageInfo<>(List<T> list, int navigatePages);
```

PageInfo中的分页相关数据有：

```java
PageInfo{
pageNum=8, pageSize=4, size=2, startRow=29, endRow=30, total=30, pages=8,
list=Page{count=true, pageNum=8, pageSize=4, startRow=28, endRow=32, total=30,
pages=8, reasonable=false, pageSizeZero=false},
prePage=7, nextPage=0, isFirstPage=false, isLastPage=true, hasPreviousPage=true,
hasNextPage=false, navigatePages=5, navigateFirstPage4, navigateLastPage8,
navigatepageNums=[4, 5, 6, 7, 8]
}
```

- pageNum：当前页的页码
- pageSize：每页的记录数
- size：当前页显示的真实记录数
- total：总记录数
- pages：总页数
- prePage：上一页的页码
- nextPage：下一页的页码
- isFirstPage/isLastPage：是否为第一页/最后一页
- hasPreviousPage/hasNextPage：是否存在上一页/下一页
- navigatePages：导航分页的页码数
- navigatepageNums：导航分页的页码，例如`[1,2,3,4,5]`

**举例**：

```java
@Test
public void testPageHelper() {
    // 省略获取sqlSession的步骤
    TeacherMapper teacherMapper = session.getMapper(TeacherMapper.class);

    // 1. 开启分页功能，查第8页，每页4条数据
    PageHelper.startPage(8, 4);
    // 2. 正常进行查询
    List<Teacher> allTeachers = teacherMapper.findAllTeachers();
    // 3. 封装分页相关数据
    PageInfo<Teacher> pageInfo = new PageInfo<>(allTeachers, 5);

    System.out.println("pageInfo = " + pageInfo);
    long total = pageInfo.getTotal(); // 获取总记录数
    System.out.println("total = " + total);
    int pages = pageInfo.getPages();  // 获取总页数
    System.out.println("pages = " + pages);
    int pageNum = pageInfo.getPageNum(); // 获取当前页码
    System.out.println("pageNum = " + pageNum);
    int pageSize = pageInfo.getPageSize(); // 获取每页的记录数
    System.out.println("pageSize = " + pageSize);
    List<Teacher> teachers = pageInfo.getList(); // 获取查询页的数据集合
    teachers.forEach(System.out::println);
}
```
