# 第1章 Java基础

## 1.1 Java简介

- 编写代码
- 编译代码：将人能看懂的源代码（.java文件）转换为Java虚拟机能够执行的字节码文件（.class文件）
- 运行代码：将字节码文件交给Java虚拟机执行

> **编写第一个Java入门程序**

按照下面提供的步骤，一步一步的完成第一个Java入门程序的编写、编译和执行。

**第一步**：新建一个后缀为.java的文本文件`HelloWorld.java`，用记事本编写代码如下。

```java
public class HelloWorld {
   public static void main(String[] args) {
     System.out.println(" HelloWorld ");
    }
}
```

**第二步**：进入`HelloWorld.java`文件所在目录，在地址栏输入cmd回车，即可在此处打开命令行窗口。

编译：在命令行窗口输入编译命令`javac HelloWorld`完成编译，编译后会生成一个`HelloWorld.class`文件。

**第三步**：再接着输入`java HelloWorld`就可以运行了，运行结果如下。


### 1.1.1 JDK的组成
 

JDK由JVM、核心类库、开发工具组成，如下图所示

![](/zzimages/1660147531310.png)


- 什么是JVM?
    答：JDK最核心的组成部分是JVM（Java Virtual Machine），它是Java虚拟机，真正运行Java程序的地方。
    
- 什么是核心类库？
	答：它是Java本身写好的一些程序，给程序员调用的。 Java程序员并不是凭空开始写代码，是要基于核心类库提供的一些基础代码，进行编程。
	
- 什么是JRE?
    答：JRE（Java Runtime Enviroment），意思是Java的运行环境；它是由JVM和核心类库组成的；如果你不是开发人员，只需要在电脑上安装JRE就可以运行Java程序。
    
- 什么是开发工具呢？
	答：Java程序员写好源代码之后，需要编译成字节码，这里会提供一个编译工具叫做javac.exe，编写好源代码之后，想要把class文件加载到内存中运行，这里需要用到运行工具java.exe。 除了编译工具和运行工具，还有一些其他的反编译工具、文档工具等

JDK、JRE的关系用一句话总结就是：用JDK开发程序，交给JRE运行



### 1.1.2 Java的跨平台原理

因为有了Java虚拟机所以Java程序有一个重要的特性叫做跨平台性。

- **什么是跨平台性呢？**

  所谓跨平台指的是用Java语言开发的程序可以在多种操作系统上运行，常见的操作系统有Windows、Linux、MacOS系统。如果没有跨平台性，同一个应用程序，想要在多种操作系统上运行，需要针对各个操作系统单独开发应用。比如微信有Windows版本、MacOS版本、Android版本、IOS版本

  

- **为什么Java程序可以跨平台呢？**

  跨平台性的原理是因为在**不同版本的操作系统**中安装有**不同版本的Java虚拟机**，Java程序的运行只依赖于Java虚拟机，和操作系统并没有直接关系。**从而做到一处编译，处处运行**。



### 1.1.3 JDK环境变量配置

JDK安装后，接下我们来学习一个补充知识，叫做Path环境变量

- **什么是Path环境变量？**

  Path环境变量是让系统程序的路径，方便程序员在命令行窗口的任意目录下启动程序

- **如何配置环境变量呢？**

  比如把QQ的启动程序，配置到Path环境变量下就可以在任意目录下启动QQ，按照一下步骤操作。

  **第一步：**先找到QQ启动程序所在的目录`C:\Program Files (x86)\Tencent\QQ\Bin`，复制这个路径


  **第二步：**按照下面的步骤，找到Path环境变量。

  首先找到此电脑，右键点击属性，可以按照下面的界面；点击【高级系统设置】，再点击【环境变量】


  双击Path后，点击新建，把QQ启动目录粘贴进来，不要忘记点确定哦


  **第三步：**配置好之后，检查是否配置成功

  ```java
  1.Win+R 输入cmd回车，打开命令行窗口
  2.输入QQScLanucher，可以看到QQ启动了
  ```


- **将JDK配置到Path路径下**

  上面我们配置了QQ的启动目录到Path环境变量位置，那么接下来，我们把JDK的bin目录配置到Path环境变量下，这样就可以在任意目录下启动javac和java命令来完成编译和运行了。

  **第一步：**找到JDK的bin目录`C:\Program Files\Java\jdk-17.0.3\bin`，复制一下

  **第二步：**将JDK的bin目录粘贴在Path环境变量后面



  **第三步：检测否配置成功**

  ```java
  1.按住Win+R输入cmd 回车，打开命令行创建
  2.输入javac -version 看提示信息是否显示你安装JDK的版本号
    输入java -version 看提示信息是否显示你安装JDK的版本号
  【如果显示版本号都是JDK17就表示配置安装成功】
  ```

## 1.2 Java开发工具


有没有一种软件能够将写代码、编译、运行等工具集成到一起呢？ 有，这就是集成开发环境（Integrated Development Environment ，简称IDE）。除此之外，IDE还有代码提示、检查代码错误等功能，从而提高程序员的开发效率。

IDE有很多种，常见的Eclipse、MyEclipse、Intellij IDEA、JBuilder、NetBeans等。但是这些IDE中目前比较火的是Intellij IDEA（以下简称IDEA），被众多Java程序员视为最好用的Java集成开发环境，所以我们课程中就以IDEA为开发工具来编写代码，以后大家去公司也建议用IDEA作为开发环境。


### 1.2.1 IDEA编写Java程序


想要在IDEA正确的写一个Java程序，必须先认识一下IDEA的管理Java程序的工程结构。

- 第一步：首先得在IDEA中创建一个Project（工程、也叫项目），后面统称为工程。
- 第二步：需要在Project中创建Module（模块），一个工程中可以包含多个模块
- 第三步：需要在Module中新建Package（包），一个模块中可以有多个包
- 第四步：需要在Package中新建Class（类），一个包中可以包含多个类


### 1.2.2 常用快捷键


下面是几种常见的快捷键，以及他们的作用，大家可以自己试试

| **快捷键**                        | **功能效果**                     |
| --------------------------------- | -------------------------------- |
| main/psvm、sout               | 快速键入相关代码                 |
| Ctrl + D                          | 复制当前行数据到下一行           |
| Ctrl + Y                          | 删除所在行，建议用Ctrl + X       |
| Ctrl + ALT + L                    | 格式化代码                       |
| ALT + SHIFT + ↑ , ALT + SHIFT + ↓ | 上下移动当前代码                 |
| Ctrl + / , Ctrl + Shift + /       | 对代码进行注释(讲注释的时候再说) |


## 1.3 Java基础语法


### 1.3.1 注释


- 注释有哪几种？格式怎样？

  ```java
  1.单行注释：
  	//后面根解释文字
  2.多行注释
      /*
      这里写注释文字
      可以写多行
      */
  3.文档注释
      /**
      这里写文档注释
      也可以写多行，文档注释可以利用JDK的工具生成帮助文档
      */
  ```

每次手动加注释比较麻烦，也可以使用快捷键加注释

```java
Ctrl + / 	单行注释（对当前行进行注释）
Ctrl + Shift + / 	对选中的代码进行多行注释。
```


### 1.3.2 字面量



- 什么是字面量？

  字面量其实就是告诉程序员数据在程序中的书写格式。下面是常用的数据在程序中的书写格式。

```java
public class LiteralDemo{
    public static void main(String[] args){
        //1.整数
        System.out.println(666);
        
        //2.小数
        System.out.println(3.66);
        
        //3.字符: 字符必须用单引号引起来
        System.out.println('a');
        System.out.println('中');
        System.out.println(' '); //空格也算字符
        //特殊字符：\t表示制表符 \n表示换行
        
        //4.字符串：字符串是双引号引起来的
        System.out.println("我爱你中国abc");
        
        //5.布尔值：只有两个值true和false
        System.out.println(true);
        System.out.println(false);

        //6.空值：null
    }
}
```



### 1.3.3 变量


**什么是变量？**

变量是用来记录程序中的数据的。其本质上是内存中的一块区域，你可以把这块区域理解成一个小盒子。

当执行`int age = 18;` 这句代码时，JVM会在内存中申请一块区域，在这个区域中存储了一个整数18，给这个区域取的名字叫age； 相当于在盒子中存了一个数据18，这个盒子的名字是age，当我们打印age时，就是从盒子中把盒子中的数据取出来再打印。

注意变量是什么类型，就应该用来装什么类型的数据，否则报错。例如对于上述的 `age`，则 `age = 9.5` 会报错。



### 1.3.4 标志符

```java
强制要求：必须遵守，不遵守就会报错
	1.由字母、数字、下划线、$组成
	2.不能以数字开头
	3.不能是Java的关键字

建议遵守：按照下面的方式取名字会显得更加专业
	1.所有的名字要见名知意，便于自己和别人阅读
		举例： class Student{} //一看这个类就知道表示一个学生
			  int age = 10;    //一看这个变量就知道表示年龄
		
	2.类名：首字母大写（大驼峰命名）
		举例： class Student{}
		
	3.变量名：第二个单词开始首字母大写（小驼峰命名）
		举例： double money = 6.88;  
			  double applePrice = 7.5; 
```




## 1.4 数据类型

### 1.4.1 不同进制在Java程序中的书写格式

```java
System.out.pirntln('a' + 1); //98
System.out.pirntln(0b01100001); //97，二进制
System.out.pirntln(0141); //97，八进制
System.out.pirntln(0x61); //97，十六进制
```

### 1.4.2 Java数据类型

Java的数据类型整体上来说分为两大类： **基本数据类型**、**引用数据类型**。 

基本数据类型一共有4类8种，每一种数据类型占用的内存空间不一样，能够表示的数据范围也不一样。如下图所示

![](/zzimages/1660832924103.png)

需要我们注意的是，随便写一个整数或者小数的字面量，它也是有默认数据类型的(整数默认int，小数默认double)

```
- 比如23，它默认就为int类型；如果加上后缀L，则为long类型；
- 比如23.8，它默认为double类型；如果加上后缀F，则为float类型;
```


### 1.4.3 自动类型转换

在我们实际开发中可能存在将某种类型变量的值，赋值给另一个类型的变量；也可能存在多种数据类型的数据一起运算的情况。

在以上情况中，其实都会涉及到类型转换。类型转换的形式总体分为2种，一种是**自动类型转换**，一种是**强制类型转换**。

- **什么是自动类型转换呢？**

```java
答：自动类型转换指的是，数据范围小的变量可以直接赋值给数据范围大的变量
    int x = 3;
    float y = x;
    System.out.println(y); //输出3.0
```

- **自动类型转换的原理是怎样的？**

```java
答：自动类型转换其本质就是在较小数据类型数据前面，补了若干个字节
```

![](/zzimages/1660837456261.png)



- **表达式的自动类型转换**

自动类型转换还有另外一种形式，就是表达式的自动类型转换。所谓表达式指的是几个变量或者几个数据一起参与运算的式子。

如果同一个表达式中，出现不同类型的变量或者数据一起运算，这种情况下运算结果是一个什么数据类型呢？需要遵守下面的两条运算规则：

1. 表达式的最终结果类型由表达式中的最高类型决定。
2. 在表达式中，byte、short、char 是直接转换成int类型参与运算的。注意，即使两个byte运算，结果也会提升为int。


### 1.4.4 强制类型转换

能不能将数据范围大的数据直接赋值给数据范围小的变量呢？ **答案是会报错。**


- **什么是强制类型转换**

但是你强行将范围大的数据，赋值给范围小的变量也是可以的，这里就需要用到强制类型转换。下面是强制类型转换的格式

```java
目标数据类型  变量名  =  (目标数据类型)被转换的数据;
```


```java
public class TypeConversionDemo3 {
    public static void main(String[] args) {
        // 目标：掌握强制类型转换。
        int a = 20;
        byte b = (byte) a;  // ALT + ENTER 强制类型转换。
        System.out.println(a);
        System.out.println(b);

        double d = 99.5;
        int m = (int) d; // 强制类型转换
        System.out.println(m); // 丢掉小数部分，保留整数部分
    }
}
```

- 注：强制类型转换可能造成数据(丢失)溢出；浮点型强转成整型，直接丢掉小数部分，保留整数部分返回。

## 1.5 运算符


- 基本算术运算符
- 自增自减运算符
- 赋值运算符
- 关系运算符
- 逻辑运算符
- 三元运算符

### 1.5.1 算术运算符

先从最基本的算术运算符开始学习，算术运算符有 `+ - * / % ` ，其中`*`表示乘法，`/`表示除法，`%`表示取余数

需要我们注意以下几点

```java
/: 两个整数相除，结果也是一个整数
%: 表示两个数相除，取余数
```

需要我们注意的是：`+`符号除了用于加法运算，还可以作为连接符。**`+`符号与字符串运算的时候是用作连接符的，其结果依然是一个字符串**。


```java
public class OperatorDemo1 {
    public static void main(String[] args) {
        int a2 = 5;
        System.out.println("abc" + a2); // "abc5"
        System.out.println(a2 + 5); //  10
        System.out.println("itheima" + a2 + 'a'); // "itheima5a"
        System.out.println(a2 + 'a' + "itheima"); // 102itheima
    }
}
```


### 1.5.2 自增自减运算符

`++`读作自增，`--`读作自减；注意自增自减只能操作变量不能操作字面量。


### 1.5.3 赋值运算符


除了基本的赋值运算符，我们这里主要学习一下扩展的赋值运算符。有`+= -= *= /= %=` ，注意：扩展的赋值运算符隐含了强制类型转换。例如 `a += b;`，底层代码形式为`a = (a的类型)(a + b);`


```java
问题1：下面的代码否有问题？
    byte x = 10;
    byte y = 30;
	  x = x + y;  //这句代码有问题，因为两个byte类型数据相加，会提升为int类型;
	
问题2：下面的代码是否有问题？
	byte x = 10;
	byte y = 30;
	x += y; //这句代码没有问题，因为这里有隐含的强制类型转换
	//x += y; 等价于 byte x = (byte)(x + y);
```


### 1.5.4 关系运算符

关系运算符(比较运算符)在程序中常用于条件判断，根据条件判断的结果是true还是false，来决定后续该执行哪些操作。


### 1.5.5 逻辑运算符

**逻辑运算符是用来将多个条件放在一起运算，最终结果是true或者false**

![](/zzimages/1660873470958.png)


### 1.5.6 三元运算符

三元运算符的格式： 

```java
关系表达式? 值1 : 值2;
```

### 1.5.7 运算优先级



![](/zzimages/1660875681298.png)

从图中我们发现，&&运算比||运算的优先级高，所以&&和||同时存在时，是先算&&再算||；

**在实际开发中，其实我们很少考虑运算优先级， 因为如果你想让某些数据先运算，其实加`()`就可以了，这样阅读性更高。**



### 1.5.8 案例技术：获取用户键盘输入的数据

**键盘录入这个事情，其实并不是我们自己做的，而是Java本身就提供了这样的功能，我们按照它的要求，去调用就行。**

我们在安装JDK的时候，其实JDK中就已经包含了一些Java写好的代码，我们把Java写好的代码直接拿过来用就行。


比如：Scanner就是Java提供给我们用于键盘录入数据的类，为了录入不同类型的数据，还提供了不同的功能，每一个功能会有不同的名称，我们只需要调用Scanner提供的功能就可以完成键盘录入数据。


大家只需要按照下面的步骤编写代码，就可以键盘录入数据了

```java
【第1步】：在class类上导包：一般不需要我们自己做，idea工具会自动帮助我们导包的。
	import java.util.Scanner;
	
【第2步】：得到一个用于键盘扫描器对象（照抄代码就行，固定格式）
	//Scanner是键盘扫描器对象(你就把它理解成一个东西)，这个东西有录入的功能
	//sc是给这个东西取的名字
	Scanner sc = new Scanner(System.in);

【第3步】：开始调用sc的功能，来接收用户键盘输入的数据。
	//sc这个东西有键盘录入整数的功能，这个功能的名字叫nextInt()
	//.表示表示调用的意思
	int age = sc.nextInt();
	System.out.println("我的年龄是:"+age);

	//sc这个东西还有键盘录入字符串的功能，这个功能的名字叫next
	String name = sc.next();
	System.out.println("我的姓名是:"+name);
```

- 注意：System、String在JDK中的Java.lang包下。lang包不需要我们导包，是默认的包。



## 1.6 程序流程控制

### 1.6.1 分支结构

#### if分支

#### switch分支

**switch 注意事项**


```java
- 1.表达式类型只能是 byte、short、int、char
	JDK5开始支持枚举，JDK7开始支持String
	不支持 double、float、long
    
- 2.case给出的值不允许重复，且只能是字面量，不能是变量。
		
- 3.正常使用switch的时候，不要忘记写break，否则会出现穿透现象。
```

### 1.6.2 循环结构

#### for循环

#### while循环

#### do-while循环

### 1.6.3 随机数

生成随机数的功能，其实 Java已经给我们提供了，在JDK中提供了一个类叫做Random，我们只需要调用Random这个类提供的功能就可以了。

- 注意：`Randome` 类下的 `nextInt(n)` 功能只能生成 `0` 至 `n-1`之间的随机数，不包含 `n`

```java
// 目标：掌握使用Random生成随机数的步骤。
// 1、导包。import java.util.Random; (idea会自动完成)
import java.util.Random;
public class RandomDemo1 {
    public static void main(String[] args) {
        // 2、创建一个Random对象，用于生成随机数。
        Random r = new Random();
        // 3、调用Random提供的功能：nextInt得到随机数。
        for (int i = 1; i <= 20; i++) {
            int data = r.nextInt(10); // 0 - 9
            System.out.println(data);
        }
    }
}
```

```java
// 生成[M, N]之间的随机数
// 方案一：
Random r = new Random();
int ans = r.nextInt(N - M + 1) + M;
// 方案二：直接调用java提供的API : r.nextInt(a, b) 生成[a, b)之间的随机整数
ans = r.nextInt(M, N + 1);
```



## 1.7 数组


数组有两种初始化的方式，一种是静态初始化、一种是动态初

### 1.7.1 数组的静态初始化

所谓静态初始化指的是：在定义数组时直接给数组中的数据赋值。

**1. 静态初始化标准格式：**

```java
数据类型[] 变量名 = new 数据类型[]{元素1,元素2,元素3};
```

```java
int[] ages = new int[]{12, 24, 36};
```

**2. 静态初始化简化格式**

Java语言的设计者为了简化定义数组的写法，还为静态初始化提供了一种简化写法

```java
数据类型[] 变量名 = {元素1,元素2,元素3};
```

```java
int[] ages = {12, 24, 36}
```

**3. 注意哟**

- 定义数组时， `数据类型[] 数组名` 也可写成 `数据类型 数组名[]` 

```java
//以下两种写法是等价的。但是建议大家用第一种，因为这种写法更加普遍
int[] ages = {12, 24, 36};
int ages[] = {12, 24, 36};
```



**4. 数组在计算机中的基本原理**

数组变量名中存储的是数组在内存中的地址，数组是一种引用数据类型

我们以`int[] ages = {12,24,36};`这句话为例，看一下这句话到底在计算机中做了那些事情。

- 首先，左边`int[] ages` 表示定义了一个数组类型的变量，变量名叫ages
- 其次，右边`{12,24,36}`表示创建一个数组对象，你完全可以把它理解成一个能装数据的东西。这个对象在内存中会有一个地址值`[I@4c873330`，每次创建一个数组对象都会有不用的地址值。
- 然后，把右边的地址值`[I@4c873330`赋值给左边的ages变量
- 所以，ages变量就可以通过地址值，找到数组这个东西。


### 1.7.2 数组长度


我们可以获取数组中元素的个数，后面我们统称为数组的长度。

```java
// 访问数组的元素个数：数组名.length
System.out.println(arr.length);
```

### 1.7.3 数组的动态初始化

另一个初始化数组的方式叫 **动态初始化**。动态初始化不需要我们写出具体的元素，而是指定元素类型和长度就行。格式如下

```java
//数据类型[]  数组名 = new 数据类型[长度];
int[] arr = new int[3];
```

下面是动态初始化数组的原理图。我们发现`int[] arr` 其实就是一个变量，它记录了数组对象的地址值，而且数组中的元素默认值是0。


**注意：**

使用动态初始化定义数组时，根据元素类型不同，默认值也有所不同。

![](/zzimages/1661417981361.png)

注意：静态初始化和动态初始化数组的写法是独立的，不可以混用。如下写法是错误的：

```java
int[] arr = new int[3]{30，40,50};
```


### 1.7.4 数组的执行原理，Java程序的执行原理

实际上Java程序是把编译后的字节码加载到Java虚拟机中执行的。

![](/zzimages/1661437717797.png)

Java为了便于虚拟机执行Java程序，将虚拟机的内存划分为 方法区、栈、堆、本地方法栈、寄存器 这5块区域。同学们需要重点关注的是  **方法区、栈、堆**。

下面把每一个块内存区域作用介绍一下，我们大致只需要知道每一部分存储什么内容就行。

- **方法区**：字节码文件先加载到这里
- **栈**：方法运行时所进入的内存区域，由于变量在方法中，所以变量也在这一块区域中
- **堆**：存储new出来的东西，并分配地址。由于数组是new 出来的，所以数组也在这块区域。

下面是上面案例执行的内存原理如下图所示，按照① ② ③ ④ ⑤ ⑥ 的标记的顺序来看

![](/zzimages/1661438278304.png)

**总结一下`int a = 10`与 `int[] arr = new int[]{11,22,33}的区别`**

- **a**是一个变量，在栈内存中，**a**变量中存储的数据就是**10**这个值。
- **arr**也是一个变量，在栈中，存储的是数组对象在堆内存中的地址值

```java
// 这里的int a是一个基本类型变量，存储的是一个数值
int a = 10 ; 
//这里的int[] arr是一个引用类型的变量，存储的是一个地址值
int[] arr = new int[]{44,55,66};
```


### 1.7.5 多个变量指向同一个数组的问题

在实际开发中可能存在一种特殊情况，就是多个变量指向同一个数组对象的形式。


```java
public class ArrayDemo2 {
    public static void main(String[] args) {
        // 目标：认识多个变量指向同一个数组对象的形式，并掌握其注意事项。
        int[] arr1 = {11, 22, 33};

        // 把int类型的数组变量arr1赋值给int类型的数组变量arr2
        int[] arr2 = arr1;

        System.out.println(arr1);
        System.out.println(arr2);

        arr2[1] = 99;
        System.out.println(arr1[1]);

        arr2 = null; // 拿到的数组变量中存储的值是null
        System.out.println(arr2); //null
    }
}
```

**总结：**

- 两个变量指向同一个数组时，两个变量记录的是同一个地址值。

- 当一个变量修改数组中的元素时，另一个变量去访问数组中的元素，元素已经被修改过了。

- 如果某个数组变量存储的地址是null，那么该变量将不再指向任何数组对象，此时只能打印出 `null`，但无法获得 `length` 等属性


### 1.7.6 Debug调试工具


Debug调试工具的使用步骤如下：

```java
第一步：打断点，如下图的红色小圆点
第二步：右键Debug方式启动程序，如下图右键菜单
	  启动后，代码会停留在打断点的这一行
第三步：点击箭头按钮，一行一行往下执行
```

![](/zzimages/1661444896100.png)




## 1.8 方法

**1. 方法是什么**

**方法是一种语法结构，它可以把一段代码封装成一个功能，以便重复调用**。

```java
修饰符 返回值类型 方法名(形参列表) {
    方法体代码(需要执行的功能代码)
    return 返回值;
}
```

```java
public static int sum(int a, int b) {
    int c = a + b;
    return c;
}
```

**2. 定义方法的注意点**


1. 方法的修饰符：暂时都使用public static 修饰。（目前看做是固定写法，后面是可以改动的）

2. 方法申明了具体的返回值类型，内部必须使用return返回对应类型的数据。

3. 形参列表可以有多个，甚至可以没有；如果有多个形参，多个形参必须用 `,` 隔开，且不能给初始化值。


**3. 设计一个合理的方法的原则**

- 如果方法不需要返回数据，返回值类型必须申明成void（无返回值申明）,  此时方法内部不可以使用return返回数据。
- 方法如果不需要接收外部传递进来的数据，则不需要定义形参，且调用方法时也不可以传数据给方法。


**4. 方法使用常见的问题**

1. 方法在类中没有先后顺序，但是不能把一个方法定义在另一个方法中。

