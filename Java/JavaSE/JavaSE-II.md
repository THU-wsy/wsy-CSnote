# 第09章_异常处理

## 1. 异常概述

### 1.1 异常

**异常** ：指的是程序在执行过程中，出现的非正常情况，如果不处理最终会导致JVM的非正常停止。

> 异常指的并不是语法错误和逻辑错误。语法错了，编译不通过，不会产生字节码文件，根本不能运行。代码逻辑错误，只是没有得到想要的结果，例如：求a与b的和，你写成了a-b

### 1.2 异常的抛出机制

Java中把不同的异常用不同的类表示，一旦发生某种异常，就`创建该异常类型的对象`，并且抛出（throw）。然后程序员可以捕获(catch)到这个异常对象，并处理；如果没有捕获(catch)这个异常对象，那么这个异常对象将会导致程序终止。

### 1.3 如何对待异常

对于程序出现的异常，一般有两种解决方法：一是遇到错误就终止程序的运行。另一种方法是程序员在编写程序时，就充分考虑到各种可能发生的异常和错误，极力预防和避免。实在无法避免的，要编写相应的代码进行异常的检测、以及`异常的处理`，保证代码的`健壮性`。

## 2. Java异常体系

### 2.1 Throwable

`java.lang.Throwable` 类是Java程序执行过程中发生的异常事件对应的类的根父类。

**Throwable中的常用方法：**

* `public void printStackTrace()`：打印异常的详细信息。包含了异常的类型、异常的原因、异常出现的位置、在开发和调试阶段都得使用printStackTrace。

* `public String getMessage()`：获取发生异常的字符串信息。比如，自定义异常类型时，用的带参数String的构造器中传入的String参数，就可以用该getMessage()方法获取到。

### 2.2 Error 和 Exception

Throwable可分为两类：Error和Exception。分别对应着`java.lang.Error`与`java.lang.Exception`两个类。

**Error**：Java虚拟机无法解决的严重问题。如：JVM系统内部错误、资源耗尽等严重情况。一般不编写针对性的代码进行处理。

- 例如：StackOverflowError（栈内存溢出）和OutOfMemoryError（堆内存溢出，简称OOM）。

**Exception**: 其它因编程错误或偶然的外在因素导致的一般性问题，需要使用针对性的代码进行处理，使程序继续运行。否则一旦发生异常，程序也会挂掉。

> 说明：
>
> 1. 无论是Error还是Exception，还有很多子类，异常的类型非常丰富。当代码运行出现异常时，特别是我们不熟悉的异常时，不要紧张，把异常的简单类名，拷贝到API中去查去认识它即可。
> 2. 我们本章讲的异常处理，其实针对的就是Exception。


### 2.3 编译时异常和运行时异常

Java程序的执行分为编译时过程和运行时过程。因此，根据异常可能出现的阶段，可以将异常分为：

* **编译时期异常**（即checked异常、受检异常）：在代码编译阶段，编译器就能明确`警示`当前代码`可能发生（不是一定发生）`xx异常，并`明确督促`程序员提前编写处理它的代码。如果程序员`没有编写`对应的异常处理代码，则编译器就会直接判定编译失败，从而不能生成字节码文件。通常，这类异常的发生不是由程序员的代码引起的，或者不是靠加简单判断就可以避免的，例如：FileNotFoundException（文件找不到异常）、ClassNotFoundException、IOException。
* **运行时期异常**（即runtime异常、unchecked异常、非受检异常）：在代码编译阶段，编译器完全不做任何检查，无论该异常是否会发生，编译器都不给出任何提示。只有等代码运行起来并确实发生了xx异常，它才能被发现。通常，这类异常是由程序员的代码编写不当引起的，只要稍加判断，或者细心检查就可以避免。
  * **java.lang.RuntimeException**类及它的子类都是运行时异常。比如：ArrayIndexOutOfBoundsException数组下标越界异常，ClassCastException类型转换异常，NullPointerException，NumberFormatException，InputMismatchException，ArithmeticException。

## 3. 异常的处理

### 3.1 异常处理概述

**Java异常处理**

Java采用的异常处理机制，是`将异常处理的程序代码集中在一起`，与正常的程序代码分开，使得程序简洁、优雅，并易于维护。

**Java异常处理的方式：**

方式一：try-catch-finally

方式二：throws + 异常类型

**Java提供了异常处理的抓抛模型**：

- Java程序的执行过程中如出现异常，会生成一个异常类对象，该异常对象将被提交给Java运行时系统，这个过程称为`抛出(throw)异常`。当然，程序员也可以使用"throw + 异常类对象"的方式主动抛出异常对象。
- 如果一个方法内抛出异常，该异常对象会被抛给调用者方法中处理。处理方式有两种：一种方式是通过 throws 继续抛给这个调用方法的上层方法，这个过程可以一直继续下去；另一种方式是直接通过 `try-catch-finally` 捕获异常并进行处理。注意如果一个异常一直被抛到main()方法，并且main()也不进行 `try-catch-finally` 捕获处理，那么程序将运行终止。编译时异常要求必须显式地选择上述两种方法之一来处理，而运行时异常可以不处理，此时默认将异常不断抛给上层方法。

### 3.2 方式1：捕获异常（try-catch-finally）

#### 3.2.1 try-catch-finally基本格式

捕获异常语法如下：

~~~java
try{
	......	//可能产生异常的代码
}
catch( 异常类型1 e ){
	......	//当产生异常类型1型异常时的处置措施
}
catch( 异常类型2 e ){
	...... 	//当产生异常类型2型异常时的处置措施
}  
finally{
	...... //无论是否发生异常，都无条件执行的语句
} 

~~~

**1、整体执行过程：**

当某段代码可能发生异常，不管这个异常是编译时异常（受检异常）还是运行时异常（非受检异常），我们都可以使用try块将它括起来，并在try块下面编写catch分支尝试捕获对应的异常对象。

- 如果在程序运行时，try块中的代码没有发生异常，那么catch所有的分支都不执行。
- 如果在程序运行时，try块中的代码发生了异常，根据异常对象的类型，将从上到下选择第一个匹配的catch分支执行。此时try中发生异常的语句下面的代码将不执行，而整个try...catch之后的代码可以继续运行。
- 如果在程序运行时，try块中的代码发生了异常，但是所有catch分支都无法匹配（捕获）这个异常，那么JVM将会终止当前方法的执行，并把异常对象“抛”给调用者。如果调用者不处理，程序就挂了。

**2、try**

- 捕获异常的第一步是用`try{…}语句块`选定捕获异常的范围，将可能出现异常的业务逻辑代码放在try语句块中。注意，try中声明的局部变量，出了try结构之后，就不可以进行调用了。

**3、catch (Exceptiontype e)**

- catch分支，分为两个部分，catch()中编写异常类型和异常参数名，{}中编写如果发生了这个异常，要做什么处理的代码。

- 如果明确知道产生的是何种异常，可以用该异常类作为catch的参数；也可以用其父类作为catch的参数。

- 如果有多个catch分支，并且多个异常类型有父子类关系，必须保证小的子异常类型在上，大的父异常类型在下。否则，报错。

- catch中常用异常处理的方式
  - 自己编写输出的语句
  - `public String getMessage()`：获取异常的描述信息，返回字符串

  - `public void printStackTrace()`：打印异常的跟踪栈信息并输出到控制台。包含了异常的类型、异常的原因、还包括异常出现的位置，在开发和调试阶段，都得使用printStackTrace()。

- try-catch结构是可以嵌套使用的

举例：

```java
@Test
public void test1(){
	try{
		String str1 = "atguigu.com";
		str1 = null;
		System.out.println(str1.charAt(0));
	}catch(NullPointerException e){
		//异常的处理方式1
		System.out.println("不好意思，亲~出现了小问题，正在加紧解决...");	
	}catch(ClassCastException e){
		//异常的处理方式2
		System.out.println("出现了类型转换的异常");
	}catch(RuntimeException e){
		//异常的处理方式3
		System.out.println("出现了运行时异常");
	}
	//此处的代码，在异常被处理了以后，是可以正常执行的
	System.out.println("hello");
}
```


#### 3.2.2 finally使用及举例

因为异常会引发程序跳转，从而会导致有些语句执行不到。而程序中有一些特定的代码无论异常是否发生，都`需要执行`。例如，数据库连接、输入流输出流、Socket连接、Lock锁的关闭等，这样的代码通常就会放到finally块中。所以，我们通常将一定要被执行的代码声明在finally中。唯一的例外，使用 System.exit(0) 来终止当前正在运行的 Java 虚拟机，则finally中的代码就不会执行。

- 不论在try代码块中是否发生了异常事件，catch语句是否执行，catch语句是否有异常，catch语句中是否有return，finally块中的语句都会被执行。

- finally语句和catch语句都是可选的，但finally不能单独使用。

**举例：确保资源关闭**

```java
public class TestFinally {
    @Test
    public void test1(){
        FileInputStream fis = null;
        try{
            File file = new File("hello1.txt");
            fis = new FileInputStream(file);//FileNotFoundException
            int b = fis.read();//IOException
            while(b != -1){
                System.out.print((char)b);
                b = fis.read();//IOException
            }
        }catch(IOException e){
            e.printStackTrace();
        }finally{
            try {
                if(fis != null)
                    fis.close();//IOException
            } catch (IOException e) {
                e.printStackTrace();
            }	
        }
    }
}
```

**笔试题1：**

```java
public class FinallyTest1 {
    public static void main(String[] args) {
        int result = test("12"); // test结束
        System.out.println(result); // 1
    }
    public static int test(String str){
        try{
            Integer.parseInt(str);
            return 1;
        }catch(NumberFormatException e){
            return -1;
        }finally{
            System.out.println("test结束");
        }
    }
}
```

**笔试题2：**

```java
public class FinallyTest2 {
    public static void main(String[] args) {
        int result = test("a"); // test结束
        System.out.println(result); // -1
    }
    public static int test(String str) {
        try {
            Integer.parseInt(str);
            return 1;
        } catch (NumberFormatException e) {
            return -1;
        } finally {
            System.out.println("test结束");
        }
    }
}
```

**笔试题3：**

```java
public class FinallyTest3 {
    public static void main(String[] args) {
        int result = test("a"); // test结束
        System.out.println(result); // 0
    }
    public static int test(String str) {
        try {
            Integer.parseInt(str);
            return 1;
        } catch (NumberFormatException e) {
            return -1;
        } finally {
            System.out.println("test结束");
            return 0;
        }
    }
}
```

**笔试题4：**

```java
public class FinallyTest4 {
    public static void main(String[] args) {
        int result = test(10); // test结束
        System.out.println(result); // 11
    }
    public static int test(int num) {
        try {
            return num;
        } catch (NumberFormatException e) {
            return num--;
        } finally {
            System.out.println("test结束");
            return ++num;
        }
    }
}
```

**笔试题5：**

```java
public class FinallyTest5 {
    public static void main(String[] args) {
        int result = test(10); // test结束
        System.out.println(result); // 10
    }
    public static int test(int num) {
        try {
            return num;
        } catch (NumberFormatException e) {
            return num--;
        } finally {
            System.out.println("test结束");
            ++num;
        }
    }
}
```

**解释：方法栈帧中有操作数栈和局部变量表，进入try语句后，将局部变量表中值为10的num放入临时的操作数栈中准备return，此时执行finally语句，将局部变量表中的num值++变为11，但操作数栈中的值并未改变，然后return返回，将10赋值给result**。

#### 3.2.3 try-with-resource

finally的一个很重要的应用场景就是完成对资源的释放，JDK7之前基本也都是通过finally来释放一些流资源，但其缺点是代码太长、臃肿。如下所示：

```java
@Test
public void test01() {
    FileWriter fw = null;
    BufferedWriter bw = null;
    try {
        fw = new FileWriter("d:/1.txt");
        bw = new BufferedWriter(fw);

        bw.write("hello");
    } catch (IOException e) {
        e.printStackTrace();
    } finally {
        try {
            if (bw != null) {
                bw.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            if (fw != null) {
                fw.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
```

**JDK7开始提供了更简单的资源释放方案：try-with-resource**，格式如下：

```java
try (
    定义资源1;
    定义资源2; ...
) {
    可能出现异常的代码;
} catch (异常类名 变量名) {
    异常的处理代码;
}
```

这种方案能使得资源使用完毕后，自动调用其close()方法，完成对资源的释放。注意：

- try后的`()`内只能放置资源，否则报错
- 写到try()中的资源类的变量默认是final声明的，不能修改
- 资源一般指的是最终实现了AutoCloseable接口的类，比如

```java
public abstract class InputStream implements Closeable {}
public abstract class OutputStream implements Closeable, Flushable {}
public interface Closeable extends AutoCloseable {}
```

