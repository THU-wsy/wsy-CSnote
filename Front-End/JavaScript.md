# 第1章 JavaScript 基础

## 1.1 简介

JavaScript是一种运行在客户端（浏览器）的脚本语言，实现人机交互效果。JavaScript由 ECMAScript 和 Web APIs 组成，其中前者规定了js基础语法核心知识，后者由 DOM（操作文档）和 BOM（操作浏览器）组成。特点如下：

- 脚本语言：JavaScript是一种解释型的脚本语言。不同于C、C++、Java等语言先编译后执行, JavaScript不会产生编译出来的字节码文件，而是在程序的运行过程中对源文件逐行进行解释。
- 基于对象：JavaScript是一种基于对象的脚本语言，它不仅可以创建对象，也能使用现有的对象。但是面向对象的三大特性：封装、继承、多态中，JavaScript能够实现封装，可以模拟继承，不支持多态，所以它不是一门面向对象的编程语言。
- 弱类型：JavaScript中也有明确的数据类型，但是声明一个变量后它可以接收任何类型的数据，并且会在程序执行过程中根据上下文自动转换类型。
- 事件驱动：JavaScript是一种采用事件驱动的脚本语言，它不需要经过Web服务器就可以对用户的输入做出响应。
- 跨平台性：JavaScript脚本语言不依赖于操作系统，仅需要浏览器的支持。

### 1.1.1 引入方式

JavaScript 程序不能独立运行，它需要被嵌入 HTML 中，然后浏览器才能执行 JavaScript 代码。引入js有三种方式：

#### 内部方式

通过 `script` 标签包裹 JavaScript 代码，一般`script`标签写在`</body>`上面

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>JavaScript 基础 - 引入方式</title>
</head>
<body>
  <!-- 内联形式：通过 script 标签包裹 JavaScript 代码 -->
  <script>
    alert('Hello！')
  </script>
</body>
</html>
```

#### 外部形式

一般将 JavaScript 代码写在独立的以 .js 结尾的文件中，然后通过 `script` 标签的 `src` 属性引入。如果 script 标签使用 src 属性引入了某 .js 文件，那么两个标签中间的代码会被忽略。

```javascript
// demo.js
document.write('Hello！')
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>JavaScript 基础 - 引入方式</title>
</head>
<body>
  <!-- 外部形式：通过 script 的 src 属性引入独立的 .js 文件 -->
  <script src="demo.js">
    // 此处的代码会被忽略掉！！！！
  </script>
</body>
</html>
```

#### 内联 JavaScript

代码写在标签内部

```html
<body>
    <button onclick="alert('逗你玩~');">点击我年薪过亿</button>
</body>
```

###  1.1.2 注释和结束符

JavaScript 支持两种形式注释语法：

#### 单行注释

使用 `// ` 注释单行代码

#### 多行注释

使用 `/* */` 注释多行代码

#### 结束符

在 JavaScript 中 `;` 代表一段代码的结束，多数情况下可以省略 `;` 使用回车（enter）替代。

### 1.1.3 输入和输出

#### 输出

`document.write()` 作用是向 `body` 内输出内容，注意如果输出的内容写的是标签，也会被解析成网页元素。

`alert()` 作用是让页面弹出警告对话框

`console.log()` 是控制台输出语法，给程序员调试使用

#### 输入

向 `prompt()` 输入任意内容会以弹窗形式出现在浏览器中，一般提示用户输入一些内容。

注意js代码一般按顺序执行，但 `alert()` 和 `prompt()` 会跳过页面渲染先被执行。

## 1.2 变量

### 1.2.1 声明和赋值

```js
//let是用于声明的关键字
let a = 2, str = 'hello world!'; 
```

### 1.2.2 数组

数组可以存储任意类型的数据

```js
let names = ['张三', '李四', 10];
console.log(names[0]); // '张三'
console.log(names.length) // 3
```

## 1.3 常量

概念：使用 const 声明的变量称为“常量”。

```js
const PI = 3.14
```

> 注意：常量不允许重新赋值，声明的时候必须赋值（初始化）
> 注意：对于引用数据类型，const声明的变量，里面存的不是值，而是地址。所以建议数组和对象使用 const 来声明。

## 1.4 数据类型

js数据类型主要分为两大类：基本数据类型和引用数据类型(object, 对象)。基本数据类型主要包括：number(数字型)、string(字符串型)、boolean(布尔型)、undefined(未定义型)、null(空类型)。

JS 是弱数据类型语言，变量到底属于那种类型，只有赋值之后，我们才能确认；而Java、C都是强数据类型语言。

