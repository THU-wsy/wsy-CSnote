# 目录

- [目录](#目录)
- [第01章\_Python简介](#第01章_python简介)
  - [1. Python安装](#1-python安装)
  - [2. PyCharm安装](#2-pycharm安装)
  - [3. 虚拟环境 venv](#3-虚拟环境-venv)
- [第02章\_Python基础](#第02章_python基础)
  - [1. 变量](#1-变量)
    - [1.1 变量的声明与赋值](#11-变量的声明与赋值)
    - [1.2 数据类型](#12-数据类型)
    - [1.3 数据输入](#13-数据输入)
    - [1.4 数据输出](#14-数据输出)
  - [2. 运算符](#2-运算符)
    - [2.1 算术运算符](#21-算术运算符)
    - [2.2 赋值运算符](#22-赋值运算符)
    - [2.3 比较运算符](#23-比较运算符)
      - [is 与 == 的区别](#is-与--的区别)
      - [三元表达式（条件表达式）](#三元表达式条件表达式)
    - [2.4 逻辑运算符](#24-逻辑运算符)
      - [and](#and)
      - [or](#or)
      - [not](#not)
  - [3. 流程控制语句](#3-流程控制语句)
    - [3.1 if](#31-if)
    - [3.2 while](#32-while)
    - [3.3 for](#33-for)
      - [enumerate() — 同时获取索引和值](#enumerate--同时获取索引和值)
      - [zip() — 并行迭代](#zip--并行迭代)
      - [for-else 与 while-else](#for-else-与-while-else)
  - [4. 函数](#4-函数)
    - [4.1 函数的定义](#41-函数的定义)
    - [4.2 变量的作用域](#42-变量的作用域)
    - [4.3 多返回值](#43-多返回值)
    - [4.4 多种传参方式](#44-多种传参方式)
      - [1、位置参数](#1位置参数)
      - [2、关键字参数](#2关键字参数)
      - [3、缺省参数](#3缺省参数)
      - [4、可变参数](#4可变参数)
    - [4.5 lambda匿名函数](#45-lambda匿名函数)
  - [5. 异常处理](#5-异常处理)
  - [6. 模块与包](#6-模块与包)
    - [6.1 模块](#61-模块)
    - [6.2 json模块的使用](#62-json模块的使用)
    - [6.3 自定义模块](#63-自定义模块)
    - [6.4 包](#64-包)
    - [6.5 安装第三方包](#65-安装第三方包)
- [第03章\_数据容器](#第03章_数据容器)
  - [1. 列表list](#1-列表list)
    - [1.1 列表的定义](#11-列表的定义)
    - [1.2 列表的索引](#12-列表的索引)
    - [1.3 列表的常用操作](#13-列表的常用操作)
    - [1.4 列表的遍历](#14-列表的遍历)
  - [2. 元组tuple](#2-元组tuple)
    - [2.1 元组的定义](#21-元组的定义)
    - [2.2 元组的常用操作](#22-元组的常用操作)
    - [2.3 元组的遍历](#23-元组的遍历)
  - [3. 字符串str](#3-字符串str)
    - [3.1 三种定义方式](#31-三种定义方式)
    - [3.2 字符串拼接](#32-字符串拼接)
    - [3.3 字符串格式化](#33-字符串格式化)
      - [方式一](#方式一)
      - [方式二](#方式二)
    - [3.4 字符串的常用操作](#34-字符串的常用操作)
    - [3.5 字符串的遍历](#35-字符串的遍历)
  - [4. 集合set](#4-集合set)
    - [4.1 集合的定义](#41-集合的定义)
    - [4.2 集合的常用操作](#42-集合的常用操作)
    - [4.3 集合的遍历](#43-集合的遍历)
    - [4.4 不可变集合 frozenset](#44-不可变集合-frozenset)
  - [5. 字典dict](#5-字典dict)
    - [5.1 字典的定义](#51-字典的定义)
    - [5.2 字典的常用操作](#52-字典的常用操作)
    - [5.3 字典的遍历](#53-字典的遍历)
  - [6. 数据容器的其他操作](#6-数据容器的其他操作)
    - [6.1 序列切片](#61-序列切片)
    - [6.2 统计功能](#62-统计功能)
    - [6.3 转换功能](#63-转换功能)
    - [6.4 排序功能](#64-排序功能)
    - [6.5 其他常用容器方法补充](#65-其他常用容器方法补充)
  - [7. 推导式 Comprehension](#7-推导式-comprehension)
    - [7.1 列表推导式](#71-列表推导式)
    - [7.2 字典推导式](#72-字典推导式)
    - [7.3 集合推导式](#73-集合推导式)
  - [8. 五类数据容器对比](#8-五类数据容器对比)
- [第04章\_文件操作](#第04章_文件操作)
  - [1. 打开文件](#1-打开文件)
  - [2. 读取文件](#2-读取文件)
  - [3. 关闭文件](#3-关闭文件)
  - [4. 写入文件](#4-写入文件)
  - [5. pathlib — 更现代的文件路径操作](#5-pathlib--更现代的文件路径操作)
- [第05章\_面向对象编程](#第05章_面向对象编程)
  - [1. 类与对象](#1-类与对象)
    - [1.1 类的定义](#11-类的定义)
    - [1.2 魔术方法](#12-魔术方法)
  - [2. 封装](#2-封装)
    - [2.1 @property 装饰器 — Pythonic 的 getter/setter](#21-property-装饰器--pythonic-的-gettersetter)
    - [2.2 @classmethod 与 @staticmethod](#22-classmethod-与-staticmethod)
  - [3. 继承](#3-继承)
    - [3.1 继承的基本语法](#31-继承的基本语法)
    - [3.2 复写](#32-复写)
  - [4. 多态](#4-多态)
  - [5. 类型检查：isinstance() 和 issubclass()](#5-类型检查isinstance-和-issubclass)
  - [6. dataclass — 简化数据类的定义](#6-dataclass--简化数据类的定义)
- [第06章\_类型注解](#第06章_类型注解)
  - [1. 类型注解简介](#1-类型注解简介)
  - [2. 变量的类型注解](#2-变量的类型注解)
  - [3. 函数的类型注解](#3-函数的类型注解)
  - [4. Union类型注解](#4-union类型注解)
- [第07章\_Python操作数据库](#第07章_python操作数据库)
  - [1. 创建数据库连接](#1-创建数据库连接)
  - [2. 增删改语句](#2-增删改语句)
  - [3. 查询语句](#3-查询语句)
- [第08章\_Python高阶技巧](#第08章_python高阶技巧)
  - [1. 闭包](#1-闭包)
  - [2. Python中实现常见的设计模式](#2-python中实现常见的设计模式)
    - [2.1 装饰器模式](#21-装饰器模式)
    - [2.2 单例模式](#22-单例模式)
    - [2.3 工厂模式](#23-工厂模式)
  - [3. 多线程编程](#3-多线程编程)
  - [4. eval函数](#4-eval函数)
  - [5. 浅拷贝和深拷贝](#5-浅拷贝和深拷贝)
    - [5.1 可变类型](#51-可变类型)
    - [5.2 不可变类型](#52-不可变类型)
  - [6. 生成器与 yield](#6-生成器与-yield)
  - [7. match-case 结构模式匹配](#7-match-case-结构模式匹配)
  - [8. map() 与 filter()](#8-map-与-filter)
  - [9. 解包运算符 \* 和 \*\*（函数调用侧）](#9-解包运算符--和-函数调用侧)
  - [10. f-string 高级格式化](#10-f-string-高级格式化)

---

# 第01章_Python简介

## 1. Python安装

前往官网 https://www.python.org/downloads/ 下载，然后进行安装：

![image-20250611142937458](images/image-20250611142937458.png)

![image-20250611143046672](images/image-20250611143046672.png)

![image-20250611143225021](images/image-20250611143225021.png)

![image-20250611143350567](images/image-20250611143350567.png)

然后在cmd中输入python，能够返回python的版本号并进入python编辑模式就意味着python安装成功。

## 2. PyCharm安装

PyCharm是Python最常用的集成开发工具（IDE），前往官网 https://www.jetbrains.com.cn/pycharm/download/?section=windows 下载PyCharm社区版即可。

## 3. 虚拟环境 venv

虚拟环境是 Python 项目隔离的基础设施。每个项目可以有自己独立的依赖包，互不冲突。

**创建和激活虚拟环境**：

```cmd
# 创建虚拟环境（在项目目录下）
python -m venv venv

# 激活虚拟环境（Windows）
venv\Scripts\activate

# 激活虚拟环境（Mac / Linux）
source venv/bin/activate

# 退出虚拟环境
deactivate
```

激活后，通过 `pip install` 安装的第三方包只会安装在当前虚拟环境中，不会影响系统全局 Python。

**导出和安装依赖**：

```cmd
# 导出当前环境的依赖清单
pip freeze > requirements.txt

# 根据依赖清单一键安装
pip install -r requirements.txt
```

> 建议：每个 Python 项目都创建独立的虚拟环境，并通过 `requirements.txt` 管理依赖。`venv/` 目录应写入 `.gitignore`，不纳入版本控制。



# 第02章_Python基础

## 1. 变量

### 1.1 变量的声明与赋值

```python
"""
我是
多行注释
"""

# 我是单行注释

money = 50
money = money - 10
print("剩余金额：", money)
```

说明：

- 多行注释使用三引号包裹，通常用于解释类、方法、或者整个python代码文件
- 单行注释以`#`开头，起辅助说明作用

注意：Python中变量、函数的命名推荐使用**下划线命名法**（多个单词用下划线连接，所有英文字母小写），例如`student_name`；而类的命名推荐使用**大驼峰命名法**，例如`UserInfoModel`。这些命名规范来源于 Python 官方的 **PEP 8** 风格指南，建议在编码时遵循 PEP 8 规范。

### 1.2 数据类型

Python中常用的有以下6种数据类型：

![image-20250612004724704](images/image-20250612004724704.png)

> 注1：变量是没有类型的，但它存储的数据是有类型的
>
> 注2：Python中，数字、字符串、元组属于**值类型（不可变类型）**；而列表、集合、字典属于**引用类型（可变类型）**。

**查看数据类型**：可以通过`type()`

```python
x = 10
print(type(x)) # 输出<class 'int'>
x = 13.14
print(type(x)) # 输出<class 'float'>
x = 1 + 2j
print(type(x)) # 输出<class 'complex'>
x = True
print(type(x)) # 输出<class 'bool'>
x = "哈哈"
print(type(x)) # 输出<class 'str'>
```

**数据类型转换**：

```python
a = "3.14"
b = float(a)  # 转换为小数
c = int(b)    # 转换为整数（浮点数转整数可能会丢失精度）
d = str(c)    # 转换为字符串
print(b)      # 3.14
print(c)      # 3
print(d)      # 3
```

### 1.3 数据输入

使用`input()`语句可以从键盘获取输入，输入的内容都将转为字符串类型

```python
age = input("请输入您的年龄\n")
print(type(age))  # <class 'str'>
```

### 1.4 数据输出

使用`print()`语句可以输出到显示屏，默认情况下`print()`是会自动换行的。如果不想换行，则可采用如下方式：

```python
print("Hello ", end='')
print("World", end='')
```

## 2. 运算符

### 2.1 算术运算符

```python
print(3 + 2)   # 5，加法
print(3 - 2)   # 1，减法
print(3 * 2)   # 6，乘法
print(3 / 2)   # 1.5，除法
print(9 % 4)   # 1，取余
print(9 // 4)  # 2，取整除（返回商的整数部分）
print(3 ** 2)  # 9，乘方
```

### 2.2 赋值运算符

`=`、`+=`、`-=`、`*=`、`/=`、`%=`、`//=`、`**=`

### 2.3 比较运算符

通过比较运算符进行比较运算会得到布尔类型的结果：

```python
a, b = 10, 20
print(a == b)  # False
print(a != b)  # True
print(a > b)   # False
print(a < b)   # True
print(a >= b)  # False
print(a <= b)  # True
```

**链式比较**：Python 支持链式比较，比其它语言更简洁直观：

```python
age = 25
print(18 <= age <= 60)  # True
print(0 < age < 18)     # False
```

#### is 与 == 的区别

- `==` 比较两个对象的**值**是否相等
- `is` 比较两个对象的**内存地址**是否相同（身份比较）

```python
a = [1, 2, 3]
b = [1, 2, 3]
c = a

print(a == b)  # True  — 值相等
print(a is b)  # False — 不同对象，地址不同
print(a is c)  # True  — 同一对象
```

> 惯用法：与 `None` 比较时统一使用 `is`，即 `if x is None` 而不是 `if x == None`。

#### 三元表达式（条件表达式）

Python 中没有 `?:` 三目运算符，而是使用 `if-else` 表达式：

```python
x = 10
result = "偶数" if x % 2 == 0 else "奇数"
print(result)  # 偶数
```

### 2.4 逻辑运算符

- `and`：逻辑与运算
- `or`：逻辑或运算
- `not`：逻辑非运算

说明：

1. Python中，以下变量都会被当成False：任何数字类型的0、空字符串、空列表、空元组、空集合、空字典、`None`等
2. `and`和`or`运算符会将其中一个表达式的值作为最终结果，而并不是将True或False作为最终结果
3. 当一个表达式中有多个逻辑运算符时，按优先级`not>and>or`顺序来运算

#### and

若左边表达式的值为假，则左边表达式的值作为最终结果；若左边表达式的值为真，则右边表达式的值作为最终结果。

```python
print(15 > 10 and 15 < 6) # False
print({} and 15)          # {}
print(6 and 15)           # 15
```

#### or

若左边表达式的值为假，则右边表达式的值作为最终结果；若左边表达式的值为真，则左边表达式的值作为最终结果。

```python
print(15 > 10 or 15 < 6) # True
print({} or 15)          # 15
print(6 or 15)           # 6
```

#### not

若表达式的值为真，则结果为False；若表达式的值为假，则结果为True。

```python
print(not 16 < 9) # True
print(not {})     # True
print(not 6)      # False
```

## 3. 流程控制语句

### 3.1 if

```python
import random
# 生成一个[70, 100]之间的随机整数
score = random.randint(70, 100)
print(f"你的分数是{score}")
if score >= 90:
    print("成绩为优秀")
elif score >= 80:
    print("成绩为良好")
else:
    print("成绩为中等")
```

### 3.2 while

```python
sum = 0
i = 1
while i <= 100:
    sum += i
    i += 1
print(sum)
```

> 在while循环和for循环中，我们可以使用continue和break关键字来控制循环的中断

### 3.3 for

Python中的for循环是无法定义循环条件的，只能从被处理的数据集中依次取出内容进行逐个处理。语法如下：

```python
for 临时变量 in 待处理数据集:
    循环体代码
```

其中，待处理数据集是一种**可迭代类型**。可迭代类型就是其内容可以一个个依次取出的一种类型，包括字符串、列表、元组、集合、字典等。for循环语句本质上就是遍历可迭代对象。

```python
for x in "hello你好":
    print(x)
```

在for循环中，我们通常使用**range语句获取一个简单的数字序列**（可迭代类型的一种），例如：

```python
for i in range(5):
    print(i)
```

1. `range(n)`获取一个从`0`开始、到`n`结束的数字序列（不含`n`本身）。例如，`range(5)`取得的数据是`[0,1,2,3,4]`
2. `range(n1, n2)`获取一个从`n1`开始、到`n2`结束的数字序列（不含`n2`本身）。例如，`range(5, 10)`取得的数据是`[5,6,7,8,9]`
3. `range(n1, n2, step)`获取一个从`n1`开始、到`n2`结束、以`step`为步长的数字序列（不含`n2`本身）。例如，`range(5, 10, 2)`取得的数据是`[5, 7, 9]`

#### enumerate() — 同时获取索引和值

`enumerate()` 可以在遍历可迭代对象时同时获取索引和值，非常常用：

```python
fruits = ["苹果", "香蕉", "橘子"]
for index, fruit in enumerate(fruits):
    print(f"第{index}个水果是{fruit}")
# 输出：
# 第0个水果是苹果
# 第1个水果是香蕉
# 第2个水果是橘子

# 可通过 start 参数指定索引起始值
for index, fruit in enumerate(fruits, start=1):
    print(f"第{index}个水果是{fruit}")
# 输出：
# 第1个水果是苹果
# 第2个水果是香蕉
# 第3个水果是橘子
```

#### zip() — 并行迭代

`zip()` 可以将多个可迭代对象"拉链式"地并行迭代：

```python
names = ["张三", "李四", "王五"]
ages = [18, 20, 19]
for name, age in zip(names, ages):
    print(f"{name}今年{age}岁")
# 输出：
# 张三今年18岁
# 李四今年20岁
# 王五今年19岁
```

> 说明：`zip()` 按最短的可迭代对象截断。如果需要严格等长校验，可传入 `strict=True`（Python 3.10+）。

#### for-else 与 while-else

Python 的循环有一个独特的 `else` 子句：当循环**正常结束**（即未被 `break` 中断）时，会执行 `else` 块。

```python
# for-else 示例：查找元素
nums = [1, 3, 5, 7]
target = 4
for n in nums:
    if n == target:
        print("找到了")
        break
else:
    print("未找到")  # 未被break时执行
# 输出：未找到
```

```python
# while-else 示例
count = 3
while count > 0:
    print(count)
    count -= 1
else:
    print("循环正常结束")
# 输出：3 2 1 循环正常结束
```

## 4. 函数

### 4.1 函数的定义

函数的定义格式如下：

```python
def 函数名(形参1, 形参2):
    函数体
    return 返回值
```

说明：

1. 函数必须先定义再调用
2. 函数可以没有return语句，此时该函数的返回值为`None`字面量，其类型为`<class 'NoneType'>`

给函数添加**说明文档**的规范格式如下：

```python
def div(x, y):
    """
    div函数的功能是进行除法运算
    :param x: 形参x
    :param y: 形参y，不能为零
    :return: 返回两数相除的结果
    """
    return x / y
```

> 注意：在Python中，如果将函数定义为class（类）的成员，那么我们就称之为`方法`。

### 4.2 变量的作用域

- 局部变量：定义在函数体内的变量是局部变量，只在函数体内部生效
- 全局变量：定义在函数体外的变量是全局变量

例1：

```python
num = 100
def test1():
    num = 200
    print(num)
def test2():
    print(num)

test1()   # 200
test2()   # 100
```

> 说明：在函数`test1()`中定义了一个同名的局部变量`num`，所以在`test1()`中会打印200；而`test2()`中访问的则是全局变量`num`，所以会打印100

例2：

```python
num = 100
def test1():
    global num
    num = 200
    print(num)
def test2():
    print(num)

test1()   # 200
test2()   # 200
```

> 说明：在函数`test1()`中通过**global**关键字声明该`num`是全局变量，所以`test1()`中将全局变量`num`的值修改成了200

### 4.3 多返回值

Python函数支持返回多个返回值（多个返回值之间用逗号隔开），只需按照返回值的顺序用多个变量接收即可：

```python
def test():
    return "wsy", 666, True
x, y, z = test()
print(f"x={x}, y={y}, z={z}")
```

### 4.4 多种传参方式

#### 1、位置参数

位置参数指的是调用函数时根据函数定义的参数位置来传递参数，也是我们最常用的传参方式。

```python
def test(name, age, gender):
    print(f"姓名是{name}，年龄是{age}，性别是{gender}")
test("张三", 20, "男")
```

#### 2、关键字参数

函数调用时可以通过`键=值`的形式传递参数，关键字参数无需按照形参的顺序来传递。关键字参数可以和位置参数混合使用，但位置参数必须在关键字参数的前面。

```python
def test(name, age, gender):
    print(f"姓名是{name}，年龄是{age}，性别是{gender}")
test("张三", gender="男", age=18)
```

#### 3、缺省参数

缺省参数也叫默认参数，用于定义函数时给参数提供默认值。注意，位置参数必须在默认参数的前面。

```python
def test(name, age, gender="男"):
    print(f"姓名是{name}，年龄是{age}，性别是{gender}")
test("张三", 18)
test("李四", 20, "女")
```

#### 4、可变参数

可变参数可以接收0个或多个参数，有以下两种传递方式：

**位置传递**：以`*`标记一个形参，用元组的形式接收参数

```python
def test(*args):
    print(f"类型为{type(args)}，内容为{args}")
test("张三", 18)  # 类型为<class 'tuple'>，内容为('张三', 18)
```

**关键字传递**：以`**`标记一个形参，用字典的形式接收参数，传参的格式为`键=值`

```python
def test(**kwargs):
    print(f"类型为{type(kwargs)}，内容为{kwargs}")
test(name="张三", age=18)  # 类型为<class 'dict'>，内容为{'name': '张三', 'age': 18}
```

### 4.5 lambda匿名函数

Python中，函数本身也可以像普通变量一样作为参数传递使用（**函数名**存放的是函数的地址）：

```python
def test(compute):
    result = compute(1, 2)
    print(f"类型为{type(compute)}，结果为{result}")
def div(x, y):
    return x / y
test(div)  # 类型为<class 'function'>，结果为0.5
```

为了更简便地传递上述参数，我们可以通过lambda关键字定义**匿名函数**（匿名函数只可以临时使用），匿名函数只允许有一行函数体代码，格式为`lambda 形参: 函数体`，示例如下：

```python
def test(compute):
    result = compute(1, 2)
    print(f"类型为{type(compute)}，结果为{result}")
test(lambda x, y: x / y)
```

## 5. 异常处理

**格式一**：最简单的形式

```python
try:
    # 可能抛出异常的代码
    file = open("E:/e.txt", "r", encoding="UTF-8")
except:
    # 出现异常后会执行的代码
    print("文件未找到")
```

**格式二**：捕获指定异常（如果抛出的异常类型与要捕获的异常类型不一致，则无法捕获异常，所以我们推荐使用Exception来捕获所有类型的异常）

```python
try:
    file = open("E:/e.txt", "r", encoding="UTF-8")
except FileNotFoundError as e:
    print(e)  # [Errno 2] No such file or directory: 'E:/e.txt'
```

```python
try:
    file = open("E:/e.txt", "r", encoding="UTF-8")
except Exception as e:
    print(e)  # [Errno 2] No such file or directory: 'E:/e.txt'
```

**格式三**：捕获多个异常（多个异常类型通过元组的方式进行书写）

```python
try:
    file = open("E:/e.txt", "r", encoding="UTF-8")
except (NameError, FileNotFoundError) as e:
    print(e)
```

**格式四**：异常else（出现异常则不执行else，未出现异常则执行else）

```python
try:
    file = open("E:/e.txt", "r", encoding="UTF-8")
    print("执行成功1")
except Exception as e:
    print(e)
else:
    print("执行成功2")
    
# 最终输出：
# [Errno 2] No such file or directory: 'E:/e.txt'
```

```python
try:
    print("执行成功1")
except Exception as e:
    print(e)
else:
    print("执行成功2")

# 最终输出：
# 执行成功1
# 执行成功2
```

**格式五**：异常finally（无论是否出现异常，finally中的代码都会最终被执行）

```python
file = None
try:
    file = open("E:/demo.txt", "w", encoding="UTF-8")
    number = 10 / 0
    print("执行成功1")
except Exception as e:
    print(e)
finally:
    file.close()
    print("执行成功2")

# 最终输出：
# division by zero
# 执行成功2
```

## 6. 模块与包

### 6.1 模块

Python模块（Module）其实就是一个Python文件，其中可以定义函数、类、变量等，也可以包含可执行代码。模块的作用就是帮助我们快速实现一些功能，比如time模块就为我们提供与时间相关的功能，所以我们可以认为一个模块就是一个工具包。导入模块的语法主要有以下几种：

**格式一**：

```python
# 导入：import 模块名1, 模块名2
import time

# 使用：模块名.功能名
time.sleep(3)
```

**格式二**：

```python
# 导入：from 模块名 import 功能名
from time import sleep

# 使用：功能名
sleep(3)
```

```python
# 导入：from 模块名 import *
from time import *

# 使用：功能名
sleep(3)
```

**格式三**：

```python
# 导入：import 模块名 as 模块别名
import time as t

# 使用：模块别名.功能名
t.sleep(3)
```

```python
# 导入：from 模块名 import 功能名 as 功能别名
from time import sleep as sl

# 使用：功能别名
sl(3)
```

### 6.2 json模块的使用

Python字典的结构与JSON格式相兼容，所以Python数据和JSON数据的相互转化十分方便，只需使用json模块为我们提供的功能即可：

- `json.dumps(py_data)`：将Python数据转化为JSON数据，可以添加参数`ensure_ascii=False`来确保中文字符正确转换
- `json.loads(json_data)`：将JSON数据转化为Python数据

```python
import json

py_obj = {"name": "张三", "age": 18}
py_list = [{"name": "李四", "age": 19}, {"name": "王五", "age": 20}]

# Python数据转JSON数据
json_obj = json.dumps(py_obj, ensure_ascii=False)
json_list = json.dumps(py_list, ensure_ascii=False)
print(f"类型：{type(json_obj)}，数据：{json_obj}")
print(f"类型：{type(json_list)}，数据：{json_list}")

# JSON数据转Python数据
py_obj_new = json.loads(json_obj)
py_list_new = json.loads(json_list)
print(f"类型：{type(py_obj_new)}，数据：{py_obj_new}")
print(f"类型：{type(py_list_new)}，数据：{py_list_new}")
```

### 6.3 自定义模块

我们可以根据自己的需求来自定义模块，例如我们自定义一个`compute_util.py`模块：

```python
# 定义各种功能函数
def add(x, y):
    print(f"{x}+{y}={x + y}")
    return x + y

def sub(x, y):
    print(f"{x}-{y}={x - y}")
    return x - y

# 在自定义模块中可以编写测试方法，需要采用如下格式：
if __name__ == '__main__':
    print("=======测试add功能=======")
    add(2, 3)
    print("=======测试sub功能=======")
    sub(2, 3)
# 说明：
# - 当运行该Python文件时，__name__会被赋值为__main__，因此上述测试方法可以执行
# - 而当别的文件导入该模块后运行，if判断就不成立，所以不会执行上述测试方法
# - 因此，如果不使用上述if判断，那么别的文件导入该模块后都会执行一遍测试方法，不符合我们的预期
```

在Python文件`demo.py`中导入自定义模块：

```python
import compute_util

result = compute_util.add(4, 5)
```

> 说明：如果Python文件与自定义模块在同一目录下，则可以使用上述方式直接import导入；但若不在同一目录下，则需要使用导入包的方式进行导入。

**注意**：在模块文件中可以定义`__all__`变量（list类型），用于**限制导入`*`的范围**，例如我们在`compute_util.py`首行可以定义`__all__ = ["add"]`。也就是说，使用`from 模块名 import *`进行导入时，只会导入这个`__all__`变量中保存的元素。

### 6.4 包

Python包（Package）其实就是一个文件夹，且该文件夹下包含了一个` __init__.py`文件，该文件夹可用于包含多个模块文件，事实上包的本质依然是模块。包的作用就是帮助我们管理模块文件。

![image-20250618145353195](images/image-20250618145353195.png)

在PyCharm中创建Python软件包后会自动添加` __init__.py`文件（这个文件控制着包的导入行为），我们在该文件夹中可以添加多个模块文件交给包管理：

![image-20250618150545669](images/image-20250618150545669.png)

包的导入主要有以下几种语法：

**格式一**：

```python
# 导入：import 包名.模块名
import utils.compute_util

# 使用：包名.模块名.功能名
utils.compute_util.add(2, 3)
```

**格式二**：

```python
# 导入：from 包名 import 模块名
from utils import compute_util

# 使用：模块名.功能名
compute_util.add(2, 3)
```

```python
# 注意：以下格式必须在__init__.py文件中添加__all__ = []来控制允许导入的模块
# 例如__all__ = ["compute_util", "network_util", "string_util"]

# 导入：from 包名 import *
from utils import *

# 使用：模块名.功能名
compute_util.add(2, 3)
```

**格式三**：

```python
# 导入：from 包名.模块名 import 功能名
from utils.compute_util import add

# 使用：功能名
add(2, 3)
```

```python
# 导入：from 包名.模块名 import *
from utils.compute_util import *

# 使用：功能名
add(2, 3)
```

### 6.5 安装第三方包

在Python的生态中，有非常多的第三方包（非Python官方），可以极大地帮助我们提高开发效率，如：

- 科学计算中常用的：numpy包
- 数据分析中常用的：pandas包
- 大数据计算中常用的：pyspark、apache-flink包
- 图形可视化常用的：matplotlib、pyecharts包
- 人工智能常用的：tensorflow包

但由于是第三方，所以Python没有内置，因此我们需要安装它们后才可以导入使用。在cmd中输入如下指令即可通过网络快速安装第三方包：

```cmd
pip install 包名称
```

但由于pip是连接国外网站进行包的安装，所以速度很慢，我们可以通过如下命令让其连接国内网站进行包的安装：

```cmd
pip install -i https://mirrors.aliyun.com/pypi/simple/ 包名称
```

第三方包安装完成后，就可以在Python程序中导入并使用：

```python
import numpy

matrix = numpy.identity(4)
print(matrix)
# [[1. 0. 0. 0.]
#  [0. 1. 0. 0.]
#  [0. 0. 1. 0.]
#  [0. 0. 0. 1.]]
```



# 第03章_数据容器

Python中的数据容器是一种可以容纳多份数据的数据类型，其中每一个元素可以是**任意类型**的数据（字符串这一数据容器除外）。数据容器有以下5类：列表、元组、字符串、集合、字典。

## 1. 列表list

列表是有序的可变序列

### 1.1 列表的定义

```python
# 定义列表
list1 = ["wsy", 666, True]
# 定义空列表
empty_list1 = []
empty_list2 = list()

print(list1)        # ['wsy', 666, True]
print(type(list1))  # <class 'list'>
```

### 1.2 列表的索引

- 正向索引：从前往后，从0开始依次递增
- 反向索引：从后往前，从-1开始依次递减

```python
list1 = ["wsy", 666, True]
print(list1[0])   # wsy
print(list1[-1])  # True
```

### 1.3 列表的常用操作

| 使用方式                | 作用                                                 |
| ----------------------- | ---------------------------------------------------- |
| `x in 列表`             | 判断 x 是否在列表中（O(n) 线性查找）                  |
| 列表.append(元素)       | 向列表尾部追加一个元素                               |
| 列表.extend(容器)       | 将容器中的所有元素依次追加到列表尾部                 |
| 列表.insert(下标, 元素) | 在指定下标处插入指定元素                             |
| del 列表[下标]          | 删除列表指定下标元素                                 |
| 列表.pop(下标)          | 删除列表指定下标元素                                 |
| 列表.remove(元素)       | 从前往后，删除此元素第一个匹配项                     |
| 列表.clear()            | 清空列表                                             |
| 列表.index(元素)        | 从前往后，查找此元素第一个匹配项的下标，找不到则报错 |
| 列表.count(元素)        | 统计此元素在列表中出现的次数                         |
| len(列表)               | 返回列表中的元素个数                                 |

示例：

```python
list1 = [1, 2, 3]
list1.append(4)         # [1, 2, 3, 4]
list1.extend(range(2))  # [1, 2, 3, 4, 0, 1]
list1.insert(1, 5)      # [1, 5, 2, 3, 4, 0, 1]
del list1[1]            # [1, 2, 3, 4, 0, 1]
list1.pop(3)            # [1, 2, 3, 0, 1]
list1.remove(3)         # [1, 2, 0, 1]
print(list1.index(1))   # 0
print(list1.count(1))   # 2
print(len(list1))       # 4

# in 判断元素是否在列表中
print(2 in list1)       # True
print(99 in list1)      # False
```

### 1.4 列表的遍历

```python
list1 = [1, 2, 3, 4, 5]
for element in list1:
    print(element)
```

## 2. 元组tuple

元组是有序的不可变序列

### 2.1 元组的定义

```python
# 定义元组
tuple1 = ("wsy", 666, True)
# 定义空元组
empty_tuple1 = ()
empty_tuple2 = tuple()
# 定义只有一个元素的元组，注意单元素后必须添加逗号，否则不是元组
single_tuple = ("wsy",)

print(tuple1)        # ('wsy', 666, True)
print(type(tuple1))  # <class 'tuple'>
```

> 说明：通过索引访问元组的方式与列表一致

### 2.2 元组的常用操作

> 说明：**元组不可被修改**

| 使用方式         | 作用                                                 |
| ---------------- | ---------------------------------------------------- |
| `x in 元组`      | 判断 x 是否在元组中（与列表相同，O(n) 线性查找）      |
| 元组.index(元素) | 从前往后，查找此元素第一个匹配项的下标，找不到则报错 |
| 元组.count(元素) | 统计此元素在元组中出现的次数                         |
| len(元组)        | 返回元组中的元素个数                                 |

**注意**：如果元组中有引用类型的元素（例如列表），那么只要不改变其地址，就相当于没有修改该元组。

```python
tuple1 = (1, [1, 2, 3])
tuple1[1].append(4)   # 正确，('wsy', [1, 2, 3, 4])
tuple1[1] = [2, 3, 4] # 报错
tuple1[0] = 2         # 报错
```

### 2.3 元组的遍历

```python
tuple1 = (1, 2, 3, 4, 5)
for element in tuple1:
    print(element)
```

## 3. 字符串str

字符串是字符的容器，是不可修改的

### 3.1 三种定义方式

```python
name = "张三"     # 双引号定义法
name = '张三'     # 单引号定义法
name = """张三""" # 三引号定义法
```

> 说明：使用三引号定义法，其内容也支持换行，当它赋值给一个变量时就作为字符串，而当它不赋值给某个变量时就作为多行注释。

### 3.2 字符串拼接

两个字符串可以通过`+`进行拼接。注意，字符串无法和非字符串类型进行拼接。

### 3.3 字符串格式化

#### 方式一

通过占位符`%s`可以进行字符串格式化：

```python
name = "张三"
age = 18
message = "我叫%s，今年%s岁" % (name, age)
print(message)
```

格式符号有以下三种（不过在大多数情况下我们都使用`%s`来转换成字符串占位即可）：

| 格式符号 | 说明                             |
| -------- | -------------------------------- |
| `%s`     | 将内容转换成字符串，放入占位位置 |
| `%d`     | 将内容转换成整数，放入占位位置   |
| `%f`     | 将内容转换成浮点数，放入占位位置 |

**数字精度控制**：我们可以使用辅助符号`m.n`来控制数字的宽度和精度。`m`用于控制宽度（很少使用），但若设置的宽度小于数字自身，则不生效；`.n`用于控制小数精度，会进行小数的四舍五入。

举例：

- `%5d`表示将整数的宽度控制在5位，例如数字`11`就会变成`[空格][空格][空格]11`
- `%7.2f`表示将宽度控制在7位，将小数点精度设置为2，例如`11.345`就会变成`[空格][空格]11.35`
- `%.2f`表示不限制宽度，只设置小数点精度为2，例如`11.345`就会变成`11.35`

#### 方式二

通过语法`f"内容{变量}"`可以进行字符串的快速格式化：

```python
name = "张三"
age = 18
message = f"我叫{name}，今年{age}岁"
print(message)
```

### 3.4 字符串的常用操作

| 使用方式                         | 作用                                                         |
| -------------------------------- | ------------------------------------------------------------ |
| `子串 in 字符串`                 | 判断字符串中是否包含该子串，返回布尔值                       |
| 字符串[下标]                     | 根据下标索引读取字符                                         |
| 字符串.index(字符串)             | 从前往后，查找此字符串第一个匹配项的下标，找不到则报错       |
| 字符串.replace(字符串1, 字符串2) | 将字符串中的全部字符串1替换为字符串2后返回一个新的字符串。注意，原字符串并不会被修改。 |
| 字符串.split(分隔符)             | 按照指定分隔符划分字符串，并存入一个列表中返回               |
| "分隔符".join(列表)              | 用指定分隔符将列表中的字符串元素拼接成一个新字符串           |
| 字符串.startswith(字符串)        | 判断字符串是否以指定前缀开头，返回布尔值                     |
| 字符串.endswith(字符串)          | 判断字符串是否以指定后缀结尾，返回布尔值                     |
| 字符串.strip()                   | 移除首尾的空格和换行符后返回一个新的字符串                   |
| 字符串.strip(字符串)             | 移除首尾的指定字符串后返回一个新的字符串                     |
| 字符串.count(字符串)             | 统计字符串中某字符串的出现次数                               |
| len(字符串)                      | 统计字符串的字符个数                                         |

示例：

```python
s = "$$hello, world$$"
print(s.index("l"))     # 4

new_s = s.replace("ll", "!!")
print(s)                # $$hello, world$$
print(new_s)            # $$he!!o, world$$

str_list = s.split(",")
print(str_list)         # ['$$hello', ' world$$']

print(s.strip())        # $$hello, world$$
print(s.strip("$$"))    # hello, world

print(s.count("l"))     # 3
print(len(s))           # 16

# join() — 用分隔符拼接列表
words = ["Hello", "World"]
print("-".join(words))          # Hello-World

# startswith() / endswith()
filename = "photo.jpg"
print(filename.startswith("photo"))  # True
print(filename.endswith(".jpg"))     # True

# in 判断子串是否在字符串中（非常常用）
print("hello" in s)     # True
print("world" not in s) # False
```

### 3.5 字符串的遍历

```python
s = "hello, world"
for c in s:
    print(c)
```

## 4. 集合set

集合中的元素是无序不重复的

### 4.1 集合的定义

```python
# 定义集合
set1 = {"wsy", 666, "wsy"}
# 定义空集合
empty_set = set()

print(set1)        # {666, 'wsy'}
print(type(set1))  # <class 'set'>
```

### 4.2 集合的常用操作

| 使用方式                       | 作用                                                       |
| ------------------------------ | ---------------------------------------------------------- |
| `x in 集合`                    | 判断 x 是否为集合的成员（比列表查找快，O(1)）               |
| 集合.add(元素)                 | 集合内添加元素                                             |
| 集合.remove(元素)              | 移除集合内指定的元素                                       |
| 集合.pop()                     | 从集合中随机移除一个元素并返回                             |
| 集合.clear()                   | 清空集合                                                   |
| 集合1.difference(集合2)        | 返回集合1与集合2的差集。原来的两个集合内容不变。           |
| 集合1.difference_update(集合2) | 从集合1中删除集合2中存在的元素。集合1会被修改，集合2不变。 |
| 集合1.union(集合2)             | 返回集合1与集合2的并集。原来的两个集合内容不变。           |
| len(集合)                      | 返回集合中元素的个数                                       |

示例：

```python
set1 = {1, 2, 3}
set1.add(4)       # {1, 2, 3, 4}
set1.remove(4)    # {1, 2, 3}
set1.pop()        # {2, 3}

# in 判断元素是否在集合中（O(1) 哈希查找，比列表快很多）
print(2 in set1)   # True
print(5 in set1)   # False

set2 = {1, 2, 3}
print(set2.difference({3, 4}))  # {1, 2}
set2.difference_update({3, 4})
print(set2)                     # {1, 2}
print(set2.union({1, 4}))       # {1, 2, 4}
print(len(set2))                # 2
```

### 4.3 集合的遍历

```python
set1 = {1, 2, 3, 4, 5}
for element in set1:
    print(element)
```

### 4.4 不可变集合 frozenset

`frozenset` 是不可变的集合类型——创建后不能再添加或删除元素。由于它是不可变的，可以作为字典的 key 或另一个集合的元素：

```python
fs = frozenset([1, 2, 3])
print(type(fs))  # <class 'frozenset'>
# fs.add(4)      # 报错：AttributeError

# frozenset 可作为字典的 key（普通 set 不可以）
d = {frozenset([1, 2]): "group_a", frozenset([3, 4]): "group_b"}
print(d[frozenset([1, 2])])  # group_a
```

## 5. 字典dict

字典是无序的，存放key-value对

### 5.1 字典的定义

```python
# 定义字典
dict1 = {"name": "wsy", "age": 666, 123: 321}
# 定义空字典
empty_dict1 = {}
empty_dict2 = dict()

print(dict1)        # {'name': 'wsy', 'age': 666, 123: 321}
print(type(dict1))  # <class 'dict'>
```

> 注意：key不可重复，重复会对原数据覆盖。key不能是字典。

### 5.2 字典的常用操作

| 使用方式        | 作用                                         |
| --------------- | -------------------------------------------- |
| 字典[key]       | 获取指定key对应的value                       |
| 字典[key]=value | 添加或更新键值对                             |
| 字典.pop(key)   | 从字典中删除指定的key-value对，并返回该value |
| 字典.clear()    | 清空字典                                     |
| `x in 字典`     | 判断 x 是否为字典的 **key**     |
| 字典.keys()     | 获取字典的全部key                            |
| len(字典)       | 返回字典中的元素个数                         |

示例：

```python
dict1 = {"k1": 111, "k2": 222, "k3": 333}
print(dict1["k1"])   # 111
dict1["k4"] = 444
dict1.pop("k3")
print(dict1.keys())  # dict_keys(['k1', 'k2', 'k4'])
print(len(dict1))    # 3

# in 运算符判断的是 key，不是 value
print("k1" in dict1)  # True  — "k1" 是 key
print(111 in dict1)   # False — 111 是 value，不是 key
```

### 5.3 字典的遍历

```python
dict1 = {"k1": 111, "k2": 222, "k3": 333}
for key in dict1:
    print(f"key={key}, value={dict1[key]}")
```

## 6. 数据容器的其他操作

### 6.1 序列切片

**序列**是指有序并且可以用下标索引的数据容器，Python中列表、元组、字符串都是序列。序列支持切片操作，**切片**是指从该序列中取出一个子序列。

基本格式：`序列[起始下标:结束下标:步长]`，表示从指定位置开始、依次取出元素、到指定位置结束得到一个新的序列。

- 起始下标：可以省略，省略视作从头开始。
- 结束下标：可以省略，省略视作截取到结尾。注意，最终得到的序列中**不包含**该结束下标处的元素。
- 步长：表示依次取元素的间隔，可以省略，省略视作1。步长可以是负数，表示反向取，此时起始下标和结束下标也要反向标记。

示例：

```python
list1 = [0, 1, 2, 3, 4, 5]
print(list1[1:4])     # [1, 2, 3]
print(list1[:])       # [0, 1, 2, 3, 4, 5]
print(list1[::2])     # [0, 2, 4]
print(list1[::-1])    # [5, 4, 3, 2, 1, 0]
print(list1[3:1:-1])  # [3, 2]
```

### 6.2 统计功能

五类数据容器都可以调用以下函数进行数据统计：

| 函数      | 功能                 |
| --------- | -------------------- |
| len(容器) | 返回容器中的元素个数 |
| max(容器) | 返回容器中的最大元素 |
| min(容器) | 返回容器中的最小元素 |

### 6.3 转换功能

五类数据容器都可以调用以下函数进行转换：

| 函数        | 功能                   |
| ----------- | ---------------------- |
| list(容器)  | 将给定容器转换为列表   |
| tuple(容器) | 将给定容器转换为元组   |
| str(容器)   | 将给定容器转换为字符串 |
| set(容器)   | 将给定容器转换为集合   |

### 6.4 排序功能

五类数据容器都可以调用`sorted()`函数**返回一个排序后的列表(list)对象**，注意原容器不会被修改：

- `sorted(容器)`：升序
- `sorted(容器, reverse=True)`：降序

示例：

```python
set1 = {2, 5, 1, 0}
print(sorted(set1))                # [0, 1, 2, 5]
print(sorted(set1, reverse=True))  # [5, 2, 1, 0]
```

> 补充说明：`list.sort()` 是列表的**原地排序**方法（修改原列表，返回 None），而 `sorted()` 是内置函数（**返回新列表**，原容器不变）。`sorted()` 可作用于任何可迭代对象，而 `sort()` 只属于列表。

### 6.5 其他常用容器方法补充

**列表的 `sort()` vs `sorted()`**：

```python
nums = [3, 1, 2]
nums.sort()         # 原地排序，nums 变为 [1, 2, 3]，返回 None
print(nums)         # [1, 2, 3]
print(sorted(nums)) # [1, 2, 3]，返回新列表，原列表不变
```

**字典的 `get()` 方法 vs 直接索引**：

```python
d = {"name": "张三"}

# dict[key] — key 不存在时抛出 KeyError
print(d["name"])    # 张三
# print(d["age"])   # KeyError: 'age'  ← 直接报错！

# dict.get(key) — key 不存在时返回 None 或自定义默认值（不报错）
print(d.get("name"))       # 张三
print(d.get("age"))        # None（key 不存在，返回 None）
print(d.get("age", "未知"))  # 未知（使用自定义默认值）
```

> 小结：`dict[key]` 适合**确定 key 一定存在**的场景；`dict.get()` 适合**key 可能不存在**的场景，更安全。

**字典的 `items()` / `values()` / `keys()` 方法**：

```python
d = {"k1": 111, "k2": 222, "k3": 333}

# items() — 遍历键值对（最常用）
for key, value in d.items():
    print(f"key={key}, value={value}")

# values() — 只遍历值
for value in d.values():
    print(value)  # 111  222  333

# keys() — 只遍历键（与直接 for key in d 等价）
for key in d.keys():
    print(key)  # k1  k2  k3

# 常用操作示例
print(list(d.values()))  # [111, 222, 333] — 转列表
print(sum(d.values()))   # 666 — 直接求和
print(max(d.values()))   # 333 — 取最大值
```

## 7. 推导式 Comprehension

推导式是 Python 最具标志性的特性之一，可以用**一行简洁语法**创建列表、字典、集合。

### 7.1 列表推导式

```python
# 基本格式：[表达式 for 临时变量 in 可迭代对象 if 条件]

# 示例1：生成平方列表
squares = [x**2 for x in range(6)]
print(squares)  # [0, 1, 4, 9, 16, 25]

# 示例2：带条件过滤
evens = [x for x in range(10) if x % 2 == 0]
print(evens)    # [0, 2, 4, 6, 8]

# 示例3：嵌套循环
pairs = [(x, y) for x in range(2) for y in "ab"]
print(pairs)    # [(0, 'a'), (0, 'b'), (1, 'a'), (1, 'b')]

# 示例4：if-else 三元表达式
labels = ["偶数" if x % 2 == 0 else "奇数" for x in range(5)]
print(labels)   # ['偶数', '奇数', '偶数', '奇数', '偶数']
```

### 7.2 字典推导式

```python
# 基本格式：{键表达式: 值表达式 for 临时变量 in 可迭代对象}

squares_dict = {x: x**2 for x in range(4)}
print(squares_dict)  # {0: 0, 1: 1, 2: 4, 3: 9}

# 从两个列表创建字典
keys = ["name", "age", "gender"]
values = ["张三", 18, "男"]
d = {k: v for k, v in zip(keys, values)}
print(d)  # {'name': '张三', 'age': 18, 'gender': '男'}
```

### 7.3 集合推导式

```python
# 基本格式：{表达式 for 临时变量 in 可迭代对象}

# 去重并求平方
nums = [1, 2, 2, 3, 3, 4]
unique_squares = {x**2 for x in nums}
print(unique_squares)  # {1, 4, 9, 16}
```

> 说明：推导式不仅简洁，而且通常比等价的 for 循环**执行更快**。但嵌套过深时会降低可读性，建议控制在 2 层以内。

## 8. 五类数据容器对比

| 特性     | 列表 list | 元组 tuple | 集合 set | 字典 dict | 字符串 str |
| -------- | --------- | ---------- | -------- | --------- | ---------- |
| 有序性   | 有序      | 有序       | 无序     | 无序（3.7+有序） | 有序 |
| 可变性   | 可变      | 不可变     | 可变     | 可变      | 不可变     |
| 重复元素 | 允许      | 允许       | 不允许   | key 不重复 | 允许     |
| 索引访问 | 支持      | 支持       | 不支持   | key 访问  | 支持       |
| 元素类型 | 任意      | 任意       | 不可变类型（可哈希） | key 不可变 | 字符 |
| 典型场景 | 有序集合  | 常量/坐标  | 去重/集合运算 | 键值映射 | 文本处理 |



# 第04章_文件操作

## 1. 打开文件

使用open函数可以打开一个已经存在的文件或者创建一个新文件：

```python
file = open(name, mode, encoding="UTF-8")
```

- name表示文件路径，如果使用相对路径，则默认的相对路径是当前python文件所在目录
- mode表示访问模式，有以下三种：
  1. `r`表示以**只读**方式打开文件，这是默认模式。文件的指针将会放在文件开头。
  2. `w`表示打开一个文件**只用于写入**。如果该文件不存在，则创建新文件；如果该文件已存在，则打开该文件，清空原有内容，并从头开始写入。
  3. `a`表示打开一个文件**用于追加**。如果该文件不存在，则创建新文件；如果该文件已存在，则打开该文件，新的内容将会被写入到已有内容之后。
- encoding表示编码格式，推荐统一使用UTF-8
- 返回值file是一个**文件对象**

示例：

```python
file = open("E:/demo.txt", "r", encoding="UTF-8")
```

## 2. 读取文件

每次`open()`中的内容只能被读取一次。对于同一文件对象，每次读取会从上一次读取结束的位置开始读取。读取文件的常用操作如下：

- `file.read(num)`：读取num个字符。若没有传入num，则读取文件中的全部数据。
- `file.readline()`：读取一行数据
- `file.readlines()`：按照行的方式读取全部内容，返回一个列表，列表中的每个元素代表每一行的数据
- `for line in file`：for循环读取数据，每个临时变量line记录一行数据

示例：

```python
file = open("E:/demo.txt", "r", encoding="UTF-8")
for line in file:
    print(line, end='')
file.close()
```

## 3. 关闭文件

如果不关闭文件，且程序没有停止运行，那么这个文件将一直被Python程序占用，无法操作。所以我们使用完文件对象后，必须调用`file.close()`来关闭文件。

Python中为我们提供了`with open() as file`的语法，在该语句块中可以对文件进行操作，操作完成后会**自动关闭文件**，即使出现异常也会自动关闭文件：

```python
with open("E:/demo.txt", "r", encoding="UTF-8") as file:
    for line in file:
        print(line, end='')
```

## 4. 写入文件

`w`写入模式：

```python
file = open("E:/demo.txt", "w", encoding="UTF-8")
file.write("hello world\n")
file.close()
```

`a`追加模式：

```python
file = open("E:/demo.txt", "a", encoding="UTF-8")
file.write("hello world\n")
file.close()
```

说明：

- 调用`file.write(content)`后，数据并**未真正**写入文件，而是会写入内存缓冲区。
- 调用`file.flush()`后，数据才会**真正**写入文件，即从内存缓冲区刷新到硬盘。
- `file.close()`会附带`file.flush()`方法的功能。

## 5. pathlib — 更现代的文件路径操作

Python 3.4+ 引入了 `pathlib` 模块，提供面向对象的路径操作方式，比传统的 `os.path` 更优雅、更易读写：

```python
from pathlib import Path

# 构建路径（自动适配操作系统分隔符）
p = Path("E:/demo.txt")

# 常用操作
print(p.name)        # demo.txt（文件名）
print(p.suffix)      # .txt（后缀名）
print(p.stem)        # demo（无后缀的文件名）
print(p.parent)      # E:\ （父目录）
print(p.exists())    # True/False（文件是否存在）

# 读写文件（with 无需手动 open）
content = p.read_text(encoding="UTF-8")       # 读取全部文本
p.write_text("hello", encoding="UTF-8")       # 写入文本

# 遍历目录
for f in Path("E:/").iterdir():
    print(f)
```

> 推荐在新项目中使用 `pathlib` 替代 `os.path` 和手动 `open()` 进行路径操作。



# 第05章_面向对象编程

## 1. 类与对象

### 1.1 类的定义

```python
class Student:
    # 成员变量
    name = None
    age = None

    # 成员方法（必须要写self关键字，它表示对象自身）
    def say_hi(self):
        # 在方法内部想访问类的其他属性或方法，必须使用self
        print(f"大家好，我叫{self.name}，今年{self.age}岁")

# 创建对象（类默认会提供一个无参构造方法）
student = Student()
# 为属性赋值
student.name = "张三"
student.age = 18
# 调用成员方法（self会自动被Python传入，所以我们无需手动传递self）
student.say_hi()
```

### 1.2 魔术方法

魔术方法是Python类内置的方法，有各自特殊的功能，我们将介绍几个常用的魔术方法。

**`__init__`方法**：构造方法，可用于创建类对象的时候设置初始化行为。如果我们自定义了构造方法，则默认的无参构造方法将不再提供。

```python
class Student:
    name = None
    age = None

    def __init__(self, name, age):
        self.name = name
        self.age = age


student = Student("张三", 18)
print(f"姓名：{student.name}，年龄：{student.age}")
```

**`__str__`方法**：默认打印对象时输出的是对象的内存地址，我们可以通过重写`__str__`方法来自定义打印对象时的输出内容。

```python
class Student:
    name = "张三"
    age = 18

    def __str__(self):
        return f"Student(name={self.name}, age={self.age})"


student = Student()
print(student)  # Student(name=张三, age=18)
```

**`__repr__`方法**：`__repr__` 与 `__str__` 类似，但面向**开发者调试**。`print()` 优先调用 `__str__`，若未定义则回退到 `__repr__`；在交互式环境中直接输入变量名则优先调用 `__repr__`。推荐至少实现 `__repr__`：

```python
class Student:
    name = "张三"
    age = 18

    def __repr__(self):
        return f"Student(name={self.name!r}, age={self.age})"


student = Student()
print(repr(student))  # Student(name='张三', age=18)
```

> 说明：`{self.name!r}` 中的 `!r` 会自动给字符串加上引号，使输出更清晰。

**`__lt__`方法**：默认两个对象是无法进行大小比较的，我们可以通过重写`__lt__`方法来自定义`<`的比较逻辑。除此之外，重写完该方法后，也能进行`>`的比较。

```python
class Student:
    name = None
    age = None

    def __init__(self, name, age):
        self.name = name
        self.age = age

    def __lt__(self, other):
        return self.age < other.age


student1 = Student("张三", 18)
student2 = Student("李四", 19)
print(student1 < student2)  # True
print(student1 > student2)  # False
```

**`__le__`方法**：默认两个对象是无法进行大小比较的，我们可以通过重写`__le__`方法来自定义`<=`的比较逻辑。除此之外，重写完该方法后，也能进行`>=`的比较。

```python
class Student:
    name = None
    age = None

    def __init__(self, name, age):
        self.name = name
        self.age = age

    def __le__(self, other):
        return self.age <= other.age


student1 = Student("张三", 18)
student2 = Student("李四", 19)
print(student1 <= student2)  # True
print(student1 >= student2)  # False
```

**`__eq__`方法**：默认两个对象进行`==`比较是比较内存地址是否相同，我们可以通过重写`__eq__`方法来自定义`==`的比较逻辑。除此之外，重写完该方法后，也会改变`!=`的比较逻辑。

```python
class Student:
    name = None
    age = None

    def __init__(self, name, age):
        self.name = name
        self.age = age

    def __eq__(self, other):
        return self.name == other.name and self.age == other.age


student1 = Student("张三", 18)
student2 = Student("张三", 18)
print(student1 == student2)  # True
```

## 2. 封装

封装的思想其实就是合理隐藏、合理暴露。通过定义私有成员变量、私有成员方法，就可以实现封装的思想。在Python中，以双下划线`__`开头命名的就代表私有成员变量、私有成员方法。

```python
class Student:
    def __init__(self, name, age):
        self.name = name       # 公有成员
        self.__age = age       # 私有成员

    # 提供公开方法访问私有成员
    def get_age(self):
        return self.__age

    def set_age(self, age):
        if age > 0:
            self.__age = age
        else:
            raise ValueError("年龄必须为正数")


stu = Student("张三", 18)
print(stu.get_age())  # 18
stu.set_age(20)
# print(stu.__age)     # 报错：AttributeError
```

### 2.1 @property 装饰器 — Pythonic 的 getter/setter

比起手写 `get_xxx()` / `set_xxx()`，Python 提供了更优雅的 `@property` 装饰器，让我们可以像访问属性一样调用方法：

```python
class Student:
    def __init__(self, name, age):
        self.name = name
        self.__age = age

    @property
    def age(self):
        """获取年龄"""
        return self.__age

    @age.setter
    def age(self, value):
        """设置年龄，附带校验"""
        if value < 0:
            raise ValueError("年龄必须为正数")
        self.__age = value


stu = Student("张三", 18)
print(stu.age)    # 18 — 像属性一样读取，实际调用了 age() 方法
stu.age = 20      # 像属性一样赋值，实际调用了 age.setter
```

### 2.2 @classmethod 与 @staticmethod

除了普通的成员方法（第一个参数是 `self`），Python 还有两种特殊方法：

```python
class Calculator:
    factor = 10  # 类变量

    def instance_method(self, x):
        """普通方法：操作实例数据"""
        return x * self.factor

    @classmethod
    def class_method(cls, x):
        """类方法：第一个参数是类本身(cls)，可访问类变量"""
        return x * cls.factor

    @staticmethod
    def static_method(x):
        """静态方法：无需 self 或 cls，本质是放在类里的普通函数"""
        return x * 2


calc = Calculator()
print(calc.instance_method(5))  # 50
print(Calculator.class_method(5))  # 50（可直接通过类调用）
print(Calculator.static_method(5)) # 10
```

- `@classmethod`：常用于定义**工厂方法**（创建对象的替代构造器）
- `@staticmethod`：常用于组织**工具函数**到类的命名空间下

## 3. 继承

### 3.1 继承的基本语法

**单继承**

```python
# 父类
class Parent:
    name = "李xx"
    def hello(self):
        print(f"我是{self.name}")

# 子类
class Child(Parent):
    student_number = "2025300011"
    def introduce(self):
        print(f"我的学号是{self.student_number}")

child = Child()
child.hello()      # 我是李xx
child.introduce()  # 我的学号是2025300011
```

**多继承**（如果父类中有同名成员，默认以继承顺序从左到右为优先级）

```python
# 父类1
class Parent1:
    name = "父类1"
# 父类2
class Parent2:
    name = "父类2"
# 子类
class Child(Parent1, Parent2):
    def introduce(self):
        print(f"name={self.name}")

child = Child()
child.introduce()  # name=父类1
```

### 3.2 复写

子类可以复写父类的属性和方法，即在子类中重新定义同名的属性和方法。进行复写后，如果在子类中想调用父类的同名属性或方法，则可以采用以下方式：

1. 方式一：通过父类名调用
   - 调用成员变量：`父类名.成员变量`
   - 调用成员方法：`父类名.成员方法(self)`
2. 方式二：通过`super()`调用
   - 调用成员变量：`super().成员变量`
   - 调用成员方法：`super().成员方法()`

```python
# 父类
class Parent:
    name = "父类"
    def hello(self):
        print(f"我是父类！")

# 子类
class Child(Parent):
    name = "子类"
    def hello(self):
        print(f"我是子类！")
    def show(self):
        print(f"Parent.name={Parent.name}")
        Parent.hello(self)
        print(f"super().name={super().name}")
        super().hello()

child = Child()
child.hello()
child.show()
# 输出：
# 我是子类！
# Parent.name=父类
# 我是父类！
# super().name=父类
# 我是父类！
```

## 4. 多态

多态常作用在继承关系上，以父类做定义声明，以子类做实际工作：

```python
class Animal:
    def speak(self):
        pass

class Dog(Animal):
    def speak(self):
        print("汪汪汪")

class Cat(Animal):
    def speak(self):
        print("喵喵喵")

def test(animal: Animal):
    animal.speak()

test(Dog())  # 汪汪汪
test(Cat())  # 喵喵喵
```

上述Animal是一个抽象类（含有抽象方法的类），其中speak()是一个抽象方法（方法体是空实现的，使用pass占位），然后由子类去实现该抽象方法，从而达到了多态的效果。

## 5. 类型检查：isinstance() 和 issubclass()

前面我们使用 `type()` 来检查类型，但 `isinstance()` 更推荐使用，因为它会**考虑继承关系**：

```python
class Animal: pass
class Dog(Animal): pass

dog = Dog()

# type() 不识别继承关系
print(type(dog) == Animal)    # False — 严格比较

# isinstance() 识别继承关系
print(isinstance(dog, Animal)) # True — dog 也是 Animal
print(isinstance(dog, Dog))    # True
print(isinstance(123, int))    # True
print(isinstance(123, (int, float)))  # True — 可以是多个类型之一
```

`issubclass()` 用于判断类之间的继承关系：

```python
print(issubclass(Dog, Animal))   # True
print(issubclass(Dog, object))   # True（所有类都继承自 object）
```

> 推荐：在判断类型时优先使用 `isinstance()` 而非 `type()`，除非确实需要严格类型匹配。

## 6. dataclass — 简化数据类的定义

Python 3.7+ 引入的 `dataclass` 装饰器，可自动生成 `__init__`、`__repr__`、`__eq__` 等魔术方法，极大地简化数据类的写法：

```python
from dataclasses import dataclass

@dataclass
class Student:
    name: str
    age: int
    score: float = 0.0  # 带默认值的字段放最后


# 自动生成 __init__、__repr__、__eq__
stu1 = Student("张三", 18)
stu2 = Student("张三", 18)
print(stu1)              # Student(name='张三', age=18, score=0.0)
print(stu1 == stu2)      # True（自动按字段值比较）

# 也可手动覆盖默认行为
@dataclass
class Student:
    name: str
    age: int

    def __str__(self):
        return f"学生：{self.name}"
```

对比传统写法（需手写 `__init__`、`__repr__`、`__eq__`），`@dataclass` 能节省大量样板代码，是定义数据模型的首选方式。



# 第06章_类型注解

## 1. 类型注解简介

Python在3.5版本的时候引入了类型注解（在代码中涉及数据交互的地方，提供数据类型的显式说明），其功能是帮助第三方IDE工具对代码进行类型推断、协助做代码提示，以及帮助开发者自身对变量进行类型注释。但要注意，**类型注解并不会真正地对类型做验证和判断**，也就是说，类型注解仅仅是提示性的、不是决定性的。Python中支持变量的类型注解、函数形参和返回值的类型注解。

## 2. 变量的类型注解

> 说明：一般来说，无法直接看出变量类型时，我们才会添加变量的类型注解。

基本数据类型注解：

```python
var_1: int = 10
var_2: float = 3.14
var_3: bool = True
var_4: str = "thu"
```

类对象类型注解：

```python
class Student:
    pass
stu: Student = Student()
```

容器类型注解：

```python
my_list: list = [1, 2, 3]
my_tuple: tuple = (1, 2, 3)
my_set: set = {1, 2, 3}
my_dict: dict = {"age": 18}
```

容器类型详细注解：

```python
my_list: list[int] = [1, 2, 3]
my_tuple: tuple[int, int, int] = (1, 2, 3)
my_set: set[int] = {1, 2, 3}
my_dict: dict[str, int] = {"age": 18}
```

> 注意：元组类型设置类型详细注解时，需要将每一个元素都标记出来。字典类型设置类型详细注解时，需要两个类型，第一个是key第二个是value。

## 3. 函数的类型注解

形参的类型注解：

```python
def add(x: int, y: int):
    return x + y
```

返回值的类型注解：

```python
def zero() -> int:
    return 0
```

## 4. Union类型注解

使用`Union[类型, ..., 类型]`可以定义联合类型注解，表示此处的数据类型是Union的其中之一。使用Union类型注解需要导包`from typing import Union`

```python
from typing import Union

my_list: list[Union[str, int]] = [1, 2, "wsy"]
my_dict: dict[str, Union[str, int]] = {"name": "wsy", "age": 18}
```

> 说明：Union类型注解同样可以用在函数形参和返回值处。



# 第07章_Python操作数据库

## 1. 创建数据库连接

我们首先执行以下cmd命令来安装pymysql包，用于操作数据库：

```cmd
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pymysql
```

创建数据库连接：

```python
from pymysql import Connection

# 获取数据库连接对象
conn = Connection(
    host="localhost",   # IP地址
    port=3306,          # 端口号
    user="root",        # 用户名
    password="abc666",  # 密码
    autocommit=True     # 设置自动提交
)
print(conn.get_server_info())
# 关闭数据库连接
conn.close()
```

## 2. 增删改语句

我们以插入语句为例：

```python
from pymysql import Connection

# 获取数据库连接对象
conn = Connection(
    host="localhost",   # IP地址
    port=3306,          # 端口号
    user="root",        # 用户名
    password="abc666",  # 密码
    autocommit=True     # 设置自动提交
)

# 获取游标对象，用于操作数据库
cursor = conn.cursor()
# 选择数据库
conn.select_db("test")
# 执行SQL语句
cursor.execute("insert into student values(1, '张三', 18)")
# 关闭数据库连接
conn.close()
```

## 3. 查询语句

```python
from pymysql import Connection

# 获取数据库连接对象
conn = Connection(
    host="localhost",   # IP地址
    port=3306,          # 端口号
    user="root",        # 用户名
    password="abc666",  # 密码
    autocommit=True     # 设置自动提交
)

# 获取游标对象，用于操作数据库
cursor = conn.cursor()
# 选择数据库
conn.select_db("test")
# 执行SQL语句
cursor.execute("select * from student")
# 获取查询结果（会封装到嵌套元组中）
results: tuple = cursor.fetchall()
for r in results:
    print(r)
# 关闭数据库连接
conn.close()
```



# 第08章_Python高阶技巧

## 1. 闭包

在函数嵌套的前提下，内部函数使用了外部函数的变量，并且外部函数返回了内部函数，我们把这个使用外部函数变量的内部函数称为闭包。注意，在内部函数中如果想要**修改**外部函数的变量值，则必须用nonlocal声明这个变量。

```python
def outer(num):
    def inner():
        nonlocal num
        num += 100
        print(f"num={num}")
    return inner

# 创建闭包实例
f = outer(10)
f()  # num=110
```

- 优点：闭包使用的变量位于外部函数之中，不像全局变量一样容易被错误修改，可使变量的访问和修改更加安全。
- 缺点：由于内部函数持续引用外部函数的值，所以会导致这一部分内存空间不被释放，一直占用内存。

## 2. Python中实现常见的设计模式

### 2.1 装饰器模式

一般写法：

```python
# 定义一个装饰器
def decorator(func):
    # 为目标函数进行装饰
    def inner():
        print("前置操作")
        func()
        print("后置操作")
    return inner

# 目标函数
def hello():
    print("Hello world!")

new_func = decorator(hello)
new_func()
```

语法糖写法：（在目标函数上添加`@装饰器名`，解释器遇到时会自动执行装饰过程）

```python
# 定义一个装饰器
def decorator(func):
    # 为目标函数进行装饰
    def inner():
        print("前置操作")
        func()
        print("后置操作")
    return inner

# 目标函数
@decorator
def hello():
    print("Hello world!")

# 通过语法糖注解，直接调用即可达到装饰效果
hello()
```

### 2.2 单例模式

在模块文件`tools.py`中定义：

```python
class StrTool:
    pass

str_tool = StrTool()
```

在我们的Python文件中导入并使用`str_tool`就是单例的：

```python
from tools import str_tool

s1 = str_tool
s2 = str_tool
print(s1 == s2)  # True
```

### 2.3 工厂模式

```python
class Person:
    pass

class Worker(Person):
    pass
class Student(Person):
    pass
class Teacher(Person):
    pass

class Factory:
    def get_person(self, p_type):
        if p_type == "w":
            return Worker()
        elif p_type == "s":
            return Student()
        elif p_type == "t":
            return Teacher()
        else:
            return None

factory = Factory()
worker = factory.get_person("w")
student = factory.get_person("s")
teacher = factory.get_person("t")
```

## 3. 多线程编程

Python可以通过threading模块进行多线程编程：

```python
import threading
import time

def func(name, age):
    while True:
        print(f"我叫{name}，今年{age}岁！")
        time.sleep(1)

"""
通过threading.Thread()可以创建一个线程，它主要有以下参数：
- target: 执行的目标任务
- args: 以元组的方式给执行任务传参
- kwargs: 以字典的方式给执行任务传参
- name: 线程名
"""

thread1 = threading.Thread(target=func, args=("张三", 18))
thread2 = threading.Thread(target=func, kwargs={"name": "李四", "age": 20})

# 启动线程
thread1.start()
thread2.start()
```

## 4. eval函数

`eval()`函数可将字符串**当成有效的表达式**来求值并返回计算结果：

```python
res = eval("(1+9)*5")
print(res)  # 50

res = eval("'*'*10")
print(res)  # **********

res = eval("[1,2,3]")
print(type(res))  # <class 'list'>
```

## 5. 浅拷贝和深拷贝

### 5.1 可变类型

对于可变类型：

- 进行普通赋值时，仅仅是拷贝地址
- 使用`copy`函数进行浅拷贝，则会创建一个新对象，但其内部的子对象也仅仅拷贝地址
- 使用`deepcopy`函数进行深拷贝，则会对其内部每层可变类型对象都进行拷贝（开辟新内存空间，创建新对象）

```python
import copy

arr = [[1, 2], [11, 22]]
arr_assign = arr
arr_copy = copy.copy(arr)
arr_deepcopy = copy.deepcopy(arr)

# id()可获得变量的内存地址
print(id(arr))              # 2138616074944
print(id(arr_assign))       # 2138616074944
print(id(arr_copy))         # 2138615952320
print(id(arr_deepcopy))     # 2138615952192
print(id(arr[0]))           # 2138614228800
print(id(arr_assign[0]))    # 2138614228800
print(id(arr_copy[0]))      # 2138614228800
print(id(arr_deepcopy[0]))  # 2138615952256
```

### 5.2 不可变类型

对于不可变类型，进行普通赋值、使用`copy`函数、使用`deepcopy`函数的效果都相同，仅仅是拷贝地址：

```python
import copy

arr = ((1, 2), (11, 22))
arr_assign = arr
arr_copy = copy.copy(arr)
arr_deepcopy = copy.deepcopy(arr)

# id()可获得变量的内存地址
print(id(arr))              # 2358694435200
print(id(arr_assign))       # 2358694435200
print(id(arr_copy))         # 2358694435200
print(id(arr_deepcopy))     # 2358694435200
```

## 6. 生成器与 yield

生成器是一种特殊的迭代器，使用 `yield` 关键字**惰性**地逐个生成值，而不是一次性将所有值加载到内存中。这对于处理大数据集非常有用。

```python
# 定义一个生成器函数
def count_up_to(n):
    i = 1
    while i <= n:
        yield i       # yield 会"暂停"函数，保存当前状态
        i += 1

gen = count_up_to(3)
print(type(gen))       # <class 'generator'>
print(next(gen))       # 1（每次next恢复执行，直到下一个yield）
print(next(gen))       # 2
print(next(gen))       # 3
# print(next(gen))     # 报错：StopIteration（生成完毕）

# 生成器可以直接用于 for 循环
for num in count_up_to(5):
    print(num, end=' ')  # 1 2 3 4 5
```

**生成器表达式**（类似推导式，但用圆括号）：

```python
# 推导式 → 一次性生成列表（占用内存）
squares_list = [x**2 for x in range(1000000)]

# 生成器表达式 → 惰性生成，节省内存
squares_gen = (x**2 for x in range(1000000))
print(next(squares_gen))  # 0
print(next(squares_gen))  # 1
```

> `range()` 本质上就是一个惰性序列，它的行为类似生成器，在 Python 3 中不会一次性创建列表。

## 7. match-case 结构模式匹配

Python 3.10+ 引入的 `match-case` 语句，比 if-elif-else 链更强大、更易读：

```python
# 基础匹配
status = 404
match status:
    case 200:
        print("请求成功")
    case 404:
        print("页面未找到")
    case 500:
        print("服务器错误")
    case _:               # _ 是通配符，匹配所有情况
        print("其他状态")

# 数据结构解构匹配
point = (1, 0)
match point:
    case (0, 0):
        print("原点")
    case (0, y):
        print(f"在 Y 轴上，y={y}")
    case (x, 0):
        print(f"在 X 轴上，x={x}")
    case (x, y):
        print(f"坐标：({x}, {y})")
# 输出：在 X 轴上，x=1

# 字典匹配与 guard 条件
user = {"name": "张三", "age": 18}
match user:
    case {"name": name, "age": age} if age >= 18:
        print(f"{name}已是成年人")
    case {"name": name}:
        print(f"{name}信息不完整")
```

## 8. map() 与 filter()

`map()` 和 `filter()` 是 Python 函数式编程的基础工具：

```python
# map() — 对每个元素应用函数
nums = [1, 2, 3, 4]
squares = list(map(lambda x: x**2, nums))
print(squares)  # [1, 4, 9, 16]

# filter() — 按条件过滤元素
evens = list(filter(lambda x: x % 2 == 0, nums))
print(evens)    # [2, 4]
```

> 说明：推导式通常比 `map()`/`filter()` 更 Pythonic、更易读，但 `map()`/`filter()` 返回的是惰性迭代器，适合搭配大数据管道使用。

## 9. 解包运算符 * 和 **（函数调用侧）

笔记 4.4 中介绍了 `*args` 和 `**kwargs` 用于函数**定义**，其实 `*` 和 `**` 也可以在函数**调用**时解包序列/字典：

```python
def greet(name, age):
    print(f"{name}今年{age}岁")

# * 解包列表/元组
info = ["张三", 18]
greet(*info)  # 等价于 greet("张三", 18)

# ** 解包字典
info_dict = {"name": "李四", "age": 20}
greet(**info_dict)  # 等价于 greet(name="李四", age=20)
```

## 10. f-string 高级格式化

f-string 不仅支持变量插入，还支持表达式、格式化说明符和调试模式：

```python
name = "张三"
age = 18
score = 92.567

# 表达式嵌入
print(f"{name}明年{age + 1}岁")

# 数字格式化（宽度、精度、补零）
print(f"PI ≈ {3.1415926:.2f}")   # PI ≈ 3.14
print(f"学号：{15:04d}")          # 学号：0015
print(f"得分：{score:.1f}分")     # 得分：92.6分

# 对齐与填充
print(f"{'标题':*^20}")           # ********标题********

# 调试速记（Python 3.8+）
print(f"{name=}, {age=}")         # name='张三', age=18
```

## 11. collections.defaultdict — 带默认值的字典

普通字典访问不存在的 key 会报 `KeyError`，而 `defaultdict` 在 key 不存在时会**自动用工厂函数创建默认值**，省去手动初始化的麻烦：

```python
from collections import defaultdict

# 场景1：分组（默认值为空列表）
mp = defaultdict(list)
words = ["eat", "tea", "tan"]
for w in words:
    key = "".join(sorted(w))
    mp[key].append(w)      # key 不存在时自动创建 []，无需 if key not in mp
print(dict(mp))            # {'aet': ['eat', 'tea'], 'ant': ['tan']}

# 场景2：计数（默认值为 0）
counter = defaultdict(int)
for ch in "abracadabra":
    counter[ch] += 1       # 首次访问自动初始化为 0
print(dict(counter))       # {'a': 5, 'b': 2, 'r': 2, 'c': 1, 'd': 1}

# 场景3：集合去重（默认值为空集合）
mp = defaultdict(set)
mp["a"].add(1)
mp["a"].add(1)             # 自动去重
print(dict(mp))            # {'a': {1}}
```

常见工厂函数：`list`（空列表）、`int`（0）、`set`（空集合）、`float`（0.0）、`str`（空字符串）、自定义 `lambda: "默认值"`。

## 12. 常用内置函数补充

### ord() 与 chr() — 字符与码点互转

```python
print(ord("a"))   # 97  — 字符 → Unicode 码点
print(ord("中"))  # 20013
print(chr(97))    # 'a' — 码点 → 字符
print(chr(20013)) # '中'

# 常见用法：将字母映射到 0~25
for ch in "abc":
    print(ord(ch) - ord("a"))  # 0, 1, 2
```

> `ord(ch) - ord("a")` 是 LeetCode 字母类题目的经典技巧，将 `'a'~'z'` 映射为数组下标 `0~25`。

### 列表 * 运算符 — 快速创建重复元素列表

```python
print([0] * 5)        # [0, 0, 0, 0, 0]
print([1, 2] * 3)     # [1, 2, 1, 2, 1, 2]

# 常见用法：创建固定长度的计数数组
counts = [0] * 26     # 26 个 0，用于统计字母频率
```

> ⚠️ `*` 复制的是引用。如果元素是可变对象（如 `[[]] * 3`），三个子列表指向同一对象，修改一个会影响全部。对不可变元素（`int`、`str`、`tuple`）则安全。

