# 1. HTML表单

表单区域要用form标签包裹，其中action的内容是要发送数据的地址。
```html
<form action="">

</form>
```

## 1.1 input标签

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

## 1.2 select标签

下拉菜单：select嵌套option，select是下拉菜单整体，option是下拉菜单的每一项(需要默认选中的一项只需写\<option selected\>)即可

## 1.3 textarea标签

文本域标签textarea，可以实现多行输入的文本框

## 1.4 label标签

label可以为某个标签添加说明文本，也可以用label标签绑定文字和表单控件的关系，来增大表单控件的点击范围(直接用label包裹文字和表单控件即可)。

## 1.5 button标签

```html
<button type="属性">
```

|type属性值|说明|
|---|---|
|submit|提交按钮，点击后可以提交数据到后台(默认功能)|
|reset|重置按钮，点击后将表单控件恢复默认值|
|button|普通按钮，默认没有功能，一般配合JavaScript使用|

## 1.6 其他

### 无语义的布局标签

div：独占一行
span：不换行

### 字符实体

|显示结果|描述|实体名称|
|---|---|---|
| |空格|\&nbsp\;|
|\< |小于号|\&lt\;|
|\> |大于号|\&gt\;|

# 2. CSS简介

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

## 2.1 选择器

选择器的作用是查找标签、设置样式。基础选择器有标签选择器、类选择器、id选择器、通配符选择器。

### 标签选择器

使用标签名作为选择器，从而选中同名标签设置相同的样式。
```html
<style>
    p {
        color: red;
    }
</style>
```

### 类选择器

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

### id选择器

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

### 通配符选择器

查找页面所有标签，设置相同样式。

```html
<style>
    * {
        color: red;
    }
</style>
```

