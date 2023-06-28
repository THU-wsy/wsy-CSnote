# 第1章 HTML基础

## 1.1 基础语法

### 1.1.1 注释

在 VS Code 中，**添加 / 删除**注释的快捷键：**Ctrl + /** 

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

超链接默认是在当前窗口跳转页面，添加 **target="_blank"** 实现**新窗口**打开页面。

拓展：开发初期，不确定跳转地址，则 href 属性值写为 **#**，表示**空链接**，页面不会跳转，在当前页面刷新一次。

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

- div：独占一行
- span：不换行

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

> 提示：在网页中，**表格默认没有边框线**，使用 **border 属性**可以为表格添加边框线。 

```html
<table border="1">
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

表单区域要用form标签包裹，其中action的内容是要发送数据的地址。
```html
<form action="">

</form>
```

### 1.4.1 input标签

```html
<input type="属性">
```

|type属性值|说明|
|---|---|
|text|文本框，用于输入单行文本，可以使用placeholder|
|password|密码框，可以使用placeholder|
|radio|单选框|
|checkbox|多选框|
|file|上传文件|

- text和password可以添加placeholder="提示信息"
- radio可以添加name(表示控件分组，同组只能选中一个，即单选功能)，再加上checked表示默认选中
- checkbox可以添加checked表示默认选中
- file可以添加multiple实现文件多选功能

### 1.4.2 select标签

下拉菜单：select嵌套option，select是下拉菜单整体，option是下拉菜单的每一项(需要默认选中的一项只需写\<option selected\>)即可

### 1.4.3 textarea标签

文本域标签textarea，可以实现多行输入的文本框

> 注意点：
>
> * 实际开发中，使用 CSS 设置 文本域的尺寸
> * 实际开发中，一般禁用右下角的拖拽功能

### 1.4.4 label标签

label可以为某个标签添加说明文本，也可以用label标签绑定文字和表单控件的关系，来增大表单控件的点击范围(直接用label包裹文字和表单控件即可)。

* 写法一
  * label 标签只包裹内容，不包裹表单控件
  * 设置 label 标签的 for 属性值 和表单控件的 id 属性值相同

```html
<input type="radio" id="man">
<label for="man">男</label>
```

* 写法二：使用 label 标签包裹文字和表单控件，不需要属性 

```html
<label><input type="radio"> 女</label>
```

> 提示：支持 label 标签增大点击范围的表单控件：文本框、密码框、上传文件、单选框、多选框、下拉菜单、文本域等等。 

### 1.4.5 button标签

```html
<button type="属性">
```

|type属性值|说明|
|---|---|
|submit|提交按钮，点击后可以提交数据到后台(默认功能)|
|reset|重置按钮，点击后将表单控件恢复默认值|
|button|普通按钮，默认没有功能，一般配合JavaScript使用|

> 提示：按钮需配合 form 标签（表单区域）才能实现对应的功能。



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

### 盒子模型-组成

* 内容区域 – width & height
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

![1680330928735](assets/1680330928735.png)

![1680330935635](assets/1680330935635.png)



### 边框线

#### 四个方向

属性名：**border**（bd）

属性值：边框线粗细  线条样式  颜色（不区分顺序）

![1680330976390](assets/1680330976390.png)

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

### 内边距 

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

* padding 多值写法

![1680331118330](assets/1680331118330.png)

> 技巧：从**上**开始**顺时针**赋值，当前方向没有数值则与**对面取值相同**。 

### 尺寸计算

![1680331322935](assets/1680331322935.png)

默认情况：盒子尺寸 = 内容尺寸 + border 尺寸 + 内边距尺寸

结论：给盒子加 border / padding 会撑大盒子

解决：

* 手动做减法，减掉 border / padding 的尺寸
* 內减模式：**box-sizing: border-box**

### 外边距 

作用：拉开两个盒子之间的距离

属性名：**margin**

提示：与 padding 属性值写法、含义相同

### 版心居中

![1680331503466](assets/1680331503466.png)

左右 margin 值 为 auto（盒子要有宽度）

```css
div {
  margin: 0 auto;
  width: 1000px;
  height: 200px;
  background-color: pink;
}
```

### 清除默认样式 

![1680331558304](assets/1680331558304.png)

清除标签默认的样式，比如：默认的内外边距。 

![1680331580746](assets/1680331580746.png)

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

### 元素溢出

作用：控制溢出元素的内容的显示方式。

属性名：**overflow**

![1680331623305](assets/1680331623305.png)

### 外边距问题

#### 合并现象

场景：**垂直**排列的兄弟元素，上下 **margin** 会**合并**

现象：取两个 margin 中的**较大值生效**

![1680331672628](assets/1680331672628.png)

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

![1680333860271](assets/1680333860271.png)

解决方法：

* 取消子级margin，父级设置padding
* 父级设置 overflow: hidden
* 父级设置 border-top

### 行内元素 – 内外边距问题 

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

### 圆角

作用：设置元素的外边框为圆角。

属性名：**border-radius**

属性值：数字+px / 百分比

提示：属性值是圆角半径

![1680334014390](assets/1680334014390.png)



* 多值写法

![1680334027657](assets/1680334027657.png)

> 技巧：从左上角开始顺时针赋值，当前角没有数值则与对角取值相同。 

* 正圆形状：给正方形盒子设置圆角属性值为 **宽高的一半 / 50%**

```css
img {
  width: 200px;
  height: 200px;
  
  border-radius: 100px;
  border-radius: 50%;
}
```

![1680334083567](assets/1680334083567.png)

* 胶囊形状：给长方形盒子设置圆角属性值为 盒子高度的一半 

```css
div {
  width: 200px;
  height: 80px;
  background-color: orange;
  border-radius: 40px;
}
```

![1680334136242](assets/1680334136242.png)

### 盒子阴影（拓展）

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

## 04-综合案例-产品卡片

![1680334221212](assets/1680334221212.png)

CSS 书写顺序：

1. 盒子模型属性
2. 文字样式
3. 圆角、阴影等修饰属性

### HTML标签

```html
<div class="product">
  <img src="./images/liveSDK.svg" alt="">
  <h4>抖音直播SDK</h4>
  <p>包含抖音直播看播功能</p>
</div>
```



### CSS样式

```html
<style>
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  body {
    background-color: #f1f1f1;
  }

  .product {
    margin: 50px auto;
    padding-top: 40px;

    width: 270px;
    height: 253px;
    background-color: #fff;
    text-align: center;

    border-radius: 10px;
  }

  .product h4 {
    margin-top: 20px;
    margin-bottom: 12px;
    font-size: 18px;
    color: #333;
    font-weight: 400;
  }

  .product p {
    font-size: 12px;
    color: #555;
  }
</style>
```

## 05-综合案例二 – 新闻列表 



![1680334329887](assets/1680334329887.png)



### 整体布局

```html
<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

li {
  list-style: none;
}

a {
  text-decoration: none;
}

.news {
  margin: 100px auto;
  width: 360px;
  height: 200px;
  /* background-color: pink; */
}
</style>

