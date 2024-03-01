## 第1章：JDBC概述

### 1.1 数据的持久化

持久化(persistence)：**把数据保存到可掉电式存储设备中以供之后使用**。大多数情况下，特别是企业级应用，**数据持久化意味着将内存中的数据保存到硬盘**上加以”固化”**，而持久化的实现过程大多通过各种关系数据库来完成**。

### 1.2 Java中的数据存储技术

在Java中，数据库存取技术可分为如下几类：
  - **JDBC**直接访问数据库
  - JDO (Java Data Object )技术
  - **第三方O/R工具**，如Hibernate, Mybatis 等

JDBC是java访问数据库的基石，JDO、Hibernate、MyBatis等只是更好的封装了JDBC。

### 1.3 JDBC介绍

- JDBC(Java Database Connectivity)是一个**独立于特定数据库管理系统、通用的SQL数据库存取和操作的公共接口**（一组API），定义了用来访问数据库的标准Java类库，（**java.sql, javax.sql**）使用这些类库可以以一种**标准**的方法、方便地访问数据库资源。
- JDBC为访问不同的数据库提供了一种**统一的途径**，为开发者屏蔽了一些细节问题。
- JDBC的目标是使Java程序员使用JDBC可以连接任何**提供了JDBC驱动程序**的数据库系统，这样就使得程序员无需对特定的数据库系统的特点有过多的了解，从而大大简化和加快了开发过程。

### 1.4 JDBC体系结构

JDBC接口（API）包括两个层次：
- **面向应用的API**：Java API，抽象接口，供应用程序开发人员使用（连接数据库，执行SQL语句，获得结果）。
-  **面向数据库的API**：Java Driver API，供开发商开发数据库驱动程序用。

> **JDBC是sun公司提供一套用于数据库操作的接口，java程序员只需要面向这套接口编程即可。**
>
> **不同的数据库厂商，需要针对这套接口，提供不同实现。不同的实现的集合，即为不同数据库的驱动。	——面向接口编程**

### 1.5 JDBC程序编写的基本步骤

1. 注册驱动
2. 获取连接
3. 创建发送sql语句的对象
4. 发送sql语句，并获取返回结果
5. 结果集解析
6. 资源关闭

## 第2章：获取数据库连接

### 2.1 连接方式1

```java
package com.thuwsy.jdbctest;

import com.mysql.cj.jdbc.Driver;
import java.sql.*;

public class ConnectionTest {
    public static void main(String[] args) throws SQLException {
        // 1. 加载并注册驱动
        Class.forName("com.mysql.cj.jdbc.Driver");

        // 2. 获取连接
        Connection connection = DriverManager.
                getConnection("jdbc:mysql:///atguigu", "root", "abc666");

        // 关闭资源
        connection.close();
    }
}
```

#### 2.1.1 加载并注册驱动

**Driver接口介绍**

java.sql.Driver 接口是所有 JDBC 驱动程序需要实现的接口。这个接口是提供给数据库厂商使用的，不同数据库厂商提供不同的实现。

在程序中不需要直接去访问实现了 Driver 接口的类，而是由**驱动程序管理器类**(java.sql.DriverManager)去调用这些Driver实现。
  - Oracle的驱动：oracle.jdbc.driver.OracleDriver
  - mySql的驱动：com.mysql.jdbc.Driver

在当前模块下新建一个lib目录，将jar包`mysql-connector-java-8.0.27-bin`拷贝到该lib目录下并添加依赖。

注意：如果是Dynamic Web Project（动态的web项目），则是在WEB-INF目录下新建一个lib目录

**加载驱动**

加载 JDBC 驱动需调用 Class 类的静态方法 forName()，向其传递要加载的 JDBC 驱动的类名。注意mysql驱动版本8+应该导入com.mysql.cj.jdbc.Driver

```java
Class.forName("com.mysql.cj.jdbc.Driver");
```

**注册驱动**

加载驱动后，由于Driver接口的驱动程序类都包含了一个静态代码块，该静态代码块中会调用 `DriverManager.registerDriver()` 方法来注册自身的一个实例，所以无需程序员自己手动注册驱动。

#### 2.1.2 获取连接

调用`DriverManager.getConnection()`，它是一个重载的方法，有以下几种参数列表：


**三个参数(常用)**：`(String url, String user, String password)`

user即数据库账号，password即数据库密码。url则是包含数据库的相关信息，格式如下：

```
jdbc:mysql://ip:port/数据库名?key=value&key=value
```

如果数据库软件在本机，且端口号是3306，则可以用以下简略的写法：

```
jdbc:mysql:///数据库名
```

注意：`?`后面可以添加一些可选的参数信息，如

```
serverTimezone=Asia/Shanghai&useUnicode=true&characterEncoding=utf8&useSSL=true
```

驱动版本在8.0.25之后会自动识别时区，而字符编码等信息在版本8.0之后都会默认添加。所以使用最新版本的驱动，无需添加以上信息。

**两个参数**：`(String url, Properties info)`

url作用与上述相同。Properties集合中存储账号和密码等信息，所以至少要包含两个键值对`user=账号`和`password=密码`。举例如下：

```java
Properties info = new Properties();
info.put("user", "root");
info.put("password", "abc666");
Connection connection1 = DriverManager.getConnection("jdbc:mysql:///atguigu", info);
```

**一个参数**：`(String url)`