注：通过 typeof 关键字可以检测数据类型

```js
let age = 18;
console.log(typeof age); // 作为运算符，number
console.log(typeof(age)); // 作为函数，number
let obj = null;
console.log(typeof obj); // object，实际上null是对象数据类型
```

```js
let num1 = 10;
let num2 = num1;
num2 = 20;
console.log(num1); // 10

let obj1 = {
    age: 18
};
let obj2 = obj1;
obj2.age = 20;
console.log(obj1.age); // 20
```

### 1.4.1 数字型

JavaScript 中的正数、负数、小数等统一称为数字类型。

NaN 代表一个计算错误(not a number)，它是一个不正确的或者一个未定义的数学操作所得到的结果。NaN 是粘性的，即任何对 NaN 的操作都会返回 NaN。

```js
console.log('张三' - 2); // NaN
console.log(NaN + 2); // NaN
```

### 1.4.2 字符串类型

通过单引号（ `''`） 、双引号（ `""`）或反引号包裹的数据都叫字符串，单引号和双引号没有本质上的区别，推荐使用单引号。

注意事项：
1. 单引号/双引号可以互相嵌套，但是不以自已嵌套自已
2. 必要时可以使用转义符 `\`，输出单引号或双引号

`+` 运算符可以实现字符串拼接。也可以使用模板字符串，即用反引号 \` \`包裹内容，内容拼接变量时用 `${ }` 包住变量，例如：

```js
let age = 25;
console.log(`我今年${age}岁了`);
```

### 1.4.3 布尔类型

有两个固定的值 `true` 和 `false`。


### 1.4.4 undefined

```js
let obj; // undefined
```

未定义是比较特殊的类型，只有一个值 undefined，只声明变量，不赋值的情况下，变量的默认值为 undefined。

### 1.4.5 null

```js
let obj = null; // null
```

JavaScript 中的 null 仅仅是一个代表“无”、“空”或“值未知”的特殊值。 undefined 表示没有赋值，而 null 表示赋值了，但内容为空(在开发中，一般把 null 作为尚未创建的对象)。


## 1.5 类型转换

在实际编程的过程中，不同数据类型之间存在着转换的关系。例如使用表单、prompt 获取过来的数据默认是字符串类型的，此时就不能直接简单地进行加法运算。

### 1.5.1 隐式转换

某些运算符被执行时，系统内部自动将数据类型进行转换，这种转换称为隐式转换。规则：

- `+` 号两边边只要有一个是字符串，都会把另外一个转成字符串
- 除了 `+` 以外的运算符，如 `- * /` 等都会把数据转成数字类型
- `+` 号作为正号解析可以转换成数字型，例如 `typeof +'123'`是 number 类型
- `null` 经过数字转换之后会变为 `0`，`undefined` 经过数字转换之后会变为 `NaN`

```js
console.log(null + 1); // 1
console.log(undefined + 1); // NaN
console.log(NaN + 1); // NaN
```


### 1.5.2 显式转换

#### 转换为数字型

通过 `Number()` 显式转换成数字类型，例如 `Number('123')`。如果字符串内容里有非数字，则转换失败，结果为 `NaN`，注意 `NaN` 也是 number 类型的数据，代表非数字。

通过 `parseInt()` 转换，只保留从头开始的整数，如 `parseInt('12.94px')` 的结果为 `12`。

通过 `parseFloat()` 转换，保留从头开始的小数，如 `parseFloat('12.94px')` 的结果为 `12.94`。

#### 转换为字符串型

可以用 `String(数据)` 或 `变量.toString(进制)`

#### 转换为Boolean型

`Boolean(内容)`。`'', 0, undefined, null, false, NaN` 转换为布尔值后都是 `false`，其余则为 `true`

# 第2章 运算符和语句

## 2.1 运算符

### 2.1.1 算术运算符

算术运算符：也叫数学运算符，主要包括加、减、乘、除、取余（求模）等

### 2.1.2 赋值运算符

赋值运算符：对变量进行赋值的运算符，包括 `=、+=、-=、*=、/=、%=`

### 2.1.3 自增/自减运算符

`++、--`

### 2.1.4 比较运算符

根据比较结果返回一个布尔值（true / false）

| 运算符 | 作用                                   |
| ------ | ------------------------------------- |
| >      | 左边是否大于右边                       |
| <      | 左边是否小于右边                       |
| >=     | 左边是否大于或等于右边                 |
| <=     | 左边是否小于或等于右边                 |
| ===    | 左右两边是否 `类型` 和 `值` 都相等      |
| ==     | 左右两边`值`是否相等                   |
| !=     | 左右值不相等                           |
| !==    | 左右两边是否不全等                     |

```javascript
// 比较运算符有隐式转换, 把'2'转换为2, 双等号只判断值
console.log(2 == '2')  // true
// 以后判断是否相等, 请用 ===  
console.log(2 === '2') // false
console.log(NaN === NaN) // false, NaN 不等于任何人, 包括他自己
```

### 2.1.5 逻辑运算符

`&&、||、!`

#### 逻辑运算符里的短路

对于 `&&`，左边为 `false` 就短路。对于 `||`，左边为 `true` 就短路。无论 `&&` 还是 `||`，运算结果都是最后被执行的表达式值，一般用在变量赋值。

```js
console.log(5 < 3 && 20); // false
console.log(undefined && 20); // undefined
console.log(null && 20); // null
console.log(0 && 20); // 0
console.log(10 && 20); // 20

