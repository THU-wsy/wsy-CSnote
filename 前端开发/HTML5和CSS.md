# 第1章 HTML基础

> **HTML:** HyperText Markup Language，超文本标记语言。
>
> - 超文本：超越了文本的限制，比普通文本更强大。除了文字信息，还可以定义图片、音频、视频等内容。
>
> - 标记语言：由标签构成的语言
>   - HTML标签都是预定义好的。
>   - HTML代码直接在浏览器中运行，HTML标签由浏览器解析。


## 1.1 基础语法

### 1.1.1 注释

**添加 / 删除**注释的快捷键：**Ctrl + /** 

```html
<!-- 我是 HTML 注释 -->
```

### 1.1.2 标题标签

```html
<h1>一级标题</h1>
<h2>二级标题</h2>
<h3>三级标题</h3>
<h4>四级标题</h4>
<h5>五级标题</h5>
<h6>六级标题</h6>
```

注：h1 标签在一个网页中只能用一次

### 1.1.3 段落标签

```html
<p>段落</p>
```

显示特点：

* 独占一行
* 段落之间存在间隙

### 1.1.4 换行和水平线

```html
<br> <!-- 换行 -->
<hr> <!-- 水平线 -->
```

### 1.1.5 文本格式化标签

`strong`：加粗
`em`：倾斜
`ins`：下划线
`del`：删除线

### 1.1.6 图像标签

```html
<img src="图片的URL" title="这是一张图片">
```

#### 图像属性

- alt：替换文本，图片无法显示的时候显示的文字
- title：提示文本，鼠标悬停在图片上面的时候显示的文字

### 1.1.7 超链接标签

```html
<a href="https://www.baidu.com">跳转到百度</a>
```

**href 属性值是跳转地址，是超链接的必须属性。**

- 超链接默认是在当前窗口跳转页面(即 `target="_self"`)，添加 **`target="_blank"`** 实现**新窗口**打开页面。
- 开发初期，不确定跳转地址，则 href 属性值写为 **#**，表示**空链接**，页面不会跳转，在当前页面刷新一次。
- 可以添加CSS样式 text-decoration：规定添加到文本的修饰，none表示定义标准的文本。可以用这种方式来去除超链接的下划线。

### 1.1.8 音频

```html
<audio src="音频的URL"></audio>
```

**常用属性** ：
- controls：显示音频控制面板
- loop：循环播放
- autoplay：自动播放，一般浏览器禁止自动播放

### 1.1.9 视频

```html
<video src="视频的URL"></video>
```

**常用属性** ：
- controls：显示视频控制面板
- loop：循环播放
- muted：静音播放
- autoplay：自动播放，一般浏览器最好只支持在静音状态下自动播放



### 1.1.10 其他

#### 无语义的布局标签

- div：一行只显示一个，独占一行。宽度默认是父元素的宽度，高度默认由内容撑开，可以设置宽高（width、height）。
- span：不换行，一行可以显示多个。宽度和高度默认由内容撑开，不可以设置宽高（width、height）。

#### 有语义的布局标签

- header：网页头部
- nav：网页导航
- footer：网页底部
- aside：网页侧边栏
- section：网页区块
- article：网页文章

#### 字符实体

|显示结果|描述|实体名称|
|---|---|---|
| |空格|\&nbsp\;|
|\< |小于号|\&lt\;|
|\> |大于号|\&gt\;|

#### iframe标签

iframe标签可以在网页上开辟一个小区域显示一个单独的页面。可以与a标签组合使用：
- 在iframe标签中使用name属性定义一个名称
- 在a标签的target属性上设置iframe的name的属性值

```html
<iframe src="./test2.html" frameborder="1" name="abc"></iframe>
<a href="./test1.html" target="abc">链接1</a>
<a href="./test2.html" target="abc">链接2</a>
```

## 1.2 列表

### 1.2.1 无序列表

作用：布局排列整齐的**不需要规定顺序**的区域。

标签：ul 嵌套 li，ul 是无序列表，li 是列表条目。

```html
<ul>
  <li>第一项</li>
  <li>第二项</li>
  <li>第三项</li>
  ……
</ul>
```

> 注意事项：
>
> * ul 标签里面只能包裹 li 标签
> * li 标签里面可以包裹任何内容


### 1.2.2 有序列表

作用：布局排列整齐的**需要规定顺序**的区域。

标签：ol 嵌套 li，ol 是有序列表，li 是列表条目。

```html
<ol>
  <li>第一项</li>
  <li>第二项</li>
  <li>第三项</li>
  ……
</ol>
```

> 注意事项：
>
> * ol 标签里面只能包裹 li 标签
> * li 标签里面可以包裹任何内容

### 1.2.3 定义列表

标签：dl 嵌套 dt 和 dd，dl 是定义列表，dt 是定义列表的标题，dd 是定义列表的描述 / 详情。

```html
<dl>
  <dt>列表标题</dt>
  <dd>列表描述 / 详情</dd>
   ……
</dl>
```

> 注意事项：
>
> * dl 里面只能包含dt 和 dd
> * dt 和 dd 里面可以包含任何内容


## 1.3 表格

### 1.3.1 基本使用

标签：table 嵌套 tr，tr 嵌套 td / th。table指表格，tr指行，th指表头单元格，td指内容单元格。

> 提示：在网页中，**表格默认没有边框线**，使用 **border 属性**可以为表格添加边框线，单位px表示边框的宽度。table中的属性值还可以有 width：规定表格的宽度，cellspacing: 规定单元之间的空间。

```html
<table border="1px">
  <tr>
    <th>姓名</th>
    <th>语文</th>
    <th>数学</th>
    <th>总分</th>
  </tr>
  <tr>
    <td>张三</td>
    <td>99</td>
    <td>100</td>
    <td>199</td>
  </tr>
  <tr>
    <td>李四</td>
    <td>98</td>
    <td>100</td>
    <td>198</td>
  </tr>
  <tr>
    <td>总结</td>
    <td>全市第一</td>
    <td>全市第一</td>
    <td>全市第一</td>
  </tr>
</table>
```


### 1.3.2 合并单元格


合并单元格的步骤：

1. 明确合并的目标
2. 保留**最左最上**的单元格，添加属性（取值是**数字**，表示需要**合并的单元格数量**）
   * **跨行合并**，保留最上单元格，添加属性 **rowspan**
   * **跨列合并**，保留最左单元格，添加属性 **colspan**
3. 删除其他单元格

```html
<table border="1">
  <thead>
    <tr>
      <th>姓名</th>
      <th>语文</th>
      <th>数学</th>
      <th>总分</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>张三</td>
      <td>99</td>
      <td rowspan="2">100</td>
      <td>199</td>
    </tr>
    <tr>
      <td>李四</td>
      <td>98</td>
      <!-- <td>100</td> -->
      <td>198</td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td>总结</td>
      <td colspan="3">全市第一</td>
      <!-- <td>全市第一</td>
      <td>全市第一</td> -->
    </tr>
  </tfoot>
</table>
```


## 1.4 表单

### 1.4.1 表单标签：form

表单区域必须用`表单标签 form`包裹

```html
<form action="" method="">

</form>
```

**属性**：

- action: 规定表单提交时，表单提交的服务器地址，即表单提交的URL。如果不指定，默认提交到当前页面。
- method: 规定用于发送表单数据的方式，常见为：get(默认)、post。

**GET请求的特点**：

- 浏览器地址栏格式：`xxxxxxxxxxx?name=value&name=value`，其中`?`前的是action的属性值，`?`后的是请求参数。
- 不安全(地址栏可能显示出密码等信息)
- 数据长度有限制

**POST请求的特点**：

- 浏览器地址栏中只有action的属性值
- 相对于GET更安全
- 表单数据是在请求体（消息体）中携带的，理论上数据长度没有限制

**表单提交的时候，数据能发送给服务器的三个必要条件**：

1. **表单项标签必须要有name属性值**
2. **单选、复选、隐藏域、下拉菜单中的option标签，都必须添加value属性**，以便发送给服务器
3. 要提交的表单项必须在该form标签中


示例：
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form action="http://localhost:8080" method="get">
        <table align="center">
            <tr>
                <td>用户名称：</td>
                <td>
                    <input type="text" name="username" value="默认值">
                </td>
            </tr>
            <tr>
                <td>用户密码：</td>
                <td>
                    <input type="password" name="password" value="default">
                </td>
            </tr>
            <tr>
                <td>性别：</td>
                <td>
                    <input type="radio" name="sex" value="boy" checked>男
                    <input type="radio" name="sex" value="girl">女
                </td>
            </tr>
            <tr>
                <td>兴趣爱好：</td>
                <td>
                    <input type="checkbox" name="hobby" checked value="java">java
                    <input type="checkbox" name="hobby" value="cpp">c++
                    <input type="checkbox" name="hobby" value="py">python
                </td>
            </tr>
            <tr>
                <td>国籍：</td>
                <td>
                    <select name="country">
                        <option value="none">无</option>
                        <option value="cn" selected>中国</option>
                        <option value="usa">美国</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>自我评价：</td>
                <td>
                    <textarea name="desc" cols="20" rows="10">
                    </textarea>
                </td>
            </tr>
            <tr>
                <td><button type="reset">重置</button></td>
                <td><button type="submit">提交</button></td>
            </tr>
        </table>
    </form>
</body>
</html>
```

浏览器打开上述html文件，输入信息点击提交后，地址栏会得到

```
http://localhost:8080/?username=wsy&password=123456&sex=boy&hobby=java&hobby=cpp&country=cn&desc=666++++++++++++++++++++
```
其中`?`是分隔符，前面是表单action属性中填写的url地址，后面是服务器端收到的数据。

### 1.4.2 表单项标签：input标签

```html
<input type="属性">
```

|type属性值|说明|
|---|---|
|text|单行文本框，可以使用placeholder|
|password|密码框，可以使用placeholder|
|radio|单选框|
|checkbox|多选框|
|file|上传文件|
|hidden|隐藏域|

- text和password可以添加placeholder="提示信息"
- radio根据name(表示控件分组，同组只能选中一个)实现单选功能，添加checked表示默认选中。
- checkbox可以添加checked表示默认选中。
- file可以添加multiple实现文件多选功能。
- hidden是表单隐藏域，通过表单隐藏域设置的表单项不会显示到页面上，用户看不到。但是提交表单时会一起被提交。通常用来设置一些需要和表单一起提交但是不希望用户看到的数据，例如用户id等等，所以需要添加value属性值。

**注意**：

- **input标签必须添加name属性值**
- **radio、checkbox和hidden还必须添加value属性值**

### 1.4.3 表单项标签：select标签

下拉菜单：select嵌套option，select是下拉菜单整体，option是下拉菜单的每一项(需要默认选中的一项只需在option标签中添加selected即可)。

举例：

```html
  <select name="hobby">
      <option value="cpp">cpp</option>
      <option value="java">java</option>
      <option value="js">javascript</option>
  </select>
```

**注意**：

- **select标签必须添加name属性值，而option标签必须添加value属性值**


### 1.4.4 表单项标签：textarea标签

文本域标签textarea，可以实现多行输入的文本框。textarea没有value属性，如果要设置默认值需要写在开始和结束标签之间。

> 注意点：
>
> * 实际开发中，使用 CSS 设置 文本域的尺寸
> * 实际开发中，一般禁用右下角的拖拽功能

**注意**：

- **textarea标签必须添加name属性值**


### 1.4.5 按钮：button标签

```html
<button type="属性">提交</button>
```

|type属性值|说明|
|---|---|
|submit|提交按钮，点击后可以提交数据到后台(默认功能)|
|reset|重置按钮，点击后将表单控件恢复默认值|
|button|普通按钮，默认没有功能，一般配合JavaScript使用|

> 提示：按钮需配合 form 标签（表单区域）才能实现对应的功能。按钮无需添加name或value属性。


### 1.4.6 补充：label标签

label标签主要用于绑定文字和表单控件的关系，来增大表单控件的点击范围(直接用label包裹文字和表单控件即可，无需添加属性)。

```html
<label><input type="radio"> 女</label>
```


# 第2章 CSS基础

层叠样式表(Cascading Style Sheets, CSS)是一种样式表语言，用来美化HTML的内容。CSS引入HTML的方式有以下三种：
- 内部样式表：在html文件的title标签下方添加style双标签，里面书写CSS代码
- 外部样式表：CSS代码单独写在.css文件中，在html文件中使用link标签引入
```html
<link rel="stylesheet" href="./test.css">
```
- 行内样式：一般配合JavaScript使用。将CSS写在标签的style属性中
```html
<p style="color: red; font-size: 20px;">内容</p>
```

常见属性：
|属性名|作用|
|---|---|
|color|字体颜色|
|font-size|字体大小，PC端网页常用单位为px，浏览器默认字体大小一般为16px|
|width|盒子宽度|
|height|盒子高度|
|background-color|背景色|
|font-weight|字体粗细，400表示不加粗，700表示加粗|
|font-style|字体倾斜，normal表示不倾斜，italic表示倾斜|
|line-height|设置行高，单位px(如果不加单位，则表示font-size的倍数)。若行高等于盒子高度，则能实现文字垂直居中的效果。|
|font-family|字体族，写字体名即可，如楷体|
|font|字体复合属性，分别是是否倾斜、是否加粗、字号/行高、字体，中间用空格隔开|
|text-indent|文本缩进，一般写2em|
|text-align|文本对齐，left是左对齐、right是右对齐、center是居中对齐|
|text-decoration|修饰线，none表示无修饰线、underline表示下划线、line-through表示删除线、overline表示上划线|

注：样式的显示和隐藏，display: none 表示隐藏元素，display: block 表示显示元素。

## 2.1 基础选择器

选择器的作用是查找标签、设置样式。基础选择器有标签选择器、类选择器、id选择器、通配符选择器。

### 2.1.1 标签选择器

使用标签名作为选择器，从而选中同名标签设置相同的样式。
```html
<style>
    p {
        color: red;
    }
</style>
```

### 2.1.2 类选择器

查找标签，差异化设置标签的显示效果。步骤：
- 定义类选择器(.类名)
- 使用类选择器，标签添加class="类名"(class属性里可以写多个类名)

```html
<style>
    .red {
        color: red;
    }
    .big {
        font-size: 30px;
    }
</style>

<div class="red big">内容</div>
```

### 2.1.3 id选择器

查找标签，差异化设置标签的显示效果，id选择器一般配合JavaScript使用，很少用来设置CSS样式。步骤：
- 定义id选择器(#id名)
- 使用id选择器，标签添加id="id名"

注意同一个id选择器在一个页面只能使用一次

```html
<style>
    #red {
        color: red;
    }
</style>

<div id="red">内容</div>
```

### 2.1.4 通配符选择器

查找页面所有标签，设置相同样式。

```html
<style>
    * {
        color: red;
    }
</style>
```

> 经验：通配符选择器可以用于**清除标签的默认样式**，例如：标签默认的外边距、内边距。



## 2.2 复合选择器

定义：由两个或多个基础选择器，通过不同的方式组合而成。

作用：更准确、更高效的选择目标元素（标签）。

### 2.2.1 后代选择器

后代选择器：**选中某元素的后代元素**。

选择器写法：`父选择器 子选择器 { CSS 属性}`，父子选择器之间用**空格**隔开。

```html
<style>
  div span {
    color: red;
  }
</style>
  <span> span 标签</span>
<div>
  <span>这是 div 的儿子 span</span >
</div>
```

### 2.2.2 子代选择器

子代选择器：选中某元素的子代元素（**最近的子级**）。

选择器写法：`父选择器 > 子选择器 { CSS 属性}`，父子选择器之间用 **>** 隔开。

```html
<style>
  div > span {
    color: red;
  }
</style>

<div>
  <span>这是 div 里面的 span</span>
  <p>
    <span>这是 div 里面的 p 里面的 span</span>
  </p>
</div>
```

### 2.2.3 并集选择器

并集选择器：选中**多组标签**设置**相同**的样式。

选择器写法：`选择器1, 选择器2, …, 选择器N { CSS 属性}`，选择器之间用 **,** 隔开。

```html
<style>
  div,
  p,
  span {
    color: red;
  }
</style>

<div> div 标签</div>
<p>p 标签</p>
<span>span 标签</span>
```

### 2.2.4 交集选择器 

交集选择器：选中**同时满足多个条件**的元素。

选择器写法：`选择器1选择器2 { CSS 属性}`，选择器之间连写，没有任何符号。

```html
<style>
  p.box {
  color: red;
}
</style>

<p class="box">p 标签，使用了类选择器 box</p>
<p>p 标签</p>
<div class="box">div 标签，使用了类选择器 box</div>
```

> 注意：如果交集选择器中有标签选择器，标签选择器必须书写在最前面。 

### 2.2.5 伪类选择器 

伪类选择器：伪类表示元素**状态**，选中元素的某个状态设置样式。

鼠标悬停状态：`选择器:hover { CSS 属性 }`

```html
<style>
  a:hover {
    color: red;
  }
  .box:hover {
    color: green;
  }
</style>

<a href="#">a 标签</a>
<div class="box">div 标签</div>
```

#### 超链接伪类

|选择器|作用|
|---|---|
|:link|访问前|
|:visited|访问后|
|:hover|鼠标悬停|
|:active|点击时(激活)|

> 提示：如果要给超链接设置以上四个状态，需要按 LVHA 的顺序书写。 
>
> 经验：工作中，一个 a 标签选择器设置超链接的样式，hover状态特殊设置 

```css
a {
  color: red;
}

a:hover {
  color: green;
}
```

## 2.3 CSS特性

CSS特性：化简代码 / 定位问题，并解决问题

* 继承性
* 层叠性
* 优先级

### 2.3.1 继承性

继承性：子级默认继承父级的**文字控制属性**。 

> 注意：如果标签有默认文字样式会继承失败。 例如：a 标签的颜色、标题的字体大小。

### 2.3.2 层叠性

特点：

* 相同的属性会覆盖：**后面的 CSS 属性覆盖前面的 CSS 属性**
* 不同的属性会叠加：**不同的 CSS 属性都生效**

```html
<style>
  div {
    color: red;
    font-weight: 700;
  }
  div {
    color: green;
    font-size: 30px;
  }
</style>

<div>div 标签</div>
```

> 注意：选择器类型相同则遵循层叠性，否则按选择器优先级判断。 

### 2.3.3 优先级

优先级：也叫权重，当一个标签**使用了多种选择器时**，基于不同种类的选择器的**匹配规则**。

```html
<style>
  div {
    color: red;
  }
  .box {
    color: green;
  }
</style>

<div class="box">div 标签</div>
```

#### 基础选择器

规则：选择器**优先级高的样式生效**。

公式：**通配符选择器 < 标签选择器 < 类选择器 < id选择器 < 行内样式 < !important**

**（选中标签的范围越大，优先级越低）**

#### 复合选择器-叠加

叠加计算：如果是复合选择器，则需要**权重叠加**计算。

公式：（每一级之间不存在进位）

```
(行内样式，id选择器个数，类选择器个数，标签选择器个数)
```

规则：

* 从左向右依次比较选个数，同一级个数多的优先级高，如果个数相同，则向后比较
* **!important 权重最高**
* 继承权重最低


## 2.4 背景属性

### 2.4.1 背景图

网页中，使用背景图实现装饰性的图片效果。

* 属性名：**background-image**（bgi）
* 属性值：url(背景图 URL)

```css
div {
  width: 400px;
  height: 400px;

  background-image: url(./images/1.png);
}
```

> 提示：背景图默认有**平铺（复制）效果**。 

### 2.4.2 平铺方式

属性名：**background-repeat**（bgr） 

|属性值|效果|
|---|---|
|no-repeat|不平铺|
|repeat|平铺|
|repeat-x|水平方向平铺|
|repeat-y|垂直方向平铺|

```css
div {
  width: 400px;
  height: 400px;
  background-color: pink;
  background-image: url(./images/1.png);

  background-repeat: no-repeat;
}
```

### 2.4.3 背景图位置

属性名：**background-position**（bgp）

属性值：水平方向位置 垂直方向位置

* 关键字

|关键字|位置|
|---|---|
|left|左侧|
|right|右侧|
|center|居中|
|top|顶部|
|bottom|底部|

* 坐标
  * 水平：正数向右；负数向左
  * 垂直：正数向下；负数向上

```css
div {
  width: 400px;
  height: 400px;
  background-color: pink;
  background-image: url(./images/1.png);
  background-repeat: no-repeat;

  background-position: center bottom;
  background-position: 50px -100px;
  background-position: 50px center;
}
```

> 提示：
>
> * 关键字取值方式写法，可以颠倒取值顺序
> * 可以只写一个关键字，另一个方向默认为居中；数字只写一个值表示水平方向，垂直方向为居中

### 2.4.4 背景图缩放

作用：设置背景图大小

属性名：**background-size**（bgz）

常用属性值：

* 关键字
  *  cover：等比例缩放背景图片以完全覆盖背景区，可能背景图片部分看不见
  * contain：等比例缩放背景图片以完全装入背景区，可能背景区部分空白

* 百分比：根据盒子尺寸计算图片大小
* 数字 + 单位（例如：px）

```css
div {
  width: 500px;
  height: 400px;
  background-color: pink;
  background-image: url(./images/1.png);
  background-repeat: no-repeat;
  
  background-size: cover;
  background-size: contain;
}
```

> 提示：工作中，**图片比例与盒子比例相同**，使用 cover 或 contain 缩放背景图效果相同。

### 2.4.5 背景图固定

作用：背景不会随着元素的内容滚动。

属性名：**background-attachment**（bga）

属性值：**fixed**

```css
body {
  background-image: url(./images/bg.jpg);
  background-repeat: no-repeat;
  background-attachment: fixed;
}
```

### 2.4.6 背景复合属性

属性名：**background**（bg）

属性值：背景色 背景图 背景图平铺方式 背景图位置/背景图缩放  背景图固定（**空格隔开各个属性值，不区分顺序**）

```css
div {
  width: 400px;
  height: 400px;

  background: pink url(./images/1.png) no-repeat right center/cover;
}
```

## 2.5 显示模式

显示模式：标签（元素）的显示方式。 

作用：布局网页的时候，根据标签的显示模式选择合适的标签摆放内容。 

### 2.5.1 块级元素

特点：

* 独占一行
* 宽度默认是父级的100%
* 添加宽高属性生效

### 2.5.2 行内元素

特点：

* 一行可以显示多个
* 设置宽高属性不生效
* 宽高尺寸由内容撑开

### 2.5.3 行内块元素 

特点：

* 一行可以显示多个
* 设置宽高属性生效
* 宽高尺寸也可以由内容撑开


### 2.5.4 转换显示模式

属性：**display**

|属性值|效果|
|---|---|
|block|块级|
|inline|行内|
|inline-block|行内块|


## 2.6 选择器进阶

### 2.6.1 结构伪类选择器 

作用：根据元素的**结构关系**查找元素。 

|选择器|说明|
|---|---|
|E:first-child|查找第一个E元素|
|E:last-child|查找最后一个E元素|
|E:nth-child(N)|查找第N个E元素(第一个元素N值为1)|

```css
li:first-child {
  background-color: green;
}
```


### 2.6.2 伪元素选择器 

作用：创建**虚拟元素**（伪元素），用来**摆放装饰性的内容**。 

|选择器|说明|
|---|---|
|E::before|在E元素里面最前面添加一个伪元素|
|E::after|在E元素里面最后面添加一个伪元素|


```css
div::before {
  content: "before 伪元素";
}
div::after {
  content: "after 伪元素";
}
```

注意点：

* 必须设置 **content: ""属性**，用来 设置伪元素的内容，如果没有内容，则**引号留空**即可
* 伪元素默认是**行内**显示模式
* **权重和标签选择器相同**


# 第3章 CSS进阶

## 3.1 盒子模型

作用：布局网页，摆放盒子和内容。

### 3.1.1 盒子模型-组成

* 内容区域(content) – width & height
* 内边距 – padding（出现在内容与盒子边缘之间）
* 边框线 – border 
* 外边距 – margin（出现在盒子外面）

```css
div {
  margin: 50px;
  border: 5px solid brown;
  padding: 20px;
  width: 200px;
  height: 200px;
  background-color: pink;
}
```

![](/zzimages/20230703183149.png)

盒子区域指的就是border包含的区域。

### 3.1.2 边框线

#### 四个方向

属性名：**border**（bd）

属性值：边框线粗细  线条样式  颜色（不区分顺序）

|属性值|线条样式|
|---|---|
|solid|实线|
|dashed|虚线|
|dotted|点线|

```css
div {
  border: 5px solid brown;
  width: 200px;
  height: 200px;
  background-color: pink;
}
```

#### 单方向边框线 

属性名：**border-方位名词**（bd+方位名词首字母，例如，bdl）

属性值：边框线粗细  线条样式  颜色（不区分顺序）

```css
div {
  border-top: 2px solid red;
  border-right: 3px dashed green;
  border-bottom: 4px dotted blue;
  border-left: 5px solid orange;
  width: 200px;
  height: 200px;
  background-color: pink;
}
```

### 3.1.3 内边距 

作用：设置 内容 与 盒子边缘 之间的距离。

* 属性名：padding / padding-方位名词

```css
div {
  /* 四个方向 内边距相同 */
  padding: 30px;
  /* 单独设置一个方向内边距 */
  padding-top: 10px;
  padding-right: 20px;
  padding-bottom: 40px;
  padding-left: 80px;
  width: 200px;
  height: 200px;
  background-color: pink;
}
```

> 提示：添加 padding 会撑大盒子。


### 3.1.4 尺寸计算


默认情况：盒子尺寸 = 内容尺寸 + border 尺寸 + 内边距尺寸

结论：给盒子加 border / padding 会撑大盒子

解决：

* 手动做减法，减掉 border / padding 的尺寸
* 內减模式：**box-sizing: border-box** (指定width height为盒子的宽高)

### 3.1.5 外边距 

作用：拉开两个盒子之间的距离

属性名：**margin**

提示：与 padding 属性值写法、含义相同

### 3.1.6 版心居中


左右 margin 值为 auto（盒子要有宽度）

```css
div {
  margin: 0 auto;
  width: 1000px;
  height: 200px;
  background-color: pink;
}
```

### 3.1.7 清除默认样式 

清除标签默认的样式，比如：默认的内外边距。 

```css
/* 清除默认内外边距 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}
/* 清除列表项目符号 */
li {
  list-style: none;
}
```

### 3.1.8 元素溢出

作用：控制溢出元素的内容的显示方式。

属性名：**overflow**

|属性值|效果|
|---|---|
|hidden|溢出隐藏|
|scroll|溢出滚动(无论是否溢出，都显示滚动条位置)|
|auto|溢出滚动(溢出才显示滚动条位置)|

### 3.1.9 外边距问题

#### 合并现象

场景：**垂直**排列的兄弟元素，上下 **margin** 会**合并**

现象：取两个 margin 中的**较大值生效**

```css
.one {
  margin-bottom: 50px;
}
.two {
  margin-top: 20px;
}
```

#### 外边距塌陷

场景：父子级的标签，子级的添加 **上外边距** 会产生**塌陷**问题

现象：**导致父级一起向下移动**

```css
.son {
  margin-top: 50px;
  width: 100px;
  height: 100px;
  background-color: orange;
}
```

解决方法：

* 取消子级margin，父级设置padding
* 父级设置 overflow: hidden
* 父级设置 border-top

### 3.1.10 行内元素 – 内外边距问题 

场景：行内元素添加 margin 和 padding，无法改变元素垂直位置

解决方法：给行内元素添加 **line-height** 可以改变垂直位置

```css
span {
  /* margin 和 padding 属性，无法改变垂直位置 */
  margin: 50px;
  padding: 20px;
  /* 行高可以改变垂直位置 */
  line-height: 100px;
}
```

### 3.1.11 圆角

作用：设置元素的外边框为圆角。

属性名：**border-radius**

属性值：数字+px / 百分比

提示：属性值是圆角半径



* 正圆形状：给正方形盒子设置圆角属性值为 **宽高的一半 / 50%**

```css
img {
  width: 200px;
  height: 200px;
  
  border-radius: 100px;
  border-radius: 50%;
}
```

* 胶囊形状：给长方形盒子设置圆角属性值为 盒子高度的一半 

```css
div {
  width: 200px;
  height: 80px;
  background-color: orange;
  border-radius: 40px;
}
```

### 3.1.12 盒子阴影（拓展）

作用：给元素设置阴影效果

属性名：**box-shadow**

属性值：X 轴偏移量  Y 轴偏移量  模糊半径  扩散半径  颜色  内外阴影

注意： 

* X 轴偏移量 和 Y 轴偏移量 必须书写
* 默认是外阴影，内阴影需要添加 inset

```css
div {
  width: 200px;
  height: 80px;
  background-color: orange;
  box-shadow: 2px 5px 10px 0 rgba(0, 0, 0, 0.5) inset;
}
```



## 3.2 Flex布局

Flex 布局也叫**弹性布局**，是浏览器**提倡的布局模型**，非常适合**结构化**布局，提供了强大的空间分布和对齐能力。

Flex 模型不会产生浮动布局中脱标现象，布局网页更简单、更灵活。

### 3.2.1 Flex组成

设置方式：给**父**元素设置 **display: flex**，子元素可以自动挤压或拉伸

组成部分：

* 弹性容器
* 弹性盒子
* 主轴：默认在**水平**方向
* 侧轴 / 交叉轴：默认在**垂直**方向

### 3.2.2 主轴对齐方式

属性名：**justify-content**

|属性值|效果|
|---|---|
|flex-start|默认值，弹性盒子从起点开始依次排列|
|flex-end|弹性盒子从终点开始依次排列|
|center|弹性盒子沿主轴居中排列|
|space-between|弹性盒子沿主轴均匀排列，空白间距均分在弹性盒子之间|
|space-around|弹性盒子沿主轴均匀排列，空白间距均分在弹性盒子两侧|
|space-evenly|弹性盒子沿主轴均匀排列，弹性盒子与容器之间间距相等|



### 3.2.3 侧轴对齐方式

* align-items：当前弹性容器内**所有**弹性盒子的侧轴对齐方式（给**弹性容器**设置）
* align-self：单独控制**某个弹性盒子**的侧轴对齐方式（给**弹性盒子**设置）

|属性值|效果|
|---|---|
|stretch|弹性盒子沿着侧轴线被拉伸至铺满容器(弹性盒子没有设置侧轴方向尺寸则默认拉伸)|
|center|弹性盒子沿侧轴居中排列|
|flex-start|弹性盒子从起点开始依次排列|
|flex-end|弹性盒子从终点开始依次排列|


### 3.2.4 修改主轴方向

**主轴默认在水平方向，侧轴默认在垂直方向**

属性名：**flex-direction**

|属性值|效果|
|---|---|
|row|水平方向，从左向右(默认)|
|column|垂直方向，从上向下|
|row-reverse|水平方向，从右向左|
|column-reverse|垂直方向，从下向上|

### 3.2.5 弹性伸缩比

作用：控制弹性盒子的主轴方向的尺寸。

属性名：**flex**

属性值：整数数字，表示占用**父级剩余尺寸的份数**。

### 3.2.6 弹性盒子换行

弹性盒子可以自动挤压或拉伸，默认情况下，所有弹性盒子都在一行显示。

属性名：**flex-wrap**

属性值

* wrap：换行
* nowrap：不换行（默认）

### 3.2.7 行内对齐方式

属性名：**align-content** 

|属性值|效果|
|---|---|
|flex-start|默认值，弹性盒子从起点开始依次排列|
|flex-end|弹性盒子从终点开始依次排列|
|center|弹性盒子沿主轴居中排列|
|space-between|弹性盒子沿主轴均匀排列，空白间距均分在弹性盒子之间|
|space-around|弹性盒子沿主轴均匀排列，空白间距均分在弹性盒子两侧|
|space-evenly|弹性盒子沿主轴均匀排列，弹性盒子与容器之间间距相等|

> 注意：该属性对**单行**弹性盒子模型**无效**。 



## 3.3 定位

作用：灵活的改变盒子在网页中的位置

实现：

1.定位模式：position

2.边偏移：设置盒子的位置

* left
* right
* top
* bottom

### 3.3.1 相对定位

**position: relative**

特点：

* 不脱标，占用自己原来位置
* 显示模式特点保持不变
* 设置边偏移则相对自己原来位置移动

```css
div {
  position: relative;
  top: 100px;
  left: 200px;
}	
```

### 3.3.2 绝对定位

**position: absolute**

使用场景：子级绝对定位，父级相对定位（**子绝父相**）

特点：

* 脱标，不占位
* 显示模式具备行内块特点
* 设置边偏移则相对最近的已经定位的祖先元素改变位置
* 如果祖先元素都未定位，则相对浏览器可视区改变位置

```css
.father {
  position: relative;
}