直接在`?`后面传递账号和密码等信息，如

```
jdbc:mysql:///atguigu?user=root&password=abc666
```


### 2.2 连接方式2(开发中更常用)

我们在src目录下添加一个配置文件`jdbc.properties`，用于保存配置信息，然后在代码中读取配置信息。

```properties
driverClass=com.mysql.cj.jdbc.Driver
url=jdbc:mysql://127.0.0.1:3306/atguigu
user=root
password=abc666
```

```java
package com.thuwsy.jdbctest;

import java.io.InputStream;
import java.sql.*;
import java.util.*;

public class ConnectionTest {
    public static void main(String[] args) throws Exception {
        // 读取配置文件中的信息(将属性文件jdbc.properties放在src目录下)
        InputStream is = ClassLoader.getSystemClassLoader()
                .getResourceAsStream("jdbc.properties");
        Properties properties = new Properties();
        properties.load(is);

        String driverClass = properties.getProperty("driverClass");
        String url = properties.getProperty("url");
        String user = properties.getProperty("user");
        String password = properties.getProperty("password");

        // 加载并注册驱动
        Class.forName(driverClass);
        // 获取连接
        Connection conn = DriverManager.getConnection(url, user, password);
		// 关闭资源
        conn.close();
        is.close();
    }
}
```

>
> **使用配置文件的好处：**
>
> 1.实现了代码和数据的分离，如果需要修改配置信息，直接在配置文件中修改，不需要深入代码
> 2.如果修改了配置信息，省去重新编译的过程。

## 第3章：使用PreparedStatement实现CRUD操作

### 3.1 操作和访问数据库

数据库连接被用于向数据库服务器发送命令和 SQL 语句，并接受数据库服务器返回的结果。其实一个数据库连接就是一个Socket连接。

在 java.sql 包中有 3 个接口分别定义了对数据库的调用的不同方式：
  - Statement：用于执行静态 SQL 语句并返回它所生成结果的对象（不推荐使用）
  - PreparedStatement：SQL 语句被预编译并存储在此对象中，可以使用此对象多次高效地执行该语句。
  - CallableStatement：用于执行 SQL 存储过程


### 3.2 使用Statement操作数据表的弊端

通过调用 Connection 对象的 createStatement() 方法创建该对象。该对象用于执行静态的 SQL 语句，并且返回执行结果。

案例：基于Statement模拟用户登录

```java
public static void main(String[] args) throws Exception {
    Scanner sc = new Scanner(System.in);
    System.out.println("请输入账号");
    String account = sc.nextLine();
    System.out.println("请输入密码");
    String password = sc.nextLine();

    // 注册驱动
    Class.forName("com.mysql.cj.jdbc.Driver");
    // 获取连接
    Connection connection = DriverManager.
            getConnection("jdbc:mysql:///atguigu", "root", "abc666");
    // 创建statement
    Statement statement = connection.createStatement();

    // 发送sql语句，并且获取返回结果
    String sql = "select * from t_user where account = '"
            + account + "' && password = '" + password + "';";
    ResultSet resultSet = statement.executeQuery(sql);

    // 进行结果集解析
    boolean flag = false;
    while (resultSet.next()) {
        flag = true;
        System.out.println("登录成功！你的信息如下：");
        int id = resultSet.getInt("id");
        String account1 = resultSet.getString("account");
        String password1 = resultSet.getString("password");
        String nickname = resultSet.getString("nickname");
        System.out.println(id+"--"+account1+"--"+password1+"--"+nickname);
    }
    if (!flag) System.out.println("登录失败！");

    // 关闭资源
    resultSet.close();
    statement.close();
    connection.close();
}
```

警告：这种实现是不安全的，比如在密码部分输入`' or '1' = '`，则始终会登录成功，这就称为注入攻击。因此Statement只能支持没有动态值的SQL语句。

总结：使用Statement操作数据表存在弊端

  - **问题一：存在拼串操作，繁琐**
  - **问题二：存在SQL注入问题**

对于 Java 而言，要防范 SQL 注入，只要用 PreparedStatement 取代 Statement 就可以了。不仅如此，PreparedStatement还能对预编译的SQL语句进行优化，提高性能。


### 3.3 PreparedStatement的使用

**PreparedStatement 接口是 Statement 的子接口，它表示一条预编译过的 SQL 语句**。可以通过调用 Connection 对象的 `preparedStatement(String sql)` 方法获取 PreparedStatement 对象。

使用步骤：

1. 编写SQL语句，动态值部分用占位符`?`替代
2. 创建PreparedStatement对象，参数传入SQL语句
3. 给占位符`?`赋值：调用`setObject(int index, Object val)`方法
4. 发送SQL语句，并获取返回结果

```java
// 编写SQL语句
String sql = "select * from t_user where account = ? && password = ? ;";
// 调用connection.prepareStatement(sql)创建PreparedStatement对象
PreparedStatement ps = connection.prepareStatement(sql);
// 给占位符赋值，占位符索引从1开始，占位符的值可以是任意数据类型
ps.setObject(1, account);
ps.setObject(2, password);
// 发送SQL语句(该方法无需参数)
ResultSet resultSet = ps.executeQuery();
```

- 如果发送的是DQL语句，则调用`ResultSet executeQuery()`方法，返回查询的结果集
- 如果发送的不是DQL语句，则调用`int executeUpdate()`方法，返回影响的行数

