# 第1章 JavaScript 基础


## 1.1 简介

JavaScript是一种运行在客户端（浏览器）的编程语言，实现人机交互效果。JavaScript由 ECMAScript 和 Web APIs 组成，其中前者规定了js基础语法核心知识，后者由 DOM（操作文档）和 BOM（操作浏览器）组成。

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

**注：编辑器中单行注释的快捷键为 `ctrl + /`**

#### 结束符

在 JavaScript 中 `;` 代表一段代码的结束，多数情况下可以省略 `;` 使用回车（enter）替代。


### 1.1.3 输入和输出

输出和输入也可理解为人和计算机的交互，用户通过键盘、鼠标等向计算机输入信息，计算机处理后再展示结果给用户，这便是一次输入和输出的过程。

#### 输出

`document.write()` 作用是向 `body` 内输出内容，注意如果输出的内容写的是标签，也会被解析成网页元素。

`alert()` 作用是让页面弹出警告对话框

`console.log()` 是控制台输出语法，给程序员调试使用

####  输入

向 `prompt()` 输入任意内容会以弹窗形式出现在浏览器中，一般提示用户输入一些内容。

注意js代码一般按顺序执行，但 `alert()` 和 `prompt()` 会跳过页面渲染先被执行。

## 1.2 变量

### 1.2.1 声明和赋值

```js
//let是用于声明的关键字
let a = 2, str = 'hello world!'; 
```

#### 变量名命名规则

关于变量的名称（标识符）有一系列的规则需要遵守：

1. 只能是字母、数字、下划线、$，且不能能数字开头
2. 字母区分大小写，如 Age 和 age 是不同的变量
3. JavaScript 内部已占用于单词（关键字或保留字）不允许使用
4. 尽量保证变量具有一定的语义，见字知义

### 1.2.2 数组

数组可以存储任意类型的数据

```js
let names = ['张三', '李四', 10];
console.log(names[0]); // '张三'
console.log(names.length) // 3
```

## 1.3 常量

概念：使用 const 声明的变量称为“常量”。

使用场景：当某个变量永远不会改变的时候，就可以使用 const 来声明，而不是let。

命名规范：和变量一致

```js
const PI = 3.14
```

> 注意：常量不允许重新赋值，声明的时候必须赋值（初始化）

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

1. 无论单引号或是双引号必须成对使用
2. 单引号/双引号可以互相嵌套，但是不以自已嵌套自已
3. 必要时可以使用转义符 `\`，输出单引号或双引号

`+` 运算符可以实现字符串拼接。也可以使用模板字符串，即用反引号 \` \`包裹内容，内容拼接变量时用 `${ }` 包住变量，例如：

```js
let age = 25;
console.log(`我今年${age}岁了`);
```

### 1.4.3 布尔类型

表示肯定或否定时在计算机中对应的是布尔类型数据，它有两个固定的值 `true` 和 `false`。


### 1.4.4 undefined

```js
let obj; // undefined
```

未定义是比较特殊的类型，只有一个值 undefined，只声明变量，不赋值的情况下，变量的默认值为 undefined，一般很少直接为某个变量赋值为 undefined。

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

编写程序时过度依靠系统内部的隐式转换是不严禁的，因为隐式转换规律并不清晰，大多是靠经验总结的规律。为了避免因隐式转换带来的问题，通常根逻辑需要对数据进行显示转换。

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

使用场景：比较两个数据大小、是否相等，根据比较结果返回一个布尔值（true / false）

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


### 2.1.6 运算符优先级

![](/zzimages/20230625161443.png) 

## 2.2 语句

### 2.2.1 表达式和语句

表达式是可以被求值的代码，JavaScript 引擎会将其计算出一个结果。语句是一段可以执行的代码。

区别：因为表达式可被求值，所以它可以写在赋值语句的右侧；而语句不一定有值，所以比如 alert(), for 和 break 等语句就不能被用于赋值。

### 2.2.2 分支语句

#### if 分支语句

```javascript
if (条件表达式) {
  // 满足条件要执行的语句
} else if (条件表达式) {
  // 满足条件要执行的语句
} else {
  // 满足条件要执行的语句
}
```

#### 三元运算符

```javascript
条件 ? 表达式1 : 表达式2 ;
```

#### switch语句

switch 找到跟小括号里数据==全等==的case值，并执行里面对应的代码。

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


### 2.2.3 循环语句

#### while循环

```javascript
while (条件表达式) {
   // 循环体    
}
```

#### for循环

```js
for (起始值; 终止条件; 变化量) {
  // 要重复执行的代码
}
```

中止循环：

`break` 中止整个循环，一般用于结果已经得到, 后续的循环不需要的时候可以使用（提高效率）  

`continue` 中止本次循环，一般用于排除或者跳过某一个选项的时候


#  第3章 数组、函数和对象


## 3.1 数组

**数组：** (Array)是一种可以按顺序保存数据的数据类型


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

- Math.random()，生成 0 到 1 间的随机数

```javascript
// 0 ~ 1 之间的随机数, 包含 0 不包含 1
Math.random()
```

- Math.ceil，数字向上取整

```javascript
// 舍弃小数部分，整数部分加1
Math.ceil(3.4)
```

- Math.floor，数字向下取整

```javascript
// 舍弃小数部分，整数部分不变
Math.floor(4.68)
```

- Math.round，四舍五入取整

```javascript
// 取整，四舍五入原则
Math.round(5.46539)
Math.round(4.849)
```

- Math.max，在一组数中找出最大的

```javascript
// 找出最大值
Math.max(10, 21, 7, 24, 13)
```

- Math.min，在一组数中找出最小的

```javascript
// 找出最小值
Math.min(24, 18, 6, 19, 21)
```

- Math.pow，幂方法

```javascript
// 求某个数的多少次方
Math.pow(4, 2) // 求 4 的 2 次方
Math.pow(2, 3) // 求 2 的 3 次方
```

- Math.sqrt，平方根

```javascript
// 求某数的平方根
Math.sqrt(16)
```

数学对象提供了比较多的方法，这里不要求强记，通过演示数学对象的使用，加深对对象的理解。