2. 方法的返回值类型写void（无返回申明）时，方法内不能使用return返回数据，但可以使用 `return` 立即跳出并结束当前方法的执行。如果方法的返回值类型写了具体类型，方法内部则必须使用return返回对应类型的数据。

3. return语句的下面，不能编写代码，属于无效的代码，执行不到这儿。

4. 方法不调用就不会执行, 调用方法时，传给方法的数据，必须严格匹配方法的参数情况。

5. 调用有返回值的方法，有3种方式：
     ① 可以定义变量接收结果 
     ② 或者直接输出调用，
     ③ 甚至直接调用；

6. 调用无返回值的方法，只有1种方式：只能直接调用。



### 1.8.1 方法在计算机中的执行原理


我们知道Java程序的运行，都是在内存中执行的，而内存区域又分为栈、堆和方法区。那Java的方法是在哪个内存区域中执行呢？

答案是栈内存。 **每次调用方法，方法都会进栈执行；执行完后，又会弹栈出去。**

假设在main方法中依次调用A方法、B方法、C方法，在内存中的执行流程如下：

- 每次调用方法，方法都会从栈顶压栈执行
- 每个方法执行完后，会从栈顶弹栈出去


### 1.8.2 方法参数的传递机制


**Java的参数传递机制都是：值传递**

所谓值传递：指的是在传递实参给方法的形参的时候，传递的是实参变量中存储的值的副本。 

#### 参数传递的是基本类型数据

**Java的参数传递机制都是：值传递，传递的是实参存储的值的副本。**


#### 参数传递的是引用数据类型

我们发现调用change方法时参数是引用类型，**实际上也是值传递，只不过参数传递存储的地址值**。此时change方法和main方法中两个方法中各自有一个变量arrs，这两个变量记录的是同一个地址值 `[I@4c873330` ，change方法把数组中的元素改了，main方法在访问时，元素已经被修改了。


例：数组拷贝

```java
// 注意：这个不是拷贝数组，叫把数组变量赋值给另一个数组变量。
// int[] arr2 = arr;

public static int[] copy(int[] arr){
    // arr = [11, 22, 33]
    // 1、创建一个长度一样的整型数组出来。
    int[] arr2 = new int[arr.length];
    // arr2 = [0, 0, 0]

    // 2、把原数组的元素值对应位置赋值给新数组。
    for (int i = 0; i < arr.length; i++) {
        arr2[i] = arr[i];
    }
    return arr2;
}
```


**总结：**

```java
基本类型和引用类型的参数在传递的时候有什么不同？
  - 都是值传递
  - 基本类型的参数传递存储的数据值。
  - 引用类型的参数传递存储的地址值。
```


### 1.8.3 方法重载


所谓方法重载指的是：一个类中，只要一些方法的名称相同、形参列表不同，那么它们就是方法重载了，其它的都不管。

下面案例中有多个test方法，但是参数列表都不一样，它们都是重载的方法。调用时只需要通过参数来区分即可。

```java
public class MethodOverLoadDemo1 {
    public static void main(String[] args) {
        // 目标：认识方法重载，并掌握其应用场景。
        test();
        test(100);
    }

    public static void test(){
        System.out.println("===test1===");
    }

    public static void test(int a){
        System.out.println("===test2===" + a);
    }

    void test(double a){

    }

    void test(double a, int b){
    }

    void test(int b, double a){
    }

    int test(int a, int b){
        return a + b;
    }
}
```




# 第2章 Java面向对象基础


## 2.1 面向对象入门

**所谓编写对象编程，就是把要处理的数据交给对象，让对象来处理。**

1. 面向对象编程有什么好处？

答：面向对象的开发更符合人类的思维习惯，让编程变得更加简单、更加直观。

2. 程序中对象到底是个啥？

答：**对象实质上是一种特殊的数据结构**。

3. 对象是怎么出来的？

刚刚我们讲到对象就是一张数据表，那么这个数据表是怎么来的呢？这张表是不会无缘无故存在的，因为Java也不知道你这个对象要处理哪些数据，所以这张表需要我们设计出来。

用什么来设计这张表呢？就是类（class），**类可以理解成对象的设计图**，或者对象的模板。

**一句话总结：对象可以理解成一张数据表，而数据表中可以有哪些数据，是由类来设计的。**



### 2.1.1 对象在计算机中的执行原理


按照我们之前讲的数组的执行原理，数组变量记录的其实数数组在堆内存中的地址。其实面向对象的代码执行原理和数组的执行原理是非常类似的。

其实`Student s1 = new Student();`这句话中的原理如下

- `Student s1`表示的是在栈内存中，创建了一个Student类型的变量，变量名为s1

- 而`new Student()`会在堆内存中创建一个对象，而对象中包含学生的属性名和属性值。同时系统会为这个Student对象分配一个地址值 `0x4f3f5b24`

- 接着把对象的地址赋值给栈内存中的变量s1，通过s1记录的地址就可以找到这个对象

- 当执行`s1.name="播妞"`时，其实就是通过s1找到对象的地址，再通过对象找到对象的name属性，再给对象的name属性赋值为`播妞`;  


![](/zzimages/1662213744520.png)



### 2.1.2 类和对象的一些注意事项

![](/zzimages/1662213891968.png)

> **第一条**：一个代码文件中，可以写多个class类，但是只能有一个是public修饰，且public修饰的类必须和文件名相同。

假设文件名为`Demo1.java`，这个文件中假设有两个类`Demo1类和Student类`，代码如下

```java
//public修饰的类Demo1，和文件名Demo1相同
public class Demo1{
    
}

class Student{
    
}
```

> **第二条**：对象与对象之间的数据不会相互影响，但是多个变量指向同一个对象会相互影响。

> **第三条**：当堆内存中的对象，没有被任何变量引用（指向）时，就会被判定为内存中的“垃圾”。Java存在自动垃圾回收机制，会自动清除掉垃圾对象，程序员不用操心。

### 2.1.3 this关键字


this就是一个变量，用在方法中，可以拿到当前类的对象。

我们看下图所示代码，通过代码来体会这句话到底是什么意思。**哪一个对象调用方法，方法中的this就是哪一个对象**。事实上在底层，哪一个对象调用方法，该方法会默认地添加一个this参数，然后把该对象的地址值传入this。

![](/zzimages/1662301823320.png)

上面代码运行结果如下

![](/zzimages/1662302089326.png)

**this有什么用呢？**

通过this在方法中可以访问本类对象的成员变量。this主要用来解决：变量名称冲突问题的。


### 2.1.4 构造器

- **什么是构造器？**

  构造器其实是一种特殊的方法，但是这个方法没有返回值类型，方法名必须和类名相同。

  比如一个Student类，构造器名称也必须叫Student；也有空参数构造器，也可以有有参数构造器。


- **构造器的特点？**

  在创建对象时，会调用构造器。关于构造器的特点，我们记住一句话：**new 对象就是在执行构造方法**

- **构造器的应用场景？**

  其实构造器就是用来创建对象的。可以在创建对象时给对象的属性做一些初始化操作。

- **构造器的注意事项？**

  1.在设计一个类时，如果不写构造器，Java会自动生成一个无参数构造器。
  2.一旦定义了有参数构造器，Java就不再提供空参数构造器，此时建议自己加一个无参数构造器。



## 2.2 封装性


**1. 什么是封装呢？**

所谓封装，就是用类设计对象处理某一个事物的数据时，应该把要处理的数据，以及处理数据的方法，都设计到一个对象中去。

封装的设计规范用8个字总结，就是：**合理隐藏、合理暴露**


**2. 封装在代码中的体现**

一般我们在设计一个类时，会将成员变量隐藏，然后把操作成员变量的方法对外暴露。

这里需要用到一个修饰符，叫private，**被private修饰的变量或者方法，只能在本类中被访问。**

`private double score;` 就相当于把score变量封装在了Student对象的内部，且不对外暴露，你想要在其他类中访问score这个变量就不能直接访问了；

如果你想给Student对象的score属性赋值，得调用对外暴露的方法`setScore(int score)`，在这个方法中可以对调用者传递过来的数据进行一些控制，更加安全。

## 2.3 实体JavaBean

**1. 什么是实体类？**

实体类就是一种特殊的类，它需要满足下面的要求：

1. 这个类中的成员变量都要私有，并且要对外提供响应的`getXXX` , `setXXX` 方法
2. 类中必须要有一个公共的无参构造器


其实我们会发现实体类中除了有给对象存、取值的方法就没有提供其他方法了。所以**实体类仅仅只是用来封装数据用的**。

**2. 实体类的应用场景**

在实际开发中，实体类仅仅只用来封装数据，而对数据的处理交给其他类来完成，以实现数据和数据业务处理相分离。如下图所示

![](/zzimages/1662336287570.png)

在实际应用中，会将类作为一种数据类型使用。如下图所示，在StudentOperator类中，定义一个Student类型的成员变量student，然后使用构造器给student成员变量赋值。

然后在Student的printPass()方法中，使用student调用Student对象的方法，对Student对象的数据进行处理。

![](/zzimages/1662337507608.png)


**补充**：成员变量和局部变量的区别

![](/zzimages/1662371089114.png)





# 第3章 String和ArrayList基础

## 3.1 概述

### 3.1.1 API

API（全称是Application Program Interface 应用程序接口），就是：**别人写好的一些程序，给咱们程序员直接拿去调用。**

Java官方其实已经给我们写好了很多很多类，每一个类中又提供了一系列方法来解决与这个类相关的问题。

- 比如String类，String代表字符串对象，可以用来封装字符串数据，并提供了很多操作字符串的方法。
- 比如ArrayList类，ArrayList是集合中最常用的一种，集合类似于数组，也是容器，用来装数据的，但集合的大小可变。

像这样的类还有很多，Java把这些类是干什么用的、类中的每一个方法是什么含义，编写成了文档，我们把这个文档称之为API文档。

**3. 今天我们主要学习两个类，一个是String类、还有一个是ArrayList类。**

有数组，为啥还学习集合？
答：数组定义完成并启动后，类型确定、长度固定。集合大小可变，提供的功能更为丰富，开发中用的更多。

### 3.1.2 包

**1. 什么是包**

在学习API类之前，我们先要学习包。因为Java官方提供的类有很多，为了对这些类进行分门别类的管理，别人把写好的类都是放在不同的包里的。

包其实类似于文件夹，一个包中可以放多个类文件。
建包的语法格式：

```java
//类文件的第一行定义包
package com.itheima.javabean;

public class 类名{
    
}
```

**2. 在自己的程序中，调用其他包中的程序，需要注意下面一个问题**

- 如果当前程序中，要调用自己所在包下的其他程序，可以直接调用。（同一个包下的类，互相可以直接调用）

- 如果当前程序中，要调用其他包下的程序，则必须在当前程序中导包, 才可以访问！

  导包格式：` import 包名.类名;`

- 如果当前程序中，要调用Java提供的程序，也需要先导包才可以使用；但是Java.lang包下的程序是不需要我们导包的，可以直接使用。

- 如果当前程序中，要调用多个不同包下的程序，而这些程序名正好一样，此时默认只能导入一个程序，另一个程序必须带包名访问。



## 3.2 String类

Java为了方便我们处理字符串，所以给我们提供了一个String类来代表字符串，这个类就是`java.lang`包下。

按照面向对象的编程思想，对于字符串的操作，只需要创建字符串对象，用字符串对象封装字符串数据，然后调用String类的方法就可以了。


### 3.2.1 String创建对象


String类的API中，有这么一句话：“Java程序中的所有字符串字面值（如"abc"）都是字符串的实例实现”。这里所说的实例实现，其实指的就是字符串对象。

意思就是：**所有Java的字符串字面值，都是字符串对象。**

- 所以创建String对象的第一种方式就有了

```java
String s1 = "abc"; // 这里"abc"就是一个字符串对象，用s1变量接收
```

- 创建String对象还有第二种方式，就是利用String类的构造方法创建String类的对象。

![](/zzimages/1662608166502.png)

我们前面学习过类的构造方法，执行构造方法需要用到new关键字。`new String(参数)`就是在执行String类的构造方法。 

下面我们演示通过String类的构造方法，创建String类的对象

```java
// 1、直接双引号得到字符串对象，封装字符串数据
String name = "黑马666";
System.out.println(name);

// 2、new String创建字符串对象，并调用构造器初始化字符串
String rs1 = new String();
System.out.println(rs1); // ""

String rs2 = new String("itheima");
System.out.println(rs2);

char[] chars = {'a', '黑', '马'};
String rs3 = new String(chars);
System.out.println(rs3);

byte[] bytes = {97, 98, 99};
String rs4 = new String(bytes);
System.out.println(rs4);
```


### 3.2.2 String类的常用方法


![](/zzimages/1662609378727.png)



```java
public class StringDemo2 {
    public static void main(String[] args) {
        String s = "黑马Java";
        // 1、获取字符串的长度
        System.out.println(s.length());

        // 2、提取字符串中某个索引位置处的字符
        char c = s.charAt(1);
        System.out.println(c);

        // 字符串的遍历
        for (int i = 0; i < s.length(); i++) {
            // i = 0 1 2 3 4 5
            char ch = s.charAt(i);
            System.out.println(ch);
        }

        System.out.println("-------------------");

        // 3、把字符串转换成字符数组，再进行遍历
        char[] chars = s.toCharArray();
        for (int i = 0; i < chars.length; i++) {
            System.out.println(chars[i]);
        }

        // 4、判断字符串内容，内容一样就返回true
        String s1 = new String("黑马");
        String s2 = new String("黑马");
        System.out.println(s1 == s2); // false
        System.out.println(s1.equals(s2)); // true

        // 5、忽略大小写比较字符串内容
        String c1 = "34AeFG";
        String c2 = "34aEfg";
        System.out.println(c1.equals(c2)); // false
        System.out.println(c1.equalsIgnoreCase(c2)); // true

        // 6、截取字符串内容 (包前不包后的)
        String s3 = "Java是最好的编程语言之一";
        String rs = s3.substring(0, 8);
        System.out.println(rs); // "Java是最好的"

        // 7、从当前索引位置一直截取到字符串的末尾
        String rs2 = s3.substring(5);
        System.out.println(rs2);

        // 8、把字符串中的某个内容替换成新内容，并返回新的字符串对象给我们
        String info = "这个电影简直是个垃圾，垃圾电影！！";
        String rs3 = info.replace("垃圾", "**");
        System.out.println(rs3);

        // 9、判断字符串中是否包含某个关键字
        String info2 = "Java是最好的编程语言之一，我爱Java,Java不爱我！";
        System.out.println(info2.contains("Java"));//true
        System.out.println(info2.contains("java"));//false
        System.out.println(info2.contains("Java2"));//false

        // 10、判断字符串是否以某个字符串开头。
        String rs4 = "张三丰";
        System.out.println(rs4.startsWith("张")); //true
        System.out.println(rs4.startsWith("张三")); //true
        System.out.println(rs4.startsWith("张三2")); //false

        // 11、把字符串按照某个指定内容分割成多个字符串，放到一个字符串数组中返回给我们
        String rs5 = "张无忌,周芷若,殷素素,赵敏";
        String[] names = rs5.split(",");
        for (int i = 0; i < names.length; i++) {
            System.out.println(names[i]);
        }
    }
}
```

**注**：对于字符串对象的比较，`==` 比较的是地址，容易出业务bug。要比较字符串内容应调用String提供的equals方法。


### 3.2.3 String的注意事项

- **注意事项1：String对象的内容不可改变，被称为不可变字符串对象**

我们先看一段代码，分析这段代码的结果

![](/zzimages/1662610347618.png)


需要注意的是：只要是以`""`方式写出的字符串对象，会在堆内存中的**字符串常量池**中存储。

执行第一句话时，会在堆内存的常量池中，创建一个字符串对象`“黑马”`，然后把`“黑马”`的地址赋值给`String name`

![](/zzimages/1662610697641.png)

当执行第二句话时，又会在堆内存的常量池中创建一个字符串`“程序员”`，和`“黑马”`拼接，拼接之后还会产生一个新的字符串对象`”黑马程序员“`，然后将新产生的`“黑马程序员”`对象的地址赋值给`String name`变量。

![](/zzimages/1662610978351.png)

此时你会发现，之前创建的字符串对象`“黑马”`内容确实是没有改变的，所以说String的对象是不可变的。

结论：每次试图改变字符串对象实际上是新产生了新的字符串对象了，变量每次都是指向了新的字符串对象，之前字符串对象的内容确实是没有改变的，因此说String的对象是不可变的。



- **注意事项2：字符串字面量和new出来字符串的区别**
  1. 只要是以`"..."`方式写出的字符串对象，会存储到字符串常量池，且相同内容的字符串只存储一份。如下图一所示
  2. 但通过`new`方式创建字符串对象，每new一次都会产生一个新的对象放在堆内存中。如下图二所示

![](/zzimages/1662618688215.png)

![](/zzimages/1662618651517.png)

![](/zzimages/20230702131758.png)

![](/zzimages/20230702132157.png)



## 3.3 ArrayList类


想要使用ArrayList存储数据，并对数据进行操作：

- 第一步：创建ArrayList容器对象。一般使用空参数构造方法，如下图所示：

- 第二步：调用ArrayList类的常用方法对容器中的数据进行操作。常用方法如下：

![](/zzimages/1662620389155.png)


```java
public class ArrayListDemo1 {
    public static void main(String[] args) {
        // 1、创建一个ArrayList的集合对象
        // ArrayList<String> list = new ArrayList<String>();
        // 从jdk 1.7开始才支持的
        ArrayList<String> list = new ArrayList<>();

        list.add("黑马");
        list.add("黑马");
        list.add("Java");
        System.out.println(list);

        // 2、往集合中的某个索引位置处添加一个数据
        list.add(1, "MySQL");
        System.out.println(list);

        // 3、根据索引获取集合中某个索引位置处的值
        String rs = list.get(1);
        System.out.println(rs);

        // 4、获取集合的大小（返回集合中存储的元素个数）
        System.out.println(list.size());

        // 5、根据索引删除集合中的某个元素值，会返回被删除的元素值给我们
        System.out.println(list.remove(1));
        System.out.println(list);

        // 6、直接删除某个元素值，删除成功会返回true，反之
        System.out.println(list.remove("Java"));
        System.out.println(list);

        list.add(1, "html");
        System.out.println(list);

        // 默认删除的是第一次出现的这个"黑马"的数据的
        System.out.println(list.remove("黑马"));
        System.out.println(list);

        // 7、修改某个索引位置处的数据，修改后会返回原来的值给我们
        System.out.println(list.set(1, "黑马程序员"));
        System.out.println(list);
    }
}
```




# 第4章 Java面向对象高级



## 4.1 static

static读作静态，可以用来修饰成员变量，也能修饰成员方法。我们先来学习static修饰成员变量。

### 4.1.1 static修饰成员变量

Java中的成员变量按照有无static修饰分为两种：**类变量、实例变量**。它们的区别如下图所示：

- 类变量(静态变量)：有static修饰，属于类，在计算机里只有一份，会被类的全部对象共享。
- 实例变量(对象的变量)：无static修饰，属于每个对象。

由于静态变量是属于类的，只需要通过类名就可以调用：**`类名.静态变量`** (虽然 `对象.静态变量` 也能访问静态变量，但并不推荐这么调用)

实例变量是属于对象的，需要通过对象才能调用：**`对象.实例变量`**

![](/zzimages/1663978808670.png)


**应用场景**：在实际开发中，如果某个数据只需要一份，且希望能够被共享（访问、修改），则该数据可以定义成类变量来记住。

### 4.1.2 static修饰成员方法

成员方法根据有无static也分为两类：**类方法、实例方法**

> 有static修饰的方法，是属于类的，称为**类方法**；调用时直接用类名调用即可。(不推荐使用对象来调用类方法)

> 无static修饰的方法，是属于对象的，称为实例方法；调用时，需要使用对象调用。

![](/zzimages/1664005554987.png)

补充：main方法就是个类方法，例如 Java 在运行 Test 类文件时，实际就是调用了 `Test.main()`

### 4.1.3 工具类


如果一个类中的方法全都是静态的，那么这个类中的方法就全都可以被类名直接调用，由于调用起来非常方便，就像一个工具一样，所以把这样的类就叫做工具类。

> 再补充一点，工具类里的方法全都是静态的，推荐用类名调用为了防止使用者用对象调用。我们可以把工具类的构造方法私有化。

```java
public class MyUtils{
    //私有化构造方法：这样别人就不能使用构造方法new对象了
    private MyUtils(){
        
    }
    
    //类方法
    public static String createCode(int n){
       ...
    }
}
```

### 4.1.4 static的注意事项

- 类方法中可以直接访问类成员/类方法，不可以直接访问实例成员/实例方法。
- 实例方法中既可以直接访问类成员/类方法，也可以直接访问实例成员/实例方法。
- 实例方法中可以出现this关键字，类方法中不可以出现this关键字的。


### 4.1.5 static应用（代码块）

代码块是类的5大成分之一（成员变量、构造器、方法、代码块、内部类）。代码块根据有无static修饰分为两种：静态代码块、实例代码块。

- 静态代码块：
  - 格式：`static { }`
  - 特点：类加载时自动执行，由于类只会加载一次，所以静态代码块也只会执行一次。注意静态代码块不需要创建对象就能够执行。
  - 作用：完成类的初始化，例如：对类变量的初始化赋值。


```java
public class Student {
    static int number = 80;
    static String schoolName;
    // 静态代码块
    static {
        System.out.println("静态代码块执行了~~");
        schoolName = "黑马";
    }
}
```

```java
public class Test {
    public static void main(String[] args) {
        System.out.println(Student.number);
        System.out.println(Student.number);
        System.out.println(Student.number);

        System.out.println(Student.schoolName); 
        // 以上代码将先后输出：
        // 静态代码块执行了~~
        // 80
        // 80
        // 80
        // 黑马
    }
}
```

- 实例代码块：
  - 格式：`{ }`
  - 特点：每次创建对象时，执行实例代码块，并在构造器前执行。
  - 作用：和构造器一样，都是用来完成对象的初始化的，例如：对实例变量进行初始化赋值。


```java
public class Student{
    //实例变量
	int age;
    //实例代码块：实例代码块会执行在每一个构造方法之前
    {
        System.out.println("实例代码块执行了~~");
        age = 18;
        System.out.println("有人创建了对象：" + this);
    }

    public Student(){
        System.out.println("无参数构造器执行了~~");
    }

    public Student(String name){
        System.out.println("有参数构造器执行了~~");
    }
}
```


```java
public class Test {
    public static void main(String[] args) {
        Student s1 = new Student();
        Student s2 = new Student("张三");
        System.out.println(s1.age);
        System.out.println(s2.age);
    }
    // 以上代码将先后输出：
    // 实例代码块执行了~~
    // 有人创建了对象：com.thuwsy.tmp.Student@6d311334
    // 无参数构造器执行了~~
    // 实例代码块执行了~~
    // 有人创建了对象：com.thuwsy.tmp.Student@682a0b20
    // 有参数构造器执行了~~
    // 18
    // 18
}
```


### 4.1.6 static应用（单例设计模式）

所谓设计模式指的是，一个问题通常有n种解法，其中肯定有一种解法是最优的，这个最优的解法被人总结出来了，称之为设计模式。设计模式有20多种，对应20多种软件开发中会遇到的问题。

**单例设计模式**

单例设计模式：确保一个类只有一个对象。

单例设计模式的实现方式很多，比如有：
- 饿汉式单例：拿对象时，对象早就创建好了。
- 懒汉式单例：拿对象时，才开始创建对象。

**饿汉式单例设计模式写法**：
- 把类的构造器私有。
- 定义一个类变量记住类的一个对象。
- 定义一个类方法，返回对象。

```java
public class A {
  // 2. 定义一个类变量记住类的一个对象
  private static A a = new A();

  // 1. 私有构造器
  private A() {}

  // 3. 定义一个类方法返回对象
  public static A getObject() {
    return a;
  }
}
```

**懒汉式单例设计模式写法**：
- 把类的构造器私有。
- 定义一个类变量用于存储对象。
- 提供一个类方法，保证返回的是同一个对象。

```java
public class B {
  // 2. 定义一个类变量量用于存储对象
  private static B b; // null

  // 1. 私有构造器
  private B() {}

  // 3. 提供一个类方法返回类的一个对象
  public static B getObject() {
    if (b == null)
      b = new B();
    return b;
  }
}
```