**补充**：sql语句分类：DDL(容器创建，修改，删除)，DML(插入，修改，删除)，DQL(查询)，DCL(权限控制)，TCL(事务控制语言)


### 3.4 ResultSet与ResultSetMetaData

#### 3.4.1 ResultSet

**ResultSet结果集解析**：

首先，我们需要移动游标指定获取数据行。

- ResultSet内部包含一个游标，用于指向当前行的数据。默认游标指向的是第一行数据之前。
- 调用next()方法：如果有下一行数据，则游标向下移动一行，并返回true；如果没有下一行数据，则有效不移动，并返回false
- 一般我们用while循环配合next()方法来获取每一行数据

其次，我们要获取游标指定的行的列数据。

- 调用`getXxx(参数)`方法，可以根据字段获取数据，其中Xxx是数据类型，如String，Int等
- 该方法有两个重载：一种参数是`(String columnLabel)`，即根据字段名获取(如果有别名，则要写别名)；另一种参数是`(int columnIndex)`，即根据列的下标获取，从1开始

```java
public static void main(String[] args) throws Exception {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql:///atguigu", "root", "abc666");

	String sql = "select id, `name`, hire_date from emps where id < ?;";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setObject(1, 100);

	ResultSet rs = ps.executeQuery();
	while (rs.next()) {
		int id = rs.getInt("id");
		String name = rs.getString("name");
		Date hireDate = rs.getDate("hire_date");
		System.out.println(id + ", " + name + ", " + hireDate);
	}
	rs.close();
	ps.close();
	conn.close();
}
```

#### 3.4.2 ResultSetMetaData

事实上，我们很少从数据库中获取数据后直接打印到控制台，而是将其封装到一个对象中，即ORM思想(object relational mapping)：
- 一个数据表对应一个java类
- 表中的一条记录对应java类的一个对象
- 表中的一个字段对应java类的一个属性

  > 注意如果sql的字段名与java类的属性名不一致时，在编写SQL查询语句时一定要起别名，让别名和java类的属性名相同。

```java
class Person {
    private int id;
    private String name;
    private Date hireDate;

    public Person() {
    }
    public Person(int id, String name, Date hireDate) {
        this.id = id;
        this.name = name;
        this.hireDate = hireDate;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public Date getHireDate() {
        return hireDate;
    }
    public void setHireDate(Date hireDate) {
        this.hireDate = hireDate;
    }
    @Override
    public String toString() {
        return "Person{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", hireDate=" + hireDate +
                '}';
    }
}
```

除此之外，我们还需要使用ResultSetMetaData对象(结果集元数据)，它保存了结果集中列的类型和属性信息。我们可以通过结果集的`rs.getMetaData();`方法来获取结果集元数据对象。ResultSetMetaData提供了以下方法：

- `getColumnName(int index)`：获取列的名称(不推荐使用)
- `getColumnLabel(int index)`：获取列的别名
- `getColumnCount()`：获取列的总数

```java
public static void main(String[] args) throws Exception {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql:///atguigu", "root", "abc666");

	// 字段名与Java类中的属性名不一致时，一定要起别名
	String sql = "select id, `name`, hire_date hireDate from emps where id < ?;";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setObject(1, 100);

	ResultSet rs = ps.executeQuery();
	// 获取结果集元数据对象，并获取列的总数
	ResultSetMetaData rsmd = rs.getMetaData();
	int columnCount = rsmd.getColumnCount();
	// 每一行数据对应一个Person类的实例，将总的Person对象存储到一个集合中
	List<Person> list = new ArrayList<>();
	while (rs.next()) {
		Person p = new Person();
		for (int i = 1; i <= columnCount; i++) {
			// 获取列的别名
			String columnLabel = rsmd.getColumnLabel(i);
			// 获取对应的值
			Object columnValue = rs.getObject(i);
			// 通过反射，给Person对象对应的属性赋值
			Field field = Person.class.getDeclaredField(columnLabel);
			field.setAccessible(true);
			field.set(p, columnValue);
		}
		list.add(p);
	}
	for (Person person : list)
		System.out.println(person);

	rs.close();
	ps.close();
	conn.close();
}
```

#### 3.4.3 Java与SQL对应数据类型转换表

| Java类型           | SQL类型                  |
| ------------------ | ------------------------ |
| boolean            | BIT                      |
| byte               | TINYINT                  |
| short              | SMALLINT                 |
| int                | INTEGER                  |
| long               | BIGINT                   |
| String             | CHAR,VARCHAR,LONGVARCHAR |
| byte   array       | BINARY  ,    VAR BINARY  |
| java.sql.Date      | DATE                     |
| java.sql.Time      | TIME                     |
| java.sql.Timestamp | TIMESTAMP                |

### 3.5 资源的释放

释放ResultSet, Statement, Connection。可以在finally中关闭，保证及时其他代码出现异常，资源也一定能被关闭。


## 第4章：拓展操作

### 4.1 操作BLOB类型字段

#### 4.1.1 MySQL BLOB类型

- MySQL中，BLOB是一个二进制大型对象，是一个可以存储大量数据的容器，它能容纳不同大小的数据。
- 插入BLOB类型的数据必须使用PreparedStatement，因为BLOB类型的数据无法使用字符串拼接写的。

#### 4.1.2 向数据表中插入大数据类型

