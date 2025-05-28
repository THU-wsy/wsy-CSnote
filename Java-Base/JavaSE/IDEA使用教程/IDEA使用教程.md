# 第01章_IDEA简介

## 1. 简介

IDEA，全称`IntelliJ IDEA`，是 Java 语言的集成开发环境，它是JetBrains公司的产品。该公司成立于2000年，总部位于捷克的布拉格，致力于为开发者打造最高效智能的开发工具。公司旗下还有其它产品，比如：

* WebStorm：用于开发 JavaScript、HTML5、CSS3 等前端技术
* PyCharm：用于开发 python
* PhpStorm：用于开发 PHP
* RubyMine：用于开发 Ruby/Rails
* AppCode：用于开发 Objective - C/Swift
* CLion：用于开发 C/C++
* DataGrip：用于开发数据库和 SQL
* Rider：用于开发.NET
* GoLand：用于开发 Go

## 2. IDEA卸载

（1）在控制面板卸载IDEA

![image-20240925180820346](images/image-20240925180820346.png)

（2）注册表清理：按`windows+R`后输入`regedit`，依次点击`计算机\HKEY_CURRENT_USER\Software\JavaSoft\Prefs\jetbrains`，然后右键删除

![image-20240925183859192](images/image-20240925183859192.png)

（3）还有几个地方的缓存数据需要删除：

```shell
C:\用户\${用户名称}\IdeaProjects\
# 如果你想删除 IDEA 相关，则只需要删除 JetBrains 目录下包含 IDEA 的文件夹即可
C:\用户\${用户名称}\AppData\Roaming\JetBrains
# 如果你想删除 IDEA 相关，则只需要删除 JetBrains 目录下包含 IDEA 的文件夹即可
C:\用户\${用户名称}\AppData\Local\JetBrains
C:\用户\公用\.jetbrains
# 如果你想删除 IDEA 相关，则只需要删除 JetBrains 目录下包含 IDEA 的文件夹即可
C:\Program Files\JetBrains
```

（4）如果以前执行过破解IDEA的脚本，则需要进行卸载。例如，以前把破解脚本保存在`D:\jetbra`下，则需要执行其中的`uninstall-all-users.vbs`和`uninstall-current-user.vbs`来进行卸载，然后将`D:\jetbra`文件夹删除即可。

## 3. IDEA安装

可以参考"犬小哈教程"来安装IDEA破解版 https://www.quanxiaoha.com/idea-pojie/idea-pojie-202414.html



# 第02章_IDEA配置

## 1. JDK配置

`File-->Project Structure`

![image-20240925205414604](images/image-20240925205414604.png)

## 2. 个性化配置

`File-->Settings`

### 2.1 关闭IDEA版本的自动更新

![image-20240925210157426](images/image-20240925210157426.png)

### 2.2 调整字体大小

![image-20240925210440847](images/image-20240925210440847.png)

### 2.3 代码提示忽略大小写

![image-20240925210659809](images/image-20240925210659809.png)

### 2.4 自动导包

![image-20240925210854955](images/image-20240925210854955.png)

### 2.5 设置utf-8编码

![image-20240925211006253](images/image-20240925211006253.png)

![image-20240925211133978](images/image-20240925211133978.png)

### 2.6 自定义类头的文档注释信息

![image-20240925211938985](images/image-20240925211938985.png)

```java
/**
 * @author THU-wsy
 * @date ${DATE} ${TIME}
 * @description
 */
```

### 2.7 关闭双击shift搜索

![image-20240925212350739](images/image-20240925212350739.png)

## 3. 代码模板

### 3.1 后缀补全模板

![image-20240925213319202](images/image-20240925213319202.png)

### 3.2 实时模板

![image-20240925213626669](images/image-20240925213626669.png)

### 3.3 常用的代码模板

#### 1、非空判断

* `变量.null`：`if (变量 == null)`
* `变量.nn`：`if (变量 != null)`
* `ifn`：`if (xx == null)`
* `inn`：`if (xx != null)`

#### 2、遍历数组和集合

* `数组或集合变量.fori`：for循环
* `数组或集合变量.forr`：反向for循环
* `数组或集合变量.for`：增强for循环

#### 3、输出语句

- `sout`：相当于`System.out.println`
- `变量.sout`：打印当前变量值

#### 4、对象操作

- `Xxx.new .var`：创建Xxx类的对象，并赋给相应的变量

#### 5、静态常量声明

* `psf`：public static final
* `psfi`：public static final int
* `psfs`：public static final String
* `prsf`：private static final