单例设计模式的应用场景：如任务管理器对象、获取运行时对象。在这些业务场景下，使用单例模式，可以避免浪费内存。


## 4.2 继承

### 4.2.1 继承快速入门

Java中提供了一个关键字extends，用这个关键字，可以让一个类和另一个类建立起父子关系。

继承的特点：子类能继承父类的非私有成员（成员变量、成员方法）。

继承后对象的创建：子类的对象是由子类、父类共同完成的。


```java
public class B extends A{
    // A类称为父类(基类或超类)
    // B类称为子类(派生类)
}
```

这里我们只需要关注一点：**子类对象实际上是由子、父类两张设计图共同创建出来的。**

所以，在子类对象的空间中，既有本类的成员，也有父类的成员。但是子类只能调用父类公有的成员。

![](/zzimages/1664010590126.png)



### 4.2.2 继承的好处

减少重复代码的编写，**继承可以提高代码的复用性**


```java
public class People{
    private String name;
    
    public String getName(){
        return name;
    }
    public void setName(String name){
        this.name=name;
    }
}
```

```java
public class Teacher extends People{
    private String skill; //技能
    
    public String getSkill(){
        return skill;
    }
    
    public void setSkill(String skill){
        this.skill=skill;
    }
    
    public void printInfo(){
        System.out.println(getName()+"具备的技能："+skill);
    }
}
```


### 4.2.3 权限修饰符

各位同学，在刚才使用继承编写的代码中我们有用到两个权限修饰符，一个是public（公有的）、一个是private（私有的），实际上还有两个权限修饰符，一个是protected（受保护的）、一个是缺省的（不写任何修饰符）。


> **什么是权限修饰符呢？**
>
> 权限修饰符是用来限制类的成员（成员变量、成员方法、构造器...）能够被访问的范围。

每一种权限修饰符能够被访问的范围如下

![](/zzimages/20230703121812.png)

下面我们用代码演示一下，在本类中可以访问到哪些权限修饰的方法。

```java
public class Fu {
    // 1、私有:只能在本类中访问
    private void privateMethod(){
        System.out.println("==private==");
    }

    // 2、缺省：本类，同一个包下的类
    void method(){
        System.out.println("==缺省==");
    }

    // 3、protected: 本类，同一个包下的类，任意包下的子类
    protected void protectedMethod(){
        System.out.println("==protected==");
    }

    // 4、public： 本类，同一个包下的类，任意包下的子类，任意包下的任意类
    public void publicMethod(){
        System.out.println("==public==");
    }

    public void test(){
        //在本类中，所有权限都可以被访问到
        privateMethod(); //正确
        method(); //正确
        protectedMethod(); //正确
        publicMethod(); //正确
    }
}
```

接下来，在和Fu类同一个包下，创建一个测试类Demo，演示同一个包下可以访问到哪些权限修饰的方法。

```java
public class Demo {
    public static void main(String[] args) {
        Fu f = new Fu();
        // f.privateMethod();	//私有方法无法使用
        f.method();
        f.protectedMethod();
        f.publicMethod();
    }
}
```

接下来，在另一个包下创建一个Fu类的子类，演示不同包下的子类中可以访问哪些权限修饰的方法。

```java
public class Zi extends Fu {
    //在任意包下的子类中，只能访问到public、protected修饰的方法
    public void test(){
        // privateMethod(); // 报错
        // method(); // 报错
        protectedMethod();	//正确
        publicMethod();	//正确
    }
}
```

接下来，在和Fu类不同的包下，创建一个测试类Demo2，演示一下不同包的无关类，能访问到哪些权限修饰的方法；

```java
public class Demo2 {
    public static void main(String[] args) {
        Fu f = new Fu();
        // f.privateMethod(); // 报错
        // f.method();		  //报错
        // f.protecedMethod();//报错
        f.publicMethod();	//正确

        Zi zi = new Zi();
        // zi.protectedMethod();  //报错，不同包中，只能在子类Zi中访问protected，而Demo2并不是Fu的子类
    }
}
```



### 4.2.4 单继承 和 Object

**Java语言只支持单继承(一个类只能继承一个类)，不支持多继承，但是可以多层继承**。

**Object类是Java所有类的祖宗类。我们写的任何一个类，其实都是Object的子类或子孙类。**

```java
public class Test {
    public static void main(String[] args) {
        // 1、Java是单继承的：一个类只能继承一个直接父类；
        // 2、Object类是Java中所有类的祖宗。
        A a = new A();
        B b = new B();

        ArrayList list = new ArrayList();
        list.add("java");
        System.out.println(list.toString());
    }
}

class A {} //extends Object{}
class B extends A{}
// class C extends B , A{} // 报错
class D extends B{}
```

### 4.2.5 方法重写


> **什么是方法重写**

当子类觉得父类中的某个方法不好用，或者无法满足自己的需求时，子类可以重写一个方法名称、参数列表一样的方法，去覆盖父类的这个方法，这就是方法重写。

**注意：重写后，方法的访问遵循就近原则**。

下面我们看一个代码演示。写一个A类作为父类，定义两个方法print1和print2

```java
public class A {
    public void print1(){
        System.out.println("111");
    }

    public void print2(int a, int b){
        System.out.println("111111");
    }
}
```

再写一个B类作为A类的子类，重写print1和print2方法。

```java
public class B extends A{
    // 方法重写
    @Override // 安全，可读性好
    public void print1(){
        System.out.println("666");
    }

    // 方法重写
    @Override
    public void print2(int a, int b){
        System.out.println("666666");
    }
}
```

接下来，在测试类中创建B类对象，调用方法

```java
public class Test {
    public static void main(String[] args) {
        B b =  new B();
        b.print1();
        b.print2(2, 3);
    }
}
```

执行代码，我们发现真正执行的是B类中的print1和print2方法

**注意事项**

1. 重写的方法上面，可以加一个注解 `@Override` , 用于标注这个方法是重写的父类方法，他可以指定java编译器检查我们方法重写的格式是否正确，代码可读性也会更好。
2. 子类重写父类方法时，访问权限必须大于或者等于父类该方法的权限( public > protected > 缺省 )
3. 重写的方法返回值类型，必须与被重写的方法返回值类型一样，或者范围更小
4. 私有方法、静态方法不能被重写，如果重写会报错。


> **方法重写的应用场景**

方法重写的应用场景之一就是：**子类重写Object的toString()方法，以便返回对象的内容。**

比如：有一个Student类，这个类会默认继承Object类。其实Object类中有一个toString()方法，直接通过Student对象调用Object的toString()方法，会得到对象的地址值。(事实上调用 `System.out.println(s);` 时会默认调用 `System.out.println(s.toString());`)

但是，此时不想调用父类Object的toString()方法，那就可以在Student类中重新写一个toSting()方法，用于返回对象的属性值。

```java
package com.itheima.d12_extends_override;

public class Student extends Object{
    private String name;
    private int age;

    public Student() {
    }

    public Student(String name, int age) {
        this.name = name;
        this.age = age;
    }

    @Override
    public String toString() {
        return "Student{" +
                "name='" + name + '\'' +
                ", age=" + age +
                '}';
    }
}
```

所以如果我们打印一个对象 `System.out.println(s);` 发现得到的不是地址值时，说明这个类的 `toString()` 方法一定被重写了。

### 4.2.6 子类中访问成员的特点

**原则：在子类中访问其他成员（成员变量、成员方法），是依据就近原则的**

- 先子类局部范围找
- 然后子类成员范围找
- 然后父类成员范围找，如果父类范围还没有找到则报错


**如果子父类中，出现了重名的成员，会优先使用子类的；如果此时一定要在子类中使用父类的，可以通过super关键字，指定访问父类的成员：`super.父类成员变量/父类成员方法`**

```java
public class Z extends F {
    String name = "子类名称";

    public void showName(){
        String name = "局部名称";
        System.out.println(name); // 局部名称
        System.out.println(this.name); // 子类成员变量
        System.out.println(super.name); // 父类的成员变量
    }

    @Override
    public void print1(){
        System.out.println("==子类的print1方法执行了=");
    }

    public void showMethod(){
        print1(); // 子类的
        super.print1(); // 父类的
    }
}
```

### 4.2.7 子类构造器的特点

**子类构造器的特点：子类的全部构造器，都会先调用父类的构造器，再执行自己。**

**子类构造器是如何实现调用父类构造器的：**
- 默认情况下，子类全部构造器的第一行代码都是 `super();` （写不写都有） ，它会调用父类的无参数构造器。
- 如果父类没有无参数构造器或者不想使用默认的`super()`方式调用父类构造器，则我们必须在子类构造器的第一行手写`super(a, b, ...)`，指定去调用父类的有参数构造器。


> **在本类中访问自己的构造方法**

任意类的构造器中，是可以通过 `this()` 去调用该类的其他构造器的。注意：`this(…) 、super(…)` 都只能放在构造器的第一行，因此，有了 `this(…)` 就不能写 `super(…)` 了，反之亦然。

```java
this(): 调用本类的空参数构造器
this(参数): 调用本类有参数的构造器
```


## 4.3 多态


### 4.3.1 多态概述

> 多态是在继承/实现情况下的一种现象，表现为：对象多态、行为多态。

比如：Teacher和Student都是People的子类，代码可以写成下面的样子

![](/zzimages/16642789439056.png)

![](/zzimages/1664278943905.png)

```java
public class People {
    public String name = "People";
    public void run() {
        System.out.println("人可以跑");
    }
}
public class Teacher extends People{
    public String name = "Teacher";
    @Override
    public void run() {
        System.out.println("老师跑的贼慢");
    }
}
public class Student extends People {
    public String name = "Student";
    @Override
    public void run() {
        System.out.println("学生跑的贼快");
    }
}
public class Test {
    public static void main(String[] args) {
        // 对象多态
        // 编译看左边(p1和p2都是People类型，但指向的对象不一样)
        People p1 = new Teacher();
        People p2 = new Student();
        // 行为多态
        // 运行看右边(run方法行为不一样)
        p1.run(); // 老师跑的贼慢
        p2.run(); // 学生跑的贼快
        // 成员变量没有多态(多态只有对象多态、行为多态)
        System.out.println(p1.name); // People
        System.out.println(p2.name); // People
    }
}
```

**多态的前提：有继承/实现关系；存在父类引用子类对象；存在方法重写**。

**注意：** 多态是对象、行为的多态，Java中的属性(成员变量)不谈多态。



### 4.3.2 多态的好处



> 1.在多态形式下，右边的代码`new Teacher()`是解耦合的，更便于扩展和维护。

- 怎么理解这句话呢？比如刚开始p1指向Teacher对象，run方法执行的就是Teacher对象的业务；假如p1指向Student对象，run方法执行的自然是Student对象的业务。

> 2.定义方法时，使用父类类型作为形参，可以接收一切子类对象，扩展行更强，更便利。


### 4.3.3 类型转换

虽然多态形式下有一些好处，但是也有一些弊端。在多态形式下，不能调用子类特有的方法，比如在Teacher类中多了一个teach方法，在Student类中多了一个study方法，这两个方法在多态形式下是不能直接调用的(因为编译的时候把p1和p2看作People)。

```java
// 自动类型转换：父类 变量名 = new 子类();
People p = new Teacher();
// 强制类型转换：子类 变量名 = (子类) 父类变量;
Teacher t = (Teacher) p;
```

**强制类型转换的注意事项：**

- 存在继承/实现关系就可以在编译阶段进行强制类型转换，编译阶段不会报错。
- 但运行时，如果发现对象的真实类型与强转后的类型不同，就会报类型转换异常（ClassCastException）的错误出来。
    ```java
    People p = new Teacher();
    Student s = (Student) p; //编译时不会报错，但运行时会出现异常java.lang.ClassCastException
    ```
- 强转前，Java建议使用instanceof关键字，判断当前对象的真实类型，再进行强转。
    ```java
    People p = new Teacher();
    if (p instanceof Teacher)
        Teacher t = (Teacher) p;
    ```

关于多态转型问题，我们最终记住一句话：**原本是什么类型，才能还原成什么类型**



## 4.4 final关键字


### 4.4.1 final修饰符的特点

final关键字是最终的意思，可以修饰类、修饰方法、修饰变量。

- final修饰类：该类称为最终类，特点是不能被继承
- final修饰方法：该方法称为最终方法，特点是不能被重写。
- final修饰变量：该变量只能被赋值一次。

```java
// final修饰变量的特点
// 情况一
final double a = 3.14; // final修饰，必须赋值
a = 3.15; // 报错，不能再给a赋值

// 情况二
public static void pay(final double z) {
    z = 0.9; // 第二次赋值，报错。因为传参时是第一次赋值
}

// 情况三
final int[] arr = {10, 20, 30};
arr = null; // 第二次赋值，报错
arr[1] = 200; // 但可以修改数组元素
```

final修饰变量的注意事项：

- final修饰基本类型的变量，变量存储的数据不能被改变。
- final修饰引用类型的变量，变量存储的地址不能被改变，但地址所指向对象的内容是可以被改变的。

### 4.4.2 常量


- 被 `static final` 修饰的成员变量，称之为常量。
- 作用：通常用于记录系统的配置信息

```java
// 常量建议名称全部大写，多个单词用下划线连接
public static final String IT_NAME = "黑马";
```

使用常量记录系统配置信息的优势、执行原理：

- 代码可读性更好，可维护性也更好。
- 程序编译后，常量会被“宏替换”：出现常量的地方全部会被替换成其记住的字面量，这样可以保证使用常量和直接用字面量的性能是一样的。


## 4.5 抽象


### 4.5.1 认识抽象类


- 在Java中有一个关键字叫abstract，它就是抽象的意思，它可以修饰类也可以修饰成员方法。
- 被abstract修饰的类，就是抽象类
- 被abstract修饰的方法，就是抽象方法（不允许有方法体，只能有方法签名）

```java
//abstract修饰类，这个类就是抽象类
public abstract class A{
    //abstract修饰方法，这个方法就是抽象方法
    public abstract void test();
}
```

注意事项：

- 抽象类中不一定有抽象方法，但有抽象方法的类一定是抽象类。
- 类该有的成员（成员变量、方法、构造器）抽象类都可以有。
- 抽象类最主要的特点：抽象类不能创建对象，仅作为一种特殊的父类，让子类继承并实现。
- 一个类继承抽象类，必须重写完抽象类的全部抽象方法，否则这个类也必须定义成抽象类。


### 4.5.2 抽象类的好处

父类知道每个子类都要做某个行为，但每个子类要做的情况不一样，父类就定义成抽象方法，交给子类去重写实现，我们设计这样的抽象类，**就是为了更好地支持多态**。

```java
public abstract class Animal {
    private String name;
    public abstract void cry();
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
}
public class Cat extends Animal{
    @Override
    public void cry() {
        System.out.println(getName() + "cat cry");
    }
}
public class Dog extends Animal{
    @Override
    public void cry() {
        System.out.println(getName() + "dog cry");
    }
}
public class Test {
    public static void main(String[] args) {
        Animal a = new Dog();
        a.setName("二花");
        a.cry();
    }
}
```

### 4.5.3 模板方法设计模式

**模板方法设计模式主要解决方法中存在重复代码的问题**

比如A类和B类都有sing()方法，sing()方法的开头和结尾都是一样的，只是中间一段内容不一样。此时A类和B类的sing()方法中就存在一些相同的代码。

怎么解决上面的重复代码问题呢？我们可以写一个抽象类C类，在C类中写一个doSing()的抽象方法。再写一个sing()模板方法。


- 第1步：定义一个抽象类，把子类中相同的代码写成一个模板方法，建议使用final关键字修饰模板方法。
- 第2步：把模板方法中不能确定的代码写成抽象方法，并在模板方法中调用。
- 第3步：子类继承抽象类，只需要重写父类抽象方法就可以了。


```java
public abstract class C {
    // 模板方法
    public final void sing() {
        System.out.println("唱一首歌");
        doSing();
        System.out.println("唱完了");
    }
    // 抽象方法
    public abstract void doSing();
}
public class A extends C{
    @Override
    public void doSing() {
        System.out.println("歌名：AAA");
    }
}
public class B extends C{
    @Override
    public void doSing() {
        System.out.println("歌名：BBB");
    }
}
public class Test {
    public static void main(String[] args) {
        B b = new B();
        b.sing();
    }
}

```

## 4.6 接口

### 4.6.1 认识接口

Java提供了一个关键字interface，用这个关键字来定义接口这种特殊结构。传统的接口中只能定义成员变量和成员方法。

- 接口中的成员变量一定是常量，所以我们可以省略 `public static final`
- 接口中的成员方法一定是抽象方法，所以我们可以省略 `public abstract`

```java
public interface 接口名{
    //成员变量（常量）
    //成员方法（抽象方法）
}
```

- **接口不能创建对象；接口是用来被类实现（implements）的，实现接口的类称为实现类。**
- **一个类可以实现多个接口，实现类实现多个接口，必须重写完全部接口的全部抽象方法，否则实现类需要定义成抽象类。**

```java
修饰符 class 实现类 implements 接口1, 接口2, 接口3 {

}
```

### 4.6.2 接口的好处

- 弥补了类单继承的不足，一个类同时可以实现多个接口。
- 让程序可以面向接口编程，这样程序员可以灵活方便的切换各种业务实现。

我们看一个案例演示，假设有一个Studnet学生类，还有一个Driver司机的接口，还有一个Singer歌手的接口。现在要写一个A类，想让他既是学生，偶然也是司机能够开车，偶尔也是歌手能够唱歌。那我们代码就可以这样设计，如下：

```java
class Student{
}
interface Driver{
    void drive();
}
interface Singer{
    void sing();
}
//A类是Student的子类，同时也实现了Dirver接口和Singer接口
class A extends Student implements Driver, Singer{
    @Override
    public void drive() {
    }
    @Override
    public void sing() {
    }
}
public class Test {
    public static void main(String[] args) {
        //想唱歌的时候，A类对象就表现为Singer类型
        Singer s = new A();
        s.sing();
		
        //想开车的时候，A类对象就表现为Driver类型
        Driver d = new A();
        d.drive();
    }
}
```

### 4.6.3 接口的案例

各位同学，关于接口的特点以及接口的好处我们都已经学习完了。接下来我们做一个案例，先来看一下案例需求.

![](/zzimages/1665102202635.png)

```java
public class Student {
    private String name;
    private char sex;
    private double score;
    public Student() {
    }
    public Student(String name, char sex, double score) {
        this.name = name;
        this.sex = sex;
        this.score = score;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public char getSex() {
        return sex;
    }
    public void setSex(char sex) {
        this.sex = sex;
    }
    public double getScore() {
        return score;
    }
    public void setScore(double score) {
        this.score = score;
    }
}

public interface StudentOperator {
    void printAllInfo(ArrayList<Student> students);
    void printAverageScore(ArrayList<Student> students);
}

public class StudentOpImpl1 implements StudentOperator{
    @Override
    public void printAllInfo(ArrayList<Student> students) {
        System.out.println("---------全部学生信息如下---------");
        for (int i = 0; i < students.size(); i++) {
            Student tmp = students.get(i);
            System.out.println("姓名：" + tmp.getName() + "  性别：" + tmp.getSex() + "  成绩：" + tmp.getScore());
        }
        System.out.println("-------------------------------");
    }

    @Override
    public void printAverageScore(ArrayList<Student> students) {
        double sum = 0;
        for (int i = 0; i < students.size(); i++)
            sum += students.get(i).getScore();
        System.out.println("全部学生的平均分为：" + sum / students.size());
    }
}

public class StudentOpImpl2 implements StudentOperator{
    @Override
    public void printAllInfo(ArrayList<Student> students) {
        int count1 = 0, count2 = 0;
        System.out.println("---------全部学生信息如下---------");
        for (int i = 0; i < students.size(); i++) {
            Student tmp = students.get(i);
            System.out.println("姓名：" + tmp.getName() + "  性别：" + tmp.getSex() + "  成绩：" + tmp.getScore());
            if (tmp.getSex() == '男')
                count1++;
            else count2++;
        }
        System.out.println("男生人数为：" + count1 + "  女生人数为：" + count2);
        System.out.println("班级总人数是" + students.size());
        System.out.println("-------------------------------");
    }

    @Override
    public void printAverageScore(ArrayList<Student> students) {
        double sum = 0, max = 0, min = 100;
        for (int i = 0; i < students.size(); i++) {
            double tmp = students.get(i).getScore();
            sum += tmp;
            max = Math.max(max, tmp);
            min = Math.min(min, tmp);
        }
        System.out.println("最高分：" + max + "  最低分：" + min);
        sum -= max + min;
        System.out.println("去掉最高最低分后全部学生的平均分为：" + sum / (students.size() - 2));
    }
}

public class ClassManager {
    private ArrayList<Student> students = new ArrayList<>();
    private StudentOperator studentOperator = new StudentOpImpl1();

    public ClassManager() {
        students.add(new Student("张三", '男', 100));
        students.add(new Student("李四", '女', 90));
        students.add(new Student("王五", '男', 80));
        students.add(new Student("六六", '女', 70));
    }
    public void printInfo() {
        studentOperator.printAllInfo(students);
    }
    public void printScore() {
        studentOperator.printAverageScore(students);
    }
}

public class Test {
    public static void main(String[] args) {
        ClassManager cla = new ClassManager();
        cla.printInfo();
        cla.printScore();
    }
}
```

注意：如果想切换班级管理系统的业务功能，随时可以将ClassManager中的StudentOpImpl1切换为StudentOpImpl2


### 4.6.4 接口JDK8的新特性

随着JDK版本的升级，在JDK8版本以后接口中能够定义的成员也做了一些更新，从JDK8开始，接口中新增三种方法形式。新增的方法增强了接口的能力，更便于项目的扩展和维护。

```java
public interface A {
    /**
     * 1、默认方法：必须使用default修饰，默认会被public修饰，所以可省略public
     * 它是实例方法，即对象的方法，必须使用实现类的对象来访问。
     */
    default void test1(){
        System.out.println("===默认方法==");
        test2();
    }

    /**
     * 2、私有方法：必须使用private修饰。(JDK 9开始才支持的)
     *   只能在本接口中访问，比如可以在test1()中调用
     */
    private void test2(){
        System.out.println("===私有方法==");
    }

    /**
     * 3、静态方法：必须使用static修饰，默认会被public修饰，所以可省略public
     * 注意：只能用接口名来调用，例如 A.test3();
     */
     static void test3(){
        System.out.println("==静态方法==");
     }
}
```

### 4.6.5 接口的其他细节


- 一个接口可以同时继承多个接口，从而便于便于实现类去实现。

```java
//比如：D接口继承C、B、A
public interface D extends C, B, A{

}
```

1. 一个接口继承多个接口，如果多个接口中存在方法签名冲突，则此时不支持多继承
2. 一个类实现多个接口，如果多个接口中存在方法签名冲突，则此时不支持多实现
3. 一个类继承了父类，又同时实现了接口，父类中和接口中有同名的默认方法，实现类会优先用父类的。
4. 一个类实现了多个接口，多个接口中存在同名的默认方法，可以不冲突，只要这个类重写该方法即可。



## 4.7 内部类

内部类是类中的五大成分之一（成员变量、方法、构造器、内部类、代码块），如果一个类定义在另一个类的内部，这个类就是内部类。

当一个类的内部，包含一个完整的事物，且这个事物没有必要单独设计时，就可以把这个事物设计成内部类。

内部类有四种形式，分别是成员内部类、静态内部类、局部内部类、匿名内部类。


### 4.7.1 成员内部类

成员内部类就是类中的一个普通成员，类似于普通的成员变量、成员方法。

```java
public class Outer {
    private int age = 99;
    // 成员内部类
    public class Inner {
        private int age = 88;
        public void test() {
            System.out.println(age); // 88
            int age = 77;
            System.out.println(age); // 77
            System.out.println(this.age); // 88
            System.out.println(Outer.this.age); // 99
        }
    }
}
public class Test {
    public static void main(String[] args) {
        Outer.Inner in = new Outer().new Inner();
        in.test();
    }
}
```

注意：JDK16之前，成员内部类中不能定义静态成员，JDK 16开始也可以定义静态成员了。

- 成员内部类创建对象的格式如下