举例：

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
            System.out.println("复制完成！！");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```


**JDK9的新特性**

try的前面可以定义流对象，try后面的()中可以直接引用流对象的名称。在try代码执行完毕后，流对象也可以释放掉，也不用写finally了。注意资源必须是final的，不可再被赋值。

格式：

```java
A a = new A();
B b = new B();
try (a;b) {
    可能产生的异常代码
} catch (异常类名 变量名) {
    异常处理的逻辑
}
```

举例：

```java
@Test
public void test04() {
    InputStreamReader reader = new InputStreamReader(System.in);
    OutputStreamWriter writer = new OutputStreamWriter(System.out);
    try (reader; writer) {
        //reader是final的，不可再被赋值
        //   reader = null;

    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

#### 3.2.4 异常处理的体会

- 对于运行时异常，即`RuntimeException类`或是它的`子类`，这些类的异常的特点是：即使没有使用try和catch捕获，Java自己也能捕获，并且编译通过 ( 但运行时会发生异常使得程序运行终止 )。所以，对于这类异常，可以不作处理，因为这类异常很普遍，若全处理可能会对程序的可读性和运行效率产生影响。

- 如果抛出的异常是IOException等类型的`非运行时异常`，则必须捕获，否则`编译错误`。也就是说，我们必须处理编译时异常，将异常进行捕捉，转化为运行时异常。

**简而言之，运行时异常无需处理，但编译时异常必须处理**。

### 3.3 方式2：声明抛出异常类型（throws）

如果在编写方法体的代码时，某句代码可能发生某个`编译时异常`，不处理编译不通过，但是在当前方法体中可能`不适合处理`或`无法给出合理的处理方式`，则此方法应`显式地`声明抛出异常，表明该方法将不对这些异常进行处理，而由该方法的调用者负责处理。

具体方式：在方法声明中用`throws语句`可以声明抛出异常的列表，throws后面的异常类型可以是方法中产生的异常类型，也可以是它的父类。

#### 3.3.1 throws基本格式

**声明异常格式：**

~~~java
修饰符 返回值类型 方法名(参数) throws 异常类名1, 异常类名2…{   }	
~~~

举例：

```java
public void readFile(String file)  throws FileNotFoundException, IOException {
	...
	// 读文件的操作可能产生FileNotFoundException或IOException类型的异常
	FileInputStream fis = new FileInputStream(file);
    //...
}

```

#### 3.3.2 throws 使用举例

**针对于编译时异常：**

```java
public class TestThrowsCheckedException {
    public static void main(String[] args) {
        System.out.println("上课.....");
        try {
            afterClass();//换到这里处理异常
        } catch (InterruptedException e) {
            e.printStackTrace();
            System.out.println("准备提前上课");
        }
        System.out.println("上课.....");
    }

    public static void afterClass() throws InterruptedException {
        for(int i=10; i>=1; i--){
            Thread.sleep(1000);//本来应该在这里处理异常
            System.out.println("距离上课还有：" + i + "分钟");
        }
    }
}
```

**针对于运行时异常：**

throws后面也可以写运行时异常类型，只是运行时异常类型，写或不写对于编译器和程序执行来说都没有任何区别。如果写了，唯一的区别就是调用者调用该方法后，使用try...catch结构时，IDEA可以获得更多的信息，需要添加哪种catch分支。

**throws是否真正处理了异常？**

> 从编译是否能通过的角度看，看成是给出了异常万一要是出现时候的解决方案。此方案就是，继续向上抛出(throws)。
> 
> 但是，此throws的方式，仅是将可能出现的异常抛给了此方法的调用者。此调用者仍然需要考虑如何处理相关异常。从这个角度来看，throws的方式不算是真正意义上处理了异常。


### 3.4 两种异常处理方式的选择

前提：对于异常，使用相应的处理方式。此时的异常，主要指的是编译时异常。

- 如果程序代码中，涉及到资源的调用（流、数据库连接、网络连接等），则必须考虑使用try-catch-finally来处理，保证不出现内存泄漏。
- 如果父类被重写的方法没有throws异常类型，则子类重写的方法中如果出现异常，只能考虑使用try-catch-finally进行处理，不能throws。
- 开发中，方法a中依次调用了方法b,c,d等方法，方法b,c,d之间是递进关系。此时，如果方法b,c,d中有异常，我们通常选择使用throws，而方法a中通常选择使用try-catch-finally。

**注意：Exception代表可以捕获一切异常，开发中简化代码一般直接抛出和捕获Exception即可**。

## 4. 手动抛出异常对象：throw

Java 中异常对象的生成有两种方式：

- 由虚拟机**自动生成**：程序运行过程中，虚拟机检测到程序发生了问题，那么针对当前代码，就会在后台自动创建一个对应异常类的实例对象并抛出。

- 由开发人员**手动创建**：`new 异常类型(参数);`，如果创建好的异常对象不抛出对程序没有任何影响，和创建一个普通对象一样，但是一旦throw抛出，就会对程序运行产生影响了。在实际开发中，如果出现不满足具体场景的代码问题，我们就有必要手动抛出一个指定类型的异常对象。

### 4.1 使用格式

~~~java
throw new 异常类型(参数);
~~~

throw语句抛出的异常对象，和JVM自动创建和抛出的异常对象一样。

- 如果是编译时异常类型的对象，同样需要使用throws或者try...catch处理，否则编译不通过。

- 如果是运行时异常类型的对象，编译器不提示。

- 可以抛出的异常必须是Throwable或其子类的实例。

### 4.2 使用注意点

无论是编译时异常类型的对象，还是运行时异常类型的对象，如果没有被try..catch合理的处理，都会导致程序崩溃。

throw语句会导致程序执行流程被改变，throw语句是明确抛出一个异常对象，因此它`下面的代码将不会执行`。

如果当前方法没有try...catch处理这个异常对象，throw语句就会`代替return语句`提前终止当前方法的执行，并返回一个异常对象给调用者。

~~~java
public class MyTest {
    public static void main(String[] args) {
        Student s = new Student();
        try {
            s.regist(-1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
class Student {
    int id;
    public void regist(int id) throws Exception {
        if (id >= 0)
            this.id = id;
        else
            throw new Exception("输入的id非法");
    }
}
~~~

## 5. 自定义异常

### 5.1 为什么需要自定义异常类

Java中不同的异常类，分别表示着某一种具体的异常情况。那么在开发中总是有些异常情况是核心类库中没有定义好的，此时我们需要根据自己业务的异常情况来定义异常类。例如年龄负数问题，考试成绩负数问题，某员工已在团队中等。

### 5.2 如何自定义异常类

1. 要继承一个异常类型
   - 自定义一个编译时异常类型：自定义类继承 `java.lang.Exception`。
   - 自定义一个运行时异常类型：自定义类继承 `java.lang.RuntimeException`。

2. 建议提供至少两个构造器，一个是无参构造，一个是(String message)构造器。
3. 自定义异常需要提供一个全局常量`serialVersionUID`

例：

```java
public class BelowZeorException extends Exception {
    static final long serialVersionUID = -33234524229948L;
    public BelowZeorException() {
        super();
    }
    public BelowZeorException(String message) {
        super(message);
    }
}
```

### 5.3 注意点

1. 自定义的异常只能通过throw手动抛出。
2. 自定义异常最重要的是异常类的名字和message属性。当异常出现时，可以见名知义，根据名字判断异常类型。比如：`TeamException("成员已满，无法添加"); `
3. 自定义异常对象只能手动抛出。抛出后由try..catch处理，也可以用throws甩给调用者处理。


# 第10章_多线程

## 1. 基本概念

下图中，红框的蓝色区域为线程独享，黄色区域为线程共享。

  ![](/zzimages/image-20220514175737426.png)

  > 注意：
  >
  > 不同的进程之间是不共享内存的。
  >
  > 进程之间的数据交换和通信的成本很高。


**抢占式调度**：让`优先级高`的线程以`较大的概率`优先使用 CPU。如果线程的优先级相同，那么会随机选择一个(线程随机性)，Java使用的就是抢占式调度。

**单核CPU和多核CPU**

单核CPU，在一个时间单元内，只能执行一个线程的任务。

`问题：多核的效率是单核的倍数吗？`理论上是，但是实际不可能，至少有两方面的损耗。

- `一个是多个核心的其他共用资源限制`。譬如，4核CPU对应的内存、cache、寄存器并没有同步扩充4倍。
- `另一个是多核CPU之间的协调管理损耗`。譬如多个核心同时运行两个相关的任务，需要考虑任务同步，这也需要消耗额外性能。

在操作系统中，启动了多个程序，`并发`指的是在一段时间内宏观上有多个程序同时运行，这在单核 CPU 系统中，每一时刻只能有一个程序执行，即微观上这些程序是分时的交替运行，只不过是给人的感觉是同时运行，那是因为分时交替运行的时间是非常短的。

而在多核 CPU 系统中，则这些可以`并发`执行的程序便可以分配到多个CPU上，实现多任务并行执行，即利用每个处理器来处理一个可以并发执行的程序，这样多个程序便可以同时执行。目前电脑市场上说的多核 CPU，便是多核处理器，核越多，`并行`处理的程序越多，能大大的提高电脑运行的效率。

## 2.创建和启动线程

### 2.1 概述

Java语言的JVM允许程序运行多个线程，使用`java.lang.Thread`类代表**线程**，所有的线程对象都必须是Thread类或其子类的实例。

**Thread类的特性**：

- 每个线程都是通过某个特定Thread对象的run()方法来完成操作的，因此把run()方法体称为`线程执行体`。
- 通过该Thread对象的start()方法来启动这个线程，而非直接调用run()
- 要想实现多线程，必须在主线程中创建新的线程对象。

### 2.2 方式1：继承Thread类

Java通过继承Thread类来**创建**并**启动多线程**的步骤如下：

1. 定义Thread类的子类，并重写该类的run()方法，该run()方法的方法体就代表了线程需要完成的任务
2. 创建当前Thread子类的实例，即创建了线程对象
3. 调用线程对象的start()方法，其作用是：启动该线程，并调用当前线程的run()方法

代码如下：

~~~java
//自定义线程类
class MyThread extends Thread {
    public MyThread() {}
    //定义指定线程名称的构造方法
    public MyThread(String name) {
        //调用父类的String参数的构造方法，指定线程的名称
        super(name);
    }
    //重写run方法，完成该线程执行的逻辑
    @Override
    public void run() {
        for (int i = 0; i < 10; i++) {
            System.out.println(getName()+"："+i);
        }
    }
}
public class MyTest {
    public static void main(String[] args) {
        //创建自定义线程对象1
        MyThread mt1 = new MyThread();
        //开启子线程1
        mt1.start();

        //创建自定义线程对象2
        MyThread mt2 = new MyThread("子线程2");
        //开启子线程2
        mt2.start();

        //在主方法中执行for循环
        for (int i = 0; i < 10; i++) {
            System.out.println(Thread.currentThread().getName() + "：" + i);
        }
    }
}
~~~


> 注意：
>
> 1. 如果自己手动调用run()方法，那么就只是调用普通方法，没有启动多线程模式。想要启动多线程，必须调用start()方法。
>
> 2. run()方法由JVM调用，什么时候调用，执行的过程控制都由操作系统的CPU调度决定。
>
> 3. 一个线程对象只能调用一次start()方法启动，如果重复调用了，则将抛出异常`IllegalThreadStateException`。

### 2.3 方式2：实现Runnable接口

在核心类库中提供了Runnable接口，我们可以实现Runnable接口，重写run()方法，然后再通过Thread类的对象代理启动和执行我们的线程体run()方法。

步骤如下：

1. 定义Runnable接口的实现类，并重写该接口的run()方法，该run()方法的方法体同样是该线程的线程执行体。
2. 创建Runnable实现类的实例，并以此实例作为Thread的target参数(target参数是Runnable类型)来创建Thread对象，该Thread对象才是真正的线程对象。
3. 调用线程对象的start()方法，其作用是：启动线程，并调用当前Thread对象的run()方法，其底层实际上是又调用了target.run()方法。

代码如下：

```java
class MyRunnable implements Runnable {
    @Override
    public void run() {
        for (int i = 0; i < 20; i++) {
            System.out.println(Thread.currentThread().getName() + " " + i);
        }
    }
}
public class TestMyRunnable {
    public static void main(String[] args) {
        //创建自定义类对象  线程任务对象
        MyRunnable mr = new MyRunnable();
        //创建线程对象
        Thread t = new Thread(mr, "长江");
        t.start();
        for (int i = 0; i < 20; i++) {
            System.out.println("黄河 " + i);
        }
    }
}
```

说明：Runnable对象仅仅作为Thread对象的target，Runnable实现类里包含的run()方法仅作为线程执行体。而实际的线程对象依然是Thread实例，只是该Thread线程负责执行其target的run()方法。


### 2.4 对比两种方式

**共同点**：启动线程，使用的都是Thread类中定义的start(); 创建的线程对象，都是Thread类或其子类的实例

**不同点**：

- 继承Thread类：线程代码存放Thread子类run方法中。

- 实现Runnable接口：线程代码存在接口的实现类的run方法中。

**联系**：

Thread类实际上也是实现了Runnable接口的类。即：

```java
// 这是一种代理模式的设计模式
public class Thread extends Object implements Runnable
```

**实现Runnable接口比继承Thread类所具有的优势**

- 避免了单继承的局限性
- 多个线程可以共享同一个接口实现类的对象，非常适合多个相同线程来处理同一份资源。
- 增加程序的健壮性，实现解耦操作，代码可以被多个线程共享，代码和线程独立。



## 3. Thread类的常用结构

### 3.1 构造器

- `public Thread()`:分配一个新的线程对象。
- `public Thread(String name)`:分配一个指定名字的新的线程对象。
- `public Thread(Runnable target)`:指定创建线程的目标对象，它实现了Runnable接口中的run方法
- `public Thread(Runnable target, String name)`:分配一个带有指定目标新的线程对象并指定名字。

### 3.2 常用方法系列1

* `public void run()`: 调用target.run()执行代码。
* `public void start()`: 启动线程，Java虚拟机调用此线程的run方法。
* `public String getName()`: 获取当前线程名称。
* `public void setName(String name)`：设置该线程名称。
* `public static Thread currentThread()`: 返回对当前正在执行的线程对象的引用。在Thread子类中就是this，通常用于主线程和Runnable实现类
* `public static void sleep(long millis)`: **使当前正在执行的线程**以指定的毫秒数暂停（暂时停止执行）。
* `public static void yield()`：yield只是让当前线程释放CPU的占有权，让系统的线程调度器重新调度一次，希望优先级与当前线程相同或更高的其他线程能够获得执行机会，但是这个不能保证，完全有可能的情况是，当某个线程调用了yield方法暂停之后，线程调度器又将其调度出来重新执行。

### 3.3 常用方法系列2

* `public final boolean isAlive()`：测试线程是否处于活动状态。如果线程已经启动且尚未终止，则为活动状态。 

* `void join()`：等待该线程终止。例如，在线程a中调用b.join()，则线程a进入阻塞状态，等待线程b执行结束后，线程a才会解除阻塞，继续运行。

  `void join(long millis)` ：等待该线程终止的时间最长为 millis 毫秒。如果millis时间到，将不再等待。 

  `void join(long millis, int nanos)` ：等待该线程终止的时间最长为 millis 毫秒 + nanos 纳秒。 
  
* public final void stop()：`已过时`，不建议使用。强行结束一个线程的执行，直接进入死亡状态。run()即刻停止，可能会导致一些清理性的工作得不到完成，如文件，数据库等的关闭。同时，会立即释放该线程所持有的所有的锁，导致数据得不到同步的处理，出现数据不一致的问题。

* void suspend() / void resume() : `已过时`，不建议使用。这两个操作就好比播放器的暂停和恢复。二者必须成对出现，否则非常容易发生死锁。suspend()调用会导致线程暂停，但不会释放任何锁资源，导致其它线程都无法访问被它占用的锁，直到调用resume()。

### 3.4 常用方法系列3

每个线程都有一定的优先级，同优先级线程组成先进先出队列（先到先服务），使用分时调度策略。优先级高的线程采用抢占式策略，获得较多的执行机会。每个线程默认的优先级都与创建它的父线程具有相同的优先级。

- Thread类的三个优先级常量：
  - MAX_PRIORITY（10）：最高优先级 
  - MIN _PRIORITY（1）：最低优先级
  - NORM_PRIORITY（5）：普通优先级，默认情况下main线程具有普通优先级。

* `public final int getPriority()` ：返回线程优先级 
* `public final void setPriority(int newPriority)` ：改变线程的优先级，范围在[1,10]之间。


### 3.5 守护线程

有一种线程，它是在后台运行的，它的任务是为其他线程提供服务的，这种线程被称为“守护线程”。JVM的垃圾回收线程就是典型的守护线程。

守护线程有个特点，就是如果所有非守护线程都死亡，那么守护线程自动死亡。形象理解：`兔死狗烹`，`鸟尽弓藏`

调用setDaemon(true)方法可将指定线程设置为守护线程。必须在线程启动之前设置，否则会报IllegalThreadStateException异常。

调用isDaemon()可以判断线程是否是守护线程。

```java
public class TestThread {
	public static void main(String[] args) {
		MyDaemon m = new MyDaemon();
		m.setDaemon(true);
		m.start();

		for (int i = 1; i <= 100; i++) {
			System.out.println("main:" + i);
		}
	}
}
class MyDaemon extends Thread {
	public void run() {
		while (true) {
			System.out.println("我一直守护者你...");
			try {
				Thread.sleep(1);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}
```

## 4. 多线程的生命周期

Java语言使用Thread类及其子类的对象来表示线程，在它的一个完整的生命周期中通常要经历如下一些状态：

### 4.1 JDK1.5之前：5种状态

线程的生命周期有五种状态：新建（New）、就绪（Runnable）、运行（Running）、阻塞（Blocked）、死亡（Dead）。CPU需要在多条线程之间切换，于是线程状态会多次在运行、阻塞、就绪之间切换。

![](/zzimages/image-20220401002307038.png)


**1.新建**

当一个Thread类或其子类的对象被声明并创建时，新生的线程对象处于新建状态。此时它和其他Java对象一样，仅仅由JVM为其分配了内存，并初始化了实例变量的值。此时的线程对象并没有任何线程的动态特征，程序也不会执行它的线程体run()。

**2.就绪**

但是当线程对象调用了start()方法之后，就不一样了，线程就从新建状态转为就绪状态。JVM会为其创建方法调用栈和程序计数器，当然，处于这个状态中的线程并没有开始运行，只是表示已具备了运行的条件，随时可以被调度。至于什么时候被调度，取决于JVM里线程调度器的调度。

> 注意：
>
> 程序只能对新建状态的线程调用start()，并且只能调用一次，如果对非新建状态的线程，如已启动的线程或已死亡的线程调用start()都会报错IllegalThreadStateException异常。

**3.运行**

如果处于就绪状态的线程获得了CPU资源时，开始执行run()方法的线程体代码，则该线程处于运行状态。如果计算机只有一个CPU核心，在任何时刻只有一个线程处于运行状态，如果计算机有多个核心，将会有多个线程并行(Parallel)执行。

当然，美好的时光总是短暂的，而且CPU讲究雨露均沾。对于抢占式策略的系统而言，系统会给每个可执行的线程一个小时间段来处理任务，当该时间用完，系统会剥夺该线程所占用的资源，让其回到就绪状态等待下一次被调度。此时其他线程将获得执行机会，而在选择下一个线程时，系统会适当考虑线程的优先级。

**4.阻塞**

当在运行过程中的线程遇到如下情况时，会让出 CPU 并临时中止自己的执行，进入阻塞状态：

* 线程调用了sleep()方法，主动放弃所占用的CPU资源；
* 线程试图获取一个同步监视器，但该同步监视器正被其他线程持有；
* 线程执行过程中，同步监视器调用了wait()，让它等待某个通知（notify）；
* 线程执行过程中，同步监视器调用了wait(time)
* 线程执行过程中，遇到了其他线程对象的加塞（join）；
* 线程被调用suspend方法被挂起（已过时，因为容易发生死锁）；

当前正在执行的线程被阻塞后，其他线程就有机会执行了。针对如上情况，当发生如下情况时会解除阻塞，让该线程重新进入就绪状态，等待线程调度器再次调度它：

* 线程的sleep()时间到；
* 线程成功获得了同步监视器；
* 线程等到了通知(notify)；
* 线程wait的时间到了
* 加塞的线程结束了；
* 被挂起的线程又被调用了resume恢复方法（已过时，因为容易发生死锁）；

**5.死亡**

线程会以以下三种方式之一结束，结束后的线程就处于死亡状态：

* run()方法执行完成，线程正常结束
* 线程执行过程中抛出了一个未捕获的异常（Exception）或错误（Error）
* 直接调用该线程的stop()来结束该线程（已过时）

### 4.2 JDK1.5及之后：6种状态

在java.lang.Thread.State的枚举类中这样定义：

```java
public enum State {
	NEW,
	RUNNABLE,
	BLOCKED,
	WAITING,
	TIMED_WAITING,
	TERMINATED;
}
```

- `NEW（新建）`：线程刚被创建，但是并未启动。还没调用start方法。

- `RUNNABLE（可运行）`：这里没有区分就绪和运行状态。因为对于Java对象来说，只能标记为可运行，至于什么时候运行，不是JVM来控制的了，是OS来进行调度的，而且时间非常短暂，因此对于Java对象的状态来说，无法区分。

- `Teminated（被终止）`：表明此线程已经结束生命周期，终止运行。

- 重点说明，根据Thread.State的定义，**阻塞状态分为三种**：`BLOCKED`、`WAITING`、`TIMED_WAITING`。
  - `BLOCKED（锁阻塞）`：在API中的介绍为：一个正在阻塞、等待一个监视器锁（锁对象）的线程处于这一状态。只有获得锁对象的线程才能有执行机会。
    - 比如，线程A与线程B代码中使用同一锁，如果线程A获取到锁，线程A进入到Runnable状态，那么线程B就进入到Blocked锁阻塞状态。
  - `TIMED_WAITING（计时等待）`：在API中的介绍为：一个正在限时等待另一个线程执行一个（唤醒）动作的线程处于这一状态。
    - 当前线程执行过程中遇到Thread类的`sleep`或`join`，Object类的`wait`，LockSupport类的`park`方法，并且在调用这些方法时，`设置了时间`，那么当前线程会进入TIMED_WAITING，直到时间到，或被中断。
  - `WAITING（无限等待）`：在API中介绍为：一个正在无限期等待另一个线程执行一个特别的（唤醒）动作的线程处于这一状态。
    - 当前线程执行过程中遇到遇到Object类的`wait`，Thread类的`join`，LockSupport类的`park`方法，并且在调用这些方法时，`没有指定时间`，那么当前线程会进入WAITING状态，直到被唤醒。
      - 通过Object类的wait进入WAITING状态的要有Object的notify/notifyAll唤醒；
      - 通过Condition的await进入WAITING状态的要有Condition的signal方法唤醒；
      - 通过LockSupport类的park方法进入WAITING状态的要有LockSupport类的unpark方法唤醒
      - 通过Thread类的join进入WAITING状态，只有调用join方法的线程对象结束才能让当前线程恢复；

说明：当从WAITING或TIMED_WAITING恢复到Runnable状态时，如果发现当前线程没有得到监视器锁，那么会立刻转入BLOCKED状态。

![](/zzimages/image-20220524203355448.png)

或

![](/zzimages/image-20221002195547666.jpg)

> 我们在翻阅API的时候会发现Timed Waiting（计时等待） 与 Waiting（无限等待） 状态联系还是很紧密的，比如Waiting（无限等待） 状态中wait方法是空参的，而timed waiting（计时等待） 中wait方法是带参的。
> 这种带参的方法，其实是一种倒计时操作，相当于我们生活中的小闹钟，我们设定好时间，到时通知，可是如果提前得到（唤醒）通知，那么设定好时间在通知也就显得多此一举了，那么这种设计方案其实是一举两得。如果没有得到（唤醒）通知，那么线程就处于Timed Waiting状态，直到倒计时完毕自动醒来；如果在倒计时期间得到（唤醒）通知，那么线程从Timed Waiting状态立刻唤醒。

举例：

```java
public class ThreadStateTest {
    public static void main(String[] args) throws InterruptedException {
        SubThread t = new SubThread();
        System.out.println(t.getName() + " 状态 " + t.getState());
        t.start();

        while (Thread.State.TERMINATED != t.getState()) {
            System.out.println(t.getName() + " 状态 " + t.getState());
            Thread.sleep(500);
        }
        System.out.println(t.getName() + " 状态 " + t.getState());
    }
}

class SubThread extends Thread {
    @Override
    public void run() {
        while (true) {
            for (int i = 0; i < 10; i++) {
                System.out.println("打印：" + i);
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            break;
        }
    }
}
```

命令行演示：

![](/zzimages/image-20220524195035355.png)

## 5. 线程安全问题及解决

当我们使用多个线程访问**同一资源**（可以是同一个变量、同一个文件、同一条记录等）的时候，若多个线程`只有读操作`，那么不会发生线程安全问题。但是如果多个线程中对资源有`读和写`的操作，就容易出现线程安全问题。

### 5.1 同步机制解决线程安全问题

要解决多线程并发访问一个资源的安全性问题，Java中提供了同步机制(synchronized)来解决。

同步机制的原理，其实就相当于给某段代码加“锁”，任何线程想要执行这段代码，都要先获得“锁”，我们称它为同步锁。因为Java对象在堆中的数据分为分为对象头、实例变量、空白的填充。而对象头中包含：

- Mark Word：记录了和当前对象有关的GC、锁标记等信息。
- 指向类的指针：每一个对象需要记录它是由哪个类创建出来的。
- 数组长度（只有数组对象才有）

哪个线程获得了“同步锁”对象之后，“同步锁”对象就会记录这个线程的ID，这样其他线程就只能等待了，除非这个线程释放了锁对象，其他线程才能重新获得/占用“同步锁”对象。

### 5.2 方式1：同步代码块


**同步代码块**：synchronized 关键字可以用于某个区块前面，表示只对这个区块的资源实行互斥访问。

格式:

```java
synchronized (同步监视器) {
     需要同步操作的代码
}
```

说明：

- 需要被同步的代码，即为操作共享数据的代码。共享数据：即多个线程都需要操作的数据。
- 需要被同步的代码，在被synchronized包裹以后，就使得一个线程在操作这些代码的过程中，其它线程必须等待。
- 同步监视器，俗称锁。哪个线程获取了锁，哪个线程就能执行需要被同步的代码。
- 同步监视器，可以使用任何一个类的对象充当。但是，多个线程必须**共用同一个同步监视器**。

**注意**：

- 在实现Runnable接口的方式中，同步监视器可以考虑使用：this。
- 在继承Thread类的方式中，同步监视器要慎用this，可以考虑使用：当前类.class。

例1：实现Runnable接口的方式，线程安全问题的解决方法

```java
public class MyTest {
    public static void main(String[] args) {
        Ticket t = new Ticket();
        Thread t1 = new Thread(t);
        Thread t2 = new Thread(t);
        Thread t3 = new Thread(t);
        t1.start();
        t2.start();
        t3.start();

    }
}
class Ticket implements Runnable {
    private int num = 100;
    @Override
    public void run() {
        while (true) {
            synchronized (this) {
                if (num > 0) {
                    System.out.println(Thread.currentThread().getName() +
                            "：取出第" + num + "张票");
                    num--;
                } else 
                    break;
            }
        }
    }
}
```

例2：继承Thread类的方式，线程安全问题的解决方法

```java
public class OtherTest {
    public static void main(String[] args) {
        Ticket t1 = new Ticket();
        Ticket t2 = new Ticket();
        Ticket t3 = new Ticket();
        t1.start();
        t2.start();
        t3.start();
    }
}
class Ticket extends Thread {
    private static int num = 100;
    @Override
    public void run() {
        while (true) {
            synchronized (Ticket.class) { // Class clz = Ticket.class;
                if (num > 0) {
                    System.out.println(Thread.currentThread().getName() +
                            "：取出第" + num + "张票");
                    num--;
                } else
                    break;
            }
        }
    }
}
```

### 5.3 方式2：同步方法


**同步方法**：synchronized 关键字直接修饰方法，表示同一时刻只有一个线程能进入这个方法，其他线程在外面等着。

```java
public synchronized void method(){
    可能会产生线程安全问题的代码
}
```

说明：

- 如果操作共享数据的代码完整的声明在了一个方法中，那么我们就可以将此方法声明为同步方法即可。
- 非静态的同步方法，默认同步监视器是this。静态的同步方法，默认同步监视器是 当前类.class。

例1：实现Runnable接口的方式，线程安全问题的解决方法

```java
public class MyTest {
    public static void main(String[] args) {
        Ticket t = new Ticket();
        Thread t1 = new Thread(t);
        Thread t2 = new Thread(t);
        Thread t3 = new Thread(t);
        t1.start();
        t2.start();
        t3.start();
    }
}
class Ticket implements Runnable {
    private int num = 100;
    private boolean flag = true;
    @Override
    public void run() {
        while (flag)
            show();
    }
    public synchronized void show() {
        if (num > 0) {
            System.out.println(Thread.currentThread().getName() +
                    "：取出第" + num + "张票");
            num--;
        } else
            flag = false;
    }
}
```

例2：继承Thread类的方式，线程安全问题的解决方法

```java
public class OtherTest {
    public static void main(String[] args) {
        Ticket t1 = new Ticket();
        Ticket t2 = new Ticket();
        Ticket t3 = new Ticket();
        t1.start();
        t2.start();
        t3.start();
    }
}
class Ticket extends Thread {
    private static int num = 100;
    private static boolean flag = true;
    @Override
    public void run() {
        while (flag)
            show();
    }
    public static synchronized void show() {
        if (num > 0) {
            System.out.println(Thread.currentThread().getName() +
                    ":取出第" + num + "张票");
            num--;
        } else
            flag = false;
    }
}
```

**总结**：synchronized好处：解决了线程的安全问题。弊端：在操作共享数据时，多线程其实是串行执行的，意味着性能低。




## 6. 再谈同步

### 6.1 单例设计模式的线程安全问题

#### 6.1.1 饿汉式没有线程安全问题

饿汉式：在类初始化时就直接创建单例对象，而类初始化过程是没有线程安全问题的

形式一：

```java
public class HungrySingle {
    private static HungrySingle INSTANCE = new HungrySingle(); 
    
    private HungrySingle(){}
    
    public static HungrySingle getInstance(){
        return INSTANCE;
    }
}
```

形式二：

```java
/*
public class HungryOne{
    public static final HungryOne INSTANCE = new HungryOne();
    private HungryOne(){}
}*/

public enum HungryOne{
    INSTANCE;
}
```

#### 6.1.2 懒汉式线程安全问题

懒汉式：延迟创建对象，第一次调用getInstance方法再创建对象

形式一：

```java
public class LazyOne {
    private static volatile LazyOne instance;

    private LazyOne(){}

    //方式1：
    public static synchronized LazyOne getInstance1(){
        if(instance == null){
            instance = new LazyOne();
        }
        return instance;
    }
    //方式2：
    public static LazyOne getInstance2(){
        synchronized(LazyOne.class) {
            if (instance == null) {
                instance = new LazyOne();
            }
            return instance;
        }
    }
    //方式3：
    public static LazyOne getInstance3(){
        if(instance == null){
            synchronized (LazyOne.class) {
                try {
                    Thread.sleep(10);//加这个代码，暴露问题
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                if(instance == null){
                    instance = new LazyOne();
                }
            }
        }
        return instance;
    }
    /*
    注意：上述方式3中，有指令重排问题
    mem = allocate(); 为单例对象分配内存空间
    instance = mem;   instance引用现在非空，但还未初始化
    ctorSingleton(instance); 为单例对象通过instance调用构造器
    从JDK2开始，分配空间、初始化、调用构造器会在线程的工作存储区一次性完成，然后复制到主存储区。但是需要   
    volatile关键字，避免指令重排。
    */   
}
```

形式二：使用内部类

```java
package com.atguigu.single.lazy;

public class LazySingle {
    private LazySingle(){}
    
    public static LazySingle getInstance(){
        return Inner.INSTANCE;
    }
    
    private static class Inner{
        static final LazySingle INSTANCE = new LazySingle();
    }
}
```

> 内部类只有在外部类被调用才加载，产生INSTANCE实例；又不用加锁。
>
> 此模式具有之前两个模式的优点，同时屏蔽了它们的缺点，是最好的单例模式。
>
> 此时的内部类，使用enum进行定义，也是可以的。

测试类：

```java
public class TestLazy {
    @Test
    public void test01(){
        LazyOne s1 = LazyOne.getInstance();
        LazyOne s2 = LazyOne.getInstance();

        System.out.println(s1);
        System.out.println(s2);
        System.out.println(s1 == s2);
    }

    //把s1和s2声明在外面，是想要在线程的匿名内部类中为s1和s2赋值
    LazyOne s1;
    LazyOne s2;
    @Test
    public void test02(){
        Thread t1 = new Thread(){
            public void run(){
                s1 = LazyOne.getInstance();
            }
        };
        Thread t2 = new Thread(){
            public void run(){
                s2 = LazyOne.getInstance();
            }
        };

        t1.start();
        t2.start();

        try {
            t1.join();
            t2.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println(s1);
        System.out.println(s2);
        System.out.println(s1 == s2);
    }


    LazySingle obj1;
    LazySingle obj2;
    @Test
    public void test03(){
        Thread t1 = new Thread(){
            public void run(){
                obj1 = LazySingle.getInstance();
            }
        };
        Thread t2 = new Thread(){
            public void run(){
                obj2 = LazySingle.getInstance();
            }
        };

        t1.start();
        t2.start();

        try {
            t1.join();
            t2.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println(obj1);
        System.out.println(obj2);
        System.out.println(obj1 == obj2);
    }
}
```

### 6.2 死锁

不同的线程分别占用对方需要的同步资源不放弃，都在等待对方放弃自己需要的同步资源，就形成了线程的死锁。

一旦出现死锁，整个程序既不会发生异常，也不会给出任何提示，只是所有线程处于阻塞状态，无法继续。

**诱发死锁的原因：**

- 互斥条件
- 占用且等待
- 不可抢夺（或不可抢占）
- 循环等待

以上4个条件，同时出现就会触发死锁。

**解决死锁：**

死锁一旦出现，基本很难人为干预，只能尽量规避。可以考虑打破上面的诱发条件。

针对条件1：互斥条件基本上无法被破坏。因为线程需要通过互斥解决安全问题。

针对条件2：可以考虑一次性申请所有所需的资源，这样就不存在等待的问题。

针对条件3：占用部分资源的线程在进一步申请其他资源时，如果申请不到，就主动释放掉已经占用的资源。

针对条件4：可以将资源改为线性顺序。申请资源时，先申请序号较小的，这样避免循环等待问题。

### 6.3 JDK5.0新特性：Lock(锁)

- JDK5.0的新增功能，保证线程的安全。与采用synchronized相比，Lock可提供多种锁方案，更灵活、更强大。Lock通过显式定义同步锁对象来实现同步。同步锁使用Lock对象充当。
- java.util.concurrent.locks.Lock接口是控制多个线程对共享资源进行访问的工具。锁提供了对共享资源的独占访问，每次只能有一个线程对Lock对象加锁，线程开始访问共享资源之前应先获得Lock对象。
- 在实现线程安全的控制中，比较常用的是`ReentrantLock`，可以显式加锁、释放锁。
  - ReentrantLock类实现了 Lock 接口，它拥有与 synchronized 相同的并发性和内存语义，但是添加了类似锁投票、定时锁等候和可中断锁等候的一些特性。此外，它还提供了在激烈争用情况下更佳的性能。
- Lock锁也称同步锁，加锁与释放锁方法，如下：
  * public void lock() :加同步锁。
  * public void unlock() :释放同步锁。

```java
public class OtherTest {
    public static void main(String[] args) {
        Ticket t1 = new Ticket();
        Ticket t2 = new Ticket();
        Ticket t3 = new Ticket();
        t1.start();
        t2.start();
        t3.start();
    }
}
class Ticket extends Thread {
    private static int num = 100;
    // 1. 创建Lock的实例，需要确保多个线程共用同一个Lock实例
    private static final ReentrantLock lock = new ReentrantLock();
    @Override
    public void run() {
        while (true) {
            try {
                // 2. 上锁
                lock.lock();
                if (num > 0) {
                    System.out.println(Thread.currentThread().getName() +
                            ":取出第" + num + "张票");
                    num--;
                } else
                    break;
            } finally {
                // 3. 解锁
                lock.unlock();
            }
        }
    }
}
```

> 注意：如果同步代码有异常，要将unlock()写入finally语句块。

**synchronized与Lock的对比**

1. Lock是显式锁（手动开启和关闭锁，别忘记关闭锁），synchronized是隐式锁，出了作用域、遇到异常等自动解锁
2. Lock只有代码块锁，synchronized有代码块锁和方法锁
3. 使用Lock锁，JVM将花费较少的时间来调度线程，性能更好。并且具有更好的扩展性（提供更多的子类），更体现面向对象。
4. （了解）Lock锁可以对读不加锁，对写加锁，synchronized不可以
5. （了解）Lock锁可以有多种获取锁的方式，可以从sleep的线程中抢到锁，synchronized不可以

> 说明：开发建议中处理线程安全问题优先使用顺序为：
>
> Lock ----> 同步代码块 ----> 同步方法

## 7. 线程的通信

当我们`需要多个线程`来共同完成一件任务，并且我们希望他们`有规律的执行`，那么多线程之间需要一些通信机制，可以协调它们的工作，以此实现多线程共同操作一份数据。

### 7.1 等待唤醒机制

这是多个线程间的一种`协作机制`。谈到线程我们经常想到的是线程间的`竞争（race）`，比如去争夺锁，但这并不是故事的全部，线程间也会有协作机制。

在一个线程满足某个条件时，就进入等待状态`wait()/wait(time)`，等待其他线程执行完他们的指定代码过后再将其唤醒`notify()`; 或可以指定wait的时间，等时间到了自动唤醒；在有多个线程进行等待时，如果需要，可以使用 `notifyAll()` 来唤醒所有的等待线程。`wait/notify` 就是线程间的一种协作机制。

1. wait：线程不再活动，不再参与调度，进入 `wait set` 中，因此不会浪费 CPU 资源，也不会去竞争锁了，这时的线程状态是 WAITING 或 TIMED_WAITING。它还要等着别的线程执行一个`特别的动作`，也即`通知（notify）`或者等待时间到，在这个对象上等待的线程从wait set 中释放出来，重新进入到调度队列（`ready queue`）中。简而言之，线程一旦执行wait方法，就进入等待状态；同时，会释放同步监视器。
2. notify：选取所通知对象的 wait set 中的优先级最高的一个线程唤醒（如果被wait()的多个线程的优先级相同，则随机唤醒一个）。被唤醒的线程从当初wait的位置继续执行。
3. notifyAll：唤醒所通知对象的 wait set 上的全部线程。

> 注意：
>
> 被通知的线程被唤醒后也不一定能立即恢复执行，因为它当初中断的地方是在同步块内，而此刻它已经不持有锁，所以它需要再次尝试去获取锁（很可能面临其它线程的竞争），成功后才能在当初调用 wait 方法之后的地方恢复执行。
>
> 总结如下：
>
> - 如果能获取锁，线程就从 WAITING 状态变成 RUNNABLE（可运行） 状态；
> - 否则，线程就从 WAITING 状态又变成 BLOCKED（等待锁） 状态

**调用wait和notify需注意的细节**：

- 此三个方法的使用，必须是在同步代码块或同步方法中，因为必须要`通过锁对象`调用这2个方法。Lock则需要配合Condition实现线程间的通信。
- 此三个方法的调用者，必须是同步监视器。wait方法与notify方法必须要由`同一个锁对象调用`，因为：对应的锁对象可以通过notify唤醒使用同一个锁对象调用的wait方法后的线程。
- 此三个方法是属于Object类的方法的。因为：锁对象可以是任意对象，而任意对象的所属类都是继承了Object类的。

例题：使用两个线程打印 1-100。线程1, 线程2 交替打印

```java
public class OtherTest {
    public static void main(String[] args) {
        PrintNumber p = new PrintNumber();
        new Thread(p, "线程1").start();
        new Thread(p, "线程2").start();
    }
}
class PrintNumber implements Runnable {
    private int num = 1;
    private final ReentrantLock lock = new ReentrantLock();
    @Override
    public void run() {
        while (true) {
            synchronized (this) {
                notify();
                if (num <= 100) {
                    System.out.println(Thread.currentThread().getName() + "打印了" + num);
                    num++;
                    try {
                        wait(); // 线程一旦执行此方法，就进入等待状态，同时会释放同步监视器
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                } else {
                    break;
                }
            }
        }
    }
}
```

### 7.2 生产者与消费者问题

等待唤醒机制可以解决经典的“生产者与消费者”的问题。生产者与消费者问题（英语：Producer-consumer problem），也称有限缓冲问题（英语：Bounded-buffer problem），是一个多线程同步问题的经典案例。该问题描述了两个（多个）`共享固定大小缓冲区的线程`，即所谓的“生产者”和“消费者”——在实际运行时会发生的问题。

生产者的主要作用是生成一定量的数据放到缓冲区中，然后重复此过程。与此同时，消费者也在缓冲区消耗这些数据。**该问题的关键就是要保证生产者不会在缓冲区满时加入数据，消费者也不会在缓冲区中空时消耗数据。**

**举例：**

生产者(Productor)将产品交给店员(Clerk)，而消费者(Customer)从店员处取走产品，店员一次只能持有固定数量的产品(比如:20)，如果生产者试图生产更多的产品，店员会叫生产者停一下，如果店中有空位放产品了再通知生产者继续生产；如果店中没有产品了，店员会告诉消费者等一下，如果店中有产品了再通知消费者来取走产品。


**生产者与消费者问题中其实隐含了两个问题：**

* 线程安全问题：因为生产者与消费者共享数据缓冲区，产生安全问题。不过这个问题可以使用同步解决。
* 线程的协调工作问题：要解决该问题，就必须让生产者线程在缓冲区满时等待(wait)，暂停进入阻塞状态，等到下次消费者消耗了缓冲区中的数据的时候，通知(notify)正在等待的线程恢复到就绪状态，重新开始往缓冲区添加数据。同样，也可以让消费者线程在缓冲区空时进入等待(wait)，暂停进入阻塞状态，等到生产者往缓冲区添加数据之后，再通知(notify)正在等待的线程恢复到就绪状态。通过这样的通信机制来解决此类问题。

**代码实现：**

```java
enum Mutex {
    MUTEX;
}
class Clerk {
    private int productNum = 0;
    public void addProduct() {
        while (productNum >= 20) {
            try {
                Mutex.MUTEX.wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println("生产者开始生产产品");
        productNum++;
        System.out.println("产品数量为" + productNum);
        Mutex.MUTEX.notify();
    }
    public void delProduct() {
        while (productNum <= 0) {
            try {
                Mutex.MUTEX.wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println("消费者开始消费产品");
        productNum--;
        System.out.println("产品数量为" + productNum);
        Mutex.MUTEX.notify();
    }
}
class Producer extends Thread{
    private Clerk clerk;
    public Producer(Clerk clerk) {
        this.clerk = clerk;
    }
    @Override
    public void run() {
        while (true) {
            synchronized (Mutex.MUTEX) {
                clerk.addProduct();
            }
        }
    }
}
class Consumer extends Thread{
    private Clerk clerk;
    public Consumer(Clerk clerk) {
        this.clerk = clerk;
    }
    @Override
    public void run() {
        while (true) {
            synchronized (Mutex.MUTEX) {
                clerk.delProduct();
            }
        }
    }
}
public class MyTest {
    public static void main(String[] args) {
        Clerk buf = new Clerk();
        Producer producer = new Producer(buf);
        Consumer consumer = new Consumer(buf);
        producer.start();
        consumer.start();
    }
}
```

### 7.3 区分sleep()和wait()

**相同点**：一旦执行，都会使得当前线程结束执行状态，进入阻塞状态。

**不同点**：

1. 定义方法所属的类不同：sleep()在Thread中定义；而wait()在Object中定义
2. 使用范围的不同：sleep()可以在任何需要使用的位置被调用；而wait()必须使用在同步代码块或同步方法中
3. 都在同步结构中使用的时候，是否释放同步监视器的操作不同：sleep()不会释放同步监视器；而wait()会释放同步监视器
4. 结束等待的方式不同：sleep()在指定时间一到就结束阻塞；而wait()可以指定时间也可以无限等待直到被notify唤醒。

### 7.4 是否释放锁的操作

任何线程进入同步代码块、同步方法之前，必须先获得对同步监视器的锁定，那么何时会释放对同步监视器的锁定呢？

#### 7.4.1 释放锁的操作

- 当前线程的同步方法、同步代码块执行结束。
- 当前线程在同步代码块、同步方法中遇到break、return终止了该代码块、该方法的继续执行。
- 当前线程在同步代码块、同步方法中出现了未处理的Error或Exception，导致当前线程异常结束。
- 当前线程在同步代码块、同步方法中执行了锁对象的wait()方法，当前线程被挂起，并释放锁。

#### 7.4.2 不会释放锁的操作

- 线程执行同步代码块或同步方法时，程序调用Thread.sleep()、Thread.yield()方法暂停当前线程的执行。
- 线程执行同步代码块时，其他线程调用了该线程的suspend()方法将该该线程挂起，该线程不会释放锁（同步监视器）。

注意：应尽量避免使用suspend()和resume()这样的过时来控制线程。

## 8. JDK5.0新增线程创建方式

### 8.1 新增方式一：实现Callable接口

JDK5提供了Callable接口和FutureTask类来创建线程，它最大的优点就是有返回值。

创建步骤如下：

1. 先定义一个Callable接口的实现类，重写call方法。泛型即为call方法的返回值类型。
2. 创建Callable实现类的对象
3. 创建FutureTask类的对象，将Callable对象传递给FutureTask
4. 创建Thread对象，将Future对象传递给Thread
5. 调用Thread的start()方法启动线程(启动后会自动执行call方法)。等call()方法执行完之后，会自动将返回值结果封装到FutrueTask对象中。
6. 调用FutrueTask对的get()方法获取返回结果

举例：

```java
public class MyCallable implements Callable<String> {
    @Override
    public String call() throws Exception {
        int sum = 0;
        for (int i = 1; i <= 100; i++)
            sum += i;
        return "线程计算出1到100的和为" + sum;
    }
}

public class MyTest {
    public static void main(String[] args) throws Exception {
        Callable<String> call = new MyCallable();
        FutureTask<String> sft = new FutureTask<>(call);
        new Thread(sft).start();

        String rs = sft.get();
        System.out.println(rs);
    }
}
```

补充：Future接口可以对具体Runnable、Callable任务的执行结果进行取消、查询是否完成、获取结果等。
- FutureTask是Futrue接口的唯一的实现类
- FutureTask 同时实现了Runnable, Future接口。它既可以作为Runnable被线程执行，又可以作为Future得到Callable的返回值
- 缺点：在获取分线程执行结果的时候，当前线程（或是主线程）受阻塞，效率较低。


### 8.2 新增方式二：使用线程池

**现有问题：**

如果并发的线程数量很多，并且每个线程都是执行一个时间很短的任务就结束了，这样频繁创建线程就会大大降低系统的效率，因为频繁创建线程和销毁线程需要时间。

那么有没有一种办法使得线程可以复用，即执行完一个任务，并不被销毁，而是可以继续执行其他的任务？

**思路**：提前创建好多个线程，放入线程池中，使用时直接获取，使用完放回池中。可以避免频繁创建销毁、实现重复利用。类似生活中的公共交通工具。

![](/zzimages/threadpool20230716.jpg)

**好处：**

- 提高响应速度（减少了创建新线程的时间）
- 降低资源消耗（重复利用线程池中线程，不需要每次都创建）
- 便于线程管理
  - corePoolSize：核心池的大小
  - maximumPoolSize：最大线程数
  - keepAliveTime：线程没有任务时最多保持多长时间后会终止

**线程池相关API**

- JDK5.0之前，我们必须手动自定义线程池。从JDK5.0开始，Java内置线程池相关的API。在java.util.concurrent包下提供了线程池相关API：`ExecutorService` 和 `Executors`。
- `ExecutorService`：真正的线程池接口。常见子类ThreadPoolExecutor
  - `void execute(Runnable command)` ：执行任务/命令，没有返回值，一般用来执行Runnable
  - `<T> Future<T> submit(Callable<T> task)`：执行任务，有返回值，一般又来执行Callable
  - `void shutdown()` ：关闭连接池
- `Executors`：一个线程池的工厂类，通过此类的静态工厂方法可以创建多种类型的线程池对象。
  - `Executors.newCachedThreadPool()`：创建一个可根据需要创建新线程的线程池
  - `Executors.newFixedThreadPool(int nThreads)`：创建一个可重用固定线程数的线程池
  - `Executors.newSingleThreadExecutor()` ：创建一个只有一个线程的线程池
  - `Executors.newScheduledThreadPool(int corePoolSize)`：创建一个线程池，它可安排在给定延迟后运行命令或者定期地执行。

**代码举例：**

```java
class NumberThread implements Runnable{

    @Override
    public void run() {
        for(int i = 0;i <= 100;i++){
            if(i % 2 == 0){
                System.out.println(Thread.currentThread().getName() + ": " + i);
            }
        }
    }
}

class NumberThread1 implements Runnable{

    @Override
    public void run() {
        for(int i = 0;i <= 100;i++){
            if(i % 2 != 0){
                System.out.println(Thread.currentThread().getName() + ": " + i);
            }
        }
    }
}

class NumberThread2 implements Callable {
    @Override
    public Object call() throws Exception {
        int evenSum = 0;//记录偶数的和
        for(int i = 0;i <= 100;i++){
            if(i % 2 == 0){
                evenSum += i;
            }
        }
        return evenSum;
    }

}

public class ThreadPoolTest {

    public static void main(String[] args) {
        //1. 提供指定线程数量的线程池
        ExecutorService service = Executors.newFixedThreadPool(10);
        ThreadPoolExecutor service1 = (ThreadPoolExecutor) service;
//        //设置线程池的属性
//        System.out.println(service.getClass());//ThreadPoolExecutor
        service1.setMaximumPoolSize(50); //设置线程池中线程数的上限

        //2.执行指定的线程的操作。需要提供实现Runnable接口或Callable接口实现类的对象
        service.execute(new NumberThread());//适合适用于Runnable
        service.execute(new NumberThread1());//适合适用于Runnable

        try {
            Future future = service.submit(new NumberThread2());//适合使用于Callable
            System.out.println("总和为：" + future.get());
        } catch (Exception e) {
            e.printStackTrace();
        }
        //3.关闭连接池
        service.shutdown();
    }

}
```




# 第11章_常用类和基础API


## 1. 字符串相关类之不可变字符序列：String

### 1.1 String的特性

- `java.lang.String` 类代表字符串。Java程序中所有的字符串文字（例如`"hello"`）都可以看作是实现此类的实例。

- 字符串是常量，用双引号引起来表示。它们的值在创建之后不能更改。

- 字符串String类型本身是final声明的，意味着我们不能继承String。

- String对象的字符内容是存储在一个字符数组value[]中的。`"abc"` 等效于 `char[] data={'h','e','l','l','o'}`。

  ```java
  // jdk8中的String源码：
  // Serializable:可序列化的接口。凡是实现此接口的类的对象就可以通过网络或本地流进行数据的传输。
  // Comparable:凡是实现此接口的类，其对象都可以比较大小。
  public final class String
      implements java.io.Serializable, Comparable<String>, CharSequence {
      /** The value is used for character storage. */
      private final char value[]; //String对象的字符内容是存储在此数组中
   
      /** Cache the hash code for the string */
      private int hash; // Default to 0
      
      ...
  }
  ```

  - private意味着外面无法直接获取字符数组，而且String没有提供value的get和set方法。

  - final意味着字符数组的引用不可改变，而且String也没有提供方法来修改value数组某个元素值

  - 因此字符串的字符数组内容也是不可变的，即String代表着不可变的字符序列。即，一旦对字符串进行修改，就会产生新对象。

  - JDK9之后，底层使用`byte[]`数组。原因是为了节省内存，具体方式是：如果String中只包含`Latin-1`的字符，则每个字符用一个字节存储；如果String中还包含其他字符(即一个字节无法表示的字符)，则每个字符依然用两个字节存储。

    ```java
    public final class String implements java.io.Serializable, Comparable<String>, CharSequence { 
        @Stable
        private final byte[] value;
    }
    
    //官方说明：... that most String objects contain only Latin-1 characters. Such characters require only one byte of storage, hence half of the space in the internal char arrays of such String objects is going unused.
    
    //细节：... The new String class will store characters encoded either as ISO-8859-1/Latin-1 (one byte per character), or as UTF-16 (two bytes per character), based upon the contents of the string. The encoding flag will indicate which encoding is used.
    ```

- Java 语言提供对字符串串联符号（"+"）以及将其他对象转换为字符串的特殊支持（toString()方法）。

### 1.2 String的内存结构

有这么一句话：“Java程序中的所有字符串字面值（如"abc"）都是字符串的实例实现”。这里所说的实例实现，其实指的就是字符串对象。意思就是：**所有Java的字符串字面值，都是字符串对象。**

因为字符串对象设计为不可变，所以字符串有常量池来保存很多常量对象。字符串常量都存储在字符串常量池(StringTable)中，字符串常量池在堆空间。**注意字符串常量池不允许存放两个相同的字符串常量**。

**注意事项1：String对象的内容不可改变，被称为不可变字符串对象**

我们先看一段代码，分析这段代码的结果

![](/zzimages/1662610347618.png)


需要注意的是：只要是以`""`方式写出的字符串对象，会在堆内存中的**字符串常量池**中存储。

执行第一句话时，会在堆内存的常量池中，创建一个字符串对象`“黑马”`，然后把`“黑马”`的地址赋值给`String name`

![](/zzimages/1662610697641.png)

当执行第二句话时，又会在堆内存的常量池中创建一个字符串`“程序员”`，和`“黑马”`拼接，拼接之后还会new一个新的字符串对象`“黑马程序员”`，然后将新产生的`“黑马程序员”`对象的地址赋值给`String name`变量。

![](/zzimages/1662610978351.png)

此时你会发现，之前创建的字符串对象`“黑马”`内容确实是没有改变的，所以说String的对象是不可变的。

结论：每次试图改变字符串对象实际上是新产生了新的字符串对象了，变量每次都是指向了新的字符串对象，之前字符串对象的内容确实是没有改变的，因此说String的对象是不可变的。


**注意事项2：字符串字面量和new出来字符串的区别**
  1. 只要是以`"..."`方式写出的字符串对象，会存储到字符串常量池，且相同内容的字符串只存储一份。如下图一所示
  2. 但通过`new`方式创建字符串对象，每new一次都会产生一个新的对象放在堆内存中。如下图二所示

![](/zzimages/1662618688215.png)

![](/zzimages/1662618651517.png)

**更严格地来描述，内存结构应该如下图所示**

![](/zzimages/20230716200423.png)


**注意事项3：String的`+`连接操作**

- 情况1：`常量 + 常量`。结果仍然存储在字符串常量池中，返回此字面量的地址。注：此时的常量可能是字面量，也可能是**final修饰的常量**。原因：编译器底层直接优化拼接。
- 情况2：`常量 + 变量`或`变量 + 变量`。都会通过new的方式创建一个新的字符串，返回堆空间中此字符串对象的地址
- 情况3：调用字符串的`intern()`。返回的是字符串常量池中字面量的地址。因此，只要两个内容相同的字符串，调用intern()后返回的地址值一定相同。
- 情况4：调用字符串的`concat(xxx)`进行拼接。不管是常量调用此方法，还是变量调用，同样不管参数是常量还是变量，总之，调用完concat()方法都返回一个新new的对象。


**练习1**：

![](/zzimages/20230702131758.png)

**练习2**：

![](/zzimages/20230702132157.png)

**练习3**：

```java
@Test
public void test01(){
	String s1 = "hello";
	String s2 = "world";
	String s3 = "helloworld";
		
	String s4 = s1 + "world";//s4字符串内容也helloworld，s1是变量，"world"常量，变量 + 常量的结果在堆中
	String s5 = s1 + s2;//s5字符串内容也helloworld，s1和s2都是变量，变量 + 变量的结果在堆中
	String s6 = "hello" + "world";//常量+ 常量 结果在常量池中，因为编译期间就可以确定结果
		
	System.out.println(s3 == s4);//false
	System.out.println(s3 == s5);//false
	System.out.println(s3 == s6);//true
}

@Test
public void test02(){
	final String s1 = "hello";
	final String s2 = "world";
	String s3 = "helloworld";
	
	String s4 = s1 + "world";//s4字符串内容也helloworld，s1是常量，"world"常量，常量+常量结果在常量池中
	String s5 = s1 + s2;//s5字符串内容也helloworld，s1和s2都是常量，常量+ 常量 结果在常量池中
	String s6 = "hello" + "world";//常量+ 常量 结果在常量池中，因为编译期间就可以确定结果
		
	System.out.println(s3 == s4);//true
	System.out.println(s3 == s5);//true
	System.out.println(s3 == s6);//true
}

@Test
public void test03(){
	String s1 = "hello";
	String s2 = "world";
	String s3 = "helloworld";
		
	String s4 = (s1 + "world").intern();//把拼接的结果放到常量池中
	String s5 = (s1 + s2).intern();
		
	System.out.println(s3 == s4);//true
	System.out.println(s3 == s5);//true
}

@Test
public void test04() {
    String str = "hello";
    String str2 = "world";
    String str3 ="helloworld";
    
    String str4 = "hello".concat("world");
    String str5 = "hello"+"world";
    
    System.out.println(str3 == str4);//false
    System.out.println(str3 == str5);//true
}
```

### 1.3 String的常用API-1

#### 1.3.1 构造器

* `public String()`：初始化新创建的String对象，以使其表示空字符序列。
* `public String(String original)`：初始化一个新创建的 `String` 对象，使其表示一个与参数相同的字符序列；换句话说，新创建的字符串是该参数字符串的副本。
* `public String(char[] value) ` ：通过当前参数中的字符数组来构造新的String。
* `public String(char[] value, int offset, int count) `：通过字符数组的一部分来构造新的String。
* `public String(byte[] bytes)` ：通过使用平台的**默认字符集**解码当前参数中的字节数组来构造新的String。
* `public String(byte[] bytes, String charsetName)`：通过使用指定的字符集解码当前参数中的字节数组来构造新的String。

举例：

```java
//字面量定义方式：字符串常量对象
String str = "hello";

//构造器定义方式：无参构造
String str1 = new String();

//构造器定义方式：创建"hello"字符串常量的副本
String str2 = new String("hello");

//构造器定义方式：通过字符数组构造
char chars[] = {'a', 'b', 'c','d','e'};     
String str3 = new String(chars);
String str4 = new String(chars,0,3);

//构造器定义方式：通过字节数组构造
byte bytes[] = {97, 98, 99 };     
String str5 = new String(bytes);
String str6 = new String(bytes,"GBK");
```


#### 1.3.2 String与其他结构间的转换

**字符数组 -->  字符串：**

- String 类的构造器：`String(char[])` 和 `String(char[], int offset, int count)` 分别用字符数组中的全部字符和部分字符创建字符串对象。 

**字符串 -->  字符数组：**

- `public char[] toCharArray()`：将字符串中的全部字符存放在一个字符数组中的方法。

- `public void getChars(int srcBegin, int srcEnd, char[] dst, int dstBegin)`：提供了将指定索引范围内的字符串存放到数组中的方法。

**字符串 --> 字节数组：（编码）**

- `public byte[] getBytes()` ：使用平台的默认字符集将此 String 编码为 byte 序列，并将结果存储到一个新的 byte 数组中。
- `public byte[] getBytes(String charsetName)` ：使用指定的字符集将此 String 编码到 byte 序列，并将结果存储到新的 byte 数组。

 **字节数组 --> 字符串：（解码）**

- `String(byte[])`：通过使用平台的默认字符集解码指定的 byte 数组，构造一个新的 String。
- `String(byte[]，int offset，int length)` ：用指定的字节数组的一部分，即从数组起始位置offset开始取length个字节构造一个字符串对象。
- `String(byte[], String charsetName)` 或 `String(byte[], int, int, String charsetName)`：解码，按照指定的编码方式进行解码。

### 1.4 String的常用API-2

`String` 类包括的方法可用于检查序列的单个字符、比较字符串、搜索字符串、提取子字符串、创建字符串副本并将所有字符全部转换为大写或小写。 

#### 1.4.1 系列1：常用方法

（1）**`boolean isEmpty()`：字符串是否为空**
（2）**`int length()`：返回字符串的长度，即字符的个数**
（3）`String concat(String str)`：拼接字符串
（4）**`boolean equals(Object obj)`：比较字符串是否相等，区分大小写**
（5）**`boolean equalsIgnoreCase(Object obj)`：比较字符串是否相等，不区分大小写**
（6）**`int compareTo(String other)`：比较字符串大小，区分大小写，按照Unicode编码值比较大小**
（7）**`int compareToIgnoreCase(String other)`：比较字符串大小，不区分大小写**
（8）**`String toLowerCase()`：将字符串中大写字母转为小写**
（9）**`String toUpperCase()`：将字符串中小写字母转为大写**
（10）**`String trim()`：去掉字符串前后空白符**
（11）`String intern()`：返回该字符串在字符串常量池中的引用

#### 1.4.2 系列2：查找

（11）**`boolean contains(CharSequence s)`：是否包含字符串s**
（12）**`int indexOf(String str)`：从前往后找当前字符串中的str，即如果有则返回第一次出现的下标，要是没有返回-1**
（13）`int indexOf(String str, int fromIndex)`：返回指定子字符串在此字符串中第一次出现处的索引，从指定的索引开始
（14）`int lastIndexOf(String str)`：从后往前找当前字符串中xx，即如果有返回最后一次出现的下标，要是没有返回-1
（15）`int lastIndexOf(String str, int fromIndex)`：返回指定子字符串在此字符串中最后一次出现处的索引，从指定的索引开始反向搜索。

#### 1.4.3 系列3：字符串截取

（16）**`String substring(int beginIndex)`：返回一个新的字符串，它是此字符串的从beginIndex开始截取到最后的一个子字符串。** 
（17）**`String substring(int beginIndex, int endIndex)`：返回一个新字符串，它是此字符串从beginIndex开始截取到endIndex(不包含)的一个子字符串**


#### 1.4.4 系列4：和字符/字符数组相关

（18）**`char charAt(int index)`：返回`[index]`位置的字符**
（19）**`char[] toCharArray()`：将此字符串转换为一个新的字符数组返回**
（20）`static String valueOf(char[] data)`：返回指定数组中表示该字符序列的 String
（21）`static String valueOf(char[] data, int offset, int count)`： 返回指定数组中表示该字符序列的 String
（22）`static String copyValueOf(char[] data)`： 返回指定数组中表示该字符序列的 String
（23）`static String copyValueOf(char[] data, int offset, int count)`：返回指定数组中表示该字符序列的 String

#### 1.4.5 系列5：开头与结尾

（24）**`boolean startsWith(String prefix)`：测试此字符串是否以指定的前缀开始**
（25）`boolean startsWith(String prefix, int toffset)`：测试此字符串从指定索引开始的子字符串是否以指定前缀开始
（26）`boolean endsWith(String suffix)`：测试此字符串是否以指定的后缀结束 

#### 1.4.6 系列6：替换

（27）`String replace(char oldChar, char newChar)`：返回一个新的字符串，它是通过用 newChar 替换此字符串中出现的所有 oldChar 得到的。 不支持正则。
（28）**`String replace(CharSequence target, CharSequence replacement)`：使用指定的字面值替换序列替换此字符串所有匹配字面值目标序列的子字符串**。 
（29）`String replaceAll(String regex, String replacement)`：使用给定的 replacement 替换此字符串所有匹配给定的正则表达式的子字符串。 
（30）`String replaceFirst(String regex, String replacement)`：使用给定的 replacement 替换此字符串匹配给定的正则表达式的第一个子字符串。 
（31）**`String[] split(String regex)`：把字符串按照某个字符串内容分割，并返回分割后的字符串数组**

```java
@Test
public void test1(){
    String str1 = "hello244world.java;887";
    //把其中的非字母去掉
    str1 = str1.replaceAll("[^a-zA-Z]", "");
    System.out.println(str1);

    String str2 = "12hello34world5java7891mysql456";
    //把字符串中的数字替换成,，如果结果中开头和结尾有，的话去掉
    String string = str2.replaceAll("\\d+", ",").replaceAll("^,|,$", "");
    System.out.println(string);

}
```

## 2. 字符串相关类之可变字符序列：StringBuffer、StringBuilder

因为String对象是不可变对象，虽然可以共享常量对象，但是对于频繁字符串的修改和拼接操作，效率极低，空间消耗也比较高。因此，JDK又在java.lang包提供了可变字符序列StringBuffer和StringBuilder类型。

### 2.1 StringBuffer与StringBuilder的理解

StringBuffer与StringBuilder是可变的字符序列，jdk8及之前底层使用`char[]`，jdk9及之后底层使用`byte[]`。两者功能类似，区别在于StringBuffer是线程安全的、效率低，而StringBuilder线程不安全、效率高。

对StringBuffer和StringBuilder的字符串内容进行增删，不会产生新的对象，因此称为`可变的字符序列`。我们假设其底层使用`char[]`存储，进行源码分析(StringBuilder和StringBuffer底层原理相同，我们以其中之一为例)：

对于String而言，如果创建`String s1 = new String("abc")`，则其底层的`char[] value = {'a', 'b', 'c'}`是固定长度为3的，且被final修饰。但对于StringBuilder而言，其底层属性有 **存储的字符序列** `char[] value` (没有final修饰) 和 **实际存储的字符的个数** `int count`，当我们创建 `StringBuilder s2 = new StringBuilder("abc");`时，其底层的`char[]`数组默认长度为`16 + "abc".length()`。

所以如果我们调用append方法添加`"de"`，则等价于`value[3] = 'd', value[4] = 'e';`，因此其增删操作的性能比String高得多。注意如果添加字符串后其长度超过了底层数组的初始长度，则会进行扩容，默认扩容的长度为原长度的2倍再加2，(假如扩容后的长度仍不够，则会直接将长度设置为添加字符串后实际的长度)，扩容完成后，将底层的value数组指向新扩容的数组，然后进行逐一复制字符，因此，本质上从来没有创建新的StringBuilder对象，只不过是其底层数组改变了指向而已，所以StringBuilder是可变的字符序列。

**注意事项**：

- 如果开发中需要频繁的针对于字符串进行增、删、改等操作，建议使用StringBuffer或StringBuilder替换String，因为使用String效率低。
- 如果开发中，不涉及到线程安全问题，建议使用StringBuilder替换StringBuffer，因为使用StringBuilder效率高。
- 对于StringBuilder和StringBuffer，如果开发中大体确定要操作的字符的个数，建议使用带`int capacity`参数的构造器(如`StringBuffer(int capacity)`)，直接指定底层value数组的大小。因为可以避免底层多次扩容操作，性能更高。

### 2.2 StringBuilder、StringBuffer的API

StringBuilder、StringBuffer的API是完全一致的，并且很多方法与String相同。

**1、常用API**

（1）**`StringBuffer append(Object obj)`：提供了很多重载的append()方法，用于进行字符串追加的方式拼接**
（2）**`StringBuffer delete(int start, int end)`：删除`[start,end)`之间字符**
（3）`StringBuffer deleteCharAt(int index)`：删除`[index]`位置字符
（4）**`StringBuffer replace(int start, int end, String str)`：替换`[start,end)`范围的字符序列为str**
（5）`void setCharAt(int index, char c)`：替换`[index]`位置字符
（6）**`char charAt(int index)`：查找指定index位置上的字符**
（7）**`StringBuffer insert(int index, Object obj)`：在`[index]`位置插入obj**
（8）**`int length()`：返回存储的字符数据的长度**
（9）**`StringBuffer reverse()`：反转**
（10）**构造器：`StringBuffer(String str)`，创建一个指定字符串内容的StringBuffer对象**

> 如上(1)(2)(3)(4)(9)这些方法支持`方法链操作`。原理：
>
>    ![](/zzimages/image-20220405223542750.png)

**2、其它API**

（1）**`int indexOf(String str)`：在当前字符序列中查询str的第一次出现下标**
（2）`int indexOf(String str, int fromIndex)`：在当前字符序列从fromIndex开始查询str的第一次出现下标
（3）`int lastIndexOf(String str)`：在当前字符序列中查询str的最后一次出现下标
（4）`int lastIndexOf(String str, int fromIndex)`：在当前字符序列从fromIndex开始查询str的最后一次出现下标
（5）**`String substring(int start)`：截取当前字符序列，从start开始到最后**
（6）**`String substring(int start, int end)`：截取当前字符序列`[start,end)`**
（7）**`String toString()`：返回此序列中数据的字符串表示形式**
（8）**`void setLength(int newLength)`：设置当前字符序列长度为newLength，如果newLength比原有字符串的长度大，则新的位置默认由`'\0'`填充**


**练习(需要根据底层源码分析)**：

```java
String str = null;
StringBuffer sb = new StringBuffer();
sb.append(str);
System.out.println(sb.length());// 4
System.out.println(sb);// null

StringBuffer sb1 = new StringBuffer(str);
System.out.println(sb1);// 空指针异常
```

### 2.3 补充：StringJoiner类

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

## 3. JDK8之前：日期时间API

### 3.1 java.lang.System类的方法

System类提供的`public static long currentTimeMillis()`：用来返回当前时间与1970年1月1日0时0分0秒之间以毫秒为单位的时间差，也称为时间戳。此方法适于计算时间差。

### 3.2 java.util.Date

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

注意还有一个Date类为java.sql.Date，它对应着数据库中的date类型。

### 3.3 java.text.SimpleDateFormat

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

### 3.4 java.util.Calendar(日历)

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

## 4. JDK8：新的日期时间API

### 4.1 JDK8日期、时间、日期时间

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

### 4.2 JDK8日期（时区）

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

### 4.3 JDK8日期（Instant类）

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

### 4.4 JDK8日期（格式化器）

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

### 4.5 JDK8日期（Period类）

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

### 4.6 JDK8日期（Duration类）

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

## 5. Java比较器

我们知道基本数据类型的数据（除boolean类型外）需要比较大小的话，之间使用比较运算符即可，但是引用数据类型是不能直接使用比较运算符来比较大小的。

- 在Java中经常会涉及到对象数组的排序问题，那么就涉及到对象之间的比较问题。

- Java实现对象排序的方式有两种：
  - 自然排序：java.lang.Comparable
  - 定制排序：java.util.Comparator

### 5.1 自然排序：java.lang.Comparable

- Comparable接口强行对实现它的每个类的对象进行整体排序。这种排序被称为类的自然排序。
- 实现 Comparable 的类必须实现 `compareTo(Object obj) `方法，两个对象即通过 compareTo(Object obj) 方法的返回值来比较大小。**默认的规则(升序)：如果当前对象this大于形参对象obj，则返回正整数，如果当前对象this小于形参对象obj，则返回负整数，如果当前对象this等于形参对象obj，则返回零**。

```java
public interface Comparable{
    int compareTo(Object obj);
}
```

- 实现Comparable接口的对象列表（和数组）可以通过 Collections.sort 或 Arrays.sort进行自动排序。实现此接口的对象可以用作有序映射中的键或有序集合中的元素，无需指定比较器。
- 对于类 C 的每一个 e1 和 e2 来说，当且仅当 e1.compareTo(e2) == 0 与 e1.equals(e2) 具有相同的 boolean 值时，类 C 的自然排序才叫做与 equals 一致。建议（虽然不是必需的）`最好使自然排序与 equals 一致`。

- Comparable 的典型实现：(`默认都是从小到大排列的`)
  - String：按照字符串中字符的Unicode值进行比较
  - Character：按照字符的Unicode值来进行比较
  - 数值类型对应的包装类以及BigInteger、BigDecimal：按照它们对应的数值大小进行比较
  - Boolean：true 对应的包装类实例大于 false 对应的包装类实例
  - Date、Time等：后面的日期时间比前面的日期时间大

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

### 5.2 定制排序：java.util.Comparator

- 思考
  - 当元素的类型没有实现java.lang.Comparable接口而又不方便修改代码（例如：一些第三方的类，你只有.class文件，没有源文件）
  - 如果一个类，实现了Comparable接口，也指定了两个对象的比较大小的规则，但是此时此刻我不想按照它预定义的方法比较大小，但是我又不能随意修改，因为会影响其他地方的使用，怎么办？
- JDK在设计类库之初，也考虑到这种情况，所以又增加了一个java.util.Comparator接口。强行对多个对象进行整体排序的比较。
  - 重写compare(Object o1,Object o2)方法，比较o1和o2的大小：(升序规则)如果方法返回正整数，则表示o1大于o2；如果返回0，表示相等；返回负整数，表示o1小于o2。
  - 可以将 Comparator 传递给 sort 方法（如 Collections.sort 或 Arrays.sort），从而允许在排序顺序上实现精确控制。

```java
public interface Comparator{
    int compare(Object o1,Object o2);
}
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

## 6. 系统相关类

### 6.1 java.lang.System类

- System类代表系统，系统级的很多属性和控制方法都放置在该类的内部。该类位于`java.lang包`。

- 由于该类的构造器是private的，所以无法创建该类的对象。其内部的成员变量和成员方法都是`static的`，所以也可以很方便的进行调用，是一个工具类。

- **成员变量**：System类内部包含`in`、`out`和`err`三个成员变量，分别代表标准输入流(键盘输入)，标准输出流(显示器)和标准错误输出流(显示器)。

- **成员方法**

  - `native long currentTimeMillis()`：
    该方法的作用是返回当前的计算机时间，时间的表达格式为当前计算机时间和GMT时间(格林威治时间)1970年1月1号0时0分0秒所差的毫秒数。

  - `void exit(int status)`：
    该方法的作用是退出程序，终止当前运行的Java虚拟机。其中status的值为0代表正常退出，非零代表异常退出。使用该方法可以在图形界面编程中实现程序的退出功能等。

  - `void gc()`：
    该方法的作用是请求系统进行垃圾回收。至于系统是否立刻回收，则取决于系统中垃圾回收算法的实现以及系统执行时的情况。

  - `String getProperty(String key)`：
    该方法的作用是获得系统中属性名为key的属性对应的值。系统中常见的属性名以及属性的作用如下表所示：

    ![](/zzimages/image-20220406003340258.png)

  - `void arraycopy(Object src, int srcPos, Object dest, int destPos, int length)`： 
    从指定源数组中复制一个数组，复制从指定的位置开始，到目标数组的指定位置结束。常用于数组的插入和删除


### 6.2 java.lang.Runtime类

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

## 7. 和数学相关的类

### 7.1 java.lang.Math

Math代表数学，是一个工具类，里面提供的都是对数据进行操作的一些静态方法。

![](/zzimages/20230705112019.png)

其他：

* public static double sqrt(double a)：返回a的平方根
* public static final double PI：返回圆周率
* acos,asin,atan,cos,sin,tan 三角函数

注意：
```java
Math.round(12.5); // 13
Math.round(-12.5); // -12
```

### 7.2 java.math包

#### 7.2.1 BigInteger

- Integer类作为int的包装类，能存储的最大整型值为`2^31-1`，Long类也是有限的，最大为`2^63-1`。如果要表示再大的整数，不管是基本数据类型还是他们的包装类都无能为力，更不用说进行运算了。

- java.math包的BigInteger可以表示`不可变的任意精度的整数`。BigInteger 提供所有 Java 的基本整数操作符的对应物，并提供 java.lang.Math 的所有相关方法。另外，BigInteger 还提供以下运算：模算术、GCD 计算、质数测试、素数生成、位操作以及一些其他操作。 

- 构造器
  - BigInteger(String val)：根据字符串构建BigInteger对象

- 方法
  - public BigInteger `abs`()：返回此 BigInteger 的绝对值的 BigInteger。
  - BigInteger `add`(BigInteger val) ：返回其值为 (this + val) 的 BigInteger
  - BigInteger `subtract`(BigInteger val) ：返回其值为 (this - val) 的 BigInteger
  - BigInteger `multiply`(BigInteger val) ：返回其值为 (this * val) 的 BigInteger
  - BigInteger `divide`(BigInteger val) ：返回其值为 (this / val) 的 BigInteger。整数相除只保留整数部分。
  - BigInteger `remainder`(BigInteger val) ：返回其值为 (this % val) 的 BigInteger。
  - BigInteger[] `divideAndRemainder`(BigInteger val)：返回包含 (this / val) 后跟 (this % val) 的两个 BigInteger 的数组。
  - BigInteger `pow`(int exponent) ：返回其值为 (this^exponent) 的 BigInteger。 

```java
@Test
public void test01(){
    //long bigNum = 123456789123456789123456789L;

    BigInteger b1 = new BigInteger("12345678912345678912345678");
    BigInteger b2 = new BigInteger("78923456789123456789123456789");

    //System.out.println("和：" + (b1+b2));//错误的，无法直接使用+进行求和

    System.out.println("和：" + b1.add(b2));
    System.out.println("减：" + b1.subtract(b2));
    System.out.println("乘：" + b1.multiply(b2));
    System.out.println("除：" + b2.divide(b1));
    System.out.println("余：" + b2.remainder(b1));
}
```

#### 7.2.2 BigDecimal

- 一般的Float类和Double类可以用来做科学计算或工程计算，但在**商业计算中，要求数字精度比较高，故用到java.math.BigDecimal类。**

- BigDecimal类支持不可变的、任意精度的有符号十进制定点数。


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

### 7.3 java.util.Random

用于产生随机数

* `boolean nextBoolean()`:返回下一个伪随机数，它是取自此随机数生成器序列的均匀分布的 boolean 值。 

* `void nextBytes(byte[] bytes)`:生成随机字节并将其置于用户提供的 byte 数组中。 

* `double nextDouble()`:返回下一个伪随机数，它是取自此随机数生成器序列的、在 0.0 和 1.0 之间均匀分布的 double 值。 

* `float nextFloat()`:返回下一个伪随机数，它是取自此随机数生成器序列的、在 0.0 和 1.0 之间均匀分布的 float 值。 

* `double nextGaussian()`:返回下一个伪随机数，它是取自此随机数生成器序列的、呈高斯（“正态”）分布的 double 值，其平均值是 0.0，标准差是 1.0。 

* `int nextInt()`:返回下一个伪随机数，它是此随机数生成器的序列中均匀分布的 int 值。 

* `int nextInt(int n)`:返回一个伪随机数，它是取自此随机数生成器序列的、在 0（包括）和指定值（不包括）之间均匀分布的 int 值。 

* `long nextLong()`:返回下一个伪随机数，它是取自此随机数生成器序列的均匀分布的 long 值。 

```java
@Test
public void test04(){
    Random r = new Random();
    System.out.println("随机整数：" + r.nextInt());
    System.out.println("随机小数：" + r.nextDouble());
    System.out.println("随机布尔值：" + r.nextBoolean());
}
```

### 7.4 Objects工具类

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

## 8. 正则表达式

**正则表达式其实是由一些特殊的符号组成的，它代表的是某种规则。**

> 正则表达式的作用1：用来校验字符串数据是否合法
>
> 正则表达式的作用2：可以从一段文本中查找满足要求的内容


### 8.1 正则表达式书写规则

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

### 8.2 正则表达式应用案例

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

### 8.3 正则表达式信息爬取

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

### 8.4 正则表达式搜索、替换

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


# 第12章_集合框架

## 1. Java集合框架概述

Java 集合可分为 Collection 和 Map 两大体系：

**Collection接口**：也称为`单列数据集合`。
- List子接口：元素有序、可重复、有索引（类似动态数组）。有以下实现类：
  - ArrayList
  - LinkedList
  - Vector
- Set子接口：元素无序、不重复、无索引。有以下实现类：
  - HashSet
  - LinkedHashSet(继承HashSet)：其底层可以记录元素添加时的先后顺序，但底层的元素位置仍是无序的
  - TreeSet：其元素是默认升序排序的

**Map接口**：存储具有映射关系"key-value"对的集合，也称`双列数据集合`。其特征由key决定：元素无序、不重复、无索引。有以下实现类：
  - HashMap
  - LinkedHashMap(继承HashMap)
  - TreeMap
  - Hashtable
  - Properties(继承Hashtable)

## 2. Collection接口及方法

Collection 接口是List和Set接口的父接口，该接口里定义的方法既可用于操作Set集合，也可用于操作List集合。

**要求：向集合中添加元素时，元素所属的类需要重写一定的方法(equals、hashCode、比较器)，因为Collection中contains()、remove()等方法需要根据以下规则判断两个元素是否相等**：

- **对于List集合：equals()返回true则认为两个元素相等**
- **对于HashSet和LinkedHashSet：hashCode()相等，且equals()返回true则认为两个元素相等**
- **对于TreeSet：比较器返回0则认为两个元素相等**


### 2.1 添加

（1）**`boolean add(E e)`：添加元素**
（2）**`boolean addAll(Collection<? extends E> e)`：将集合e中的所有元素拷贝添加到当前集合中**

### 2.2 判断

（3）**`int size()`：返回集合中的元素个数**
（4）**`boolean isEmpty()`：判断当前集合是否为空**
（5）**`boolean contains(Object obj)`：判断当前集合中是否含有与obj相等的元素**
（6）`boolean containsAll(Collection<?> e)`：判断集合e中的元素是否在当前集合中都存在
（7）`boolean equals(Object o)`：判断当前集合与obj是否相等

### 2.3 删除

（8）**`void clear()`：清空集合**
（9）**`boolean remove(Object obj)`：从当前集合中删除第一个与obj相等的元素**
（10）`boolean removeAll(Collection<?> coll)`：从当前集合中删除所有与coll集合中相同的元素。
（11）`boolean retainAll(Collection<?> coll)`：从当前集合中删除两个集合中不同的元素，使得当前集合仅保留与coll集合中的元素相同的元素，即当前集合中仅保留两个集合的交集

### 2.4 其它

（12）**`Object[] toArray()`：返回包含当前集合中所有元素的Object数组**
（13）**`<T> T[] toArray(T[] a)`：返回包含当前集合中所有元素的数组，数组中的元素都是T类型。常见用法：`String[] arr = c.toArray(new String[c.size()]);`**
（14）`int hashCode()`：获取集合对象的哈希值
（15）**`Iterator<E> iterator()`：返回集合的迭代器对象**

**补充：将数组转化成集合，可以调用工具类Arrays中的asList方法**

```java
String[] arr = {"AA", "BB", "CC"};
List<String> list = Arrays.asList(arr);
```

底层源码：
```java
public static <T> List<T> asList(T... a) {
    return new ArrayList<>(a);
}
```

**注意**：`Arrays.asList(…)` 方法返回的 List 集合，既不是 ArrayList 实例，也不是 Vector 实例。`Arrays.asList(…)` 返回值是一个固定长度的List集合。

练习：

```java
@Test
public void test1() {
    Integer[] arr = {1, 2, 3};
    List<Integer> list = Arrays.asList(arr);
    System.out.println(list.size()); // 3
    System.out.println(list); // [1, 2, 3]

    int[] arr1 = {1, 2, 3};
    List<int[]> list1 = Arrays.asList(arr1);
    System.out.println(list1.size()); // 1
    System.out.println(list1); // [[I@77f03bb1]
}
```

## 3. Iterator(迭代器)接口

### 3.1 Iterator接口

`Iterator`，被称为迭代器接口，主要用于遍历集合中的元素(数组没有迭代器)。

Collection接口继承了java.lang.Iterable接口，该接口有一个iterator()方法，那么所有实现了Collection接口的集合类都有一个iterator()方法，用以返回一个实现了Iterator接口的迭代器对象。

**Collection集合获取迭代器对象的格式**：
```java
Collection<Student> c = new ArrayList<>();
Iterator<Student> iterator = c.iterator();
```

**注意：集合对象每次调用iterator()方法都得到一个全新的迭代器对象，默认游标都在集合的第一个元素之前**。

**Iterator接口的常用方法**：

- `public E next()`: 先将迭代器后移，然后返回此时迭代器指向的元素。
- `public boolean hasNext()`: 判断迭代器指向的位置的下一个位置的元素是否存在

**注意**：在调用it.next()方法之前必须要调用it.hasNext()进行检测。若不调用，且下一条记录无效，直接调用it.next()会抛出`NoSuchElementException异常`。

### 3.2 迭代器的执行原理

Iterator迭代器对象在遍历集合时，内部采用指针的方式来跟踪集合中的元素，接下来通过一个图例来演示Iterator对象迭代元素的过程：

![](/zzimages/image-20220407235130988.png)

**使用Iterator迭代器删除元素**

java.util.Iterator迭代器中有一个方法：`void remove();` 其作用是从集合中删除此迭代器返回的最后一个元素。在用迭代器遍历集合时，可以调用该方法删除指定条件下的元素。

```java
Iterator iter = coll.iterator();
while (iter.hasNext()) {
    Object obj = iter.next();
    if(obj.equals("Tom")){
        iter.remove();
    }
}
```

**注意**：
- Iterator可以删除集合的元素，但是遍历过程中只能通过迭代器对象的remove方法进行删除，不能用集合的方法修改基础集合，否则迭代器的行为将会是未定义的。
- 如果还未调用next()或在上一次调用next()方法之后已经调用了remove()方法，再调用remove()都会报IllegalStateException。

在JDK8.0时，Collection接口新增了removeIf方法，即可以根据条件删除。（第18章中再讲）

```java
public class TestCollectionRemoveIf {
    @Test
    public void test01(){
        Collection coll = new ArrayList();
        coll.add("小李广");
        coll.add("扫地僧");
        coll.add("石破天");
        coll.add("佛地魔");
        System.out.println("coll = " + coll);

        coll.removeIf(new Predicate() {
            @Override
            public boolean test(Object o) {
                String str = (String) o;
                return str.contains("地");
            }
        });
        System.out.println("删除包含\"地\"字的元素之后coll = " + coll);
    }
}
```

### 3.3 Collection的遍历方式

#### 3.3.1 方式1：迭代器遍历

```java
Collection<String> c = new ArrayList<>();
c.add("赵敏");
c.add("小昭");
c.add("素素");
c.add("灭绝");
//第一步：先获取迭代器对象
Iterator<String> it = c.iterator();
//第二步：迭代器遍历
while(it.hasNext()){
    String e = it.next();
    System.out.println(s);
}
```

#### 3.3.2 方式2：增强for循环

增强for循环（也称foreach循环）是 JDK5.0 中定义的一个高级for循环，可以用来遍历**数组和集合**。

**增强for循环的语法格式**：

```java
for (String s : c){
    System.out.println(s); 
}
```

**注意事项**：

- 增强for循环的执行过程中，是将集合或数组中的元素依次赋值给临时变量的。所以循环体中对临时变量的修改，往往不会导致原有集合或数组中元素的修改。
- 对于集合的遍历，增强for的底层其实是调用了Iterator迭代器。对于数组的遍历则不是，因为数组没有迭代器。

**练习**：

```java
public class ForTest {
    public static void main(String[] args) {
        String[] str = new String[5];
        for (String myStr : str) {
            myStr = "atguigu";
            System.out.println(myStr); // atguigu
        }
        for (int i = 0; i < str.length; i++) {
            System.out.println(str[i]); // null
        }
    }
}
```

#### 3.3.3 方式3：Lambda表达式遍历

我们需要使用Collection接口的默认方法 forEach() 结合lambda表达式来遍历集合。forEach方法的参数是一个Consumer接口，而Consumer是一个函数式接口，所以可以传递Lambda表达式。

```java
default void forEach(Consumer<? super T> action);
```

例：
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

## 4. Collection子接口1：List

List集合的特点是：元素有序、可重复、有索引

### 4.1 List接口方法

List除了从Collection集合继承的方法外，还添加了一些`根据索引`来操作集合元素的方法。

**插入元素**
（1）**`void add(int index, E ele)`: 在index位置插入ele元素**
（2）`boolean addAll(int index, Collection<? extends E> c)`: 从index位置开始将c中的所有元素添加进来

**获取元素**
（3）**`E get(int index)`: 获取指定index位置的元素**
（4）`List<E> subList(int fromIndex, int toIndex)`: 返回从fromIndex到toIndex位置的子集合

**获取元素索引**
（5）**`int indexOf(Object o)`: 返回o在集合中首次出现的位置**
（6）`int lastIndexOf(Object o)`: 返回o在集合中末次出现的位置

**删除和替换元素**
（7）**`E remove(int index)`: 删除指定index位置的元素，返回被删除的元素**
（8）**`E set(int index, E element)`: 修改指定index位置的元素为element，返回被修改的元素**

注意：List的遍历方式除了Collection的三种遍历方式以外，还可以通过普通的for循环利用索引来遍历。

### 4.2 List接口主要实现类：ArrayList

ArrayList是List接口的`主要实现类`。ArrayList是线程不安全的、效率高。ArrayList底层是基于数组实现的。

**ArrayList的构造器**：

```java
ArrayList() // 空参构造器
ArrayList(int initialCapacity) // 直接指定底层数组的容量
ArrayList(Collection<? extends E> c) // 用另一个集合中的元素来初始化
```

### 4.3 List的实现类之二：LinkedList

LinkedList集合线程不安全，底层是基于双向链表实现的。特点：查询慢，增删相对较快，对首尾元素进行增删改查的速度是极快的。LinkedList新增了一些可以针对头尾进行操作的方法：

（1）`void addFirst(E e)`：在该列表开头插入指定的元素
（2）`void addLast(E e)`：将指定的元素追加到此列表的末尾
（3）`E getFirst()`：返回此列表中的第一个元素
（4）`E getLast()`：返回此列表中的最后一个元素
（5）`E removeFirst()`：从此列表中删除并返回第一个元素
（6）`E removeLast()`：从此列表中删除并返回最后一个元素
（7）`void push(E e)`：等价于addFirst(e)，一般作为栈使用时的API
（8）`E peek()`：等价于getFirst()，一般作为栈使用时的API
（9）`E pop()`：等价于removeFirst()，一般作为栈使用时的API

**LinkedList的构造器**：
```java
LinkedList()
LinkedList(Collection<? extends E> c)
```

**补充：LinkedList集合可以用来设计队列和栈**

- 队列：入队列可以调用LinkedList集合的 `addLast()` 方法，出队列可以调用 `removeFirst()` 方法
- 栈：压栈(push)可以用 `addFirst()`，出栈(pop)可以用 `removeFirst()`。也可以调用LinkedList拥有的栈的专有API，`push, pop, peek`

除此之外，核心类库中也有Stack，它是Vector的子类，同样提供`push, pop, peek`方法。区别在于，Stack是顺序栈，而LinkedList是链式栈。

### 4.4 List的实现类之三：Vector

Vector 是一个古老的集合，已经过时，其效率太低。底层实现基本与ArrayList相同，区别之处在于Vector是`线程安全`的，所以效率很低，而且还有很多冗余的方法。

## 5. Collection子接口2：Set

### 5.1 Set接口概述

Set接口是Collection的子接口，Set接口相较于Collection接口没有提供额外的方法。Set集合的特点是：元素无序、不重复、无索引。**注意Set集合不允许包含相同的元素，如果试图把一个相同的元素加入同一个 Set 集合中，则添加操作失败，只会保留之前的元素**。

### 5.2 Set主要实现类：HashSet

#### 5.2.1 HashSet概述

HashSet是Set接口的主要实现类，它是线程不安全的。

**HashSet和LinkedHashSet集合判断两个元素相等的标准：两个对象通过 `hashCode()` 方法得到的哈希值相等，并且两个对象的 `equals() `方法返回值为true**。

因此，对于存放在HashSet和LinkedHashSet容器中的对象，**对应的类一定要重写hashCode()和equals()方法**，并且要保证两个方法的一致性，即equals返回true的两个对象hashCode必须相同。

**补充**：为了保证equals和hashCode的一致性，对象中用作equals()方法比较的Field，都应该用来计算hashCode值。开发中直接调用IDEA里的快捷键自动重写equals()和hashCode()方法即可，我们用快捷键重写的hashCode()方法，里面有31这个数字，其原因是：

```
首先，选择系数的时候要选择尽量大的系数。因为如果计算出来的hash地址越大，所谓的“冲突”就越少，查找起来效率也会提高。（减少冲突）

其次，31只占用5bits,相乘造成数据溢出的概率较小。

再次，31可以 由i*31== (i<<5)-1来表示,现在很多虚拟机里面都有做相关优化。（提高算法效率）

最后，31是一个素数，素数作用就是如果我用一个数字来乘以这个素数，那么最终出来的结果只能被素数本身和被乘数还有1来整除！(减少冲突)
```

**HashSet的构造器**：

```java
HashSet()
HashSet(Collection<? extends E> c)
HashSet(int initialCapacity) // 一般不使用，原因见第14章
HashSet(int initialCapacity, float loadFactor) // 一般不使用，原因见第14章
```

#### 5.2.2 HashSet集合底层原理

**哈希值**：就是一个int类型的数值，Java中每个对象都有一个哈希值；Java中的所有对象，都可以调用Obejct类提供的hashCode方法，返回该对象自己的哈希值。

```java
public int hashCode() //返回对象的哈希值
```

- 同一个对象多次调用hashCode()方法返回的哈希值是相同的。
- 不同的对象，它们的哈希值一般不相同，但也有可能会相同(哈希碰撞)。

**HashSet集合底层原理**

HashSet集合底层其实就是由HashMap实现的，而HashMap是基于哈希表实现的，哈希表是一种增删改查数据，性能都较好的数据结构。哈希表根据JDK版本的不同，也是有区别的

- JDK7：哈希表 = 数组 + 单向链表
- JDK8：哈希表 = 数组 + 单向链表 + 红黑树


### 5.3 Set实现类之二：LinkedHashSet

LinkedHashSet是HashSet的子类，也是线程不安全的，底层是由LinkedHashMap实现的，而LinkedHashMap依然是基于哈希表(数组、单向链表、红黑树)实现的，但同时还使用`双向链表`维护元素添加时的先后顺序。LinkedHashSet `插入性能略低`于 HashSet，但在按照添加元素时的顺序遍历访问全部元素时有很好的性能。

**LinkedHashSet的构造器**：与HashSet类似

**练习**：

```java
public class MyTest {
    public static void main(String[] args) {
        HashSet set = new HashSet();
        Person p1 = new Person(1001,"AA");
        Person p2 = new Person(1002,"BB");

        set.add(p1);
        set.add(p2);
        p1.name = "CC";
        set.remove(p1);
        System.out.println(set); // 2个元素
        set.add(new Person(1001,"CC"));
        System.out.println(set); // 3个元素

        set.add(new Person(1001,"AA"));
        System.out.println(set); // 4个元素
    }
}
class Person {
    public int id;
    public String name;
    public Person() {
    }
    public Person(int id, String name) {
        this.id = id;
        this.name = name;
    }
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Person person = (Person) o;
        return id == person.id && Objects.equals(name, person.name);
    }
    @Override
    public int hashCode() {
        return Objects.hash(id, name);
    }
    @Override
    public String toString() {
        return "Person{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}
```

**解释：将p1加入HashSet时，用的hashCode是"AA"生成的，记为h1，哈希表中将该元素和h1封装成Entry对象e1后存入。改成"CC"后p1对象的hashCode发生了变化，记为h2，所以remove的时候拿着h2自然无法将e1删除，因为其内部hash属性值是h1。同理，再添加哈希值为h2的元素时也不会产生冲突。最后添加哈希值为h1的元素，与e1产生了Hash冲突，此时调用equals方法发现两者不同，哈希表中的是"CC"，新添加的是"AA"，于是添加成功**。



### 5.4 Set实现类之三：TreeSet

TreeSet集合线程不安全，其元素默认是升序排序的。其底层是由TreeMap实现的，而TreeMap底层是由红黑树实现的。

**注意**：
- 对于TreeSet集合而言，它判断`两个对象是否相等的唯一标准`是：两个对象通过 `compareTo(Object obj) 或compare(Object o1,Object o2)`方法比较返回值，返回值为0，则认为两个对象相等。因此，hashCode()和equals()方法可以无需重写。
- 添加到TreeSet中的元素必须是同一个类型的对象，否则会报ClassCastException

**TreeSet必须至少实现两种排序方法之一**：`自然排序`和`定制排序`。对于定制排序，可以通过调用TreeSet集合的有参构造器来设置Comparator对象。

**TreeSet的构造器**：

```java
TreeSet()
TreeSet(Comparator<? super E> comparator)
TreeSet(Collection<? extends E> c)
```

## 6. Map接口

### 6.1 Map接口概述

Map集合称为双列集合，打印格式为：`{key1=value1, key2=value2, key3=value3 , ...}`，一次需要存一对数据做为一个元素。Map集合的每个元素``key=value``是一个Entry对象，Map集合也被叫做"键值对集合"。

Map集合的所有键是不允许重复的，但值可以重复，键和值是一一对应的，每一个键只能找到自己对应的值。Map系列集合的特点都是由键决定的：无序、不重复、无索引。**注意如果试图把一个相同的key加入同一个Map集合中，则会直接用新的value替换之前元素的value**。

**因此，对于value所属的类，需要重写equals()方法。而对于key所属的类，对HashMap来说需要重写hashCode()和equals()方法，对TreeMap来说，只需要给出比较器**。

### 6.2 Map接口的常用方法

**添加、修改操作：**
（1）**`V put(K key, V value)`：将指定key-value添加到当前map对象中，添加成功则返回null。如果key已经存在，则直接替换对应的value值，然后返回原来的value**。
（2）`void putAll(Map<? extends K, ? extends V> m)`: 将m中的所有key-value对存放到当前map中

**删除操作：**
（3）**`V remove(Object key)`：移除指定key的key-value对，并返回value**
（4）**`void clear()`：清空集合**

**元素查询的操作：**
（5）**`V get(Object key)`：获取指定key对应的value**
（6）**`boolean containsKey(Object key)`：是否包含指定的key**
（7）**`boolean containsValue(Object value)`：是否包含指定的value**
（8）**`int size()`：返回map中key-value对的个数**
（9）**`boolean isEmpty()`：判断当前map是否为空**
（10）`boolean equals(Object obj)`：判断当前map和参数对象obj是否相等

**元视图操作的方法：**
（11）**`Set<K> keySet()`：返回所有key构成的Set集合**
（12）**`Collection<V> values()`：返回所有value构成的Collection集合**
（13）**`Set<Map.Entry<K, V>> entrySet()`：返回所有key-value对构成的Set集合**

### 6.3 Map的遍历方式

注意Map没有iterator()方法，无法直接获取迭代器。

#### 6.3.1 方式1：获取keySet集合后遍历

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
            // 2、根据键获取对应的值
            double val = map.get(key);
            System.out.println(key + "->" + val);
        }
    }
}
```

#### 6.3.2 方式2：获取entrySet集合后遍历

**Map集合的第二种方式，是直接获取每一个Entry对象，把Entry存储到Set集合中去，再通过Entry对象获取键和值。`Map.Entry<K, V>`提供获取键和值的方法**：

```java
K getKey(); //获取键
V getValue(); //获取值
```

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

#### 6.3.3 方式3：Lambda表达式遍历

我们需要使用Map接口的默认方法 forEach() 结合lambda表达式来遍历。forEach方法的参数是一个BiConsumer接口，而BiConsumer是一个函数式接口，所以可以传递Lambda表达式。

```java
default void forEach(BiConsumer<? super K, ? super V> action)
```

```java
public class MyTest {
    public static void main(String[] args) {
        Map<String, Double> map = new HashMap<>();
        map.put("张三", 178.5);
        map.put("李四", 180.0);
        map.put("王五", 168.3);
        //调用forEach方法
        //由于参数是一个BiConsumer接口，所以可以传递匿名内部类
        map.forEach(new BiConsumer<String, Double>() {
            @Override
            public void accept(String k, Double v) {
                System.out.println(k + "->" + v);
            }
        });

        //也可以使用lambda表达式对匿名内部类进行简化
        map.forEach((k, v) -> System.out.println(k + "->" + v));
    }
}
```

### 6.4 Map的主要实现类：HashMap

HashMap是Map接口的主要实现类，它是线程不安全的。允许添加null键和null值。HashMap底层是基于哈希表实现的，只不过HashMap计算hashCode时只依赖Entry对象的键，而不依赖Entry对象的值。

**HashMap的构造器**：
```java
HashMap()
HashMap(Map<? extends K, ? extends V> m)
HashMap(int initialCapacity) // 一般不使用
HashMap(int initialCapacity, float loadFactor) // 一般不使用
```

### 6.5 Map实现类之二：LinkedHashMap

LinkedHashMap是HashMap的子类，也是线程不安全的，其底层数据结构依然是基于哈希表实现的，只是每个键值对元素又额外的多了一个双向链表来记录添加元素的先后顺序。

**LinkedHashMap的构造器**：与HashMap类似

### 6.6 Map实现类之三：TreeMap

TreeMap集合线程不安全，底层是基于红黑树实现的排序(按照键的大小默认升序排序，只能对键排序)。

**注意**：
- 对于TreeMap集合而言，它判断`两个key是否相等的唯一标准`是：两个key通过 `compareTo(Object obj) 或compare(Object o1,Object o2)`方法比较返回值，返回值为0，则认为相等。
- 添加到TreeMap中的key必须是同一个类型的对象，否则会报ClassCastException异常

**TreeMap的键必须至少实现两种排序方法之一**：`自然排序`和`定制排序`。对于定制排序，可以通过调用TreeMap集合的有参构造器来设置Comparator对象。

**TreeMap的构造器**：

```java
TreeMap()
TreeMap(Comparator<? super K> comparator)
TreeMap(Map<? extends K, ? extends V> m)
```

### 6.7 Map实现类之四：Hashtable

Hashtable是Map接口的古老实现类，线程安全、效率低。实现原理与HashMap类似，底层使用古老的哈希表，即数组+单向链表。注意Hashtable不可以添加null的key或value值。

### 6.8 Map实现类之五：Properties

Properties类是Hashtable的子类，它是用来代表属性文件的，通过Properties可以读写属性文件里的内容。Properties中要求key和value都是字符串类型。存取数据时，建议使用该集合提供的特有API。

**属性文件**

后缀为.properties的文件，称之为属性文件，它可以很方便的存储一些类似于键值对的数据，经常当做软件的配置文件使用。

- 属性文件里面的每一行都是一个键值对，键和值中间用=隔开，每一行末尾不要加空格、分号等字符。比如: `admin=123456` 
- `#`表示这行是注释信息
- 键不能重复，值可以重复

**使用Properties读取属性文件中的键值对**

（1）`public void load(InputStream is)`：通过字节输入流，读取属性文件里的键值对数据
（2）`public void load(Reader reader)`：通过字符输入流，读取属性文件里的键值对数据。(建议使用)
（3）`public String getProperty(String key)`：根据键获取值(等效于get()方法)
（4）`public Set<String> stringPropertyNames()`：获取全部键的集合(等效于keySet()方法)

使用Properties读取属性文件的步骤如下：

```java
1、创建一个Properties的对象出来（键值对集合，空容器）
2、调用load(字符输入流/字节输入流)方法，开始加载属性文件中的键值对数据到properties对象中去
3、调用getProperty(键)方法，根据键取值
```

举例：

```java
public class PropertiesTest1 {
    public static void main(String[] args) throws Exception {
        // 1、创建一个Properties的对象出来（键值对集合，空容器）
        Properties properties = new Properties();
        System.out.println(properties);

        // 2、开始加载属性文件中的键值对数据到properties对象中去
        properties.load(new FileReader("properties-xml-log-app\\src\\users.properties"));
        System.out.println(properties);

        // 3、根据键取值
        System.out.println(properties.getProperty("赵敏"));
        System.out.println(properties.getProperty("张无忌"));

        // 4、遍历全部的键和值。
        //获取键的集合
        Set<String> keys = properties.stringPropertyNames();
        for (String key : keys) {
            //再根据键获取值
            String value = properties.getProperty(key);
            System.out.println(key + "---->" + value);
        }
		
        properties.forEach((k, v) -> {
            System.out.println(k + "---->" + v);
        });
    }
}
```


**使用Properties往属性文件中写键值对**

（5）`public Object setProperty(String key, String value)`：保存键值对数据到Properties对象中去
（6）`public void store(OutputStream os, String comments)`：把键值对数据，通过字节输出流写出到属性文件里去
（7）`public void store(Writer w, String comments)`：把键值对数据，通过字符输出流写出到属性文件里去。(建议使用)

往Properties属性文件中写键值对的步骤如下：

```java
1、创建Properties对象出来
2、调用setProperty存储一些键值对数据
3、调用store(字符输出流/字节输出流, 注释)，将Properties集合中的键和值写到文件中
	注意：第二个参数是注释，必须得加；
```

举例：

```java
public class PropertiesTest2 {
    public static void main(String[] args) throws Exception {
        // 1、创建Properties对象出来，先用它存储一些键值对数据
        Properties properties = new Properties();
        properties.setProperty("张无忌", "minmin");
        properties.setProperty("殷素素", "cuishan");
        properties.setProperty("张翠山", "susu");

        // 2、把properties对象中的键值对数据存入到属性文件中去
        properties.store(new FileWriter("properties-xml-log-app/src/users2.properties")
                         , "i saved many users!");

    }
}
```

## 7. Collections工具类

Arrays是操作数组的工具类，而Collections是一个操作Set、List和Map等集合的工具类。

Collections 中提供了一系列静态的方法对集合元素进行排序、查询和修改等操作，还提供了对集合对象设置不可变、对集合对象实现同步控制等方法（均为static方法）：

**排序操作**
（1）`void reverse(List<?> list)`：反转list中元素的顺序
（2）`void shuffle(List<?> list) `：对list中元素进行随机打乱
（3）`void sort(List<T> list)`：根据元素的自然顺序对指定list集合元素按升序排序
（4）`void sort(List<T> list, Comparator<? super T> c)`：根据指定的Comparator产生的顺序对list集合元素进行排序
（5）`void swap(List<?> list, int i, int j)`：将指定list集合中的i处元素和j处元素进行交换

**查找**

（6）`T max(Collection<? extends T> coll)`：根据元素的自然顺序，返回给定集合中的最大元素
（7）`T max(Collection<? extends T> coll, Comparator<? super T> comp)`：根据 Comparator 指定的顺序，返回给定集合中的最大元素
（8）`T min(Collection<? extends T> coll)`：根据元素的自然顺序，返回给定集合中的最小元素
（9）`T min(Collection<? extends T> coll, Comparator<? super T> comp)`：根据 Comparator 指定的顺序，返回给定集合中的最小元素
（10）`int binarySearch(List<? extends Comparable<? super T>> list, T key)`：在list集合中查找某个元素的下标，且集合必须是有序的
（11）`int binarySearch(List<? extends T> list, T key, Comparator<? super T> c)`：在list集合中查找某个元素的下标，且集合必须是有序的(按比较器c的规则有序)
（12）`int frequency(Collection<?> c, Object o)`：返回集合中指定元素的出现次数

**复制、替换**

（13）`void copy(List<? super T> dest, List<? extends T> src)`：将src中的内容复制到dest中。注意dest的大小不能小于src的大小。
（14）`boolean replaceAll(List<T> list, T oldVal, T newVal)`：使用新值替换 List 对象的所有旧值
（15）`Collection<T> unmodifiableCollection(Collection<? extends T> c)`：事实上工具类提供了多个unmodifiableXxx()方法，该方法返回一个新的元素完全相同的集合对象，但该对象只可读、不可写。

**添加**

（16）`boolean addAll(Collection<? super T> c, T... elements)`：将所有指定元素添加到指定collection中。

**同步**

（17）Collections 类中提供了多个 synchronizedXxx() 方法，该方法可使将指定集合包装成线程同步的集合，从而可以解决多线程并发访问集合时的线程安全问题：

![](/zzimages/image-20220409003002526.png)

举例：

```java
List<Integer> list1 = new ArrayList<>();
List<Integer> list2 = Collections.synchronizedList(list1);
// 返回的list2就是线程安全的
```