<div class="news"></div>
```

### 标题区域

```html
<style>
.news .hd {
  height: 34px;
  background-color: #eee;
  border: 1px solid #dbdee1;
  border-left: 0;
}

.news .hd a {
  /* -1 盒子向上移动 */
  margin-top: -1px;
  display: block;
  border-top: 3px solid #ff8400;
  border-right: 1px solid #dbdee1;
  width: 48px;
  height: 34px;
  background-color: #fff;

  text-align: center;
  line-height: 32px;
  font-size: 14px;
  color: #333;
}
</style>

<div class="hd"><a href="#">新闻</a></div>
```

### 内容区域

```html
<style>
.news .bd {
  padding: 5px;
}

.news .bd li {
  padding-left: 15px;
  background-image: url(./images/square.png);
  background-repeat: no-repeat;
  background-position: 0 center;
}

.news .bd li a {
  padding-left: 20px;
  background: url(./images/img.gif) no-repeat 0 center;

  font-size: 12px;
  color: #666;
  line-height: 24px;
}

.news .bd li a:hover {
  color: #ff8400;
}
</style>

<div class="bd">
  <ul>
    <li><a href="#">点赞“新农人” 温暖的伸手</a></li>
    <li><a href="#">在希望的田野上...</a></li>
    <li><a href="#">“中国天眼”又有新发现 已在《自然》杂志发表</a></li>
    <li><a href="#">急！这个领域，缺人！月薪4万元还不好招！啥情况？</a></li>
    <li><a href="#">G9“带货”背后：亏损面持续扩大，竞争环境激烈</a></li>
    <li><a href="#">多地力推二手房“带押过户”，有什么好处？</a></li>
  </ul>
</div>
```