```java
//外部类名.内部类名 对象名 = new 外部类().new 内部类();
Outer.Inner in = new Outer().new Inner();
//调用内部类的方法
in.test();
```

- 成员内部类中访问其他成员的特点：
  - 和前面学过的实例方法一样，成员内部类的实例方法中，同样可以直接访问外部类的实例成员、静态成员。
  - 可以在成员内部类的实例方法中，拿到当前外部类对象，格式是：外部类名.this



### 4.7.2 静态内部类

静态内部类是有static修饰的内部类，属于外部类自己持有。

```java
public class Outer {
    private int age = 99;
    public static String schoolName="黑马";

    // 静态内部类
    public static class Inner{
        //静态内部类访问外部类的静态变量，是可以的
        //静态内部类访问外部类的实例变量，是不行的
        public void test(){
            System.out.println(schoolName); //99
            //System.out.println(age);   //报错
        }
    }
}
```

静态内部类创建对象的格式：

```java
//外部类名.内部类名 对象名 = new 外部类.内部类();
Outer.Inner in = new Outer.Inner();
in.test();
```

静态内部类中访问外部类成员的特点：

- 可以直接访问外部类的静态成员，不可以直接访问外部类的实例成员。



### 4.7.3 局部内部类

局部内部类是定义在在方法中、代码块中、构造器等执行体中的类，和局部变量一样，只能在方法中有效。所以局部内部类的局限性很强，一般在开发中是不会使用的。

```java
public class Outer{
    public void test(){
        //局部内部类
        class Inner{
            public void show(){
                System.out.println("Inner...show");
            }
        }
        
        //局部内部类只能在方法中创建对象，并使用
        Inner in = new Inner();
        in.show();
    }
}
```


### 4.7.4 匿名内部类

> **1. 认识匿名内部类，基本使用**


匿名内部类是一种特殊的局部内部类；所谓匿名，指的是程序员不需要为这个类声明名字。

下面就是匿名内部类的格式：

```java
new 父类/接口(参数值){
    @Override
    重写父类/接口的方法;
}
```

匿名内部类本质就是一个子类，并会立即创建出一个子类对象。

```java
public class Test {
    public static void main(String[] args) {
        Animal cat = new Animal() { //匿名内部类
            @Override
            public void cry() {
                System.out.println("喵喵喵");
            }
        };
        cat.cry();
    }
}
abstract class Animal {
    public abstract void cry();
}
```

需要注意的是，匿名内部类在编写代码时没有名字，编译后系统会为自动为匿名内部类生产字节码，字节码的名称会以`外部类$1.class`的方法命名。

**匿名内部类的作用：简化了创建子类对象、实现类对象的书写格式。**



> **2. 匿名内部类的应用场景**

学习完匿名内部类的基本使用之后，我们再来看一下匿名内部类在实际中的应用场景。其实一般我们会主动的使用匿名内部类。

**只有在调用方法时，当方法的形参是一个接口或者抽象类，为了简化代码书写，而直接传递匿名内部类对象给方法**。这样就可以少写一个类，所以匿名内部类通常作为一个参数传输给方法。

```java
public class Test {
    public static void main(String[] args) {
        go(new Crying() {
            @Override
            public void cry() {
                System.out.println("汪汪汪");
            }
        });
    }
    public static void go(Crying s) {
        s.cry();
    }
}
interface Crying {
    void cry();
}
```


```java
public class Test {
    public static void main(String[] args) {
        // GUI编程
        // 1. 创建窗口
        JFrame win = new JFrame("登录界面");
        JPanel panel = new JPanel();
        win.add(panel);

        JButton btn = new JButton("登录");
        panel.add(btn);

        // 2. 给按钮绑定单击事件监听器(用匿名内部类)
        btn.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JOptionPane.showMessageDialog(win, "登录一下");
            }
        });

        win.setSize(400, 400);
        win.setLocationRelativeTo(null);
        win.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        win.setVisible(true);
    }
}
```


## 4.8 枚举

### 4.8.1 认识枚举

枚举是一种特殊的类，它的格式是：

```java
修饰符 enum 枚举类名{
    枚举项1, 枚举项2, 枚举项3;
    其他成员/方法;
}
```

其实枚举项就表示枚举类的对象，只是这些对象在定义枚举类时就预先写好了，以后就只能用这几个固定的对象。


![](/zzimages/20230704162434.png)

注意：

- 枚举类的第一行只能罗列一些名称，这些名称都是常量，并且每个常量记住的都是枚举类的一个对象。
- 枚举类的构造器都是私有的（写不写都只能是私有的），因此，枚举类对外不能创建对象。
- 枚举都是最终类，不可以被继承。
- 枚举类中，从第二行开始，可以定义类的其他各种成员。
- 编译器为枚举类新增了几个方法，并且枚举类都是继承：java.lang.Enum类的，从enum类也会继承到一些方法。

```java
public enum A {
    X, Y, Z;
    private String name;
    public String getName() { return name;}
    public void setName(String name) { this.name = name;}
}
public class Test {
    public static void main(String[] args) {
        A a1 = A.X; // 想要获取枚举类中的枚举项，需要用类名调用
        System.out.println(a1); // 输出X
        // A a = new A(); 枚举类的构造器是私有的，不能对外创建对象

        // 枚举类提供一些额外的API
        A[] as = A.values(); // 拿到全部对象
        A a2 = A.valueOf("Y"); // 等价于 A a2 = A.Y
        System.out.println(a2.name()); // Y
        System.out.println(a2.ordinal()); // 1, 获取索引
    }
}
```

### 4.8.2 抽象枚举

```java
// 抽象枚举
public enum B {
    X() {
        @Override
        public void go() { }
    }, Y("张三") { // 枚举项后面加括号，就是在执行枚举类的带参数构造方法。
        @Override
        public void go() {
            System.out.println(getName() + "在跑~~");
        }
    };
    private String name;
    B() {}
    B(String name) { this.name = name; }
    public abstract void go();
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
}
public class Test {
    public static void main(String[] args) {
        B y = B.Y;
        y.go(); // 张三在跑~~
    }
}
```

### 4.8.3 使用枚举可以实现单例模式

```java
public enum C {
    X; //单例
}
```


### 4.8.4 枚举的应用场景

枚举的应用场景是这样的：**枚举一般表示一组信息，然后作为参数进行传输。**

如果选择定义一个一个的常量来表示一组信息，并作为参数传输，则参数值不受约束。但如果选择定义枚举表示一组信息，并作为参数传输，则代码可读性好，参数值得到了约束，对使用者更友好。

```java
public enum Constant{
    BOY, GIRL;
}
public class Test{
    public static void main(String[] args){
        //调用方法，传递男生
        provideInfo(Constant.BOY);
    }
    
    public static void provideInfo(Constant c){
        switch(c){
            case BOY:
                System.out.println("展示一些信息给男生看");
                break;
            case GIRL:
                System.out.println("展示一些信息给女生看");
                break;
        }
    }
}
```

## 4.9 泛型

### 4.9.1 认识泛型

所谓泛型指的是，在定义类、接口、方法时，同时声明了一个或者多个类型变量（如：`<E>`），称为泛型类、泛型接口、泛型方法，它们统称为泛型。比如我们前面学过的ArrayList类就是一个泛型类。

- **泛型的作用：泛型提供了在编译阶段约束所能操作的数据类型，并自动进行检查的能力！这样可以避免强制类型转换，及其可能出现的异常。**

- **泛型的本质：把具体的数据类型作为参数传给类型变量。**

### 4.9.2 自定义泛型类


自定义泛型类的格式如下

```java
// 这里的<E, T>其实指的就是类型变量，可以是一个，也可以是多个。
// 类型变量建议用大写的英文字母，常用的有：E、T、K、V 等
修饰符 class 类名<E, T>{
    
}
```

```java
public class MyArrayList<E> {
    private Object[] arr = new Object[100];
    private int size = 0;
    public boolean add(E e) {
        arr[size++] = e;
        return true;
    }
    public E get(int index) {
        return (E) arr[index];
    }
}
public class Test {
    public static void main(String[] args) {
        MyArrayList<String> arr = new MyArrayList<>();
        arr.add("java1");
        arr.add("java2");
        System.out.println(arr.get(1)); // java2
    }
}
```

除此之外，类型变量也可以做一定的限定：

```java
public class MyClass<E extends Animal> {
}
public class Test {
    public static void main(String[] args) {
        // 报错，必须是Animal类型或者其子类
        // MyClass<String> a = new MyClass<>(); 
        
        MyClass<Animal> b = new MyClass<>();
        MyClass<Cat> c = new MyClass<>();
    }
}
```

### 4.9.3 自定义泛型接口

泛型接口其实指的是在接口中把不确定的数据类型用`<类型变量>`表示。定义格式如下：

```java
修饰符 interface 接口名<类型变量>{
    
}
```

例如
```java
// 泛型接口
public interface Data<T> {

}
// 实现类
public class StringData implements Data<String> {

}
```

### 4.9.4 泛型方法

泛型方法的格式

```java
修饰符 <类型变量, 类型变量> 返回值类型 方法名(形参列表){
    
}
```

```java
public class Test{
    public static void main(String[] args){
        ArrayList<Animal> ans = new ArrayList<>();
        go(ans);
    }
    
    //这是一个泛型方法<T>表示一个不确定的数据类型，由调用者确定
    public static <T> void go(ArrayList<T> t){
    
    }
}
```

### 4.9.5 泛型限定

在**使用泛型**的时候可以用通配符 `?` 代表一切类型。例如上一节的代码可简写为

```java
public class Test{
    public static void main(String[] args){
        ArrayList<Animal> ans = new ArrayList<>();
        go(ans);
    }
    
    public static void go(ArrayList<?> t){
    
    }
}
```

我们还可以用泛型上限和泛型下限来限定泛型数据类型的范围。

- 泛型上限：`<? extends Car>`，表示 `?` 能接收的必须是`Car`及其子类。
- 泛型下限：`<? super Car>`，表示 `?` 能接受的必须是`Car`及其父类。


### 4.9.6 泛型擦除

泛型的擦除问题和注意事项：

- 泛型是工作在编译阶段的，一旦程序编译成class文件，class文件中就不存在泛型了，这就是泛型擦除。
- 泛型不支持基本数据类型，只能支持对象类型（引用数据类型）。所以 `ArrayList<int>` 这样的语法是错误的，如果一定要存整数，可以使用 `ArrayList<Integer>`，其中 `Integer` 是整数对象类型。



# 第5章 常用API





### 4.1 Object类

Object类是Java中所有类的祖宗类，因此，Java中所有类的对象都可以直接使用Object类中提供的一些方法。

> **4.1.1 toString()方法**


```java
public String toString()
    调用toString()方法可以返回对象的字符串表示形式。
    默认的格式是：“包名.类名@哈希值16进制”
```

注意如果 `s` 是对象类型，则 `System.out.println(s);` 等价于 `System.out.println(s.toString());`

`toString()` 方法存在的意义就是为了被子类重写，以便返回对象具体的内容。


> **4.1.2 equals(Object o)方法**


```java
public boolean equals(Object o)
    - 判断此对象与参数对象是否"相等"
    - 默认比较对象的地址，作用与 == 没有区别
```

因此，直接比较两个对象的地址是否相同完全可以用 `==` 替代 `equals`，`equals` 存在的意义就是为了被子类重写，以便子类自己来定制比较规则（比如比较对象内容）。

```java
public class Student{
    private String name;
    private int age;
    
    public Student(String name, int age){
        this.name=name;
        this.age=age;
    }
    
    @Override
    public String toString(){
        return "Student{name=‘"+name+"’, age="+age+"}";
    }
    
    //重写equals方法，按照对象的属性值进行比较
    @Override
    public boolean equals(Object o) {
        // 如果地址相同，直接返回true
        if (this == o) return true;
        // 如果o是null，返回false
        // 如果两个对象的类型class不同，返回false
        if (o == null || getClass() != o.getClass()) return false;
        
        Student student = (Student) o;
        // 比较两个对象的内容
        return age == student.age && Objects.equals(name, student.name);
    }
}
```


> **4.1.3 clone() 方法**

接下来，我们学习Object类的clone()方法，克隆。当某个对象调用这个方法时，这个方法会复制一个一模一样的新对象返回。

```java
protected Object clone()
    克隆当前对象，返回一个新对象
```

- 想要调用clone()方法，必须让被克隆的类实现Cloneable接口(Cloneable只是一个标记接口，里面没有内容，代表一种规则)。
- 必须重写clone()方法

```java
public class User implements Cloneable{
    private int id;
    private String name;
    private double[] scores;

    @Override
    protected Object clone() throws CloneNotSupportedException {
        return super.clone();
    }
}
public class Test {
    public static void main(String[] args) throws CloneNotSupportedException {
        User u1 = new User();
        User u2 = (User) u1.clone();
    }
}
```

上面演示的克隆方式，是一种浅克隆的方法，浅克隆的意思：**拷贝出的新对象，与原对象中的数据一模一样（引用类型拷贝的只是地址）**。

还有一种拷贝方式，称之为深克隆：**对象中基本类型的数据直接拷贝；对象中的字符串数据拷贝的还是地址；对象中还包含的其他对象，不会拷贝地址，会创建新对象**。

重写一下 `clone` 即可实现深克隆。

```java
    protected Object clone() throws CloneNotSupportedException {
        // 先克隆得到一个新对象
        User u = (User) super.clone();
        // 再将新对象中的引用类型数据，再次克隆
        u.scores = u.scores.clone();
        return u;
    }
```



### 4.2 Objects类

Objects是一个工具类，提供了很多操作对象的静态方法给我们使用。

#### equals

```java
// 先做非空判断，再比较两个对象。用起来更安全。
public static boolean equals(Object a, Object b);
```

源码：
```java
public static boolean equals(Object a, Object b) {
    return (a == b) || (a != null && a.equals(b));
}
```

#### isNull

```java
// 判断对象是否为null，为null返回true ,反之
public static boolean isNull(Object obj) 
```

#### nonNull

```java
// 判断对象是否不为null，不为null则返回true, 反之
public static boolean nonNull(Object obj)
```


### 4.3 基本类型包装类

同学们，接下来我们学习一下包装类。为什么要学习包装类呢？因为在Java中有一句很经典的话，万物皆对象。Java中的8种基本数据类型还不是对象，所以要把它们变成对象，变成对象之后，可以提供一些方法对数据进行操作。

Java中8种基本数据类型都用一个包装类与之对一个，如下图所示

![](/zzimages/1665758797003.png)



> **4.2.1 创建包装类对象**

```java
// 1. 使用Integer类的静态方法valueOf(数据)
Integer a = Integer.valueOf(10);

// 2. 一般直接用自动装箱的写法(基本数据类型可以自动转换为包装类型)
Integer b = 10;

// 3. 自动拆箱(包装类型可以自动转换为基本数据类型)
int c = b;

// 4. 装箱和拆箱在使用集合时就有体现
ArrayList<Integer> list = new ArrayList<>();
// 添加的元素是基本类型，实际上会自动装箱为Integer类型
list.add(100);
// 获取元素时，会将Integer类型自动拆箱为int类型
int e = list.get(0);
```

> **4.2.2 包装类数据类型转换**

![](/zzimages/20230704214124.png)


```java
Integer a = 23;
String s1 = Integer.toString(a); // "23"
String s2 = a.toString(); // "23"
String s3 = a + ""; // "23"，开发中更常用

String str1 = "29";
int i1 = Integer.parseInt(str1); // 29
int i2 = Integer.valueOf(str1); // 29，开发中更常用

String str2 = "99.5";
double d1 = Double.parseDouble(str2); // 99.5
double d2 = Double.valueOf(str2); // 99.5，开发中更常用
```





# day04——常用API

## 一、 StringBuilder类

- StringBuilder代表可变字符串对象，相当于是一个容器，它里面装的字符串是可以改变的，就是用来操作字符串的。
- 好处：StringBuilder比String更合适做字符串的修改操作，效率更高，代码也更加简洁。

![](/zzimages/20230704222043.png)

**1.1 StringBuilder方法演示**


```java
public class Test{
    public static void main(String[] args){
        StringBuilder sb = new StringBuilder("itehima");
        
        //1.拼接内容
        sb.append(12);
        sb.append("黑马");
        sb.append(true);
        
        //2.append方法，支持链式编程
        sb.append(666).append("黑马2").append(666);
        System.out.println(sb); // itehima12黑马true666黑马2666
        
        //3.反转操作
        sb.reverse();
        System.out.println(sb); // 6662马黑666eurt马黑21amiheti
        
        //4.返回字符串的长度
        System.out.println(sb.length());
        
        //5.StringBuilder还可以转换为字符串
        String s = sb.toString();
        System.out.println(s); // 6662马黑666eurt马黑21amiheti
    }
}
```

对于字符串相关的操作，如频繁的拼接、修改等，建议用StringBuidler，效率更高! 如果操作字符串较少，或者不需要操作，以及定义字符串变量，还是建议用String。

**补充**：还有一个类叫作 StringBuffer，它的用法与 StringBuilder 是一模一样的。但 StringBuilder 是线程不安全的，而 StringBuffer 是线程安全的。



## 二、StringJoiner类

StringJoiner类是JDK8开始才有的，跟StringBuilder一样，也是用来操作字符串的，也可以看成是一个容器，创建之后里面的内容是可变的。好处：不仅能提高字符串的操作效率，并且在有些场景下使用它操作字符串，代码会更简洁，StringJoiner号称是拼接神器。


![](/zzimages/20230704223818.png)


下面演示一下StringJoiner的基本使用(注意StringJoiner的add方法中的参数只能是字符串类型)

```java
public class Test{
    public static void main(String[] args){
        //参数1：间隔符
        //参数2：开头
        //参数3：结尾
        StringJoiner s1 = new StringJoiner(", ","[","]");
        s1.add("java1");
        s1.add("java2");
        s1.add("java3");
        System.out.println(s1); //结果为：[java1, java2, java3]
    }
}
```



## 三、Math类

Math代表数学，是一个工具类，里面提供的都是对数据进行操作的一些静态方法。

![](/zzimages/20230705112019.png)


## 四、 System类

System代表程序所在的系统，也是一个工具类。


```java
// 终止当前运行的Java虚拟机。
public static void exit​(int status)
// 返回当前系统的时间毫秒值形式
public static long currentTimeMillis​()
```
- 时间毫秒值指的是从1970年1月1日00:00:00走到此刻的总的毫秒数(1970年1月1日算C语言的生日)


## 五、Runtime类

接下来，我们再学习一个Java的运行时类，叫Runtime类。这个类可以用来获取JVM的一些信息，也可以用这个类去执行其他的程序。Runtime代表程序所在的运行环境，它是一个单例类。

![](/zzimages/20230705113253.png)

```java
public class RuntimeTest {
    public static void main(String[] args) throws IOException, InterruptedException {
        // 1、public static Runtime getRuntime() 返回与当前Java应用程序关联的运行时对象。
        Runtime r = Runtime.getRuntime();

        // 2、public void exit(int status) 终止当前运行的虚拟机,该参数用作状态代码; 按照惯例，非零状态代码表示异常终止。
        // r.exit(0);

        // 3、public int availableProcessors(): 获取虚拟机能够使用的处理器数。
        System.out.println(r.availableProcessors());

        // 4、public long totalMemory() 返回Java虚拟机中的内存总量。
        System.out.println(r.totalMemory()/1024.0/1024.0 + "MB"); // 1024 = 1K     1024 * 1024 = 1M

        // 5、public long freeMemory() 返回Java虚拟机中的可用内存量
        System.out.println(r.freeMemory()/1024.0/1024.0 + "MB");

        // 6、public Process exec(String command) 启动某个程序，并返回代表该程序的对象。
        // r.exec("D:\\soft\\XMind\\XMind.exe");
        Process p = r.exec("QQ"); // 需要把QQ路径配置到环境变量中
        Thread.sleep(5000); // 让程序在这里暂停5s后继续往下走！！
        p.destroy(); // 销毁！关闭程序！
    }
}
```



## 六、BigDecimal类

```java
public class Test {
    public static void main(String[] args) {
        System.out.println(0.1 + 0.2);
        System.out.println(1.0 - 0.32);
        System.out.println(1.015 * 100);
        System.out.println(1.301 / 100);
    }
}
```

运行以上代码，我们会发现，结果并和我们想看到的不太一样。如下图所示

![](/zzimages/1667398959905.png)

为了解决计算精度损失的问题，Java给我们提供了BigDecimal类，它提供了一些方法可以对数据进行四则运算，而且不丢失精度，同时还可以保留指定的小数位。

![](/zzimages/20230705114657.png)

```java
public class Test2 {
    public static void main(String[] args) {
        // 目标：掌握BigDecimal进行精确运算的方案。
        double a = 0.1;
        double b = 0.2;

        // 1、把浮点型数据封装成BigDecimal对象，再来参与运算。
        // a、public BigDecimal(double val) 得到的BigDecimal对象是无法精确计算浮点型数据的。 注意：不推荐使用这个，
        // b、public BigDecimal(String val)  得到的BigDecimal对象是可以精确计算浮点型数据的。 可以使用。
        // c、public static BigDecimal valueOf(double val): 通过这个静态方法得到的BigDecimal对象是可以精确运算的。是最好的方案。
        BigDecimal a1 = BigDecimal.valueOf(a);
        BigDecimal b1 = BigDecimal.valueOf(b);

        // 2、public BigDecimal add(BigDecimal augend): 加法
        BigDecimal c1 = a1.add(b1);

        // 3、public BigDecimal subtract(BigDecimal augend): 减法
        BigDecimal c2 = a1.subtract(b1);

        // 4、public BigDecimal multiply(BigDecimal augend): 乘法
        BigDecimal c3 = a1.multiply(b1);

        // 5、public BigDecimal divide(BigDecimal b): 除法
        BigDecimal c4 = a1.divide(b1);

//        BigDecimal d1 = BigDecimal.valueOf(0.1);
//        BigDecimal d2 = BigDecimal.valueOf(0.3);
//        BigDecimal d3 = d1.divide(d2);
//        System.out.println(d3); // 运行报错，无法精确表达结果

        // 6、public BigDecimal divide(另一个BigDecimal对象，精确几位，舍入模式) : 除法，可以设置精确几位。
        BigDecimal d1 = BigDecimal.valueOf(0.1);
        BigDecimal d2 = BigDecimal.valueOf(0.3);
        BigDecimal d3 = d1.divide(d2,  2, RoundingMode.HALF_UP); // 0.33
        System.out.println(d3);

        // 7、public double doubleValue() : 把BigDecimal对象又转换成double类型的数据。
        double db1 = d3.doubleValue();
        print(db1);
    }

    public static void print(double a){
        System.out.println(a);
    }
}

```

## 五、Date类

接下来，我们学习一下Date类，Java中是由这个类的对象用来表示日期或者时间。

Date对象记录的时间是用毫秒值来表示的。Java语言规定，1970年1月1日0时0分0秒认为是时间的起点，此时记作0，那么1000（1秒=1000毫秒）就表示1970年1月1日0时0分1秒，依次内推。

下面是Date类的构造方法，和常见的成员方法，利用这些API写代码尝试一下

![](/zzimages/1667399443159.png)

```java
public class Test1Date {
    public static void main(String[] args) {
        // 1、创建一个Date的对象：代表系统当前时间信息的。
        Date d = new Date();
        System.out.println(d);

        // 2、拿到时间毫秒值。
        long time = d.getTime();
        System.out.println(time);

        // 3、把时间毫秒值转换成日期对象： 2s之后的时间是多少。
        time += 2 * 1000;
        Date d2 = new Date(time);
        System.out.println(d2);

        // 4、直接把日期对象的时间通过setTime方法进行修改
        Date d3 = new Date();
        d3.setTime(time);
        System.out.println(d3);
    }
}
```


## 六、SimpleDateFormat类

SimpleDateFormat类可以转换Date对象表示日期时间的显示格式。

- 我们把Date对象转换为指定格式的日期字符串这个操作，叫做**日期格式化，**

- 反过来把指定格式的日期符串转换为Date对象的操作，叫做**日期解析。**

接下来，我们先演示一下日期格式化，需要用到如下的几个方法

![](/zzimages/1667399804244.png)

注意：创建SimpleDateFormat对象时，在构造方法的参数位置传递日期格式，而日期格式是由一些特定的字母拼接而来的。我们需要记住常用的几种日期/时间格式