```java
String sql = "insert into customers(name,email,birth,photo)values(?,?,?,?)";
PreparedStatement ps = conn.prepareStatement(sql);

// 填充占位符
ps.setString(1, "徐海强");
ps.setString(2, "xhq@126.com");
ps.setDate(3, new Date(new java.util.Date().getTime()));
// 操作Blob类型的变量
FileInputStream fis = new FileInputStream("xhq.png");
ps.setBlob(4, fis);
//执行
ps.executeUpdate();
		
fis.close();
ps.close();
```

#### 4.1.3 修改数据表中的Blob类型字段

```java
// 操作Blob类型的变量
FileInputStream fis = new FileInputStream("coffee.png");
ps.setBlob(1, fis);
ps.executeUpdate();
```

#### 4.1.4 从数据表中读取大数据类型

```java
//读取Blob类型的字段
Blob photo = rs.getBlob(5);
InputStream is = photo.getBinaryStream();
OutputStream os = new FileOutputStream("c.jpg");
byte [] buffer = new byte[1024];
int len = 0;
while((len = is.read(buffer)) != -1){
	os.write(buffer, 0, len);
}
```

### 4.2 自增长主键回显实现

java程序获取插入数据时mysql维护的自增长的主键值，这就是主键回显。

作用：在多表关联插入数据时，一般主表的主键都是自动生成的，所以在插入数据之前无法知道这条数据的主键，但是从表需要在插入数据之前就绑定主表的主键，这时就可以使用主键回显技术。

```java
public static void main(String[] args) throws Exception {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql:///atguigu", "root", "abc666");
    String sql = "insert into t_user (account, password, nickname) values (?, ?, ?);";

    // 创建PreparedStatement对象时，调用重载的双参数构造器，告诉它携带回数据库自增长的主键
    PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
    ps.setObject(1, "test1");
    ps.setObject(2, "123456");
    ps.setObject(3, "驴蛋蛋");

    int i = ps.executeUpdate();
    if (i > 0) {
        System.out.println("插入数据成功");
        // 获取回显主键的结果集对象，它是一行一列的
        ResultSet rs = ps.getGeneratedKeys();
        rs.next();
        int id = rs.getInt(1);
        System.out.println("id=" + id);
        rs.close();
    } else {
        System.out.println("插入数据失败");
    }
    ps.close();
    conn.close();
}
```


## 第5章：批量插入

### 5.1 方式1：普通插入

```java
public static void main(String[] args) throws Exception {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql:///atguigu", "root", "abc666");
	String sql = "insert into multinsert (id) values (?);";
	PreparedStatement ps = conn.prepareStatement(sql);

	for (int i = 0; i < 10000; i++) {
		ps.setObject(1, i);
		ps.executeUpdate();
	}

	ps.close();
	conn.close();
}
```

该方式效率太低！

### 5.2 方式2：高效的批量插入

```java
public static void main(String[] args) throws Exception {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager
			.getConnection("jdbc:mysql:///atguigu?rewriteBatchedStatements=true", "root", "abc666");
	String sql = "insert into multinsert (id) values (?)";
	PreparedStatement ps = conn.prepareStatement(sql);

	for (int i = 0; i < 1000000; i++) {
		ps.setObject(1, i);
		ps.addBatch(); // 不执行sql语句，而是追加数据到sql语句后
	}
	ps.executeBatch(); // 执行批量操作

	ps.close();
	conn.close();
}
```

注意：

- 使用批量插入，必须在获取连接时url后面添加参数`?rewriteBatchedStatements=true`表示支持批量插入操作
- `insert into ... values ...`语句不能以分号结束
- `ps.addBatch()`表示不执行sql语句，而是追加数据到sql语句后
- 批量添加完毕后，调用`ps.executeBatch()`统一批量执行



## 第6章：数据库事务

### 6.1 JDBC事务处理

- 数据什么时候意味着提交？
  - **当一个连接对象被创建时，默认情况下是自动提交事务**：每次执行一个 SQL 语句时，如果执行成功，就会向数据库自动提交，而不能回滚。
  - **关闭数据库连接，数据就会自动的提交**。如果多个操作，每个操作使用的是自己单独的连接，则无法保证事务。即同一个事务的多个操作必须在同一个连接下。
- **JDBC程序中为了让多个 SQL 语句作为一个事务执行：**

  - 调用 Connection 对象的 **setAutoCommit(false);** 以取消自动提交事务(注意DDL操作一旦执行，都会自动提交，即使做了该设置也无效，此设置主要是用于关闭DML操作的自动提交)
  - 在所有的 SQL 语句都成功执行后，调用 **commit();** 方法提交事务
  - 在出现异常时，调用 **rollback();** 方法回滚事务

  > 若此时 Connection 没有被关闭，还可能被重复使用，则需要恢复其自动提交状态 setAutoCommit(true)。尤其是在使用数据库连接池技术时，执行close()方法前，建议恢复自动提交状态。

案例：转账事务