console.log(5 < 3 || 20); // 20
console.log(undefined || 20); // 20
console.log(null || 20); // 20
console.log(0 || 20); // 20
console.log(10 || 20); // 10
```


## 2.2 语句

### 2.2.1 分支语句

#### if 分支语句

#### 三元运算符

```javascript
条件 ? 表达式1 : 表达式2 ;
```

#### switch语句

switch 找到跟小括号里数据**全等**的case值，并执行里面对应的代码。

```javascript
switch (表达式) {
  case 值1:
    代码1;
    break;
  case 值2:
    代码2;
    break;
  default:
    代码3;
    break;
}
```

#### 断点调试

浏览器打开调试界面

1. 按F12打开开发者工具
2. 点到源代码一栏（sources）
3. 选择代码文件

断点：在某句代码上加的标记就叫断点，当程序执行到这句有标记的代码时会暂停下来

### 2.2.2 循环语句

#### while循环

#### for循环


#  第3章 数组、函数和对象


## 3.1 数组

**数组(Array)**：是一种可以按顺序保存数据的数据类型


### 3.1.1 定义数组

```js
  let classes = ['小明', '小刚', '小红'];
  let arr = new Array('小明', '小刚', '小红');
```

数组做为数据的集合，它的元素可以是任意数据类型。数组在 JavaScript 中并不是新的数据类型，它属于对象类型。数组对应着一个 length 属性，它的含义是获取数组的长度。

```js
  console.log(arr.length);
```

### 3.1.2 操作数组

数组做为对象数据类型，不但有 `length` 属性可以使用，还提供了许多方法：

#### push

`arr.push()` 动态向数组的尾部添加一个或多个元素，并返回该数组的新长度。

```js
  let arr = ['html', 'css', 'js'];
  arr.push('java', 'cpp'); // 返回5
```

#### unshift

`arr.unshift()` 动态向数组头部添加一个或多个元素，并返回该数组的新长度。

#### pop
`arr.pop()` 从数组中删除最后一个元素，并返回该元素的值。

#### shift

`arr.shift()` 从数组中删除第一个元素，并返回该元素的值。

#### splice

`arr.splice(start, deleteCount)` 用于删除任意元素，start 是指定的下标，deleteCount 表示要移除的数组元素的个数(如果省略，则默认删除从 start 开始到最后的所有元素)。

### 3.1.3 数组排序

```js
arr.sort(); // 默认升序排序
// 降序排序写法
arr.sort(function (a, b) {
  return b - a;
});
```

## 3.2 函数

### 3.2.1 声明和调用

```js
function getSum(arr = []) {
    let sum = 0;
    for (let i = 0; i < arr.length; i++)
        sum += arr[i];
    return sum;
}
document.write(getSum([1, 2, 3, 4]));
```

- 形参如果没有默认值，且不传递对应的实参，则默认为 undefined
- 实参的个数和形参的个数可以不一致。如果形参过多，会自动填上undefined ; 如果实参过多，那么多余的实参会被忽略 (函数内部有一个 arguments, 里面装着所有的实参)
- 函数可以没有return，这种情况默认返回值为 undefined

### 3.2.2 作用域

全局作用域：作用于所有代码执行的环境(整个 script 标签内部)或者一个独立的 js 文件

局部作用域：作用于函数内的代码环境，就是局部作用域。因为跟函数有关系，所以也称为函数作用域。


### 3.2.3 匿名函数

函数可以分为具名函数和匿名函数。匿名函数即没有名字的函数, 无法直接使用，一般用于函数表达式或者立即执行函数。

#### 函数表达式

将匿名函数赋值给一个变量，并且通过变量名称进行调用，我们将这个称为函数表达式。

```js
// 声明
let fn = function() { 
   console.log('函数表达式');
}
// 调用
fn();
```

#### 立即执行函数

无需调用，立即执行，其实本质已经调用了。多个立即执行函数之间用分号隔开。立即执行函数用于避免全局变量之间的污染。

```js
// 方式1
(function () { return 1; })();
// 方式2
(function () { return 1; }());
```


## 3.3 对象

> 对象是 JavaScript 数据类型的一种，之前已经学习了数值类型、字符串类型、布尔类型、undefined。对象数据类型可以理解为是一种无序的数据集合，注意数组是有序的数据集合。对象由属性和方法两部分构成。

null 也是 JavaScript 中数据类型的一种，通常只用它来表示不存在的对象。使用 typeof 检测类型它的类型时，结果为 `object`。

### 3.3.1 属性和访问

属性名可以使用 `""` 或 `''`，一般情况下省略，除非名称遇到特殊符号如空格、中横线等。

```js
let person = {
  uname: '张三',
  age: 18,
  'ip-addr': '192.168.0.1'
};