```java
字母	   表示含义
yyyy	年
MM		月
dd		日
HH		时
mm		分
ss		秒
SSS		毫秒
EEE     星期几
a       上午/下午

"2022年12月12日" 的格式是 "yyyy年MM月dd日"
"2022-12-12 12:12:12" 的格式是 "yyyy-MM-dd HH:mm:ss"
按照上面的格式可以任意拼接，但是字母不能写错
```

SimpleDateFormat还可以解析字符串时间成为日期对象：
```java
public Date parse​(String source)
```

```java
public class Test2SimpleDateFormat {
    public static void main(String[] args) throws ParseException {
        // 目标：掌握SimpleDateFormat的使用。
        // 1、准备一些时间
        Date d = new Date();
        System.out.println(d);

        long time = d.getTime();
        System.out.println(time);

        // 2、格式化日期对象，和时间 毫秒值。
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss EEE a");

        String rs = sdf.format(d);
        String rs2 = sdf.format(time);
        System.out.println(rs);
        System.out.println(rs2);
        System.out.println("----------------------------------------------");

        // 目标：掌握SimpleDateFormat解析字符串时间 成为日期对象。
        String dateStr = "2022-12-12 12:12:11";
        // 1、创建简单日期格式化对象 , 指定的时间格式必须与被解析的时间格式一模一样，否则程序会出bug.
        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date d2 = sdf2.parse(dateStr);
        System.out.println(d2);
    }
}
```

## 七、Calendar类

Calendar类表示日历，它提供了一些比Date类更好用的方法。Calendar代表的是系统此刻时间对应的日历，通过它可以单独获取、修改时间中的年、月、日、时、分、秒等。

![](/zzimages/1667400365583.png)

```java
public class Test4Calendar {
    public static void main(String[] args) {
        // 1、得到系统此刻时间对应的日历对象。
        Calendar now = Calendar.getInstance();
        System.out.println(now);

        // 2、获取日历中的某个信息
        int year = now.get(Calendar.YEAR);
        int days = now.get(Calendar.DAY_OF_YEAR);

        // 3、拿到日历中记录的日期对象。
        Date d = now.getTime();
        System.out.println(d);

        // 4、拿到时间毫秒值
        long time = now.getTimeInMillis();
        System.out.println(time);

        // 5、修改日历中的某个信息
        now.set(Calendar.MONTH, 9); // 修改月份成为10月份，注意其中的MONTH是从0开始的。
        now.set(Calendar.DAY_OF_YEAR, 125); // 修改成一年中的第125天。
        System.out.println(now);

        // 6、为某个信息增加或者减少多少
        now.add(Calendar.DAY_OF_YEAR, 100);
        now.add(Calendar.DAY_OF_YEAR, -10);
        now.add(Calendar.DAY_OF_MONTH, 6);
        now.add(Calendar.HOUR, 12);
        now.set(2026, 11, 22);
        System.out.println(now);
    }
}
```




## 九、JDK8日期、时间、日期时间

接下来，我们学习一下JDK8新增的日期类。为什么以前的Date类就可以表示日期，为什么要有新增的日期类呢？原因如下

![](/zzimages/20230705153357.png)


JDK8新增的日期类分得更细致一些，比如表示年月日用LocalDate类、表示时间秒用LocalTime类、而表示年月日时分秒用LocalDateTime类等；除了这些类还提供了对时区、时间间隔进行操作的类等。它们几乎把对日期/时间的所有操作都通过了API方法，用起来特别方便。

![](/zzimages/1667400655334.png)

先学习表示日期、时间、日期时间的类；有LocalDate、LocalTime、以及LocalDateTime类。仔细阅读代码，你会发现这三个类的用法套路都是一样的。它们都是不可变对象，进行修改时会获取新对象。

![](/zzimages/20230705153651.png)

![](/zzimages/20230705153727.png)

![](/zzimages/20230705153750.png)

![](/zzimages/20230705153831.png)

![](/zzimages/20230705153909.png)

- LocalDate类的基本使用

```java
public class Test1_LocalDate {
    public static void main(String[] args) {
        // 0、获取本地日期对象(不可变对象)
        LocalDate ld = LocalDate.now();
        System.out.println(ld); // "2023-07-05"

        // 1、获取日期对象中的信息
        int month = ld.getMonthValue(); // 月
        int dayOfYear = ld.getDayOfYear();  // 一年中的第几天
        int dayOfWeek = ld.getDayOfWeek().getValue(); // 星期几

        // 2、直接修改某个信息
        LocalDate ld2 = ld.withYear(2099);

        // 3、把某个信息加多少
        LocalDate ld3 = ld.plusYears(2);

        // 4、获取指定日期的LocalDate对象(参数：年，月，日)
        LocalDate ld4 = LocalDate.of(2099, 12, 11);

        // 5、判断2个日期对象，是否相等，在前还是在后
        System.out.println(ld4.isBefore(ld));// false
    }
}
```

- LocalTime类的基本使用

```java
public class Test2_LocalTime {
    public static void main(String[] args) {
        // 0、获取本地时间对象(不可变对象)
        LocalTime lt = LocalTime.now(); // 时 分 秒 纳秒
        System.out.println(lt); // "15:47:23.437787500"

        // 1、获取时间中的信息
        int nano = lt.getNano(); //纳秒

        // 2、修改时间
        // 3、加多少
        // 4、减多少
        // 5、获取指定时间的LocalTime对象(参数：时,分,秒(,纳秒))
        LocalTime lt2 = LocalTime.of(12, 12, 12);
        // 6、判断2个时间对象，是否相等，在前还是在后
    }
}
```

- LocalDateTime类的基本使用

```java
public class Test3_LocalDateTime {
    public static void main(String[] args) {
        // 0、获取本地日期和时间对象(不可变对象)
        LocalDateTime ldt = LocalDateTime.now(); // 年 月 日 时 分 秒 纳秒
        System.out.println(ldt); // "2023-07-05T15:50:55.288620200"

        // 1、可以获取日期和时间的全部信息
        // 2、修改日期时间信息
        // 3、加多少
        // 4、减多少
        // 5、获取指定日期和时间的LocalDateTime对象(参数：年,月,日,时,分,秒(,纳秒))
        // 6、判断2个日期时间对象，是否相等，在前还是在后
        // 7、可以把LocalDateTime转换成LocalDate和LocalTime
        // public LocalDate toLocalDate()
        // public LocalTime toLocalTime()
        // public static LocalDateTime of(LocalDate date, LocalTime time)
        LocalDate ld = ldt.toLocalDate();
        LocalTime lt = ldt.toLocalTime();
        LocalDateTime ldt2 = LocalDateTime.of(ld, lt);
    }
}
```



## 十、JDK8日期（时区）

接着，我们学习代表时区的两个类。由于世界各个国家与地区的经度不同，各地区的时间也有所不同，因此会划分为不同的时区。每一个时区的时间也不太一样。

![](/zzimages/20230705160924.png)

![](/zzimages/20230705160848.png)


```java
public class Test4_ZoneId_ZonedDateTime {
    public static void main(String[] args) {
        // 目标：了解时区和带时区的时间。
        // 1、ZoneId的常见方法：
        // public static ZoneId systemDefault(): 获取系统默认的时区
        ZoneId zoneId = ZoneId.systemDefault();
        System.out.println(zoneId.getId());
        System.out.println(zoneId);

        // public static Set<String> getAvailableZoneIds(): 获取Java支持的全部时区Id
        System.out.println(ZoneId.getAvailableZoneIds());

        // public static ZoneId of(String zoneId) : 把某个时区id封装成ZoneId对象。
        ZoneId zoneId1 = ZoneId.of("America/New_York");

        // 2、ZonedDateTime：带时区的时间。
        // public static ZonedDateTime now(ZoneId zone): 获取某个时区的ZonedDateTime对象。
        ZonedDateTime now = ZonedDateTime.now(zoneId1);
        System.out.println(now);

        // 世界标准时间了
        ZonedDateTime now1 = ZonedDateTime.now(Clock.systemUTC());
        System.out.println(now1);

        // public static ZonedDateTime now()：获取系统默认时区的ZonedDateTime对象
        ZonedDateTime now2 = ZonedDateTime.now();
        System.out.println(now2);

        // Calendar instance = Calendar.getInstance(TimeZone.getTimeZone(zoneId1));
    }
}
```


## 十一、JDK8日期（Instant类）

接下来，我们来学习Instant这个类。通过获取Instant的对象可以拿到此刻的时间，该时间由两部分组成：从1970-01-01 00:00:00 开始走到此刻的总秒数+不够1秒的纳秒数。

该类提供的方法如下图所示，可以用来获取当前时间，也可以对时间进行加、减、获取等操作。

![](/zzimages/1667401373923.png)

**作用：可以用来记录代码的执行时间，或用于记录用户操作某个事件的时间点。** 传统的Date类，只能精确到毫秒，并且是可变对象；新增的Instant类，可以精确到纳秒，并且是不可变对象，推荐用Instant代替Date。

```java
public class Test5_Instant {
    public static void main(String[] args) {
       // 1、创建Instant的对象，获取此刻时间信息
        Instant now = Instant.now(); // 不可变对象

        // 2、获取总秒数
        long second = now.getEpochSecond();
        System.out.println(second);

        // 3、不够1秒的纳秒数
        int nano = now.getNano();
        System.out.println(nano);

        System.out.println(now);

        Instant instant = now.plusNanos(111);

        // Instant对象的作用：做代码的性能分析，或者记录用户的操作时间点
        Instant now1 = Instant.now();
        // 代码执行。。。。
        Instant now2 = Instant.now();

        LocalDateTime l = LocalDateTime.now();
    }
}
```



## 十二、JDK8日期（格式化器）

接下来，我们学习一个新增的日期格式化类，叫DateTimeFormater。它可以从来对日期进行格式化和解析。它代替了原来的SimpleDateFormat类。

需要用到的方法，如下图所示

![](/zzimages/1667401564173.png)


```java
public class Test6_DateTimeFormatter {
    public static void main(String[] args) {
        // 1、创建一个日期时间格式化器对象出来。
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy年MM月dd日 HH:mm:ss");

        // 2、对时间进行格式化
        LocalDateTime now = LocalDateTime.now();
        System.out.println(now);

        String rs = formatter.format(now); // 正向格式化
        System.out.println(rs);

        // 3、格式化时间，其实还有一种方案。
        String rs2 = now.format(formatter); // 反向格式化
        System.out.println(rs2);

        // 4、解析时间：解析时间一般使用LocalDateTime提供的解析方法来解析。
        String dateStr = "2029年12月12日 12:12:11";
        LocalDateTime ldt = LocalDateTime.parse(dateStr, formatter);
        System.out.println(ldt);
    }
}

```

## 十三、JDK8日期（Period类）

除以了上新增的类，JDK8还补充了两个类，一个叫Period类、一个叫Duration类。其中Period用来计算日期间隔（年、月、日），Duration用来计算时间间隔（时、分、秒、纳秒）

![](/zzimages/20230705211132.png)

注意：Period **只能计算两个LocalDate对象之间的间隔**

```java
public class Test7_Period {
    public static void main(String[] args) {
        LocalDate start = LocalDate.of(2029, 8, 10);
        LocalDate end = LocalDate.of(2029, 12, 15);

        // 1、创建Period对象，封装两个日期对象。
        Period period = Period.between(start, end);

        // 2、通过period对象获取两个日期对象相差的信息。
        System.out.println(period.getYears());
        System.out.println(period.getMonths());
        System.out.println(period.getDays());
    }
}
```



## 十四、JDK8日期（Duration类）

接下来，我们学习Duration类。它是用来表示两个时间对象的时间间隔。**可以用于计算两个时间对象相差的天数、小时数、分数、秒数、纳秒数；支持LocalTime、LocalDateTime、Instant等时间**


![](/zzimages/20230705211307.png)


```java
public class Test8_Duration {
    public static void main(String[] args) {
        LocalDateTime start = LocalDateTime.of(2025, 11, 11, 11, 10, 10);
        LocalDateTime end = LocalDateTime.of(2025, 11, 11, 11, 11, 11);
        // 1、得到Duration对象
        Duration duration = Duration.between(start, end);

        // 2、获取两个时间对象间隔的信息
        System.out.println(duration.toDays());// 间隔多少天
        System.out.println(duration.toHours());// 间隔多少小时
        System.out.println(duration.toMinutes());// 间隔多少分
        System.out.println(duration.toSeconds());// 间隔多少秒
        System.out.println(duration.toMillis());// 间隔多少毫秒
        System.out.println(duration.toNanos());// 间隔多少纳秒

    }
}
```




# day05-算法和数据结构

## 一、Arrays类

### 1.1 Arrays基本使用


下面我们用代码来演示一下：**遍历、拷贝、排序等操作**。需要用到的方法如下

![](/zzimages/20230705222832.png)

```java
public class ArraysTest1 {
    public static void main(String[] args) {
        // 1、public static String toString(类型[] arr): 返回数组的内容
        int[] arr = {10, 20, 30, 40, 50, 60};
        System.out.println(Arrays.toString(arr));

        // 2、public static 类型[] copyOfRange(类型[] arr, 起始索引, 结束索引) ：拷贝数组（指定范围，包前不包后）
        int[] arr2 = Arrays.copyOfRange(arr, 1, 4);
        System.out.println(Arrays.toString(arr2));

        // 3、public static copyOf(类型[] arr, int newLength)：拷贝数组，可以指定新数组的长度。
        int[] arr3 = Arrays.copyOf(arr, 10);
        System.out.println(Arrays.toString(arr3));

        // 4、public static setAll(double[] array, IntToDoubleFunction generator)：把数组中的原数据改为新数据又存进去。
        double[] prices = {99.8, 128, 100};
        //                  0     1    2
        // 把所有的价格都打八折，然后又存进去。
        Arrays.setAll(prices, new IntToDoubleFunction() {
            @Override
            public double applyAsDouble(int value) {
                // value = 0  1  2 索引
                return prices[value] * 0.8;
            }
        });
        System.out.println(Arrays.toString(prices));

        // 5、public static void sort(类型[] arr)：对数组进行排序(默认是升序排序)
        Arrays.sort(prices);
        System.out.println(Arrays.toString(prices));
    }
}
```



### 1.2 Arrays操作对象数组


如果数组中存储的元素类型是自定义的对象，如何排序呢？接下来，我们就学习一下Arrays如何对对象数组进行排序。


- **排序方式1** ：让该对象的类实现Comparable(比较规则)接口，然后重写compareTo方法，自己来制定比较规则。

```java
public class Student implements Comparable<Student>{
    private String name;
    private double height;
    private int age;

    @Override
    public int compareTo(Student o) {
        // 升序排序约定：
        // 约定1：认为左边对象 大于 右边对象 请您返回正整数
        // 约定2：认为左边对象 小于 右边对象 请您返回负整数
        // 约定3：认为左边对象 等于 右边对象 请您一定返回0
		/* if(this.age > o.age){
            return 1;
        }else if(this.age < o.age){
            return -1;
        }
        return 0;*/

        //上面的if语句，也可以简化为下面的一行代码
        return this.age - o.age; // 按照年龄升序排列
        // return o.age - this.age; // 按照年龄降序排列
    }
    
    @Override
    public String toString() {
        return "Student{" +
                "name='" + name + '\'' +
                ", height=" + height +
                ", age=" + age +
                '}';
    }
}
```

- **排序方式2** ：在调用`Arrays.sort(数组,Comparator比较器);`时，除了传递数组之外，再创建Comparator比较器接口的匿名内部类对象，然后自己制定比较规则。

```java
// 对数组进行排序(支持自定义排序规则)
public static <T> void sort(T[] arr, Comparator<? super T> c) 
```

```java
public class ArraysTest2 {
    public static void main(String[] args) {
        // 目标：掌握如何对数组中的对象进行排序。
        Student[] students = new Student[4];
        students[0] = new Student("蜘蛛精", 169.5, 23);
        students[1] = new Student("紫霞", 163.8, 26);
        students[2] = new Student("紫霞", 163.8, 26);
        students[3] = new Student("至尊宝", 167.5, 24);

		// 2、public static <T> void sort(T[] arr, Comparator<? super T> c)
        // 参数一：需要排序的数组
        // 参数二：Comparator比较器对象（用来制定对象的比较规则）
        Arrays.sort(students, new Comparator<Student>() {
            @Override
            public int compare(Student o1, Student o2) {
                // 制定比较规则：左边对象 o1   右边对象 o2
                // 升序排序约定：
                // 约定1：认为左边对象 大于 右边对象 请您返回正整数
                // 约定2：认为左边对象 小于 右边对象 请您返回负整数
                // 约定3：认为左边对象 等于 右边对象 请您一定返回0
//                if(o1.getHeight() > o2.getHeight()){
//                    return 1;
//                }else if(o1.getHeight() < o2.getHeight()){
//                    return -1;
//                }
//                return 0; // 升序
                 return Double.compare(o1.getHeight(), o2.getHeight()); // 升序
                // return Double.compare(o2.getHeight(), o1.getHeight()); // 降序
            }
        });
        System.out.println(Arrays.toString(students));
    }
}
```

![](/zzimages/20230705225505.png)



## 二、Lambda表达式

接下来，我们学习一个JDK8新增的一种语法形式，叫做Lambda表达式。**作用：用于简化匿名内部类代码的书写。**

### 2.1 Lambda表达式基本使用

Lamdba是有特有的格式的，按照下面的格式来编写Lamdba。

```java
(被重写方法的形参列表) -> {
    被重写方法的方法体代码;
}
```

**注意：Lambda表达式只能简化函数式接口的匿名内部类**。函数式接口指的是有且仅有一个抽象方法的接口。将来我们见到的大部分函数式接口，上面都可能会有一个 `@FunctionalInterface` 的注解，有该注解的接口就必定是函数式接口。

```java
public class Test {
    public static void main(String[] args) {
        Swim student = () -> {
            System.out.println("学生在游泳~~~");
        };
        student.swimming();
    }
}
@FunctionalInterface
interface Swim {
    void swimming();
}
```


### 2.2 Lambda表达式省略规则

刚才我们学习了Lambda表达式的基本使用。Java觉得代码还不够简单，于是还提供了Lamdba表达式的几种简化写法。具体的简化规则如下

```java
  Lambda的标准格式：
	(参数类型1 参数名1, 参数类型2 参数名2) -> {
		...方法体的代码...
		return 返回值;
	}

1. 参数类型可以省略不写
	(参数名1, 参数名2)->{
		...方法体的代码...
		return 返回值;
	}
	
2. 如果只有一个参数，()也可以省略。
    参数名1 -> { ... }

3. 如果方法体代码只有一行代码，可以省略大括号不写，同时要省略分号。此时，如果这行代码是return语句，也必须去掉return。
	(a, b) -> a - b
```

## 三、JDK8新特性（方法引用）

各位小伙伴，接下来我们学习JDK8的另一个新特性，叫做方法引用。我们知道Lambda是用来简化匿名代码的书写格式的，而方法引用是用来进一步简化Lambda表达式的。


### 3.1 静态方法的引用

使用场景：如果某个Lambda表达式里只是调用一个静态方法，并且前后参数的形式一致，就可以使用静态方法引用。

语法：`类名::静态方法`

示例：我们用一个类CompareByData类封装Lambda表达式的方法体代码，然后采用静态方法引用。

```java
public class Test {
    public static void main(String[] args) {
        Student[] students = new Student[4];
        students[0] = new Student("蜘蛛精", 169.5, 23);
        students[1] = new Student("紫霞", 163.8, 26);
        students[2] = new Student("紫霞", 163.8, 26);
        students[3] = new Student("至尊宝", 167.5, 24);

        // 原始写法：对数组中的学生对象，按照年龄升序排序
        Arrays.sort(students, new Comparator<Student>() {
            @Override
            public int compare(Student o1, Student o2) {
                return o1.getAge() - o2.getAge(); // 按照年龄升序排序
            }
        });
        // 使用Lambda简化后的形式
        Arrays.sort(students, (o1, o2) -> o1.getAge() - o2.getAge());
        // 等价于：
        Arrays.sort(students, (o1, o2) -> CompareByData.compareByAge(o1, o2));
        // 使用静态方法引用
        Arrays.sort(students, CompareByData::compareByAge);
        System.out.println(Arrays.toString(students));
    }
}
class CompareByData {
    public static int compareByAge(Student o1, Student o2){
        return o1.getAge() - o2.getAge(); // 升序排序的规则
    }
}
```

### 3.2 实例方法的引用

使用场景：如果某个Lambda表达式里只是调用一个实例方法，并且前后参数的形式一致，就可以使用实例方法引用。

语法：`对象名::实例方法`

示例：基于上面的案例，在CompareByData类中，添加一个实例方法，用于封装Lambda表达式的方法体。

```java
public class Test {
    public static void main(String[] args) {
        Student[] students = new Student[4];
        students[0] = new Student("蜘蛛精", 169.5, 23);
        students[1] = new Student("紫霞", 163.8, 26);
        students[2] = new Student("紫霞", 163.8, 26);
        students[3] = new Student("至尊宝", 167.5, 24);

        // 原始写法：对数组中的学生对象，按照年龄升序排序
        Arrays.sort(students, new Comparator<Student>() {
            @Override
            public int compare(Student o1, Student o2) {
                return o1.getAge() - o2.getAge(); // 按照年龄升序排序
            }
        });
        // 使用Lambda简化后的形式
        Arrays.sort(students, (o1, o2) -> o1.getAge() - o2.getAge());
        // 等价于：
        CompareByData cmp = new CompareByData();
        Arrays.sort(students, (o1, o2) -> cmp.compareByAgeDesc(o1, o2));
        // 使用实例方法引用
        Arrays.sort(students, cmp::compareByAgeDesc);
        System.out.println(Arrays.toString(students));
    }
}
class CompareByData {
    public int compareByAgeDesc(Student o1, Student o2) {
        return o1.getAge() - o2.getAge();
    }
}
```


### 3.3 特定类型方法的引用


使用场景：如果某个Lambda表达式里只是调用一个实例方法，并且前面参数列表中的第一个参数是作为方法的主调，后面的所有参数都是作为该实例方法的入参的，则此时就可以使用特定类型的方法引用。

语法：`类型::方法`

示例：

```java
public class Test {
    public static void main(String[] args) {
        String[] names = {"boby", "angela", "Andy" ,"dlei", "caocao", "Babo", "jack", "Cici"};
        // 要求忽略首字符大小写进行排序
        Arrays.sort(names, new Comparator<String>() {
            @Override
            public int compare(String o1, String o2) {
                return o1.compareToIgnoreCase(o2);
            }
        });
        // lambda表达式写法
        Arrays.sort(names, (o1, o2) -> o1.compareToIgnoreCase(o2));
        // 特定类型方法的引用
        Arrays.sort(names, String::compareToIgnoreCase);
        System.out.println(Arrays.toString(names));
    }
}
```

### 3.4 构造器引用

使用场景：如果某个Lambda表达式里只是在创建对象，并且前后参数情况一致，就可以使用构造器引用。

语法：`类名::new`

示例：

现在，我们准备一个JavaBean类，Car类

```java
public class Car {
    private String name;
    private double price;

    public Car() {

    }

    public Car(String name, double price) {
        this.name = name;
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Car{" +
                "name='" + name + '\'' +
                ", price=" + price +
                '}';
    }
}
```

因为方法引用是基于Lamdba表达式简化的，所以也要按照Lamdba表达式的使用前提来用，需要一个函数式接口，接口中代码的返回值类型是Car类型

```java
interface CreateCar{
    Car create(String name, double price);
}
```

最后，再准备一个测试类，在测试类中创建CreateCar接口的实现类对象，先用匿名内部类创建、再用Lambda表达式创建，最后改用方法引用创建。同学们只关注格式就可以，不要去想为什么（语法就是这么设计的）。

```java
public class Test3 {
    public static void main(String[] args) {
        // 1、创建这个接口的匿名内部类对象。
        CreateCar cc1 = new CreateCar(){
            @Override
            public Car create(String name, double price) {
                return new Car(name, price);
            }
        };
		//2、使用匿名内部类改进
        CreateCar cc2 = (name,  price) -> new Car(name, price);

        //3、使用方法引用改进：构造器引用
        CreateCar cc3 = Car::new;
        
        //注意：以上是创建CreateCar接口实现类对象的几种形式而已，语法一步一步简化。
        
        //4、对象调用方法
        Car car = cc3.create("奔驰", 49.9);
        System.out.println(car);
    }
}
```