```java
public static void main(String[] args) throws ClassNotFoundException, SQLException {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql:///atguigu", "root", "abc666");
	
	try {
		// 关闭自动提交
		conn.setAutoCommit(false);
		
		String sql1 = "update bank set money = money - 100 where id = 1";
		PreparedStatement ps1 = conn.prepareStatement(sql1);
		ps1.executeUpdate();
		ps1.close();
		// System.out.println(10 / 0); // 模拟网络异常
		String sql2 = "update bank set money = money + 100 where id = 2";
		PreparedStatement ps2 = conn.prepareStatement(sql2);
		ps2.executeUpdate();
		ps2.close();
		
		// 若没有异常，则提交事务
		conn.commit();
	} catch (Exception e) {
		e.printStackTrace();
		// 若有异常，则回滚事务
		conn.rollback();
	} finally {
		// 恢复自动提交
		conn.setAutoCommit(true);
		// 关闭连接
		conn.close();
	}
}
```

## 第7章：DAO及相关实现类

### 7.1 JDBC工具类封装

由于JDBC中获取连接和回收连接的操作很频繁，我们可以将其封装到一个工具类中。

```java
package com.thuwsy.utils;

import com.alibaba.druid.pool.DruidDataSourceFactory;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

/**
 * ClassName: JdbcUtils
 * Package: com.thuwsy.utils
 * Description: JDBC工具类，内部包含一个连接池对象，并且对外提供获取连接和回收连接的方法。
 * 利用线程本地变量，存储连接信息。确保同一个线程的多个方法可以获取同一个connection！
 * 优势：事务操作的时候，service层和dao层属于同一个线程，就无需再传递connection参数了。
 * @Author THU_wsy
 * @Create 2023/7/29 15:56
 * @Version 1.0
 */
public class JdbcUtils {
    private static DataSource dataSource = null; // 连接池对象
    private static ThreadLocal<Connection> tl = new ThreadLocal<>(); // 线程本地变量

    static {
        // 初始化连接池对象
        InputStream is = ClassLoader.getSystemClassLoader()
                .getResourceAsStream("druid.properties");
        Properties properties = new Properties();
        try {
            properties.load(is);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        try {
            dataSource = DruidDataSourceFactory.createDataSource(properties);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static Connection getConnection() throws SQLException {
        // 判断线程本地变量中是否有connection
        Connection connection = tl.get();
        if (connection == null) {
            // 如果没有连接，则获取连接并设置到线程本地变量
            connection = dataSource.getConnection();
            tl.set(connection);
        }
        return connection;
    }

    public static void closeConnection() throws SQLException {
        // 从线程本地变量中获取要回收的连接
        Connection connection = tl.get();
        if (connection != null) {
            tl.remove(); // 清空线程本地变量数据
            connection.setAutoCommit(true); // 事务状态回归，即设置为默认的自动提交
            connection.close(); // 回收到连接池
        }
    }
}
```

说明：ThreadLocal通常用来在多线程中管理共享数据库连接、Session等。ThreadLocal用于保存某个线程共享变量，原因是在Java中，每一个线程对象中都有一个`ThreadLocalMap<ThreadLocal, Object>`，其key就是一个ThreadLocal，而Object即为该线程的共享变量。对于同一个static ThreadLocal，不同线程只能从中get、set、remove自己的变量，而不会影响其他线程的变量。

- `get()`用于获取ThreadLocal中当前线程共享变量的值
- `set()`用于设置ThreadLocal中当前线程共享变量的值
- `remove()`用于移除ThreadLocal中当前线程共享变量的值

### 7.2 高级应用层封装BaseDAO

DAO：Data Access Object是访问数据信息的类和接口，包括了对数据的CRUD（Create、Retrival、Update、Delete），而不包含任何业务相关的信息。有时也称作：BaseDAO
- 作用：为了实现功能的模块化，更有利于代码的维护和升级。


```java
package com.thuwsy.utils;

import java.lang.reflect.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ClassName: BaseDao
 * Package: com.thuwsy.utils
 * Description: 封装Dao数据库重复代码。一个方法简化DQL操作，一个方法简化非DQL操作。
 *
 * @Author THU_wsy
 * @Create 2023/7/29 16:32
 * @Version 1.0
 */
public abstract class BaseDao<T> {
    // 定义一个变量来接收泛型参数的类型
    private Class<T> clazz;

    {
        // 创建子类对象时，能确定泛型参数T的类型，所以我们在代码块中确定泛型参数T的类型。
        // 1. this.getClass()获取子类类型，然后getGenericSuperclass()获取父类类型
        Type type = this.getClass().getGenericSuperclass();
        // 2. ParameterizedType表示的是带泛型的类型
        ParameterizedType pType = (ParameterizedType) type;
        // 3. getActualTypeArguments()获取泛型参数的类型
        Type[] actualTypes = pType.getActualTypeArguments();
        // 4. 将泛型参数的类型存储到clazz属性中
        clazz = (Class<T>) actualTypes[0];
    }
    public int executeUpdate(String sql, Object... args) throws SQLException {
        Connection conn = JdbcUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        for (int i = 0; i < args.length; i++)
            ps.setObject(i + 1, args[i]);

        int row = ps.executeUpdate();
        ps.close();
        return row;
    }

    public List<T> executeQuery(String sql, Object... args) throws Exception {
        Connection conn = JdbcUtils.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        for (int i = 0; i < args.length; i++)
            ps.setObject(i + 1, args[i]);

        ResultSet resultSet = ps.executeQuery();
        ResultSetMetaData metaData = resultSet.getMetaData();
        int columnCount = metaData.getColumnCount();
        List<T> list = new ArrayList<>();

        while (resultSet.next()) {
            // 通过反射，创建一个T类型的对象
            T t = clazz.newInstance();
            // 遍历列，获取各个属性和对应的值
            for (int i = 1; i <= columnCount; i++) {
                String columnLabel = metaData.getColumnLabel(i);
                Object columnValue = resultSet.getObject(i);
                // 通过反射，给属性赋值
                Field field = clazz.getDeclaredField(columnLabel);
                field.setAccessible(true);
                field.set(t, columnValue);
            }
            list.add(t);
        }

        resultSet.close();
        ps.close();
        return list;
    }
}
```