// 以下语法也能声明对象
let obj = new Object();
```

声明对象，并添加了若干属性后，可以使用 `.` 或 `[]` 获得对象中属性对应的值，称之为属性访问。

```js
person.age = 19;
person['age'] = 20;
person['ip-addr'] = '192.168.0.2';
person.height = 180; //增加属性
delete person.age; //删除属性
```


### 3.3.2 方法和调用

方法名可以使用 `""` 或 `''`，一般情况下省略，除非名称遇到特殊符号如空格、中横线等。

```js
let person = {
  uname: '张三',
  age: 18,
  'ip-addr': '192.168.0.1',
  add: function (a, b) {
    return a + b;
  }
};
person.add(1, 2);
```

声明对象，并添加了若干方法后，可以使用 `.` 或 `[]` 调用对象中函数，称之为方法调用。


### 3.3.3 遍历对象

```js
let person = {
  uname: '张三',
  age: 18,
  'ip-addr': '192.168.0.1'
};
for (let k in person) {
  console.log(k); //打印属性名 'uname' 'age' 'ip-addr'
  console.log(person[k]); //打印属性值
}
```

`for in` 不提倡遍历数组 因为 `k` 是字符串(即 `k` 是表示下标的字符串，`'0' '1' '2' ....`)  

### 3.3.4 内置对象Math

`Math` 是 JavaScript 中内置的对象，称为数学对象。

#### 属性

- Math.PI，获取圆周率

#### 方法

- Math.ceil(a)，数字向上取整
- Math.floor(a)，数字向下取整
- Math.round(a)，四舍五入取整
- Math.max(a, b, c, ...)，在一组数中找出最大的
- Math.min(a, b, c, ...)，在一组数中找出最小的
- Math.pow(a, b)，计算a的b次方
- Math.sqrt(a)，平方根
- Math.random()，生成`[0, 1)`间的随机数

```js
// 生成[N, M]之间的随机数
Math.floor(Math.random() * (M - N + 1)) + N;
```


# 第4章 Web APIs

## 4.1 简介


严格意义上讲，我们在 JavaScript 阶段学习的知识绝大部分属于 ECMAScript 的知识体系，ECMAScript 简称 ES 它提供了一套语言标准规范，如变量、数据类型、表达式、语句、函数等语法规则都是由 ECMAScript 规定的。浏览器将 ECMAScript 大部分的规范加以实现，并且在此基础上又扩展一些实用的功能，这些被扩展出来的内容我们称为 Web APIs。

ECMAScript 运行在浏览器中然后再结合 Web APIs 才是真正的 JavaScript，Web APIs 的核心是 DOM 和 BOM。

DOM（Document Object Model）意思是文档对象模型，它是将整个 HTML 文档的每一个标签元素视为一个对象，这个对象下包含了许多的属性和方法，通过操作这些属性或者调用这些方法实现对 HTML 的动态更新，为实现网页特效以及用户交互提供技术支撑。

简言之 DOM 是浏览器提供的一套专门用来**操作网页内容**的功能。

### DOM 树

将 HTML 文档以树状结构直观的表现出来，我们称之为文档树或 DOM 树，**文档树直观的体现了标签与标签之间的关系。**


### DOM 对象

- DOM对象：浏览器根据html标签生成的 JS对象
  - 所有的标签属性都可以在这个对象上面找到
  - 修改这个对象的属性会自动映射到标签身上
- DOM的核心思想：把网页内容当做对象来处理
- document 对象：是 DOM 里提供的一个对象，所以它提供的属性和方法都是用来访问和操作网页内容的，网页所有内容都在document里面。


## 4.2 获取DOM对象

### 4.2.1 获取DOM对象

```js
document.querySelector('css选择器');
```
- 功能：选择匹配的第一个元素
- 参数：包含一个或多个有效的CSS选择器字符串
- 返回值：CSS选择器匹配的第一个元素,一个 HTMLElement对象。如果没有匹配到，则返回null。

```js
document.querySelectorAll('css选择器');
```
- 功能：选择匹配的多个元素
- 参数：包含一个或多个有效的CSS选择器字符串
- 返回值：CSS选择器匹配的对象集合(伪数组：有长度，但没有push和pop等方法)

### 4.2.2 操作元素内容

#### 修改文本内容

元素 `innerText` 属性：将文本内容添加/更新到任意标签位置，注意**文本中包含的标签不会被解析。**

元素 `innerHTML` 属性：将文本内容添加/更新到任意标签位置，注意**文本中包含的标签会被解析，** 多标签建议使用模板字符串。


#### 常用属性修改

可以通过 JS 设置/修改标签元素属性，比如通过 src更换图片。最常见的属性比如：href、title、src 等。


#### 修改样式属性

1. 通过修改行内样式 `style` 属性，实现对样式的动态修改。

通过元素节点获得的 `style` 属性本身的数据类型也是对象，如 `box.style.color`、`box.style.width` 分别用来获取元素节点 CSS 样式的 `color` 和 `width` 的值。

任何标签都有 `style` 属性，通过 `style` 属性可以动态更改网页标签的样式，如要遇到 `css` 属性中包含字符 `-` 时，要将 `-` 去掉并将其后面的字母改成大写，如 `background-color` 要写成 `box.style.backgroundColor`

2. 通过类名(className)操作CSS

```js
元素.className = 'Css类名';
```

>注意：
>
>1.由于class是关键字, 所以使用className去代替
>
>2.className是使用新值换旧值, 所以如果需要添加一个类, 就需要保留之前的类名

3. 通过 classList 操作类控制CSS

为了解决 className 容易覆盖以前的类名，我们可以通过classList方式追加和删除类名。

```js
元素.classList.add('类名'); //添加一个类
元素.classList.remove('类名'); //删除一个类
元素.classList.toggle('类名'); //切换一个类(即如果有该类，则删除之；没有该类，则添加之)
```


#### 操作表单元素属性

```js
表单.value; //获取用户输入的内容
表单.type; //获取表单的类型
```

表单属性中添加就有效果, 移除就没有效果, 一律使用布尔值表示, 如果为true代表添加了该属性, 如果是false代表移除了该属性。如disabled、checked、selected

```html
<input type="checkbox">
<button>提交</button>
<script>
    const ipt = document.querySelector('input');
    ipt.checked = true; //勾选复选框
    const btn = document.querySelector('button');
    btn.disabled = true; //禁用按钮