.father span {
  position: absolute;
  top: 0;
  right: 0;
}
```

### 3.3.3 定位居中

实现步骤：

1. 绝对定位
2. 水平、垂直边偏移为 50%
3. 子级向左、上移动自身尺寸的一半

* 左、上的外边距为 –尺寸的一半
* transform: translate(-50%, -50%)

```css
img {
  position: absolute;
  left: 50%;
  top: 50%;

  /* margin-left: -265px;
  margin-top: -127px; */

  /* 方便： 50% 就是自己宽高的一半 */
  transform: translate(-50%, -50%);
}
```

### 3.3.4 固定定位

**position: fixed**

场景：元素的位置在网页滚动时不会改变

特点：

* 脱标，不占位
* 显示模式具备行内块特点
* 设置边偏移相对浏览器窗口改变位置

```css
div {
  position: fixed;
  top: 0;
  right: 0;

  width: 500px;
}
```

### 3.3.5 堆叠层级z-index


默认效果：按照标签书写顺序，后来者居上

作用：设置定位元素的层级顺序，改变定位元素的显示顺序

属性名：**z-index**

属性值：**整数数字**（默认值为0，取值越大，层级越高）

```css
.box1 {
  background-color: pink;
  /* 取值是整数，默认是0，取值越大显示顺序越靠上 */
  z-index: 1;
}