### 7.3 BaseDao的具体实现类

我们需要对数据库中的一张具体的表(如Customers表)定义一个具体的Dao实现类。一般首先定义一个接口来规范方法：

```java
package com.thuwsy.utils;

import com.thuwsy.customer.Customer;

import java.util.List;

/**
 * ClassName: CustomerDao
 * Package: com.thuwsy.utils
 * Description:
 *
 * @Author THU_wsy
 * @Create 2023/7/29 17:44
 * @Version 1.0
 */
public interface CustomerDao {
    int insert(Customer customer) throws Exception;
    int deleteById(int id) throws Exception;
    int updateById(Customer customer) throws Exception;
    Customer getById(int id) throws Exception;
    List<Customer> getAll() throws Exception;
}
```

然后再定义具体的实现类(继承BaseDao类，实现CustomerDao接口)

```java
package com.thuwsy.utils;

import com.thuwsy.customer.Customer;

import java.sql.Connection;
import java.util.List;

/**
 * ClassName: CustomerDaoImpl
 * Package: com.thuwsy.utils
 * Description:
 *
 * @Author THU_wsy
 * @Create 2023/7/29 17:55
 * @Version 1.0
 */
public class CustomerDaoImpl extends BaseDao<Customer> implements CustomerDao{
    @Override
    public int insert(Customer customer) throws Exception {
        Connection conn = JdbcUtils.getConnection();
        String sql = "insert into customers(name, email, birth) values(?, ?, ?);";
        return executeUpdate(sql, customer.getName(), customer.getEmail(), customer.getBirth());
    }

    @Override
    public int deleteById(int id) throws Exception {
        Connection conn = JdbcUtils.getConnection();
        String sql = "delete from customers where id = ?;";
        return executeUpdate(sql, id);
    }

    @Override
    public int updateById(Customer customer) throws Exception {
        Connection conn = JdbcUtils.getConnection();
        String sql = "update customers set name = ?, email = ?, birth = ? where id = ?;";
        return executeUpdate(sql, customer.getName(), customer.getEmail(), customer.getBirth(), customer.getId());
    }

    @Override
    public Customer getById(int id) throws Exception {
        Connection conn = JdbcUtils.getConnection();
        String sql = "select id, name, email, birth from customers where id = ?;";
        List<Customer> customers = executeQuery(sql, id);
        return customers.get(0);
    }

    @Override
    public List<Customer> getAll() throws Exception {
        Connection conn = JdbcUtils.getConnection();
        String sql = "select id, name, email, birth from customers;";
        return executeQuery(sql);
    }
}
```

注意：创建connection和回收connection并没有在dao层中完成。dao层中只是获取已有的connection(利用数据库连接池和ThreadLocal)，并不是从数据库连接池中新获取一个连接。



## 第8章：数据库连接池

### 8.1 JDBC数据库连接池的必要性

在使用开发基于数据库的web程序时，传统的模式基本是按以下步骤：　　
  - **在主程序（如servlet、beans）中建立数据库连接**
  - **进行sql操作**
  - **断开数据库连接**

这种模式开发，存在的问题:
  - 普通的JDBC数据库连接使用 DriverManager 来获取，每次向数据库建立连接的时候都要将 Connection 加载到内存中，再验证用户名和密码(得花费0.05s～1s的时间)。需要数据库连接的时候，就向数据库要求一个，执行完成后再断开连接。这样的方式将会消耗大量的资源和时间。**数据库的连接资源并没有得到很好的重复利用**。
  - **对于每一次数据库连接，使用完后都得断开**。
  - **这种开发不能控制被创建的连接对象数**，系统资源会被毫无顾及的分配出去，如连接过多，也可能导致内存泄漏，服务器崩溃。 

### 8.2 数据库连接池技术

**数据库连接池的基本思想**：就是为数据库连接建立一个“缓冲池”。预先在缓冲池中放入一定数量的连接，当需要建立数据库连接时，只需从“缓冲池”中取出一个，使用完毕之后再放回去。

- **数据库连接池**负责分配、管理和释放数据库连接，它**允许应用程序重复使用一个现有的数据库连接，而不是重新建立一个**。
- 数据库连接池在初始化时将创建一定数量的数据库连接放到连接池中，这些数据库连接的数量是由**最小数据库连接数来设定**的。无论这些数据库连接是否被使用，连接池都将一直保证至少拥有这么多的连接数量。连接池的**最大数据库连接数量**限定了这个连接池能占有的最大连接数，当应用程序向连接池请求的连接数超过最大连接数量时，这些请求将被加入到等待队列中。


**数据库连接池技术的优点：**

1. 资源重用
2. 更快的系统反应速度
3. 新的资源分配手段
4. 统一的连接管理，避免数据库连接泄漏



### 8.3 多种开源的数据库连接池