</script>
```

#### 自定义属性

在html5中推出来了专门的data-自定义属性，在标签上一律以data-开头，在DOM对象上一律以dataset对象方式获取。

```html
<div data-id="1"> 自定义属性 </div>
<script>
// 1. 获取元素
let div = document.querySelector('div');
// 2. 获取自定义属性值
console.log(div.dataset.id);
</script>
```

#### 定时器-间歇函数


`setInterval` 是 JavaScript 中内置的函数，它的作用是间隔固定的时间自动重复执行另一个函数，也叫定时器函数。

1. 开启定时器

```js
let n = setInterval(函数, 间隔时间);
```
作用：每隔一段时间调用这个函数, 间隔时间单位是毫秒。定时器返回的是一个id数字。

2. 关闭定时器

```js
clearInterval(n);
```



## 4.3 事件

事件是编程语言中的术语，它是用来描述程序的行为或状态的，**一旦行为或状态发生改变，便立即调用一个函数。**


### 4.3.1 事件监听(绑定)

结合 DOM 使用事件时，需要为 DOM 对象添加事件监听，等待事件发生（触发）时，便立即调用一个函数。

`addEventListener` 是 DOM 对象专门用来添加事件监听的方法，它的两个参数分别为【事件类型】和【事件回调】。

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>事件监听</title>
</head>
<body>
  <h3>事件监听</h3>
  <p id="text">为 DOM 元素添加事件监听，等待事件发生，便立即执行一个函数。</p>
  <button id="btn">点击改变文字颜色</button>
  <script>
    // 1. 获取 button 对应的 DOM 对象
    const btn = document.querySelector('#btn')

    // 2. 添加事件监听
    btn.addEventListener('click', function () {
      console.log('等待事件被触发...')
      // 改变 p 标签的文字颜色
      let text = document.getElementById('text')
      text.style.color = 'red'
    })

    // 3. 只要用户点击了按钮，事件便触发了！！！
  </script>
</body>
</html>
```