.box2 {
  background-color: skyblue;
  left: 100px;
  top: 100px;

  z-index: 2;
}
```

## 3.4 高级技巧

### 3.4.1 CSS精灵

CSS 精灵，也叫 **CSS Sprites**，是一种网页**图片应用处理方式**。把网页中**一些背景图片**整合到**一张图片**文件中，再**background-position** 精确的定位出背景图片的位置。

优点：减少服务器被请求次数，减轻服务器的压力，提高页面加载速度

实现步骤：

1. 创建盒子，**盒子尺寸**与**小图**尺寸**相同**
2. 设置盒子**背景图**为精灵图
3. 添加 **background-position** 属性，改变**背景图位置**
    - 使用 PxCook 测量小图片**左上角坐标**
    - 取**负数**坐标为 background-position 属性值（向左上移动图片位置）


### 3.4.2 字体图标


字体图标：**展示的是图标，本质是字体**

作用：在网页中添加**简单的、颜色单一**的小图标

优点

* **灵活性**：灵活地修改样式，例如：尺寸、颜色等
* **轻量级**：体积小、渲染快、降低服务器请求次数
* **兼容性**：几乎兼容所有主流浏览器
* **使用方便**：先下载再使用

#### 下载字体

iconfont 图标库：<https://www.iconfont.cn/> 

登录 → 素材库 → 官方图标库 → 进入图标库 → 选图标，加入购物车 → 购物车，添加至项目，确定 → 下载至本地 

#### 使用字体

1. 引入字体样式表（iconfont.css） 

2. 标签使用字体图标类名
   * iconfont：字体图标基本样式（字体名，字体大小等等）
   * icon-xxx：图标对应的类名

#### 上传矢量图

作用：项目特有的图标上传到 iconfont 图标库，生成字体

上传步骤：上传 → 上传图标 → 选择 svg 矢量图，打开 → 提交 → 系统审核

### 3.4.3 CSS修饰属性

#### 垂直对齐方式 

属性名：vertical-align

|属性值|效果|
|---|---|
|baseline|基线对齐(默认)|
|top|顶部对齐|
|middle|居中对齐|
|bottom|底部对齐|

#### 过渡

作用：可以为一个元素在不同状态之间切换的时候添加**过渡效果**

属性名：**transition（复合属性）**

属性值：**过渡的属性  花费时间 (s)**

提示：

* 过渡的属性可以是具体的 CSS 属性
* 也可以为 all（两个状态属性值不同的所有属性，都产生过渡效果）
* transition 设置给元素本身

```css
img {
  width: 200px;
  height: 200px;
  transition: all 1s;
}

img:hover {
  width: 500px;
  height: 500px;
}
```

#### 透明度opacity

作用：设置**整个元素的透明度**（包含背景和内容）

属性名：opacity

属性值：0 – 1

* 0：完全透明（元素不可见）
* 1：不透明
* 0-1之间小数：半透明

#### 光标类型cursor

作用：鼠标悬停在元素上时指针显示样式

属性名：cursor

|属性值|效果|
|---|---|
|default|默认值，通常是箭头|
|pointer|小手效果，提示用户可以点击|
|text|工字型，提示用户可以选择文字|
|move|十字光标，提示用户可以移动|