## 五、正则表达式

接下来，我们学习一个全新的知识，叫做正则表达式。**正则表达式其实是由一些特殊的符号组成的，它代表的是某种规则。**

> 正则表达式的作用1：用来校验字符串数据是否合法
>
> 正则表达式的作用2：可以从一段文本中查找满足要求的内容


### 5.2 正则表达式书写规则

前面我们已经体验到了正则表达式，可以简化校验数据的代码书写。这里需要用到一个方法叫 `matches(String regex)`。这个方法是属于String类的方法。

```java
// 判断字符串是否匹配正则表达式，匹配则返回true，不匹配返回false
public boolean matches(String regex)
```

这个方法是用来匹配一个字符串是否匹配正则表达式的规则，参数需要调用者传递一个正则表达式。


![](/zzimages/1667469259345.png)

![](/zzimages/20230706154058.png)

我们将这些规则，在代码中演示一下

```java
public class RegexTest2 {
    public static void main(String[] args) {
        // 1、字符类(只能匹配单个字符)
        System.out.println("a".matches("[abc]"));    // [abc]只能匹配a、b、c
        System.out.println("e".matches("[abcd]")); // false

        System.out.println("d".matches("[^abc]"));   // [^abc] 不能是abc
        System.out.println("a".matches("[^abc]"));  // false

        System.out.println("b".matches("[a-zA-Z]")); // [a-zA-Z] 只能是a-z A-Z的字符
        System.out.println("2".matches("[a-zA-Z]")); // false

        System.out.println("k".matches("[a-z&&[^bc]]")); // a到z，除了b和c
        System.out.println("b".matches("[a-z&&[^bc]]")); // false

        System.out.println("ab".matches("[a-zA-Z0-9]")); // false 注意：以上带 [内容] 的规则都只能用于匹配单个字符

        // 2、预定义字符(只能匹配单个字符)  .  \d  \D   \s  \S  \w  \W
        System.out.println("徐".matches(".")); // .可以匹配任意字符
        System.out.println("徐徐".matches(".")); // false

        System.out.println("3".matches("\\d"));  // \d: 0-9
        System.out.println("a".matches("\\d"));  //false

        System.out.println(" ".matches("\\s"));   // \s: 代表一个空白字符
        System.out.println("a".matches("\\s")); // false

        System.out.println("a".matches("\\S"));  // \S: 代表一个非空白字符
        System.out.println(" ".matches("\\S")); // false

        System.out.println("a".matches("\\w"));  // \w: [a-zA-Z_0-9]
        System.out.println("_".matches("\\w")); // true
        System.out.println("徐".matches("\\w")); // false

        System.out.println("徐".matches("\\W"));  // [^\w]不能是a-zA-Z_0-9
        System.out.println("a".matches("\\W"));  // false

        System.out.println("23232".matches("\\d")); // false 注意：以上预定义字符都只能匹配单个字符。

        // 3、数量词： ?   *   +   {n}   {n, }  {n, m}
        System.out.println("a".matches("\\w?"));   // ? 代表0次或1次
        System.out.println("".matches("\\w?"));    // true
        System.out.println("abc".matches("\\w?")); // false

        System.out.println("abc12".matches("\\w*"));   // * 代表0次或多次
        System.out.println("".matches("\\w*"));        // true
        System.out.println("abc12张".matches("\\w*")); // false

        System.out.println("abc12".matches("\\w+"));   // + 代表1次或多次
        System.out.println("".matches("\\w+"));       // false
        System.out.println("abc12张".matches("\\w+")); // false

        System.out.println("a3c".matches("\\w{3}"));   // {3} 代表要正好是n次
        System.out.println("abcd".matches("\\w{3}"));  // false
        System.out.println("abcd".matches("\\w{3,}"));     // {3,} 代表是>=3次
        System.out.println("ab".matches("\\w{3,}"));     // false
        System.out.println("abcde徐".matches("\\w{3,}"));     // false
        System.out.println("abc232d".matches("\\w{3,9}"));     // {3, 9} 代表是大于等于3次，小于等于9次

        // 4、其他几个常用的符号：(?i)忽略大小写  |或  ()分组
        System.out.println("abc".matches("(?i)abc")); // true
        System.out.println("ABC".matches("(?i)abc")); // true
        System.out.println("aBc".matches("a((?i)b)c")); // true
        System.out.println("ABc".matches("a((?i)b)c")); // false

        // 需求1：要求要么是3个小写字母，要么是3个数字。
        System.out.println("abc".matches("[a-z]{3}|\\d{3}")); // true
        System.out.println("ABC".matches("[a-z]{3}|\\d{3}")); // false
        System.out.println("123".matches("[a-z]{3}|\\d{3}")); // true
        System.out.println("A12".matches("[a-z]{3}|\\d{3}")); // false

        // 需求2：必须是"我爱"开头，中间可以是至少一个"编程"，最后至少是1个"666"
        System.out.println("我爱编程编程666666".matches("我爱(编程)+(666)+")); // true
        System.out.println("我爱编程编程66666".matches("我爱(编程)+(666)+")); // false
    }
}
```

### 5.3 正则表达式应用案例

学习完正则表达式的规则之后，接下来我们再利用正则表达式，去校验几个实际案例。

- 正则表达式校验手机号码

```java
public class RegexTest3 {
    public static void main(String[] args) {
        checkPhone();
    }

    public static void checkPhone(){
        while (true) {
            System.out.println("请您输入您的电话号码(手机|座机): ");
            Scanner sc = new Scanner(System.in);
            String phone = sc.nextLine(); // 接收用户输入的一行数据
            // 18676769999  010-3424242424 0104644535
            if(phone.matches("(1[3-9]\\d{9})|(0\\d{2,7}-?[1-9]\\d{4,19})")){
                System.out.println("您输入的号码格式正确~~~");
                break;
            }else {
                System.out.println("您输入的号码格式不正确~~~");
            }
        }
    }
}
```

- 使用正则表达式校验邮箱是否正确

```java
public class RegexTest3 {
    public static void main(String[] args) {
        checkEmail();
    }

    public static void checkEmail(){
        while (true) {
            System.out.println("请您输入您的邮箱： ");
            Scanner sc = new Scanner(System.in);
            String email = sc.nextLine();
            /**
             * dlei0009@163.com
             * 25143242@qq.com
             * itheima@itcast.com.cn
             */
            if(email.matches("\\w{2,}@\\w{2,20}(\\.\\w{2,10}){1,2}")){
                System.out.println("您输入的邮箱格式正确~~~");
                break;
            }else {
                System.out.println("您输入的邮箱格式不正确~~~");
            }
        }
    }
}
```



### 5.4 正则表达式信息爬取

各位小伙伴，在前面的课程中，我们学习了正则表达式的作用之一，用来校验数据格式的正确性。接下来我们学习**正则表达式的第二个作用：在一段文本中查找满足要求的内容**

我们还是通过一个案例给大家做演示：案例需求如下

![](/zzimages/1667469722842.png)

```java
public class RegexTest4 {
    public static void main(String[] args) {
        method1();
    }

    // 需求1：从以下内容中爬取出，手机，邮箱，座机、400电话等信息。
    public static void method1(){
        String data = " 来黑马程序员学习Java，\n" +
                "        电话：1866668888，18699997777\n" +
                "        或者联系邮箱：boniu@itcast.cn，\n" +
                "        座机电话：01036517895，010-98951256\n" +
                "        邮箱：bozai@itcast.cn，\n" +
                "        邮箱：dlei0009@163.com，\n" +
                "        热线电话：400-618-9090 ，400-618-4000，4006184000，4006189090";
        // 1、定义爬取规则
        String regex = "(1[3-9]\\d{9})|(0\\d{2,7}-?[1-9]\\d{4,19})|(\\w{2,}@\\w{2,20}(\\.\\w{2,10}){1,2})"
                + "|(400-?\\d{3,7}-?\\d{3,7})";
        // 2、把正则表达式封装成一个Pattern对象
        Pattern pattern = Pattern.compile(regex);
        // 3、通过pattern对象去获取查找内容的匹配器对象。
        Matcher matcher = pattern.matcher(data);
        // 4、定义一个循环开始爬取信息
        while (matcher.find()){
            String rs = matcher.group(); // 获取到了找到的内容了。
            System.out.println(rs);
        }
    }
}
```

### 5.5 正则表达式搜索、替换

接下来，我们学习一下正则表达式的另外两个功能，替换、分割的功能。需要注意的是这几个功能需要用到Stirng类中的方法。这两个方法其实我们之前学过，只是当时没有学正则表达式而已。

![](/zzimages/1667469943451.png)

```java
public class RegexTest5 {
    public static void main(String[] args) {
        // 需求1：请把下面字符串中的不是汉字的部分替换为 “-”
        String s1 = "古力娜扎ai8888迪丽热巴999aa5566马尔扎哈fbbfsfs42425卡尔扎巴";
        System.out.println(s1.replaceAll("\\w+", "-"));
        
        // 需求2(拓展)：某语音系统，收到一个口吃的人说的“我我我喜欢编编编编编编编编编编编编程程程！”，需要优化成“我喜欢编程！”。
        // (.)表示匹配一组相同的字符
        // \\1表示为这一组声明组号为1号
        // $1表示第1组代表的那个字符
        String s2 = "我我我喜欢编编编编编编编编编编编编程程程";
        System.out.println(s2.replaceAll("(.)\\1+", "$1"));

        // 需求3：请把下面字符串中的人名取出来，使用切割来做
        String s3 = "古力娜扎ai8888迪丽热巴999aa5566马尔扎哈fbbfsfs42425卡尔扎巴";
        String[] names = s3.split("\\w+");
        System.out.println(Arrays.toString(names));
    }
}
```



# day06—集合进阶（异常、集合）

## 一、异常

### 1.1 认识异常

因为写代码时经常会出现问题，Java的设计者们早就为我们写好了很多个异常类，来描述不同场景下的问题。而有些类是有共性的所以就有了异常的继承体系

![](/zzimages/1667313423356.png)

> **先来演示一个运行时异常产生**

```java
int[] arr = {11,22,33};
//5是一个不存在的索引，所以此时产生ArrayIndexOutOfBoundsExcpetion
System.out.println(arr[5]); 
```

> **再来演示一个编译时异常**

我们在调用SimpleDateFormat对象的parse方法时，要求传递的参数必须和指定的日期格式一致，否则就会出现异常。 Java比较贴心，它为了更加强烈的提醒方法的调用者，设计了编译时异常，它把异常的提醒提前了，你调用方法是否真的有问题，只要可能有问题就给你报出异常提示（红色波浪线）。

 **编译时异常的目的：意思就是告诉你，你小子注意了！！，这里小心点容易出错，仔细检查一下**

有人说，我检查过了，我确认我的代码没问题，为了让它不报错，继续将代码写下去。我们这里有两种解决方案。

- 第一种：使用throws在方法上声明，意思就是告诉下一个调用者，这里面可能有异常啊，你调用时注意一下。

```java
/**
 * 目标：认识异常。
 */
public class ExceptionTest1 {
    public static void main(String[] args) throws ParseException{
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date d = sdf.parse("2028-11-11 10:24");
        System.out.println(d);
    }
}
```

- 第二种：使用try...catch语句块异常进行处理。

```java
public class ExceptionTest1 {
    public static void main(String[] args) throws ParseException{
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date d = sdf.parse("2028-11-11 10:24");
            System.out.println(d);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}
```

### 1.2 自定义异常

同学们经过刚才的学习已经认识了什么是异常了，但是无法为这个世界上的全部问题都提供异常类，如果企业自己的某种问题，想通过异常来表示，那就需要自己来定义异常类了。

![](/zzimages/20230706191504.png)


我们通过一个实际场景，来给大家演示自定义异常。

> 需求：写一个saveAge(int age)方法，在方法中对参数age进行判断，如果age<0或者>=150就认为年龄不合法，如果年龄不合法，就给调用者抛出一个年龄非法异常。
>
> 分析：Java的API中是没有年龄非常这个异常的，所以我们可以自定义一个异常类，用来表示年龄非法异常，然后再方法中抛出自定义异常即可。

- 先写一个异常类AgeIllegalException（这是自己取的名字），继承

```java
// 1、必须让这个类继承自Exception，才能成为一个编译时异常类。
public class AgeIllegalException extends Exception{
    public AgeIllegalException() {
    }

    public AgeIllegalException(String message) {
        super(message);
    }
}
```

- 再写一个测试类，在测试类中定义一个saveAge(int age)方法，对age判断如果年龄不在0~150之间，就抛出一个AgeIllegalException异常对象给调用者。

```java
public class ExceptionTest2 {
    public static void main(String[] args) {
        // 需求：保存一个合法的年
        try {
            saveAge2(225);
            System.out.println("saveAge2底层执行是成功的！");
        } catch (AgeIllegalException e) {
            e.printStackTrace();
            System.out.println("saveAge2底层执行是出现bug的！");
        }
    }

	//2、在方法中对age进行判断，不合法则抛出AgeIllegalException
    public static void saveAge(int age){
        if(age > 0 && age < 150){
            System.out.println("年龄被成功保存： " + age);
        }else {
            // 用一个异常对象封装这个问题
            // throw 抛出去这个异常对象
            throw new AgeIllegalRuntimeException("/age is illegal, your age is " + age);
        }
    }
}
```

- 注意，自定义异常可以是编译时异常(继承Excpetion)，也可以是运行时异常(继承RuntimeException)


### 1.3 异常处理

同学们，通过前面两小节的学习，我们已经认识了什么是异常，以及异常的产生过程。接下来就需要告诉同学们，出现异常该如何处理了。

比如有如下的场景：A调用用B，B调用C；C中有异常产生抛给B，B中有异常产生又抛给A；异常到了A这里就不建议再抛出了，因为最终抛出被JVM处理程序就会异常终止，并且给用户看异常信息，用户也看不懂，体验很不好。

此时比较好的做法就是：1.将异常捕获，将比较友好的信息显示给用户看；2.尝试重新执行，看是是否能修复这个问题。

![](/zzimages/1667315686041.png)

我们看一个代码，main方法调用test1方法，test1方法调用test2方法，test1和test2方法中多有扔异常。

- 第一种处理方式是，在main方法中对异常进行try...catch捕获处理了，给出友好提示。

```java
public class ExceptionTest3 {
    public static void main(String[] args)  {
        try {
            test1();
        } catch (FileNotFoundException e) {
            System.out.println("您要找的文件不存在！！");
            e.printStackTrace(); // 打印出这个异常对象的信息。记录下来。
        } catch (ParseException e) {
            System.out.println("您要解析的时间有问题了！");
            e.printStackTrace(); // 打印出这个异常对象的信息。记录下来。
        }
    }

    public static void test1() throws FileNotFoundException, ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date d = sdf.parse("2028-11-11 10:24:11");
        System.out.println(d);
        test2();
    }

    public static void test2() throws FileNotFoundException {
        // 读取文件的。
        InputStream is = new FileInputStream("D:/meinv.png");
    }
}
```

**注意：Exception代表可以捕获一切异常，开发中简化代码一般直接抛出和捕获Exception即可**。

- 第二种处理方式是：在main方法中对异常进行捕获，并尝试修复

```java
/**
 * 目标：掌握异常的处理方式：捕获异常，尝试修复。
 */
public class ExceptionTest4 {
    public static void main(String[] args) {
        // 需求：调用一个方法，让用户输入一个合适的价格返回为止。
        // 尝试修复
        while (true) {
            try {
                System.out.println(getMoney());
                break;
            } catch (Exception e) {
                System.out.println("请您输入合法的数字！！");
            }
        }
    }

    public static double getMoney(){
        Scanner sc = new Scanner(System.in);
        while (true) {
            System.out.println("请您输入合适的价格：");
            double money = sc.nextDouble();
            if(money >= 0){
                return money;
            }else {
                System.out.println("您输入的价格是不合适的！");
            }
        }
    }
}
```


## 二、集合概述和分类

### 2.1 集合的分类

集合是一种容器，用来装数据的，类似于数组，但集合的大小可变，开发中也非常常用。Java有两类集合，一类是单列集合Collection，每个元素（数据）只包含一个值；另一类是双列集合Map，每个元素包含两个值（键值对）。

我们先学习Collection单列集合。

![](/zzimages/20230706221027.png)


### 2.2 Collection集合的常用方法

Collection是单列集合的祖宗，它规定的方法（功能）是全部单列集合都会继承的。

![](/zzimages/20230706221154.png)

```java
Collection<String> c = new ArrayList<>();
//1.public boolean add(E e): 添加元素到集合
c.add("java1");
c.add("java1");
c.add("java2");
c.add("java2");
c.add("java3");
System.out.println(c); //打印: [java1, java1, java2, java2, java3]

//2.public int size(): 获取集合的大小
System.out.println(c.size()); //5

//3.public boolean contains(Object obj): 判断集合中是否包含某个元素
System.out.println(c.contains("java1")); //true
System.out.println(c.contains("Java1")); //false

//4.pubilc boolean remove(E e): 删除某个元素，如果有多个重复元素只能删除第一个
System.out.println(c.remove("java1")); //true
System.out.println(c); //打印: [java1,java2, java2, java3]

//5.public void clear(): 清空集合的元素
c.clear(); 
System.out.println(c); //打印：[]

//6.public boolean isEmpty(): 判断集合是否为空 是空返回true 反之返回false
System.out.println(c.isEmpty()); //true

//7.public Object[] toArray(): 把集合转换为数组
Object[] array = c.toArray();
System.out.println(Arrays.toString(array)); //[java1,java2, java2, java3]

//8.如果想把集合转换为指定类型的数组，可以使用下面的代码
String[] array1 = c.toArray(new String[c.size()]);
System.out.println(Arrays.toString(array1)); //[java1,java2, java2, java3]

//9.还可以把一个集合中的元素，添加到另一个集合中
Collection<String> c1 = new ArrayList<>();
c1.add("java1");
c1.add("java2");
Collection<String> c2 = new ArrayList<>();
c2.add("java3");
c2.add("java4");
c1.addAll(c2); //把c2集合中的全部元素拷贝添加到c1集合中去
System.out.println(c1); //[java1, java2, java3, java4]
```


## 三、Collection遍历方式

我们需要有一种通用的遍历方式，能够遍历所有集合。

### 3.1 迭代器遍历集合

迭代器是用来遍历集合的专用方式(数组没有迭代器)，在Java中迭代器的代表是Iterator。

![](/zzimages/20230707120119.png)

代码写法如下：

```java
Collection<String> c = new ArrayList<>();
c.add("赵敏");
c.add("小昭");
c.add("素素");
c.add("灭绝");

//第一步：先获取迭代器对象
//解释：Iterator就是迭代器对象，用于遍历集合的工具)
Iterator<String> it = c.iterator();

//第二步：用于判断当前位置是否有元素可以获取
//解释：hasNext()方法返回true，说明有元素可以获取；反之没有
while(it.hasNext()){
    //第三步：获取当前位置的元素，然后自动指向下一个元素.
    String e = it.next();
    System.out.println(s);
}
```

### 3.2 增强for遍历集合

**增强for循环**：

```java
for (元素的数据类型 变量名 : 数组或集合) {

}
```

- 增强for可以用来遍历集合或者数组。
- 修改增强for中的变量值不会影响到集合中的元素。

```java
Collection<String> c = new ArrayList<>();
c.add("赵敏");
c.add("小昭");
c.add("素素");
c.add("灭绝");
// 使用增强for遍历集合
for(String s : c){
    System.out.println(s); 
    s = "666"; // 并不会影响集合中的元素
}
```

### 3.3 Lambda表达式遍历集合

得益于JDK 8开始的新技术Lambda表达式，提供了一种更简单、更直接的方式来遍历集合。

![](/zzimages/20230707121114.png)

我们发现forEach方法的参数是一个Consumer接口，而Consumer是一个函数式接口，所以可以传递Lambda表达式

```java
Collection<String> c = new ArrayList<>();
c.add("赵敏");
c.add("小昭");
c.add("素素");
c.add("灭绝");

//调用forEach方法
//由于参数是一个Consumer接口，所以可以传递匿名内部类
c.forEach(new Consumer<String>{
    @Override
    public void accept(String s){
        System.out.println(s);
    }
});

//也可以使用lambda表达式对匿名内部类进行简化
c.forEach(s->System.out.println(s)); 
```

## 四、List系列集合

前面我们已经把Collection通用的功能学习完了，接下来我们学习Collection下面的一个子体系List集合。

### 4.1 List集合的常用方法

List集合因为支持索引，所以多了很多与索引相关的方法，当然，Collection的功能List也都继承了。

![](/zzimages/1666165187815.png)


```java
//1.创建一个ArrayList集合对象（有序、有索引、可以重复）
List<String> list = new ArrayList<>();
list.add("蜘蛛精");
list.add("至尊宝");
list.add("至尊宝");
list.add("牛夫人"); 
System.out.println(list); //[蜘蛛精, 至尊宝, 至尊宝, 牛夫人]

//2.public void add(int index, E element): 在某个索引位置插入元素
list.add(2, "紫霞仙子");
System.out.println(list); //[蜘蛛精, 至尊宝, 紫霞仙子, 至尊宝, 牛夫人]

//3.public E remove(int index): 根据索引删除元素, 返回被删除的元素
System.out.println(list.remove(2)); //紫霞仙子
System.out.println(list);//[蜘蛛精, 至尊宝, 至尊宝, 牛夫人]

//4.public E get(int index): 返回集合中指定位置的元素
System.out.println(list.get(3));

//5.public E set(int index, E e): 修改索引位置处的元素，修改后，会返回原数据
System.out.println(list.set(3,"牛魔王")); //牛夫人
System.out.println(list); //[蜘蛛精, 至尊宝, 至尊宝, 牛魔王]
```

### 4.2 List集合的遍历方式

List集合相比于前面的Collection多了一种可以通过索引遍历的方式，所以List集合遍历方式一共有四种：

- 普通for循环（只因为List有索引）
- 迭代器
- 增强for
- Lambda表达式


### 4.3 ArrayList底层的原理

ArrayList集合底层是基于数组结构实现的，也就是说当你往集合容器中存储元素时，底层本质上是往数组中存储元素。 特点如下：

![](/zzimages/1666166151267.png)

我们知道数组的长度是固定的，但是集合的长度是可变的，这是怎么做到的呢？原理如下：

![](/zzimages/1666166661149.png)

数组扩容，并不是在原数组上扩容（原数组是不可以扩容的），底层是创建一个新数组，然后把原数组中的元素全部复制到新数组中去。

### 4.4 LinkedList底层原理

LinkedList集合是基于双链表实现的。特点：查询慢，增删相对较快，但对首尾元素进行增删改查的速度是极快的。LinkedList新增了一些可以针对头尾进行操作的方法，如下图所示：

![](/zzimages/1666167572387.png)

### 4.5 LinkedList集合的应用场景

LinkedList集合可以用来设计队列和栈。

- 队列：入队列可以调用LinkedList集合的 `addLast()` 方法，出队列可以调用 `removeFirst()` 方法
- 栈：压栈(push)可以用 `addFirst()`，出栈(pop)可以用 `removeFirst()`。事实上LinkedList拥有栈的专有API，可以直接调用 `push` 和 `pop` (底层实现其实就是 `addFirst()` 和 `removeFirst()`)。





# day07——集合进阶（Set、Map集合）

## 一、Set系列集合

### 1.1 认识Set集合的特点

Set集合是属于Collection体系下的另一个分支，它的特点如下图所示

![](/zzimages/1666169984705-1667311908041.png)

注意：Set要用到的常用方法，基本上就是Collection提供的。自己几乎没有额外新增一些常用功能。


### 1.2 HashSet集合底层原理

**哈希值**：就是一个int类型的数值，Java中每个对象都有一个哈希值；Java中的所有对象，都可以调用Obejct类提供的hashCode方法，返回该对象自己的哈希值。

```java
public int hashCode() //返回对象的哈希值
```

- 同一个对象多次调用hashCode()方法返回的哈希值是相同的。
- 不同的对象，它们的哈希值一般不相同，但也有可能会相同(哈希碰撞)。

**HashSet集合底层原理**

HashSet集合底层是基于哈希表实现的，哈希表是一种增删改查数据，性能都较好的数据结构。哈希表根据JDK版本的不同，也是有点区别的