### 4.3.2 事件类型

#### 鼠标事件(鼠标触发)

- click(鼠标点击)
- dblclick(鼠标双击)
- mouseenter(鼠标经过)
- mouseleave(鼠标离开)

#### 焦点事件(表单获得光标)

- focus(获得焦点)
- blur(失去焦点)


#### 键盘事件(键盘触发)

- keydown(键盘按下触发)
- keyup(键盘抬起触发)

#### 文本事件(表单输入触发)

- input(用户输入事件)


### 4.3.3 事件对象

任意事件类型被触发时与事件相关的信息会被以对象的形式记录下来，我们称这个对象为事件对象。例如：鼠标点击事件中，事件对象就存了鼠标点在哪个位置等信息。

```html
<body>
  <h3>事件对象</h3>
  <p>任意事件类型被触发时与事件相关的信息会被以对象的形式记录下来，我们称这个对象为事件对象。</p>
  <hr>
  <div class="box"></div>
  <script>
    // 获取 .box 元素
    const box = document.querySelector('.box')

    // 添加事件监听
    box.addEventListener('click', function (e) {
      console.log('任意事件类型被触发后，相关信息会以对象形式被记录下来...');

      // 事件回调函数的第1个参数即所谓的事件对象
      console.log(e)
    })
  </script>
</body>
```

事件回调函数的【第1个参数】即所谓的事件对象，通常习惯性的将这个对数命名为 `event`、`e` 、`ev` 。

接下来简单看一下事件对象中包含了哪些有用的信息：

1. `ev.type` 当前事件的类型
2. `ev.clientX ev.clientY` 获取光标相对于浏览器可见窗口左上角的位置
3. `ev.offsetX ev.offsetY` 获取光标相对于当前DOM元素左上角的位置
4. `ev.key` 用户按下的键盘键的值

注：在事件回调函数内部通过 window.event 同样可以获取事件对象。

### 4.3.4 环境对象


环境对象指的是函数内部特殊的变量 `this` ，它代表着当前函数运行时所处的环境。

结论：

1. `this` 本质上是一个变量，数据类型为对象
2. 函数的调用方式不同 `this` 变量的值也不同
3. 【谁调用 `this` 就是谁】是判断 `this` 值的粗略规则
4. 函数直接调用时实际上 `window.sayHi()` 所以 `this` 的值为 `window`


### 4.3.5 回调函数

如果将函数 A 做为参数传递给函数 B 时，我们称函数 A 为回调函数。

我们回顾一下间歇函数 `setInterval` 

```html
<script>
	function fn() {
    console.log('我是回调函数...');
  }
  // 调用定时器
  setInterval(fn, 1000);
</script>
```

`fn` 函数做为参数传给了 `setInterval` ，所以 `fn` 便是回调函数。


结论：

1. 回调函数本质还是函数，只不过把它当成参数使用
2. 使用匿名函数做为回调函数比较常见










# 补充

### 1.5.1 JS对象

#### 1.5.1.1 Array对象

##### 特点

与java中不一样的是，JavaScript中数组相当于java中的集合，数组的长度是可以变化的。而且JavaScript是弱数据类型的语言，所以数组中可以存储任意数据类型的值。

##### 属性和方法

Array作为一个对象，那么对象是有属性和方法的，所以接下来我们介绍一下Array对象的属性和方法

属性：

| 属性   | 描述                         |
| :----- | :--------------------------- |
| length | 设置或返回数组中元素的数量。 |

方法：

| 方法方法  | 描述                                             |
| :-------- | :----------------------------------------------- |
| forEach() | 遍历数组中的每个有值得元素，并调用一次传入的函数 |
| push()    | 将新元素添加到数组的末尾，并返回新的长度         |
| splice()  | 从数组中删除元素                                 |