JDBC 的数据库连接池使用 javax.sql.DataSource 接口进行规范，所有的第三方连接池都实现此接口：
  - **DBCP** 是Apache提供的数据库连接池，**速度相对c3p0较快**，但因自身存在BUG，Hibernate3已不再提供支持。
  - **C3P0** 是一个开源组织提供的一个数据库连接池，**速度相对较慢，稳定性还可以**。
  - **Proxool** 是sourceforge下的一个开源项目数据库连接池，有监控连接池状态的功能，**稳定性较c3p0差一点**
  - **BoneCP** 是一个开源组织提供的数据库连接池，速度快
  - **Druid** 是阿里提供的数据库连接池，据说是集DBCP 、C3P0 、Proxool 优点于一身的数据库连接池，但是速度不确定是否有BoneCP快

**DataSource用来取代DriverManager来获取Connection，获取速度快，同时可以大幅度提高数据库访问速度。**


### 8.4 Druid（德鲁伊）数据库连接池

Druid是阿里巴巴开源平台上一个数据库连接池实现，它结合了C3P0、DBCP、Proxool等DB池的优点，同时加入了日志监控，可以很好的监控DB池连接和SQL的执行情况，可以说是针对监控而生的DB连接池，**可以说是目前最好的连接池之一**。我们首先要导入`druid-1.1.21.jar`的jar包。创建Druid数据库连接池有两种方式：

**方式1：硬编码方式(不推荐)**

```java
public void testHard() throws SQLException {
    // 1. 创建一个druid连接池对象
    DruidDataSource dataSource = new DruidDataSource();
    // 2. 设置连接池参数
    // 必须的参数：注册的驱动、url、user、password
    dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
    dataSource.setUrl("jdbc:mysql:///atguigu");
    dataSource.setUsername("root");;
    dataSource.setPassword("abc666");
    // 非必须的参数：初始化连接数量，最大的连接数量...
    dataSource.setInitialSize(5);
    dataSource.setMaxActive(10);

    // 3. 获取连接(通用方法，所有连接池都一样)
    Connection connection = dataSource.getConnection();
    // ...执行CRUD操作
    // 4. 回收连接
    connection.close(); // 连接池提供的连接调用close，是在回收连接
}
```

**方式2：软编码方式**

在src目录下创建一个属性文件druid.properties，里面填写配置参数，注意key值应和下面的示例一样：

```properties
driverClassName=com.mysql.cj.jdbc.Driver
url=jdbc:mysql://127.0.0.1:3306/atguigu
username=root
password=abc666
```

```java
public void testSoft() throws Exception {
    // 1. 读取src下的配置文件druid.properties
    InputStream is = ClassLoader.getSystemClassLoader()
            .getResourceAsStream("druid.properties");
    Properties properties = new Properties();
    properties.load(is);

    // 2. 使用连接池的工具类的工程模式，创建连接池
    DataSource dataSource = DruidDataSourceFactory.createDataSource(properties);

    // 3. 获取连接(通用方法，所有连接池都一样)
    Connection connection = dataSource.getConnection();
    // ...执行CRUD操作
    // 4. 回收连接
    connection.close();
}
```

- 其他配置参数：

| **配置**    | **缺省** | **说明** |
|---|---|---|
| name | | 配置这个属性的意义在于，如果存在多个数据源，监控的时候可以通过名字来区分开来。   如果没有配置，将会生成一个名字，格式是：”DataSource-” +   System.identityHashCode(this) |
| initialSize | 0  | 初始化时建立物理连接的个数。初始化发生在显示调用init方法，或者第一次getConnection时 |
| maxActive  | 8   | 最大连接池数量   |



## 第9章：Apache-DBUtils实现CRUD操作

### 9.1 Apache-DBUtils简介

commons-dbutils 是 Apache 组织提供的一个开源 JDBC工具类库，它是对JDBC的简单封装，学习成本极低，并且使用dbutils能极大简化jdbc编码的工作量，同时也不会影响程序的性能。我们需要导入jar包`commons-dbutils-1.7.jar`

API介绍：
- org.apache.commons.dbutils.QueryRunner
- org.apache.commons.dbutils.ResultSetHandler
- 工具类：org.apache.commons.dbutils.DbUtils   

### 9.2 主要API的使用

#### 9.2.1 DbUtils

DbUtils：提供如关闭连接、装载JDBC驱动程序等常规工作的工具类，里面的所有方法都是静态的。主要方法如下：
- `public static void close(…)`：DbUtils类提供了三个重载的关闭方法。这些方法检查所提供的参数是不是NULL，如果不是的话，它们就关闭Connection、Statement和ResultSet。
- `public static void closeQuietly(…)`: 这一类方法不仅能在Connection、Statement和ResultSet为NULL情况下避免关闭，还能隐藏一些在程序中抛出的SQLEeception。

#### 9.2.2 QueryRunner类

**该类简单化了SQL查询，它与ResultSetHandler组合在一起使用可以完成大部分的数据库操作，能够大大减少编码量。**

QueryRunner类提供了两个构造器：
  - 默认的空参构造器
  - 需要一个 javax.sql.DataSource 来作参数的构造器

QueryRunner类的主要方法：

**更新**
- `int update(conn, sql, Object... params)`：用来执行一个插入、更新或删除操作。