- JDK8以前：哈希表 = 数组 + 链表
- JDK8以后：哈希表 = 数组 + 链表 + 红黑树

![](/zzimages/1666170451762-1667311904484.png)

我们发现往HashSet集合中存储元素时，底层调用了元素的两个方法：一个是hashCode方法获取元素的hashCode值（哈希值）；另一个是调用了元素的equals方法，用来比较新添加的元素和集合中已有的元素是否相同。 

- 只有新添加元素的hashCode值和集合中以后元素的hashCode值相同、新添加的元素调用equals方法和集合中已有元素比较结果为true, 才认为元素重复。
- 如果hashCode值相同，equals比较不同，则以链表的形式连接在数组的同一个索引为位置
- 如果数组快占满了，会导致链表过长，查询性能降低，此时哈希表会扩容。具体来说，如果数组中已有元素数量占数组总长度的比例超过加载因子(0.75)，则会进行扩容(默认扩容至2倍)。

在JDK8开始后，为了提高性能，当链表的长度超过8且数组长度大于等于64时，就会把链表转换为红黑树，如下图所示：

![](/zzimages/1666171011761-1667311900100.png)


### 1.3 HashSet去重原理

前面我们学习了HashSet存储元素的原理，依赖于两个方法：一个是hashCode方法用来确定在底层数组中存储的位置，另一个是用equals方法判断新添加的元素是否和集合中已有的元素相同。

要想保证在HashSet集合中没有重复元素，我们需要重写元素类的hashCode和equals方法。比如以下面的Student类为例，假设把Student类的对象作为HashSet集合的元素，想要让学生的姓名和年龄相同，就认为元素重复。

```java
public class Student{
    private String name; //姓名
    private int age; //年龄
    private double height; //身高

    //无参数构造方法
    public Student(){}
    //全参数构造方法
    public Student(String name, int age, double height){
        this.name=name;
        this.age=age;
        this.height=height;
    }
    //...get、set、toString()方法自己补上..

    //按快捷键生成hashCode和equals方法
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Student student = (Student) o;
        return age == student.age && Double.compare(student.height, height) == 0 && Objects.equals(name, student.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, age, height);
    }
}
```

### 1.4 LinkedHashSet底层原理

接下来，我们再学习一个HashSet的子类LinkedHashSet类。LinkedHashSet依然是基于哈希表(数组、链表、红黑树)实现的，但是它的每个元素都额外的多了一个双链表的机制记录它前后元素的位置。所以它的特点是：有序、不重复、无索引。

### 1.5 TreeSet集合

TreeSet集合特点：不重复、无索引、可排序（默认升序排序 ，按照元素的大小，由小到大排序）。底层是基于红黑树实现的排序。

注意：

- 对于数值类型：Integer , Double，默认按照数值本身的大小进行升序排序。
- 对于字符串类型，默认按照首字符的编号升序排序。
- 对于自定义类型如Student对象，TreeSet默认是无法直接排序的。必须自定义排序规则，否则会出现异常。
- **如果两个元素相等，Treeset集合只会保留其中一个元素**

我们想要告诉TreeSet集合按照指定的规则排序，有两种办法：

**第一种**：让自定义的类（如学生类）实现Comparable接口，重写里面的compareTo方法来指定比较规则。

**第二种**：通过调用TreeSet集合有参数构造器，可以设置Comparator对象（比较器对象，用于指定比较规则）。

```java
public TreeSet(Comparator<? super E> comparator)
```

- **排序方式1**

```java
//第一步：先让Student类，实现Comparable接口
public class Student implements Comparable<Student>{
    private String name;
    private int age;
    private double height;
	//无参数构造方法
    public Student(){}
    //全参数构造方法
    public Student(String name, int age, double height){
        this.name=name;
        this.age=age;
        this.height=height;
    }
    //...get、set、toString()方法自己补上..
    
    //第二步：重写compareTo方法
    //按照年龄升序，只需要在方法中让this.age和o.age相减就可以。
    /*
    原理：
    在往TreeSet集合中添加元素时，add方法底层会调用compareTo方法，根据该方法的
    结果是正数、负数、还是零，决定元素放在后面、前面还是不存。
    */
    @Override
    public int compareTo(Student o) {
        //this：表示将要添加进去的Student对象
        //o: 表示集合中已有的Student对象
        return this.age-o.age;
    }
}
```

- **排序方式2**

```java
//创建TreeSet集合时，传递比较器对象排序
/*
原理：当调用add方法时，底层会先用比较器，根据Comparator的compare方是正数、负数、还是零，决定谁在后，谁在前，谁不存。
*/
Set<Student> students = new TreeSet<>(new Comparator<Student>{
    @Override
    public int compare(Student o1, Student o2){
        //需求：按照学生的身高升序
        return Double.compare(o1.getHeight(), o2.getHeight()); 
    }
});
// 也可以用Lambda表达式简化
```

### 1.7 集合的并发修改异常

- 使用迭代器遍历集合时，又同时在删除集合中的数据，程序就会出现并发修改异常的错误。
- 由于增强for循环遍历集合就是迭代器遍历集合的简化写法，因此，使用增强for循环遍历集合，又在同时删除集合中的数据时，程序也会出现并发修改异常的错误。

解决方案：

- 使用迭代器遍历集合，但用迭代器自己的删除方法删除数据即可。`it.remove()` 从底层集合中移除此迭代器返回的最后一个元素，注意每次调用 `it.next()` 时，只能调用此方法一次。
- 如果能用for循环遍历时：可以倒着遍历并删除；或者从前往后遍历，但删除元素后做 `i--` 操作。

```java
List<String> list = new ArrayList<>();
list.add("王麻子");
list.add("小李子");
list.add("李爱花");
list.add("张全蛋");
list.add("晓李");
list.add("李玉刚");
System.out.println(list); 

//需求：找出集合中带"李"字的姓名，并从集合中删除
Iterator<String> it = list.iterator();
while(it.hasNext()){
    String name = it.next();
    if(name.contains("李")){
        it.remove(); 
    }
}
System.out.println(list);
```



## 二、Collection的其他操作

为了更加方便的对Collection集合进行操作，今天我们还要学习一个操作Collection集合的工具类，叫做Collections。但是Collections工具类中需要用到一个没有学过的小知识点，叫做可变参数，所以必须先学习这个前置知识可变参数，再学习Collections工具类，最后再利用这个工具类做一个综合案例。


### 2.1 可变参数

可变参数就是一种特殊形参，定义在方法、构造器的形参列表里，格式是：`数据类型...参数名称`

可变参数特点：可以不传数据给它；可以传一个或者同时传多个数据给它；也可以传一个数组给它。

注意：

- 可变参数在方法内部就是一个数组
- 一个形参列表中可变参数只能有一个
- 可变参数必须放在形参列表的最后面

```java
public class ParamTest{
    public static void main(String[] args){
        //不传递参数，下面的nums长度则为0, 打印元素是[]
        test();	
        
        //传递3个参数，下面的nums长度为3，打印元素是[10, 20, 30]
        test(10,20,30); 
        
        //传递一个数组，下面数组长度为4，打印元素是[10,20,30,40] 
        int[] arr = new int[]{10,20,30,40}
        test(arr); 
    }
    
    public static void test(int...nums){
        //可变参数在方法内部，本质上是一个数组
        System.out.println(nums.length);
        System.out.println(Arrays.toString(nums));
        System.out.println("----------------");
    }
}
```

### 2.2 Collections工具类

注意Collections并不是集合，它比Collection多了一个s，一般后缀为s的类很多都是工具类。这里的Collections是用来操作Collection的工具类。它提供了一些好用的静态方法，如下

![](/zzimages/1667195108724.png)

```java
public class CollectionsTest{
    public static void main(String[] args){
        //1.public static <T> boolean addAll(Collection<? super T> c, T...e)
        List<String> names = new ArrayList<>();
        Collections.addAll(names, "张三","王五","李四", "张麻子");
        System.out.println(names);
        
        //2.public static void shuffle(List<?> list)：对集合打乱顺序
        Collections.shuffle(names);
        System.out.println(names);
        
        //3.public static <T> void short(List<T> list): 对List集合排序
        List<Integer> list = new ArrayList<>();
        list.add(3);
        list.add(5);
        list.add(2);
        Collections.sort(list);
        System.out.println(list);
    }
}
```

上面我们往集合中存储的元素要么是Stirng类型，要么是Integer类型，他们本来就有一种自然顺序所以可以直接排序。但是如果我们往List集合中存储Student对象，这个时候想要对List集合进行排序自定义比较规则的。指定排序规则有两种方式，如下：

> **排序方式1：让元素实现Comparable接口，重写compareTo方法**

比如现在想要往集合中存储Studdent对象，首先需要准备一个Student类，实现Comparable接口。

```java
public class Student implements Comparable<Student>{
    private String name;
    private int age;
    private double height;
    
     //排序时：底层会自动调用此方法，this和o表示需要比较的两个对象
    @Override
    public int compareTo(Student o){
        //需求：按照年龄升序排序
        //如果返回正数：说明左边对象的年龄>右边对象的年龄
        //如果返回负数：说明左边对象的年龄<右边对象的年龄，
        //如果返回0：说明左边对象的年龄和右边对象的年龄相同
        return this.age - o.age;
    }
    
    //...getter、setter、constructor..
}
```

然后再使用`Collections.sort(list集合)`对List集合排序，如下：

```java
//3.public static <T> void short(List<T list): 对List集合排序
List<Student> students = new ArrayList<>();
students.add(new Student("蜘蛛精",23,169.7));
students.add(new Student("紫霞",22,169.8));
students.add(new Student("紫霞",22,169.8));
students.add(new Student("至尊宝",26,169.5));

/*
原理：sort方法底层会遍历students集合中的每一个元素，采用排序算法，将任意两个元素两两比较；
	每次比较时，会用一个Student对象调用compareTo方法和另一个Student对象进行比较；
	根据compareTo方法返回的结果是正数、负数，零来决定谁大，谁小，谁相等，重新排序元素的位置
	
	注意：这些都是sort方法底层自动完成的，想要完全理解，必须要懂排序算法才行；
*/
Collections.sort(students);	
System.out.println(students);
```

> **排序方式2：调用sort方法时，传递比较器**

```java
/*
原理：sort方法底层会遍历students集合中的每一个元素，采用排序算法，将任意两个元素两两比较；
	每次比较，会将比较的两个元素传递给Comparator比较器对象的compare方法的两个参数o1和o2,
	根据compare方法的返回结果是正数，负数，或者0来决定谁大，谁小，谁相等，重新排序元素的位置
	
	注意：这些都是sort方法底层自动完成的，不需要我们完全理解，想要理解它必须要懂排序算法才行.
*/
Collections.sort(students, new Comparator<Student>(){
    @Override
    public int compare(Student o1, Student o2){
        return o1.getAge()-o2.getAge();
    }
});	
System.out.println(students);
```


## 三、Map集合

### 3.1 Map概述体系

Map集合称为双列集合，格式：`{key1=value1 , key2=value2 , key3=value3 , ...}`， 一次需要存一对数据做为一个元素。

Map集合的每个元素`“key=value”`称为一个键值对/键值对对象/一个Entry对象，Map集合也被叫做“键值对集合”

Map集合的所有键是不允许重复的，但值可以重复，键和值是一一对应的，每一个键只能找到自己对应的值


![](/zzimages/1667308506610.png)



### 3.2 Map集合的常用方法

Map是双列集合的祖宗，它的功能是全部双列集合都可以继承过来使用的。Map的常用方法如下：

![](/zzimages/1667308854001.png)

```java
public class MapTest2 {
    public static void main(String[] args) {
        // 1.添加元素: 无序，不重复，无索引。
        Map<String, Integer> map = new HashMap<>();
        map.put("手表", 100);
        map.put("手表", 220);
        map.put("手机", 2);
        map.put("Java", 2);
        map.put(null, null);
        System.out.println(map);
        // map = {null=null, 手表=220, Java=2, 手机=2}

        // 2.public int size():获取集合的大小
        System.out.println(map.size());

        // 3、public void clear():清空集合
        //map.clear();
        //System.out.println(map);

        // 4.public boolean isEmpty(): 判断集合是否为空，为空返回true ,反之！
        System.out.println(map.isEmpty());

        // 5.public V get(Object key)：根据键获取对应值
        int v1 = map.get("手表");
        System.out.println(v1);
        System.out.println(map.get("手机")); // 2
        System.out.println(map.get("张三")); // null

        // 6. public V remove(Object key)：根据键删除整个元素(删除键会返回键的值)
        System.out.println(map.remove("手表"));
        System.out.println(map);

        // 7.public  boolean containsKey(Object key): 判断是否包含某个键 ，包含返回true ,反之
        System.out.println(map.containsKey("手表")); // false
        System.out.println(map.containsKey("手机")); // true
        System.out.println(map.containsKey("java")); // false
        System.out.println(map.containsKey("Java")); // true

        // 8.public boolean containsValue(Object value): 判断是否包含某个值。
        System.out.println(map.containsValue(2)); // true
        System.out.println(map.containsValue("2")); // false

        // 9.public Set<K> keySet(): 获取Map集合的全部键。
        Set<String> keys = map.keySet();
        System.out.println(keys);

        // 10.public Collection<V> values(); 获取Map集合的全部值。
        Collection<Integer> values = map.values();
        System.out.println(values);

        // 11.把其他Map集合的数据倒入到自己集合中来。(拓展)
        Map<String, Integer> map1 = new HashMap<>();
        map1.put("java1",  10);
        map1.put("java2",  20);
        Map<String, Integer> map2 = new HashMap<>();
        map2.put("java3",  10);
        map2.put("java2",  222);
        map1.putAll(map2); // putAll：把map2集合中的元素全部倒入一份到map1集合中去。
        System.out.println(map1);
        System.out.println(map2);
    }
}
```

### 3.3 Map集合遍历方式1

![](/zzimages/1667308962740.png)

```java
public class Test {
    public static void main(String[] args) {
        Map<String, Double> map = new HashMap<>();
        map.put("张三", 178.5);
        map.put("李四", 180.0);
        map.put("王五", 168.3);
        // 1、获取Map集合的全部键
        Set<String> keys = map.keySet();
        for (String key : keys) {
            // 根据键获取对应的值
            double val = map.get(key);
            System.out.println(key + "->" + val);
        }
    }
}
```

### 3.4 Map集合遍历方式2

前面我们给大家介绍过，Map集合是用来存储键值对的，而每一个键值对实际上是一个Entry对象。

**这里Map集合的第二种方式，是直接获取每一个Entry对象，把Entry存储扫Set集合中去，再通过Entry对象获取键和值。**

![](/zzimages/20230707170842.png)

```java
public class Test {
    public static void main(String[] args) {
        Map<String, Double> map = new HashMap<>();
        map.put("张三", 178.5);
        map.put("李四", 180.0);
        map.put("王五", 168.3);
        // 1、获取Map集合的全部键值对
        Set<Map.Entry<String, Double>> entries = map.entrySet();
        for (Map.Entry<String, Double> entry : entries) {
            String key = entry.getKey();
            double val = entry.getValue();
            System.out.println(key + "->" + val);
        }
    }
}
```

### 3.5 Map集合遍历方式3

Map集合的第三种遍历方式，需要用到下面的一个方法forEach，而这个方法是JDK8版本以后才有的。调用起来非常简单，最好是结合的lambda表达式一起使用。

![](/zzimages/20230707171515.png)

```java
public class Test {
    public static void main(String[] args) {
        Map<String, Double> map = new HashMap<>();
        map.put("张三", 178.5);
        map.put("李四", 180.0);
        map.put("王五", 168.3);
        map.forEach((k, v) -> {
            System.out.println(k + "->" + v);
        });
    }
}
```



# day08-Map集合、Stream流、File类

## 一、Map集合


### 1.1 HashMap

HashMap跟HashSet的底层原理是一模一样的，都是基于哈希表实现的。实际上：原来学的Set系列集合的底层就是基于Map实现的，只是Set集合中的元素只要键数据，不要值数据而已。计算hashCode时只依赖Entry对象的键，而不依赖Entry对象的值。**所以，往Map集合中存储自定义对象作为键，为了保证键的唯一性，我们应该重写hashCode方法和equals方法**。


### 1.2 LinkedHashMap

LinkedHashMap底层数据结构依然是基于哈希表实现的，只是每个键值对元素又额外的多了一个双链表的机制记录元素顺序(保证有序)。实际上：原来学习的LinkedHashSet集合的底层原理就是LinkedHashMap。

### 1.3 TreeMap


- 特点：不重复、无索引、可排序(按照键的大小默认升序排序，只能对键排序)
- 原理：TreeMap跟TreeSet集合的底层原理是一样的，都是基于红黑树实现的排序。
- TreeMap集合同样也支持两种方式来指定排序规则：
  - 让类实现Comparable接口，重写比较规则。
  - TreeMap集合有一个有参数构造器，支持创建Comparator比较器对象，以便用来指定比较规则。


### 1.4 集合嵌套

把一个集合当做元素，存储到另一个集合中去，我们把这种用法称之为集合嵌套。例如：

```java
HashMap<String, ArrayList<String>> map = new HashMap<>();
```

## 二、JDK8新特性（Stream流）

Stream流，是Jdk8开始新增的一套API (`java.util.stream.*`)，可以用于操作集合或者数组的数据。

优势： Stream流大量的结合了Lambda的语法风格来编程，提供了一种更加强大，更加简单的方式操作集合或者数组中的数据，代码更简洁，可读性更好。

![](/zzimages/20230708155025.png)


### 2.2 Stream流的创建

好，接下来我们正式来学习Stream流。先来学习如何创建Stream流、或者叫获取Stream流。

![](/zzimages/20230708155133.png)


```java
public class StreamTest2 {
    public static void main(String[] args) {
        // 1、如何获取List集合的Stream流？
        List<String> names = new ArrayList<>();
        Collections.addAll(names, "张三丰","张无忌","周芷若","赵敏","张强");
        Stream<String> stream = names.stream();

        // 2、如何获取Set集合的Stream流？
        Set<String> set = new HashSet<>();
        Collections.addAll(set, "刘德华","张曼玉","蜘蛛精","马德","德玛西亚");
        Stream<String> stream1 = set.stream();
        stream1.filter(s -> s.contains("德")).forEach(s -> System.out.println(s));

        // 3、如何获取Map集合的Stream流？
        Map<String, Double> map = new HashMap<>();
        map.put("古力娜扎", 172.3);
        map.put("迪丽热巴", 168.3);
        map.put("马尔扎哈", 166.3);
        map.put("卡尔扎巴", 168.3);

        Set<String> keys = map.keySet();
        Stream<String> ks = keys.stream();

        Collection<Double> values = map.values();
        Stream<Double> vs = values.stream();

        Set<Map.Entry<String, Double>> entries = map.entrySet();
        Stream<Map.Entry<String, Double>> kvs = entries.stream();
        kvs.filter(e -> e.getKey().contains("巴"))
                .forEach(e -> System.out.println(e.getKey()+ "-->" + e.getValue()));

        // 4、如何获取数组的Stream流？
        String[] names2 = {"张翠山", "东方不败", "唐大山", "独孤求败"};
        Stream<String> s1 = Arrays.stream(names2);
        Stream<String> s2 = Stream.of(names2);
    }
}
```

### 2.3 Stream流中间方法

在上一节，我们学习了创建Stream流的方法。接下来我们再来学习，Stream流中间操作的方法。

**中间方法指的是：调用完成后会返回新的Stream流，可以继续使用(支持链式编程，或者叫流式编程)**。

![](/zzimages/1667649509262.png)


```java
public class StreamTest3 {
    public static void main(String[] args) {
        List<Double> scores = new ArrayList<>();
        Collections.addAll(scores, 88.5, 100.0, 60.0, 99.0, 9.5, 99.6, 25.0);
        // 需求1：找出成绩大于等于60分的数据，并升序后，再输出。
        scores.stream().filter(s -> s >= 60).sorted().forEach(s -> System.out.println(s));

        List<Student> students = new ArrayList<>();
        Student s1 = new Student("蜘蛛精", 26, 172.5);
        Student s2 = new Student("蜘蛛精", 26, 172.5);
        Student s3 = new Student("紫霞", 23, 167.6);
        Student s4 = new Student("白晶晶", 25, 169.0);
        Student s5 = new Student("牛魔王", 35, 183.3);
        Student s6 = new Student("牛夫人", 34, 168.5);
        Collections.addAll(students, s1, s2, s3, s4, s5, s6);
        // 需求2：找出年龄大于等于23,且年龄小于等于30岁的学生，并按照年龄降序输出.
        students.stream().filter(s -> s.getAge() >= 23 && s.getAge() <= 30)
                .sorted((o1, o2) -> o2.getAge() - o1.getAge())
                .forEach(s -> System.out.println(s));

        // 需求3：取出身高最高的前3名学生，并输出。
        students.stream().sorted((o1, o2) -> Double.compare(o2.getHeight(), o1.getHeight()))
                .limit(3).forEach(System.out::println);
        System.out.println("-----------------------------------------------");

        // 需求4：取出身高倒数的2名学生，并输出。   s1 s2 s3 s4 s5 s6
        students.stream().sorted((o1, o2) -> Double.compare(o2.getHeight(), o1.getHeight()))
                .skip(students.size() - 2).forEach(System.out::println);

        // 需求5：找出身高超过168的学生叫什么名字，要求去除重复的名字，再输出。
        students.stream().filter(s -> s.getHeight() > 168).map(Student::getName)
               .distinct().forEach(System.out::println);

        // distinct去重复，自定义类型的对象（希望内容一样就认为重复，重写hashCode,equals）
        students.stream().filter(s -> s.getHeight() > 168)
                .distinct().forEach(System.out::println);

        Stream<String> st1 = Stream.of("张三", "李四");
        Stream<String> st2 = Stream.of("张三2", "李四2", "王五");
        Stream<String> allSt = Stream.concat(st1, st2);
        allSt.forEach(System.out::println);
    }
}
```



### 2.5 Stream流终结方法

终结方法指的是调用完成后，不会返回新Stream了，没法继续使用流了。

![](/zzimages/1667649867150.png)

![](/zzimages/20230708161435.png)

**注意：流只能收集一次**

```java
public class StreamTest4 {
    public static void main(String[] args) {
        List<Student> students = new ArrayList<>();
        Student s1 = new Student("蜘蛛精", 26, 172.5);
        Student s2 = new Student("蜘蛛精", 26, 172.5);
        Student s3 = new Student("紫霞", 23, 167.6);
        Student s4 = new Student("白晶晶", 25, 169.0);
        Student s5 = new Student("牛魔王", 35, 183.3);
        Student s6 = new Student("牛夫人", 34, 168.5);
        Collections.addAll(students, s1, s2, s3, s4, s5, s6);
        // 需求1：请计算出身高超过168的学生有几人。
        long size = students.stream().filter(s -> s.getHeight() > 168).count();
        System.out.println(size);

        // 需求2：请找出身高最高的学生对象，并输出。
        Student s = students.stream().max((o1, o2) -> Double.compare(o1.getHeight(), o2.getHeight())).get();
        System.out.println(s);

        // 需求3：请找出身高最矮的学生对象，并输出。
        Student ss = students.stream().min((o1, o2) -> Double.compare(o1.getHeight(), o2.getHeight())).get();
        System.out.println(ss);

        // 需求4：请找出身高超过170的学生对象，并放到一个新集合中去返回。
        // 流只能收集一次。
        List<Student> students1 = students.stream().filter(a -> a.getHeight() > 170).collect(Collectors.toList());
        System.out.println(students1);

        Set<Student> students2 = students.stream().filter(a -> a.getHeight() > 170).collect(Collectors.toSet());
        System.out.println(students2);

        // 需求5：请找出身高超过170的学生对象，并把学生对象的名字和身高，存入到一个Map集合返回。
        Map<String, Double> map =
                students.stream().filter(a -> a.getHeight() > 170)
                        .distinct().collect(Collectors.toMap(a -> a.getName(), a -> a.getHeight()));
        System.out.println(map);

        // Object[] arr = students.stream().filter(a -> a.getHeight() > 170).toArray();
        Student[] arr = students.stream().filter(a -> a.getHeight() > 170).toArray(len -> new Student[len]);
        System.out.println(Arrays.toString(arr));
    }
}
```


## 三、File类