- forEach()函数

  首先我们学习forEach()方法，顾名思义，这是用来遍历的，那么遍历做什么事呢？所以这个方法的参数，需要传递一个函数，而且这个函数接受一个参数，就是遍历时数组的值。修改之前的遍历代码如下：

  ~~~js
  //e是形参，接受的是数组遍历时的值
  arr.forEach(function(e){
       console.log(e);
  })
  ~~~

  当然了，在ES6中，引入箭头函数的写法，语法类似java中lambda表达式，修改上述代码如下：

  ~~~js
  arr.forEach((e) => {
       console.log(e);
  }) 
  ~~~


  注意的是，没有元素的内容是不会输出的，因为forEach只会遍历有值的元素 





#### 1.5.1.2 String对象

##### 语法格式

String对象的创建方式有2种：


~~~js
var 变量名 = new String("…") ; //方式一
var 变量名 = "…" ; //方式二
~~~

##### 属性和方法

String对象也提供了一些常用的属性和方法，如下表格所示：

属性：

| 属性   | 描述           |
| ------ | -------------- |
| length | 字符串的长度。 |

方法：

| 方法        | 描述                                     |
| ----------- | ---------------------------------------- |
| charAt()    | 返回在指定位置的字符。                   |
| indexOf()   | 检索字符串。                             |
| trim()      | 去除字符串两边的空格                     |
| substring() | 提取字符串中两个指定的索引号之间的字符。 |

- length属性：

  length属性可以用于返回字符串的长度，添加如下代码：

  ~~~js
  //length
  console.log(str.length);
  ~~~

- charAt()函数：

  charAt()函数用于返回在指定索引位置的字符，函数的参数就是索引。添加如下代码：

  ~~~js
  console.log(str.charAt(4));
  ~~~

- indexOf()函数

  indexOf()函数用于检索指定内容在字符串中的索引位置的，返回值是索引，参数是指定的内容。添加如下代码：

  ~~~js
  console.log(str.indexOf("lo"));
  ~~~

- trim()函数

  trim()函数用于去除字符串两边的空格的。添加如下代码：

  ~~~js
  var s = str.trim();
  console.log(s.length);
  ~~~

- substring()函数

  substring()函数用于截取字符串的，函数有2个参数。

  参数1：表示从那个索引位置开始截取。包含

  参数2：表示到那个索引位置结束。不包含

  ~~~js
  console.log(s.substring(0,5));
  ~~~




#### 1.5.1.3 JSON对象


##### json对象

JSON对象：**J**ava**S**cript **O**bject **N**otation，JavaScript对象标记法。是通过JavaScript标记法书写的文本。其格式如下：

~~~js
{
    "key":value,
    "key":value,
    "key":value
}
~~~

其中，**key必须使用引号并且是双引号标记，value可以是任意数据类型。**

那么json这种数据格式的文本到底应用在企业开发的什么地方呢？-- 经常用来作为前后台交互的数据载体

**定义：**
~~~js
var jsonstr = '{"name":"Tom", "age":18, "addr":["北京","上海","西安"]}';
~~~

注：value的数据类型如果是字符串，则必须用双引号包裹

**上述是一个json字符串，不是json对象，所以我们需要借助如下函数来进行json字符串和json对象的转换**。添加代码如下：

~~~js
var obj = JSON.parse(jsonstr); // JSON字符串转为JS对象
alert(obj.name);
~~~

我们也可以通过如下函数将json对象再次转换成json字符串。添加如下代码：

~~~js
var str = JSON.stringify(obj); // JS对象转为JSON字符串
~~~




### 1.5.2 BOM对象

BOM的全称是Browser Object Model,翻译过来是浏览器对象模型。也就是JavaScript将浏览器的各个组成部分封装成了对象，允许JavaScript与浏览器对话。我们要操作浏览器的部分功能，可以通过操作BOM对象的相关属性或者函数来完成。例如：我们想要将浏览器的地址改为`http://www.baidu.com`,我们就可以通过BOM中提供的location对象的href属性来完成，代码如下：`location.href='http://www.baidu.com'`

BOM中提供了如下5个对象：

| 对象名称  | 描述           |
| :-------- | :------------- |
| Window    | 浏览器窗口对象 |
| Navigator | 浏览器对象     |
| Screen    | 屏幕对象       |
| History   | 历史记录对象   |
| Location  | 地址栏对象    |


#### 1.5.2.1 Window对象

window对象指的是浏览器窗口对象，是JavaScript的全部对象，所以对于window对象，我们可以直接使用，并且对于window对象的方法和属性，我们可以省略window.例如：我们之前学习的alert()函数其实是属于window对象的,其完整的代码如下：

~~~js
window.alert('hello');
~~~

其可以省略window.  所以可以简写成

~~~js
alert('hello');
~~~