**插入**
- `T insert(conn, sql, ResultSetHandler<T> rsh, Object... params)`：只支持INSERT语句

**批处理**
- `int[] batch(conn, sql,Object[][] params)`：支持INSERT, UPDATE, or DELETE语句
- `T insertBatch(conn, sql, ResultSetHandler<T> rsh,Object[][] params)`：只支持INSERT语句

**查询**
- `Object query(conn, sql, ResultSetHandler rsh,Object... params)`：执行一个查询操作，在这个查询中，对象数组中的每个元素值被用来作为查询语句的置换参数。该方法会自行处理 PreparedStatement 和 ResultSet 的创建和关闭。

#### 9.2.3 ResultSetHandler接口及实现类

该接口用于处理 java.sql.ResultSet，将数据按要求转换为另一种形式。ResultSetHandler 接口提供了一个抽象方法：`Object handle (ResultSet rs)`。

该接口的主要实现类：

- ArrayHandler：把结果集中的第一行数据转成对象数组。
- ArrayListHandler：把结果集中的每一行数据都转成一个数组，再存放到List中。
- BeanHandler：将结果集中的第一行数据封装到一个对应的JavaBean实例中。
- BeanListHandler：将结果集中的每一行数据都封装到一个对应的JavaBean实例中，存放到List里。
- ColumnListHandler：将结果集中某一列的数据存放到List中。
- KeyedHandler(name)：将结果集中的每一行数据都封装到一个Map里，再把这些map再存到一个map里，其key为指定的key。
- MapHandler：将结果集中的第一行数据封装到一个Map里，key是列名，value就是对应的值。
- MapListHandler：将结果集中的每一行数据都封装到一个Map里，然后再存放到List
- ScalarHandler：查询单个值对象

    

测试：

```java
@Test
public void test1() throws SQLException {
	Connection conn = JdbcUtils.getConnection();
	QueryRunner queryRunner = new QueryRunner();
	// 插入操作
	String sql = "insert into customers(name, email, birth) values(?, ?, ?);";
	int count = queryRunner.update(conn, sql, "吴sy", "666@666", "2020-12-12");
	System.out.println(count);

	JdbcUtils.closeConnection();
}

@Test
public void test2() throws SQLException {
	Connection conn = JdbcUtils.getConnection();
	QueryRunner queryRunner = new QueryRunner();

	String sql = "select id, name, email, birth from customers where id = ?;";
	// BeanHandler是ResultSetHandler接口的一个实现类，用于封装表中的一条记录到一个JavaBean中
	BeanHandler<Customer> handler = new BeanHandler<>(Customer.class);
	Customer customer = queryRunner.query(conn, sql, handler, 21);
	System.out.println(customer);

	JdbcUtils.closeConnection();
}

@Test
public void test3() throws SQLException {
	Connection conn = JdbcUtils.getConnection();
	QueryRunner queryRunner = new QueryRunner();

	String sql = "select id, name, email, birth from customers where id < ?;";
	// BeanListHandler将每行转成JavaBean，保存到List中
	BeanListHandler<Customer> handler = new BeanListHandler<>(Customer.class);
	List<Customer> customers = queryRunner.query(conn, sql, handler, 20);
	customers.forEach(System.out::println);

	JdbcUtils.closeConnection();
}

@Test
public void test4() throws SQLException {
	Connection conn = JdbcUtils.getConnection();
	QueryRunner queryRunner = new QueryRunner();

	String sql = "select id, name, email, birth from customers where id = ?;";
	// MapHandler将一条记录封装到一个Map中
	MapHandler handler = new MapHandler();
	Map<String, Object> map = queryRunner.query(conn, sql, handler, 21);
	System.out.println(map);

	JdbcUtils.closeConnection();
}

@Test
public void test5() throws SQLException {
	Connection conn = JdbcUtils.getConnection();
	QueryRunner queryRunner = new QueryRunner();

	String sql = "select id, name, email, birth from customers where id < ?;";
	// MapListHandler把每行记录转成一个Map，然后保存到List中
	MapListHandler handler = new MapListHandler();
	List<Map<String, Object>> list = queryRunner.query(conn, sql, handler, 20);
	list.forEach(System.out::println);

	JdbcUtils.closeConnection();
}

@Test
public void test6() throws SQLException {
	Connection conn = JdbcUtils.getConnection();
	QueryRunner queryRunner = new QueryRunner();

	String sql = "select count(*) from customers;";
	// ScalarHandler用于查询单个值对象
	ScalarHandler<Long> handler = new ScalarHandler<>();
	Long count = queryRunner.query(conn, sql, handler);
	System.out.println(count);
	
	JdbcUtils.closeConnection();
}

@Test
public void test7() throws SQLException {
	Connection conn = JdbcUtils.getConnection();
	QueryRunner queryRunner = new QueryRunner();
	
	String sql = "select id, name, email, birth from customers where id = ?;";
	// 也可以自定义ResultSetHandler的实现类
	ResultSetHandler<Customer> handler = new ResultSetHandler<Customer>() {
		@Override
		public Customer handle(ResultSet resultSet) throws SQLException {
			resultSet.next();
			System.out.println(resultSet.getObject(2));
			System.out.println("handler");
			return new Customer();
		}
	};
	Customer customer = queryRunner.query(conn, sql, handler, 1);
	System.out.println(customer);
	
	JdbcUtils.closeConnection();
}
```