File是`java.io.`包下的类，**File类的对象，用于代表当前操作系统的文件（可以是文件、或文件夹）**，通过File类提供的方法可以获取文件大小、判断文件是否存在、创建文件、创建文件夹等。

**注意**：File类只能对文件本身进行操作，不能读写文件里面存储的数据。而I/O流才能用于读写数据（可以读写文件，或网络中的数据）。


### 3.1 File对象的创建

![](/zzimages/20230708173036.png)


```java
public class FileTest1 {
    public static void main(String[] args) {
        // 1、创建一个File对象，指代某个具体的文件。
        // 路径分隔符
        // File f1 = new File("D:/resource/ab.txt");
        // File f1 = new File("D:\\resource\\ab.txt");
        File f1 = new File("D:" + File.separator +"resource" + File.separator + "ab.txt");
        System.out.println(f1.length()); // 文件大小

        File f2 = new File("D:/resource");
        System.out.println(f2.length());

        // 注意：File对象可以指代一个不存在的文件路径
        File f3 = new File("D:/resource/aaaa.txt");
        System.out.println(f3.length());
        System.out.println(f3.exists()); // false

        // 我现在要定位的文件是在模块中，应该怎么定位呢？
        // 绝对路径：从盘符开始
        // File f4 = new File("D:\\code\\javasepromax\\file-io-app\\src\\itheima.txt");
        // 相对路径（重点）：不带盘符，默认直接到当前工程下的目录寻找文件
        File f4 = new File("file-io-app\\src\\itheima.txt");
    }
}
```

### 3.2 File判断和获取方法

**File提供的判断文件类型、获取文件信息功能**

![](/zzimages/1667659321570.png)



```java
public class FileTest2 {
    public static void main(String[] args) throws UnsupportedEncodingException {
        // 1.创建文件对象，指代某个文件
        File f1 = new File("D:/resource/ab.txt");
        //File f1 = new File("D:/resource/");

        // 2、public boolean exists()：判断当前文件对象，对应的文件路径是否存在，存在返回true.
        System.out.println(f1.exists());

        // 3、public boolean isFile() : 判断当前文件对象指代的是否是文件，是文件返回true，反之。
        System.out.println(f1.isFile());

        // 4、public boolean isDirectory()  : 判断当前文件对象指代的是否是文件夹，是文件夹返回true，反之。
        System.out.println(f1.isDirectory());
    }
}
```


```java
File f1 = new File("D:/resource/ab.txt");

// 5.public String getName()：获取文件的名称（包含后缀）
System.out.println(f1.getName());

// 6.public long length()：获取文件的大小，返回字节个数
System.out.println(f1.length());

// 7.public long lastModified()：获取文件的最后修改时间。
long time = f1.lastModified();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
System.out.println(sdf.format(time));

// 8.public String getPath()：获取创建文件对象时，使用的路径
File f2 = new File("D:\\resource\\ab.txt");
File f3 = new File("file-io-app\\src\\itheima.txt");
System.out.println(f2.getPath());
System.out.println(f3.getPath());

// 9.public String getAbsolutePath()：获取绝对路径
System.out.println(f2.getAbsolutePath());
System.out.println(f3.getAbsolutePath());
```


### 3.3 创建和删除方法

![](/zzimages/20230708173431.png)

```java
public class FileTest3 {
    public static void main(String[] args) throws Exception {
        // 1、public boolean createNewFile()：创建一个新文件（文件内容为空），创建成功返回true,反之。
        File f1 = new File("D:/resource/itheima2.txt");
        System.out.println(f1.createNewFile());

        // 2、public boolean mkdir()：用于创建文件夹，注意：只能创建一级文件夹
        File f2 = new File("D:/resource/aaa");
        System.out.println(f2.mkdir());

        // 3、public boolean mkdirs()：用于创建文件夹，注意：可以创建多级文件夹
        File f3 = new File("D:/resource/bbb/ccc/ddd/eee/fff/ggg");
        System.out.println(f3.mkdirs());

        // 3、public boolean delete()：删除文件，或者空文件夹，注意：不能删除非空文件夹。
        System.out.println(f1.delete());
        System.out.println(f2.delete());
        File f4 = new File("D:/resource");
        System.out.println(f4.delete());
    }
}
```

需要注意的是：

```java
1.mkdir(): 只能创建单级文件夹、
2.mkdirs(): 才能创建多级文件夹
3.delete(): 文件可以直接删除，但是文件夹只能删除空的文件夹，文件夹有内容删除不了。
```

### 3.4 遍历文件夹方法


![](/zzimages/1667659732559.png)


```java
public class FileTest4 {
    public static void main(String[] args) {
        // 1、public String[] list()：获取当前目录下所有的"一级文件名称"到一个字符串数组中去返回。
        File f1 = new File("D:\\course\\待研发内容");
        String[] names = f1.list();
        for (String name : names) {
            System.out.println(name);
        }

        // 2、public File[] listFiles():（重点）获取当前目录下所有的"一级文件对象"到一个文件对象数组中去返回（重点）
        File[] files = f1.listFiles();
        for (File file : files) {
            System.out.println(file.getAbsolutePath());
        }

        File f = new File("D:/resource/aaa");
        File[] files1 = f.listFiles();
        System.out.println(Arrays.toString(files1));
    }
}
```

注意：

1. 当主调是文件时，或者路径不存在时，返回null
2. 当主调是空文件夹时，返回一个长度为0的数组
3. 当主调是一个有内容的文件夹时，将里面所有一级文件和文件夹的路径放在File数组中返回
4. 当主调是一个文件夹，且里面有隐藏文件时，将里面所有文件和文件夹的路径放在File数组中返回，包含隐藏文件
5. 当主调是一个文件夹，但是没有权限访问该文件夹时，返回null




## 四、递归


### 4.3 递归文件搜索

再来看一下，如果使用递归来遍历文件夹。

案例需求：在`D:\\`判断下搜索QQ.exe这个文件，然后直接输出。

```java
1.先调用文件夹的listFiles方法，获取文件夹的一级内容，得到一个数组
2.然后再遍历数组，获取数组中的File对象
3.因为File对象可能是文件也可能是文件夹，所以接下来就需要判断
	判断File对象如果是文件，就获取文件名，如果文件名是`QQ.exe`则打印，否则不打印
	判断File对象如果是文件夹，就递归执行1,2,3步骤
所以：把1，2,3步骤写成方法，递归调用即可。
```

代码如下：

```java
/**
 * 目标：掌握文件搜索的实现。
 */
public class RecursionTest3 {
    public static void main(String[] args) throws Exception {
          searchFile(new File("D:/") , "QQ.exe");
    }

    /**
     * 去目录下搜索某个文件
     * @param dir  目录
     * @param fileName 要搜索的文件名称
     */
    public static void searchFile(File dir, String fileName) throws Exception {
        // 1、把非法的情况都拦截住
        if(dir == null || !dir.exists() || dir.isFile()){
            return; // 代表无法搜索
        }

        // 2、dir不是null,存在，一定是目录对象。
        // 获取当前目录下的全部一级文件对象。
        File[] files = dir.listFiles();

        // 3、判断当前目录下是否存在一级文件对象，以及是否可以拿到一级文件对象。
        if(files != null && files.length > 0){
            // 4、遍历全部一级文件对象。
            for (File f : files) {
                // 5、判断文件是否是文件,还是文件夹
                if(f.isFile()){
                    // 是文件，判断这个文件名是否是我们要找的
                    if(f.getName().contains(fileName)){
                        System.out.println("找到了：" + f.getAbsolutePath());
                        Runtime runtime = Runtime.getRuntime();
                        runtime.exec(f.getAbsolutePath());
                    }
                }else {
                    // 是文件夹，继续重复这个过程（递归）
                    searchFile(f, fileName);
                }
            }
        }
    }
}
```




# day09-字符集、IO流（一）

各位同学，前面我们已经学习了File类，通过File类的对象可以对文件进行操作，但是不能操作文件中的内容。要想操作文件中的内容，我们还得学习IO流。但是在正式学习IO流之前，我们还需要学习一个前置知识叫做字符集，只有我们把字符集搞明白了，再学习IO流才会更加丝滑。

## 一、字符集

### 1.1 字符集的来历

我们知道计算机是美国人发明的，由于计算机能够处理的数据只能是0和1组成的二进制数据，为了让计算机能够处理字符，于是美国人就把他们会用到的每一个字符进行了编码（**所谓编码，就是为一个字符编一个二进制数据**）。

美国人常用的字符有英文字母、标点符号、数字以及一些特殊字符，这些字符一共也不到128个，所以他们用1个字节来存储1字符就够了。美国人把他们用到的字符和字符对应的编码总结成了一张码表，这张码表叫做ASCII码表（也叫ASCII字符集）。

其实计算机只在美国用是没有问题的，但是计算机慢慢的普及到全世界，当普及到中国的时候，在计算机中想要存储中文，那ASCII字符集就不够用了，因为中文太多了，随便数一数也有几万个字符。

于是中国人为了在计算机中存储中文，也编了一个中国人用的字符集叫做GBK字符集，这里面包含2万多个汉字字符，**GBK中一个汉字采用两个字节来存储**，为了能够显示英文字母，GBK字符集也兼容了ASCII字符集，**在GBK字符集中一个字母还是采用一个字节来存储**。

### 1.2 汉字和字母的编码特点

讲到这里，可能有同学有这么一个疑问： 如果一个文件中既有中文，也有英文，那计算机怎么知道哪几个字节表示一个汉字，哪几个字节表示一个字母呢？

其实这个问题问当想当有水平，接下来，就带着同学们了解一下，计算机是怎么识别中文和英文的。

比如：在文件中存储一个`我a你`，底层其实存储的是这样的二进制数据。

**需要我们注意汉字和字母的编码特点：**

1. 如果是存储字母，采用1个字节来存储，一共8位，其中第1位是0
2. 如果是存储汉字，采用2个字节来存储，一共16位，其中第1位是1

**当读取文件中的字符时，通过识别读取到的第1位是0还是1来判断是字母还是汉字**

- 如果读取到第1位是0，就认为是一个字母，此时往后读1个字节。
- 如果读取到第1位是1，就认为是一个汉字，此时往后读2个字节。


### 1.3 Unicode字符集

同学们注意了，咱们国家可以用GBK字符集来表示中国人使用的文字，那世界上还有很多其他的国家，他们也有自己的文字，他们也想要自己国家的文字在计算机中处理，于是其他国家也在搞自己的字符集，就这样全世界搞了上百个字符集，而且各个国家的字符集互不兼容。 这样其实很不利于国际化的交流，可能一个文件在我们国家的电脑上打开好好的，但是在其他国家打开就是乱码了。

为了解决各个国家字符集互不兼容的问题，由国际化标准组织牵头，设计了一套全世界通用的字符集，叫做Unicode字符集。在Unicode字符集中包含了世界上所有国家的文字，一个字符采用4个字节来存储。

在Unicode字符集中，采用一个字符4个字节的编码方案，又造成另一个问题：如果是说英语的国家，他们只需要用到26大小写字母，加上一些标点符号就够了，本身一个字节就可以表示完，用4个字节就有点浪费。

于是又对Unicode字符集中的字符进行了重新编码，一共设计了三种编码方案。分别是UTF-32、UTF-16、UTF-8;  **其中比较常用的编码方案是UTF-8**

下面我们详细介绍一下UTF-8这种编码方案的特点。

1. UTF-8是Unicode字符集的一种编码方案，采取可变长编码方案，共分四个长度区：1个字节，2个字节，3个字节，4个字节
2. 英文字母、数字占1个字节兼容(ASCII编码)
3. 汉字字符占3个字节
4. 极少数字符占4个字节

![](/zzimages/20230709184606.png)


### 1.4 字符集小结

```java
ASCII字符集：只有英文、数字、符号等，占1个字节。

GBK字符集：汉字占2个字节，英文、数字占1个字节。

UTF-8字符集：汉字占3个字节，英文、数字占1个字节。
```

注意：

- 技术人员在开发时都应该使用UTF-8编码!
- 字符编码时使用的字符集，和解码时使用的字符集必须一致，否则会出现乱码
- 英文，数字一般不会乱码，因为很多字符集都兼容了ASCII编码。


### 1.5 编码和解码

搞清楚字符集的知识之后，我们接下来再带着同学们使用Java代码完成编码和解码的操作。

其实String类类中就提供了相应的方法，可以完成编码和解码的操作。

- 编码：把字符串按照指定的字符集转换为字节数组
- 解码：把字节数组按照指定的字符集转换为字符串

![](/zzimages/20230709185350.png)


```java
/**
 * 目标：掌握如何使用Java代码完成对字符的编码和解码。
 */
public class Test {
    public static void main(String[] args) throws Exception {
        // 1、编码
        String data = "a我b";
        byte[] bytes = data.getBytes(); // 默认是按照平台字符集（UTF-8）进行编码的。
        System.out.println(Arrays.toString(bytes));

        // 按照指定字符集进行编码。
        byte[] bytes1 = data.getBytes("GBK");
        System.out.println(Arrays.toString(bytes1));

        // 2、解码
        String s1 = new String(bytes); // 按照平台默认编码（UTF-8）解码
        System.out.println(s1);

        String s2 = new String(bytes1, "GBK");
        System.out.println(s2);
    }
}
```


## 二、IO流（字节流）

### 2.1 IO流概述

各位小伙伴，在前面我们已经学习过File类。但是我们知道File只能操作文件，但是不能操作文件中的内容。我们也学习了字符集，不同的字符集存字符数据的原理是不一样的。有了前面两个知识的基础，接下来我们再学习IO流，就可以对文件中的数据进行操作了。

IO流的作用：就是可以对文件或者网络中的数据进行读、写的操作。

- 把数据从磁盘、网络中读取到内存中，用到的是输入流Input。
- 把程序中的数据写入磁盘、网络中，用到的是输出流Output。

IO流在Java中有很多种，不同的流来干不同的事情。Java把各种流用不同的类来表示，这些流的继承体系如下图所示：

```java
IO流分为两大派系：
	1.字节流：适合操作所有类型的文件，如视频、图片、文件复制等。
	2.字符流：只适合操作纯文本文件，如读写txt、java文件等。
```

![](/zzimages/1667823186345.png)

**总结流的四大类**:

- 字节输入流：以内存为基准，来自磁盘文件/网络中的数据以字节的形式读入到内存中去的流
- 字节输出流：以内存为基准，把内存中的数据以字节写出到磁盘文件或者网络中去的流。
- 字符输入流：以内存为基准，来自磁盘文件/网络中的数据以字符的形式读入到内存中去的流。
- 字符输出流：以内存为基准，把内存中的数据以字符写出到磁盘文件或者网络介质中去的流。


### 2.2 FileInputStream读取一个字节

同学们，在上节课认识了什么是IO流，接下来我们学习字节流中的字节输入流，用InputStream来表示。但是InputStream是抽象类，我们用的是它的子类，叫FileInputStream。

需要用到的方法如下图所示：有构造方法、成员方法

![](/zzimages/1667823417184.png)

使用FileInputStream读取文件中的字节数据，步骤如下

```java
第一步：创建FileInputStream文件字节输入流管道，与源文件接通。
第二步：调用read()方法开始读取文件的字节数据。
第三步：调用close()方法释放资源
```

代码如下：

```java
public class FileInputStreamTest1 {
    public static void main(String[] args) throws Exception {
        // 1、创建文件字节输入流管道，与源文件接通。
        InputStream is = new FileInputStream(("file-io-app\\src\\itheima01.txt"));

        // 2、开始读取文件的字节数据。
        // public int read():每次读取一个字节返回，如果没有数据了，返回-1.
        int b; // 用于记住读取的字节。
        while ((b = is.read()) != -1){
            System.out.print((char) b);
        }
        
        //3、流使用完毕之后，必须关闭！释放系统资源！
        is.close();
    }
}
```

注意：使用FileInputStream每次读取一个字节，读取性能较差，并且读取汉字输出会乱码。

### 2.3 FileInputStream读取多个字节

为了提高效率，我们可以使用另一个 `read(byte[] bytes)` 的重载方法，可以一次读取多个字节，至于一次读多少个字节，就在于你传递的数组有多大。

使用FileInputStream一次读取多个字节的步骤如下

```java
第一步：创建FileInputStream文件字节输入流管道，与源文件接通。
第二步：调用read(byte[] bytes)方法开始读取文件的字节数据。
第三步：调用close()方法释放资源
```

代码如下：

```java
public class FileInputStreamTest2 {
    public static void main(String[] args) throws Exception {
        // 1、创建一个字节输入流对象代表字节输入流管道与源文件接通。
        InputStream is = new FileInputStream("file-io-app\\src\\itheima02.txt");

        // 2、开始读取文件中的字节数据：每次读取多个字节。
        //  public int read(byte b[]) throws IOException
        //  每次读取多个字节到字节数组中去，返回读取的字节数量，读取完毕会返回-1.

        // 3、使用循环改造。
        byte[] buffer = new byte[3];
        int len; // 记住每次读取了多少个字节。  abc 66
        while ((len = is.read(buffer)) != -1){
            // 注意：读取多少，倒出多少。
            String rs = new String(buffer, 0 , len);
            System.out.print(rs);
        }
        // 性能得到了明显的提升！！
        // 这种方案也不能避免读取汉字输出乱码的问题！！

        is.close(); // 关闭流
    }
}
```

- 需要我们注意的是：**read(byte[] bytes)它的返回值，表示当前这一次读取的字节个数。**

假设有一个a.txt文件如下：

```java
abcde
```

每次读取过程如下

```java
注意read()并不是每次读取的时候都把数组装满，比如数组是 byte[] bytes = new byte[3];
第一次调用read(bytes)读取了3个字节(分别是97,98,99)，并且往数组中存，此时返回值就是3
第二次调用read(bytes)读取了2个字节(分别是99,100),并且往数组中存，此时返回值是2
第三次调用read(bytes)文件中后面已经没有数据了，此时返回值为-1
```

- 还需要注意一个问题：采用一次读取多个字节的方式，也是可能有乱码的。因为也有可能读取到半个汉字的情况。



### 2.4 FileInputStream读取全部字节

我们可以一次性读取文件中的全部字节，然后把全部字节转换为一个字符串，就不会有乱码了。

- 方式一：自己定义一个字节数组与被读取的文件大小一样大，然后使用该字节数组，一次读完文件的全部字节。

```java
// 1、一次性读取完文件的全部字节到一个字节数组中去。
// 创建一个字节输入流管道与源文件接通
InputStream is = new FileInputStream("file-io-app\\src\\itheima03.txt");

// 2、准备一个字节数组，大小与文件的大小正好一样大。
File f = new File("file-io-app\\src\\itheima03.txt");
long size = f.length();
byte[] buffer = new byte[(int) size];

int len = is.read(buffer);
System.out.println(new String(buffer));

//3、关闭流
is.close(); 
```

- 方式二：Java官方为InputStream提供了如下方法，可以直接把文件的全部字节读取到一个字节数组中返回。

![](/zzimages/1667830186936.png)

```java
// 1、一次性读取完文件的全部字节到一个字节数组中去。
// 创建一个字节输入流管道与源文件接通
InputStream is = new FileInputStream("file-io-app\\src\\itheima03.txt");

//2、调用方法读取所有字节，返回一个存储所有字节的字节数组。
byte[] buffer = is.readAllBytes();
System.out.println(new String(buffer));

//3、关闭流
is.close(); 
```

最后，还是要注意一个问题：**一次读取所有字节虽然可以解决乱码问题，但是文件不能过大，如果文件过大，可能导致内存溢出**。

事实上，读写文本内容更适合用字符流。而字节流适合做数据的转移，如文件复制等。


### 2.5 FileOutputStream写字节


往文件中写数据需要用到OutputStream下面的一个子类FileOutputStream。

使用FileOutputStream往文件中写数据的步骤如下：

```java
第一步：创建FileOutputStream文件字节输出流管道，与目标文件接通。
第二步：调用wirte()方法往文件中写数据
第三步：调用close()方法释放资源
```

![](/zzimages/20230709211254.png)


代码如下：

```java
/**
 * 目标：掌握文件字节输出流FileOutputStream的使用。
 */
public class FileOutputStreamTest4 {
    public static void main(String[] args) throws Exception {
        // 1、创建一个字节输出流管道与目标文件接通。
        // 覆盖管道：覆盖之前的数据
//        OutputStream os =
//                new FileOutputStream("file-io-app/src/itheima04out.txt");

        // 追加数据的管道
        OutputStream os =
                new FileOutputStream("file-io-app/src/itheima04out.txt", true);

        // 2、开始写字节数据出去了
        os.write(97); // 97就是一个字节，代表a
        os.write('b'); // 'b'也是一个字节
        // os.write('磊'); // 默认只能写出去一个字节

        byte[] bytes = "我爱你中国abc".getBytes();
        os.write(bytes);

        os.write(bytes, 0, 15);

        // 换行符
        os.write("\r\n".getBytes());

        os.close(); // 关闭流
    }
}
```


### 2.6 字节流复制文件

同学们，我们在前面已经把字节输入流和字节输出流都学习完了。现在我们就可以用这两种流配合起来使用，做一个文件复制的综合案例。

比如：我们要复制一张图片，从磁盘`D:/resource/meinv.png`的一个位置，复制到`C:/data/meinv.png`位置。

复制文件的思路如下图所示：

```java
1.需要创建一个FileInputStream流与源文件接通，创建FileOutputStream与目标文件接通
2.然后创建一个数组，使用FileInputStream每次读取一个字节数组的数据，存如数组中
3.然后再使用FileOutputStream把字节数组中的有效元素，写入到目标文件中
```

代码如下：

```java
/**
 * 目标：使用字节流完成对文件的复制操作。
 */
public class CopyTest5 {
    public static void main(String[] args) throws Exception {
        // 需求：复制照片。
        // 1、创建一个字节输入流管道与源文件接通
        InputStream is = new FileInputStream("D:/resource/meinv.png");
        // 2、创建一个字节输出流管道与目标文件接通。
        OutputStream os = new FileOutputStream("C:/data/meinv.png");

        System.out.println(10 / 0);
        // 3、创建一个字节数组，负责转移字节数据。
        byte[] buffer = new byte[1024]; // 1KB.
        // 4、从字节输入流中读取字节数据，写出去到字节输出流中。读多少写出去多少。
        int len; // 记住每次读取了多少个字节。
        while ((len = is.read(buffer)) != -1){
            os.write(buffer, 0, len);
        }

        os.close();
        is.close();
        System.out.println("复制完成！！");
    }
}
```

注意：字节流非常适合做一切文件的复制操作，因为任何文件的底层都是字节，字节流做复制，是一字不漏的转移完全部字节，只要复制后的文件格式一致就没问题。

## 三、IO流资源释放

各位同学，前面我们已经学习了字节流，也给同学们强调过，流使用完之后一定要释放资源。但是我们之前的代码并不是很专业。


### 3.1 JDK7以前的资源释放

在JDK7版本以前，我们可以使用try...catch...finally语句来处理。

finally代码区的特点：无论try中的程序是正常执行了，还是出现了异常，最后都一定会执行finally区，除非JVM终止。

作用：一般用于在程序执行完成后进行资源的释放操作（专业级做法）。

```java
try{
    //有可能产生异常的代码
}catch(异常类 e){
    //处理异常的代码
}finally{
    //释放资源的代码
    //finally里面的代码有一个特点，不管异常是否发生，finally里面的代码都会执行。
}
```

缺点：代码太长、臃肿、不优雅。



### 3.2 JDK7以后的资源释放

![](/zzimages/20230709214245.png)

代码如下：

```java
public class Test3 {
    public static void main(String[] args)  {
    	try (
          // 1、创建一个字节输入流管道与源文件接通
          InputStream is = new FileInputStream("D:/resource/meinv.png");
          // 2、创建一个字节输出流管道与目标文件接通。
          OutputStream os = new FileOutputStream("C:/data/meinv.png");
        ){
            // 3、创建一个字节数组，负责转移字节数据。
            byte[] buffer = new byte[1024]; // 1KB.
            // 4、从字节输入流中读取字节数据，写出去到字节输出流中。读多少写出去多少。
            int len; // 记住每次读取了多少个字节。
            while ((len = is.read(buffer)) != -1){
                os.write(buffer, 0, len);
            }
            System.out.println(conn);
            System.out.println("复制完成！！");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```