所以对于window对象的属性和方法，我们都是采用简写的方式。window提供了很多属性和方法，下表列出了常用属性和方法

window对象提供了获取其他BOM对象的属性：

| 属性      | 描述                  |
| --------- | --------------------- |
| history   | 对 History 对象的只读引用   |
| location  | 用于窗口或框架的 Location 对象  |
| navigator | 对 Navigator 对象的只读引用 |
| screen    | 用于获取Screen对象    |



window也提供了一些常用的函数，如下表格所示：

| 函数          | 描述                                               |
| ------------- | -------------------------------------------------- |
| alert()       | 显示带有一段消息和一个确认按钮的警告框。           |
| comfirm()     | 显示带有一段消息以及确认按钮和取消按钮的对话框。   |
| setInterval() | 按照指定的周期（以毫秒计）来调用函数或计算表达式。 |
| setTimeout()  | 在指定的毫秒数后调用函数或计算表达式。             |



- alert()函数：弹出警告框，函数的内容就是警告框的内容

  ~~~html
  <script>
      //window对象是全局对象，window对象的属性和方法在调用时可以省略window.
      window.alert("Hello BOM");
      alert("Hello BOM Window");
  </script>
  ~~~



- confirm()函数：弹出确认框，并且提供用户2个按钮，分别是确认和取消。

  添加如下代码：

  ~~~js
  confirm("您确认删除该记录吗?");
  ~~~


  但是我们怎么知道用户点击了确认还是取消呢？所以这个函数有一个返回值，当用户点击确认时，返回true，点击取消时，返回false。我们根据返回值来决定是否执行后续操作。


- setInterval(fn,毫秒值)：定时器，用于周期性的执行某个功能，并且是**循环执行**。该函数需要传递2个参数：

  fn:函数，需要周期性执行的功能代码

  毫秒值：间隔时间

  ~~~js
  //定时器 - setInterval -- 周期性的执行某一个函数
  var i = 0;
  setInterval(function(){
       i++;
       console.log("定时器执行了"+i+"次");
  },2000);
  ~~~


- setTimeout(fn,毫秒值) ：定时器，只会在一段时间后**执行一次功能**。参数和上述setInterval一致

  ~~~js
  //定时器 - setTimeout -- 延迟指定时间执行一次 
  setTimeout(function(){
  	alert("JS");
  },3000);
  ~~~

  浏览器打开，3s后弹框，关闭弹框，发现再也不会弹框了。



#### 1.5.2.2 Location对象

location是指代浏览器的地址栏对象，对于这个对象，我们常用的是href属性，用于获取或者设置浏览器的地址信息，添加如下代码：

~~~js
//获取浏览器地址栏信息
alert(location.href);
//设置浏览器地址栏信息
location.href = "https://www.itcast.cn";
~~~

浏览器效果如下：首先弹框展示浏览器地址栏信息，然后点击确定后，因为我们设置了地址栏信息，所以浏览器跳转到传智首页



### 1.5.3 DOM对象

#### 1.5.3.1 DOM介绍

DOM：Document Object Model 文档对象模型。也就是 JavaScript 将 HTML 文档的各个组成部分封装为对象。

封装的对象分为

- Document：整个文档对象
- Element：元素对象
- Attribute：属性对象
- Text：文本对象
- Comment：注释对象

JavaScript 通过DOM，就能够对HTML进行操作：

- 改变 HTML 元素的内容
- 改变 HTML 元素的样式（CSS）
- 对 HTML DOM 事件作出反应
- 添加和删除 HTML 元素

DOM是 W3C（万维网联盟）的标准，定义了访问HTML和XML文档的标准，分为3个不同的部分：
- Core DOM - 所有文档类型的标准模型
  - Document：整个文档对象
  - Element：元素对象
  - Attribute：属性对象
  - Text：文本对象
  - Comment：注释对象
- XML DOM - XML 文档的标准模型
- HTML DOM - HTML 文档的标准模型


#### 1.5.3.2 获取DOM对象

HTML中的Element对象可以通过Document对象获取，而Document对象是通过window对象获取的。document对象提供的用于获取Element元素对象的api如下表所示：

| 函数                              | 描述                                     |
| --------------------------------- | ---------------------------------------- |
| document.getElementById()         | 根据id属性值获取，返回单个Element对象    |
| document.getElementsByTagName()   | 根据标签名称获取，返回Element对象数组    |
| document.getElementsByName()      | 根据name属性值获取，返回Element对象数组  |
| document.getElementsByClassName() | 根据class属性值获取，返回Element对象数组 |