### 3.4 自定义代码模板

（1）在Live Templates中先创建一个模板组，便于管理所有自定义的代码模板

![image-20240925215604707](images/image-20240925215604707.png)

（2）选中模板组，然后在模板组里新建代码模板

![image-20240925215802859](images/image-20240925215802859.png)

（3）自定义代码模板，我们以定义一个单元测试的模板为例：

![image-20240925220521714](images/image-20240925220521714.png)

## 4. 快捷键设置

设置使用windows平台的快捷键

![image-20240926132402283](images/image-20240926132402283.png)

## 5. Maven配置

![image-20240926134607557](images/image-20240926134607557.png)



# 第03章_IDEA常用插件

## 1. MyBatisX

## 2. GenerateAllSetter



# 第04章_IDEA常用快捷键

## 1. 通用型

| 说明            | 快捷键           |
| --------------- | ---------------- |
| 复制-copy       | ctrl + c         |
| 粘贴-paste      | ctrl + v         |
| 剪切-cut        | ctrl + x         |
| 撤销-undo       | ctrl + z         |
| 反撤销-redo     | ctrl + shift + z |
| 保存-save all   | ctrl + s         |
| 全选-select all | ctrl + a         |

## 2. 提高编写速度

| 说明                                               | 快捷键           |
| -------------------------------------------------- | ---------------- |
| 智能提示-edit                                      | alt + enter      |
| 使用xx块环绕-surround with ...                     | ctrl+alt+t       |
| 调出生成getter/setter/构造器等结构-generate ...    | alt+insert       |
| 复制指定行的代码-duplicate line or selection       | ctrl+d           |
| 切换到下一行代码空位-start new line                | shift + enter    |
| 切换到上一行代码空位-start new line before current | ctrl +alt+ enter |
| 向上移动代码-move statement up                     | ctrl+shift+↑     |
| 向下移动代码-move statement down                   | ctrl+shift+↓     |
| 向上移动一行-move line up                          | alt+shift+↑      |
| 向下移动一行-move line down                        | alt+shift+↓      |
| 方法的形参列表提醒-parameter info                  | ctrl+p           |
| 批量修改指定的变量名、方法名、类名等-rename        | shift+f6         |
| 抽取代码重构方法-extract method ...                | ctrl+alt+m       |
| 重写父类的方法-override methods ...                | ctrl+o           |
| 实现接口的方法-implements methods ...              | ctrl+i           |
| 选中内容的大小写的切换-toggle case                 | ctrl+shift+u     |
| 批量导包-optimize imports                          | ctrl+alt+o       |

## 3. 类结构、查找和查看源码

| 说明                                                      | 快捷键                          |
| --------------------------------------------------------- | ------------------------------- |
| 如何查看源码-go to class...                               | ctrl + 选中指定的结构 或 ctrl+n |
| 显示当前类结构，支持搜索指定的方法、属性等-file structure | ctrl+f12                        |
| 退回到前一个编辑的页面-back                               | ctrl+alt+←                      |
| 进入到下一个编辑的页面-forward                            | ctrl+alt+→                      |
| 光标选中指定的类，查看继承树结构-Type Hierarchy           | ctrl+h                          |
| 类的UML关系图-show uml popup                              | ctrl+alt+u                      |
| 定位某行-go to line/column                                | ctrl+g                          |
| 折叠方法实现-collapse all                                 | ctrl+shift+ -                   |
| 展开方法实现-expand all                                   | ctrl+shift+ +                   |

## 4. 查找、替换与关闭

| 说明                                            | 快捷键       |
| ----------------------------------------------- | ------------ |
| 查找指定的结构                                  | ctlr+f       |
| 快速查找：选中的Word快速定位到下一个-find next  | ctrl+l       |
| 查找与替换-replace                              | ctrl+r       |
| 直接定位到当前行的首位-move caret to line start | home         |
| 直接定位到当前行的末位 -move caret to line end  | end          |
| 全项目搜索文本-find in path ...                 | ctrl+shift+f |

## 5. 调整格式

| 说明                                         | 快捷键           |
| -------------------------------------------- | ---------------- |
| 格式化代码-reformat code                     | ctrl+alt+l       |
| 使用单行注释-comment with line comment       | ctrl + /         |
| 使用/取消多行注释-comment with block comment | ctrl + shift + / |
| 选中数行，整体往后移动-tab                   | tab              |
| 选中数行，整体往前移动-prev tab              | shift + tab      |
