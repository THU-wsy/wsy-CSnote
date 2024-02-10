
# 第11章 字符串和字符串函数

## 11.1 字符串基本概念

双引号括起来的内容称为==字符串常量==，双引号中的字符和编译器自动加入末尾的'\0'字符都作为字符串存储在内存中。如果字符串常量之间没有间隔或用空白字符分隔，C会将其视为串联起来的字符串常量。

双引号括起来的内容被视为==指向该字符串存储位置的指针==。例如
```C
printf("%s, %p, %c", "We", "are", *"friends.");
```
将输出：

	We, 00007FF6FD0C9C34, f

字符串初始化方式：
```C
const char a1[10] = "limit"; //剩余元素默认初始化为\0
const char a2[10] = { 'l','i','m','i','t','\0' }; 
const char a3[] = "limit";
const char* p = "limit";
```
初始化数组的方式把静态存储区的字符串拷贝到数组中，而初始化指针只把字符串的地址拷贝给指针。采用初始化数组时可以不加const，从而可以修改数组中的变量；而采用==字符串常量初始化指针的方式必须使用const限定符==，意味着无法修改所指向的字符串。

字符串数组：
```C
const char* A[3] = { "123","+","321" };
char B[3][4] = { "123","+","321" };
```

## 11.2 字符串输入与输出

### 1. gets_s()和puts()

gets_s()第2个参数指明了读入字符的最大数量，如果该参数是n，那么gets_s()将==读入n-1个字符==；它只从标准输入中读取数据，所以不需要第3个参数；读到换行符会停止，然后==将该换行符丢弃==；如果读到最大字符数都没有读到换行符，会进行其他处理，见P287。

只需把字符串的地址作为参数传递给puts()即可；puts()遇到空字符'\0'就停止输出，然后在显示字符串时自动在其末尾==添加一个换行符==。

### 2. fgets()和fputs()

fgets()的第2个参数指明了读入字符的最大数量，如果该参数是n，那么fgets()将==读入n-1个字符==，或者读到遇到的第一个换行符为止；如果==fgets()读到一个换行符，会将它存储在字符串中==；fgets()的第3个参数指明要读入的文件，如果读入从键盘输入的数据，则以stdin作为参数；fgets()返回指向char的指针，一般返回的地址与第1个参数相同，但如果函数读到文件结尾会返回空指针NULL。

==fputs()不会在输出的末尾添加换行符==；它的第2个参数指明要写入数据的文件，如果要打印在显示器上，则以stdout作为参数。
```C
char words[10];
puts("输入一个字符串：");
fgets(words, 6, stdin);
fputs(words, stdout);
puts("输入另一个字符串：");
fgets(words, 6, stdin);
fputs(words, stdout);
```
将输出：(case 1)

	输入一个字符串：
	abc
	abc
	输入另一个字符串：
	abcdefgh
	abcde
(case 2)

	输入一个字符串：
	abcdefgh
	abcde输入另一个字符串：
	fgh
	 

对于第一种情况，fgets()的第2个参数为6, 所以将abc\n\0存储到数组中，然后fputs()输出abc\n，而另一个输入abcdefgh过长，所以将abcde\0存储到数组中，然后fputs()输出abcde。对于第二种情况，先读入abcde\0存储到数组中，然后fputs()输出abcde，紧接着fgets()继续读入剩余的fgh\n\0存储到数组中，然后fputs()输出fgh\n。

### 3. scanf()和printf()

scanf()更像是==获取单词==的函数，它从第1个非空白字符作为字符串的开始，如果使用%s转换说明，则以下一个空白字符(空行、空格、制表符或换行符)作为字符串的结束(字符串不包括空白字符)；如果使用指定了字段宽度的转换说明如==%10s，它将读取10个字符==或读到第1个空白字符停止。其返回值是一个整数，该值等于成功读取的项数或EOF(读到文件结尾)。

printf()也把字符串地址作为参数，它不会自动在每个字符串末尾加上换行符。
```C
char name1[11], name2[11];
int count;
printf("输入两个名字：\n");
count = scanf("%5s %10s", name1, name2);
printf("读取了%d个名字：%s和%s.", count, name1, name2);
```
将输出：

	输入两个名字：
	Portensia Callowit
	读取了2个名字：Porte和nsia.

## 11.3 字符串函数

### strlen()

统计字符串长度，长度不包括末尾的\0，用法为strlen(str)

### strcat()和strncat()

strcat()接受两个字符串作为参数，用于拼接字符串，将第2个字符串的备份附加在第1个字符串末尾，并把拼接后形成的新字符串作为第1个字符串，第2个字符串不变。返回类型是char*，返回第1个字符串的地址。

为了弥补strcat()无法检查第1个数组是否能容纳第2个字符串的缺陷，strncat()的第3个参数制定了最大添加字符数，例如strncat(str1,str2,13)将str2的内容附加给str1，在加到第13个字符或遇到空字符时停止，所以原数组的长度应足够大以容纳str1(不包括空字符)、str2的13个字符以及末尾的空字符。

### strcmp()和strncmp()

strcmp()用于比较字符串的内容，==若相等则返回0==；若第1个字符串在字母表位于第2个字符串前面，则返回-1(有的系统会返回两者ASCII码之差，但无论如何总返回一个负数)；反之，返回1

strncmp()其第3个参数限定了参与比较的字符数，例如第3个参数是n，则只比较两个字符串的前n个字符

### strcpy()和strncpy()

函数strcpy()用于拷贝字符串，==将第2个参数指向的字符串(源字符串)拷贝至第1个参数指向的数组中(目标字符串)==；返回类型是char*，返回第一个参数的地址；strcpy()把源字符串中的空字符也拷贝在内。

函数strncpy()的第3个参数指明可拷贝的最大字符数，比如参数为n，将拷贝源字符串中的n个字符或空字符之前的所有字符(包括空字符)，注意如果拷贝到第n个字符时还未拷贝完整个源字符串，就不会拷贝空字符。

### sprintf()

该函数类似于printf()，但作用却不同，其第1个参数是目标字符串的地址，其余参数与printf()相同(不仅可以含%s,也可以含%d等转换说明)；作用是获取输入，并将其格式化为标准形式，==然后把格式化后的字符串储存在第1个参数的字符串中==，而不是打印在显示器上。

### 其余常用字符串函数

```C
char* strchr(const char* s, int c);
```
如果字符串s中包含c字符，则返回指向s字符串首次出现的c字符的指针(末尾的空字符也在查找范围内)，如果未查找到c字符，返回空指针

```C
char* strpbrk(const char* s1, const char* s2);
```
如果s1字符串中包含s2字符串中的任意字符，则返回指向s1字符串首位置的指针；否则返回空指针

```C
char* strrchr(const char* s, char c); 
```
返回s字符串中c字符最后一次出现的位置，如果未找到c字符则返回空指针

```C
char* strstr(const char* s1, const char* s2);
```
返回指向s1字符串中s2字符串出现的首位置，若s1中没有找到s2则返回空指针


## 11.4 字符串转数字

==atoi()==用于把字母数字转换为整数，该函数接受一个字符串作为参数，返回相应的整数值
```C
printf("%d", atoi("136abc"));
```
将输出

	136

==atof()==将字符串转换成double类型的值，==atol()==将字符串转换为long类型的值

==strtol()==把字符串转换成long类型的值，==strtoul()==把字符串转换为unsigned long类型的值，==strtod()==把字符串转换为double类型的值。这几个函数的智能之处在于能报告字符串中的首字符是否是数字。并且，strtol()和strtoul()还可以指定数字的进制。例如strtol()函数原型如下：
```C
long strtol(const char* restrict nptr, char** restrict endptr, int base);
```
```C
char number[30]; char* end; long value;
scanf("%s", number); 
value = strtol(number, &end, 10);
printf("十进制输出为%ld，结束字符为%d，剩余字符串为%s\n",value,*end,end);
value = strtol(number, &end, 16);
printf("十进制输出为%ld，结束字符为%d，剩余字符串为%s\n", value, *end, end);
```
输出为：

	10
	十进制输出为10，结束字符为0，剩余字符串为
	十进制输出为16，结束字符为0，剩余字符串为
	 
 
	10atom
	十进制输出为10，结束字符为97，剩余字符串为atom
	十进制输出为266，结束字符为116，剩余字符串为tom
	 
其余如strtod()函数只能以十进制转换，因此只需要两个参数。

许多实现使用itoa()和ftoa()函数分别把整数和浮点数转换成字符串，但最好用==sprintf()==代替它们

# 第12章 存储类别、链接和内存管理

## 12.1 内存分配

C的5种存储类别：自动；寄存器；静态、无链接；静态、外部链接；静态、内部链接

malloc()和free():

malloc()==接受一个参数：所需内存字节数==，然后进行动态内存分配，返回首字节地址

free()的==参数是之前malloc()返回的地址，用于释放之前malloc()分配的内存==
```C
double* ptr = (double*) malloc(30 * sizeof(double));
free(ptr);
```

函数calloc()也可用作动态内存分配，它与malloc()，但接受两个无符号整数作为参数，第1个参数是所需的存储单元数量，第2个参数是存储单元的大小(以字节为单位)。同样也可以用free()释放其所分配的内存

## 12.2 限定符

- const限定符
	> const int\* ptr; 创建的ptr指向不能被改变的值，而ptr本身的值可以改变
	> int const\* ptr; 与上述定义相同
	> int\* const ptr; 创建的ptr指针本身的值不能改变，但他所指向的int变量的值可以改变
	
- volatile限定符
该限定符告知计算机，代理(而不是变量所在的程序)可以改变该变量的值，通常它被用于硬件地址以及在其他程序或同时运行的线程中共享数据

- restrict限定符
该限定符允许编译器优化某部分代码以更好地支持运算，它只能用于指针，表明该指针是访问数据对象的唯一且初始的方式

# 第13章 文件输入输出

## 13.1 文件I/O函数

### fopen()

第1个参数是待打开文件的名称，更确切地说是一个包含该文件名的字符串地址，第2个参数是一个字符串，指定待打开文件的模式

|参数|作用|
|---|---|
|"r"|读|
|"w"|写，把现有文件长度截为0，若文件不存在，则创建一个新文件|
|"a"|写，在现有文件末尾添加内容，若文件不存在，则创建一个新文件|
|"r+"|读和写|
|"w+"|读和写，把现有文件长度截为0，若文件不存在，则创建一个新文件|
|"a+"|读和写，在现有文件末尾添加内容，若文件不存在，则创建一个新文件；可以读整个文件，但只能从末尾添加内容|
|"rb"、"wb"、"ab"、<br>"rb+"、"r+b"、<br>"wb+"、"w+b"、<br>"ab+"、"a+b"|与上一个模式类似，但是以二进制模式而不是文本模式打开文件|
|"wx"、"wbx"、"w+x"、<br>"wb+x"或"w+bx"|类似非x模式，但是如果文件已存在或以独占模式打开文件，则打开文件失败；即用"w"打开一个现有文件会把文件长度截为0，但用"wx"打开，fopen()操作失败，而原文件内容也不会被删除|

程序成功打开文件后==fopen()返回文件指针FILE\*==，FILE是一个定义在stdio.h中的派生类型，其他I/O函数也可以使用该指针指定该文件。

### fclose()

用==fclose(fp)关闭fp指定的文件==，成功关闭返回0，否则返回EOF

### getc()和putc()

==它们与getchar()和putchar()函数类似，但还要传递最后一个参数告诉函数使用哪一个文件==
```C
FILE* fp1 = fopen("文件1.txt", "r");
FILE* fp2 = fopen("文件2.txt", "w");
char ch = getc(fp1);
putc(ch, fp2);
char chstd = getchar(); //等同于getc(stdin)
putchar(chstd); //等同于putc(chstd, stdout)
fclose(fp1); fclose(fp2);
```

getc()在读取一个字符时发现是文件结尾会返回EOF

指向标准文件的指针有stdin、stdout、stderr(标准错误)，它们都是指向FILE的指针，所以可用作I/O函数的参数

### fprintf()和fscanf()

工作方式与printf()和scanf()类似，但==需要用第1个参数指定待处理的文件==

函数rewind()接受一个文件指针作为参数，使得程序回到文件开始处

## 13.2 随机访问

函数fseek()有3个参数，第1个参数是FILE指针，指向待查找的文件，fopen()应该已打开该文件，第2个参数是偏移量，该参数表示从起始点开始要移动的距离，该参数是long类型的值，可以为正负或0，分别表示前移、后移和保持不动，第3个参数是模式，该参数确定起始点，SEEK_SET表示文件开始处，SEEK_CUR表示当前位置，SEEK_END表示文件末尾。返回值类型是int，如果一切正常则返回0，如果出现错误则返回-1
```C
FILE* fp = fopen("文件1.txt", "r");
fseek(fp, 0L, SEEK_SET); //定位至文件开始处
fseek(fp, 10L, SEEK_SET); //定位至文件中的第10个字节
fseek(fp, 2L, SEEK_CUR); //从文件当前位置前移2个字节
fseek(fp, -10L, SEEK_END); //从文件结尾处回退10个字节
fclose(fp);
```

函数ftell()以一个FILE指针作为参数，返回类型是long，返回的是参数指向文件的当前位置距文件开始处的字节数，文件的第1个字节到文件开始处的距离是0，以此类推，该定义适用于以二进制模式打开的文件

## 13.3 其他I/O函数

```C
int ungetc(int c, FILE* fp);
```
把c指定的字符放回输入流中。例如把一个字符放回标准输入流，那么下次调用标准输入函数时将读取该字符。

```C
int fflush(FILE* fp);
```
引起输出缓冲区中所有的未写入数据被发送到fp指定的输出文件

```C
int setvbuf(FILE* restrict fp, char* restrict buf, int mode, size_t size);
```
创建了一个供标准I/O函数替换使用的缓冲区

```C
size_t fwrite(const void* restrict ptr, size_t size, size_t nmemb, FILE* restrict fp);
```
把二进制数据写入文件，返回成功写入项的数量

```C
size_t fread(void* restrict ptr, size_t size, size_t nmemb, FILE* restrict fp);
```
读取二进制数据，返回成功读取项的数量

```C
int feof(FILE* fp);
int ferror(FILE* fp);
```
当上一次输入调用检测到文件结尾时，feof()返回一个非0值，否则返回0;
当读或写出现错误，ferror()函数返回一个非0值，否则返回0.

# 第14章 结构和其他数据形式

## 14.1 结构的一些性质

### 伸缩型数组成员

特点：该数组不会立即存在，使用它可以编写合适的代码，就好像它确实存在并具有所需数目的元素一样

规则：伸缩型数组成员必须是struct的最后一个成员，其声明类似普通数组，但方括号中为空
```c
struct flex {
    int count;
    double scores[];
};
    flex* pf;
    pf =(flex*) malloc(sizeof(struct flex) + 5 * sizeof(double));
    pf->scores[2] = 98.2;
```

注：带伸缩型数组成员的结构有一些特殊的处理要求：不能用结构进行赋值或拷贝；不要以按值方式把这种结构传递给函数；不要使用带伸缩型数组成员的结构作为数组成员或另一个结构的成员

### 匿名结构

```c
struct person {
    int id;
    struct { char first[20]; char last[20]; }; //匿名结构
};
    person ted = { 1998,{"Ted","Grass"} };
    puts(ted.first); //只需把first看作是person的成员那样使用它
```

## 14.2 联合简介

联合能在同一个内存空间中存储不同数据类型(但不是同时存储)，例如
```c
union hold {
    int digit;
    double bigfl;
    char letter;
};
```
根据以上形式声明的union只能存储一个int类型或一个double类型或一个char类型的值，而以上无论哪种类型的union大小都相等(编译器分配足够的空间使得union能存储其声明中占用最大字节的类型，以上即按最大的double分配8字节)

初始化联合有2种方式：把一个联合初始化为另一个同类型的联合；初始化联合的第1个元素。
```c
    hold valA;
    valA.letter = 'R';
    hold valB = valA; //用另一个联合来初始化
    hold valC = { 88 }; //初始化联合的第一个成员digit
```

联合的一些用法:
```c
    hold fit;
    fit.digit = 23; //把23存储在fit
    fit.bigfl = 2.0; //清除23，存储2.0
    fit.letter = 'h'; //清除2.0，存储'h'
```

匿名联合与匿名结构的工作原理类似

## 14.3 枚举类型

枚举类型声明符号名称来表示整型常量，使用enum关键字，可以创建一个新类型并指定它可具有的值(实际上，enum常量是int类型)，它的语法与结构的语法相同。默认情况下枚举列表中的常量从0开始赋值，然后递增，也可以为枚举常量指定整数值，后面的常量会默认被赋予后续的值。
```c
    //创建spectrum作为标记名，允许将其作为一个类型名使用
    enum spectrum { red, orange, yellow, green = 100, blue, violet = 200 };
    //red=0, orange=1, yellow=2, green=100, blue=101, violet=200
    spectrum color; //创建一个spectrum型变量
    color = blue; //blue是一个有名称的常量，代表整数101
    switch (color) {
    case red: puts("红色"); break;
    case blue: puts("蓝色"); break;
    }
    printf("%d %d", red, blue); //将输出0 101
```

## 14.4 typedef简介

typedef的一些特性与#define功能重合，例如
```c
typedef unsigned char BYTE;
#define BYTE unsigned char
```
两者功能类似

typedef与#define的区别在于：
- 与#define不同，typedef创建的符号名只受限于类型，不能用于值
- typedef由编译器解释，不是预处理器
- 在其受限范围内，typedef比#define更灵活
例如：
```c
typedef char* STR;
STR name, sign; //相当于char* name, * sign;
```
```c
#define STR char*
STR name, sign; //相当于char* name, sign;
```

typedef也常用于给复杂的类型命名，例如下面的声明
```c
typedef char(*FRPTC())[5];
```
将FRPTC声明为一个函数类型，该函数返回一个指针，该指针指向内含5个char类型元素的数组

复杂声明的示例：
```c
    int board[8][8]; //声明一个内含int数组的数组
    int** ptr; //声明一个指向指针的指针，被指向的指针指向int
    int* risks[10]; //声明一个内含10个元素的数组，每个元素都是一个指向int的指针
    int(*rusks)[10]; //声明一个指向数组的指针，该数组内含10个int类型的值
    int* oof[3][4]; //声明一个3*4的二维数组，每个元素都是指向int的指针
    int(*uuf)[3][4]; //声明一个指向3*4的二维数组的指针，该数组中内含int类型值
    int(*uof[3])[4]; //声明一个内含3个指针的数组，每个指针指向内含4个int元素的数组
    char* fump(int); //返回字符指针的函数
    char (*frump)(int); //指向函数的指针，该函数的返回类型为char
    char (*flump[3])(int); //内含3个指针的数组，每个指针指向返回类型为char的函数
```
规则：
- 数组名后面的\[\]和函数名后面的()具有相同的优先级，他们比解引用运算符\*的优先级高。因此int\* risks\[10\];声明一个指针数组，而不是指向数组的指针
- \[\]和()优先级相同，都是从左往右结合。因此int(\*rusks)\[10\];声明一个指向数组的指针，该数组内含10个int类型的元素；int\* oof\[3\]\[4\];声明一个内含3个元素的数组，每个元素是由内含4个指向int的指针组成的数组

从而可以使用typedef建立一系列相关类型：
```c
    typedef int arr5[5];
    typedef arr5* p_arr5;
    typedef p_arr5 arrp10[10];
    arr5 togs; //tog是一个内含5个int类型值的数组
    p_arr5 p2; //p2是一个指向数组的指针，该数组内含5个int类型值
    arrp10 ap; //ap是一个内含10个指针的数组，每个指针都指向一个内含5个int的数组
```

## 14.5 函数指针

声明函数指针时必须指明函数的返回类型和形参类型
```c
void show(void (*fp)(char*), char* str) {
    (*fp)(str); //把所选函数作用于str
    puts(str); //显示结果
}
void ToUpper(char*); //函数原型声明
int main() {
    void (*pf)(char*); //pf是一个函数指针，指向的函数返回值为void，形参为char*
    pf = ToUpper; //函数名表示函数的地址，将函数地址ToUpper赋值给函数指针pf
    char mis[] = "Nina Metier";
    (*pf)(mis); //把ToUpper作用于mis(语法1)
    pf(mis);  //把ToUpper作用于mis(语法2)，这两种函数指针调用函数的方式等价
    //函数指针最常见的用法是作为函数的参数
    show(ToUpper, mis); //调用show函数
    show(pf, mis); //等价调用
    return 0;
}
```

# 第16章 C预处理器和C库

## 16.1 明示常量#define

### 预处理前

在预处理前，编译器会对程序作一些翻译处理，分为四步：
- 首先编译器将源代码中出现的字符映射到源字符集
- 第二，编译器定位每个反斜杠后面跟着换行符的实例，并删除他们。即将以下多个物理行
    ```c
        printf("That's wond\
       erful!\n");
    ```
    转换成一个逻辑行
    ```c
        printf("That's wond  erful!\n"); //要想没空格，第2行必须从顶格开始写
    ```
    由于预处理表达式长度必须是一个逻辑行，所以这一步为预处理器做好了准备工作
- 第三，编译器把文本划分成预处理记号序列、空白序列和注释序列(记号是由空格、制表符或换行符分隔的项)。编译器用一个空格字符替换每一条注释，比如
    ```c
        int/*aaa*/a;
    ```
    将变成
    ```
        int a;
    ```
- 最后程序已经准备好进入预处理阶段，预处理器查找一行中以#号开始的预处理指令

### 明示常量#define

预处理器指令从#开始运行，到后面的第1个换行符为止。每行#define由三部分组成，第1部分是#define指令本身，第2部分是选定的缩写，称为宏，第3部分称为替换列表或替换体。一旦预处理器在程序中找到宏的示实例后，就会用替换体代替该宏(双引号中的宏不会被替换，因为会被视作字符串)，从宏变成最终替换文本的过程称为宏扩展。

有些宏代表值，称为类对象宏，有的宏可以使用参数，称为类对象宏，可以有一个或多个参数，随后这些参数出现在替换体中。

在类函数宏的替换体中，#号作为一个预处理运算符，可以把记号转换为字符串。比如x是一个宏形参，那么#x就是转换为字符串"x"的形参名，这一过程称为字符串化

```c
#define _CRT_SECURE_NO_DEPRECATE
#define STR "字符串"
#define TWO 2
#define SQUARE1(x) x*x
#define SQUARE2(x) (x)*(x)
#define SQUARE3(x) ((x)*(x))
#define PR(x) printf("The square of " #x " is %d.",((x)*(x)))
int main() {
    printf("STR:%s\n", STR);
    printf("%d\n", SQUARE1(5 + 2)); //5+2*5+2
    printf("%d\n", 100 / SQUARE2(5)); //100/5*5
    printf("%d\n", 100 / SQUARE3(2 + 3)); //SQUARE3的定义是合理的
    PR(2 + 4); //注意宏定义中用到了字符串拼接的性质
}
```
将输出
    
    STR:字符串
    17
    100
    4
    The square of 2 + 4 is 36.

\#\#运算符是预处理器黏合剂，它可用于类函数宏的替换体，也可用于对象宏的替换体，作用是把两个记号组合成一个记号。比如#define XNAME(n) x\#\#n  就会将宏XNAME(4)展开为x4
```c
#define XNAME(n) x##n
#define PR_XN(n) printf("x" #n " = %d. ",x##n)
int main() {
    int XNAME(1) = 14;
    int x2 = 20;
    PR_XN(1);
    PR_XN(2);
}
```
将输出

    x1 = 14. x2 = 20.

还可使用变参宏，通过把宏参数列表中==最后的参数==写成省略号(3个点)来实现这一功能，然后将预定义宏\_\_VA\_ARGS\_\_用在替换部分中，表明省略号代表什么

```c
#define PRT(X,...) printf("Message " #X ": " __VA_ARGS__)
int main(){
    PRT(1, "x = %d\n", 48);
    PRT(2, "x = %d, y = %d.", 48, 24);
}
```
将输出

    Message 1: x = 48
    Message 2: x = 48, y = 24.

### 头文件

使用头文件的一个用处是可以在头文件中声明外部变量供其他文件共享，比如已经开发了共享某个变量的一系列函数，则可以在包含这些函数声明的源代码文件定义一个文件作用域的外部链接变量(比如int status=0; //该变量具有文件作用域，在源代码文件中)，然后可以在于源代码文件相关联的头文件中进行引用式声明(extern int status; //在头文件中)，这行代码会出现在包含了该头文件的文件中，这样使用该系列函数的文件都能使用这个变量。需要包含头文件的其他情况例如，使用具有文件作用域、内部链接和const限定符的变量或数组，const防止值被以外修改，static意味着每个包含该头文件的文件都获得一份副本。

头文件limits.h中包含如下定义：
\#define INT_MAX +32767
\#define INT_MIN  -32768

## 16.2 其他指令

1. 指令\#undef
    用于取消已定义的#define指令。例如
    ```c
    #define LIMIT 400
    #undef LIMIT
    ```
    将移出上面定义的LIMIT。事实上，即使原来没有定义LIMIT，取消LIMIT的定义仍然有效。一些预定义宏如\_\_DATE\_\_或\_\_FILE\_\_是无法取消定义的。

2. 条件编译
    可以使用这些指令告诉编译器根据编译时的条件执行或忽略信息(代码)块
    ```c
    #ifdef MAVIS
    #include "horse.h" //如果已经用#define定义了MAVIS，则执行下面指令
    #define STABLES 5
    #else
    #include "cow.h" //否则，执行下面指令
    #define STABLES 15
    #endif
    ```
    \#ifndef指令判断后面的标识符是否是未定义的，常用于定义之前未定义的常量；也通常用于防止多次包含一个文件
    ```c
    #ifndef SIZE
    #define SIZE 100 //定义常量
    #endif
    #ifndef THINGS
    #define THINGS //防止头文件被重复包含
    #endif
    ```
    \#if后面跟整型常量表达式，如果表达式非零，则表达式为真
    ```c
    #if defined (VAX) //用#if defined代替#ifdef，以便于配合#elif一起使用
    #include "vax.h"
    #elif SYS==1
    #include "ibm.h"
    #else
    #include "gen.h"
    #endif
    ```

3. 预定义宏
4. \#line和\#error
5. \#pragma
6. 泛型选择\_Generic

(以上内容见书P462)

## 16.3 数学库

```c
    double acos(double x) //以下函数头文件均在#include <cmath>
    double asin(double x)
    double atan(double x)
    double atan2(double y, double x) //返回正切值为y/x的角度，-π到π弧度
    double cos(double x)
    double sin(double x)
    double tan(double x)
    double exp(double x) //e^x
    double log(double x) //lnx
    double log10(double x)
    double pow(double x, double y)
    double sqrt(double x)
    double cbrt(double x) //返回x的立方根值
    double ceil(double x)
    double fabs(double x)
    double floor(double x)
```

## 16.4 通用工具库cstdlib

### exit()和atexit()

见书P472

### qsort()

函数qsort()是快速排序算法，其原型是
```c
void qsort(void* base, size_t nmemb, size_t size, 
           int (*compar)(const void*, const void*));
```
第1个参数是指针，指向待排序数组的首元素；第2个参数是待排序项的数量；第3个参数指明待排序数组中每个元素的大小；第4个参数是一个函数指针，指向的比较函数用于确定排序顺序，该函数接受两个参数，分别指向待比较两项的指针，如果第1项的值大于第2项，则返回正数，如果两项相等，返回0，如果第1项的值小于第2项，则返回负数。

```c
struct student {
    int score;
    char name[10];
};
int comp(const void* p1, const void* p2) {
    const student* ps1 = (const student*)p1;
    const student* ps2 = (const student*)p2;
    int res = ps1->score - ps2->score;
    if (res != 0) return res; //先按分数升序排序
    else return strcmp(ps1->name, ps2->name); //分数相等再按名字升序排序
}
int main(){
    student a[3] = { {98,"aaa"},{94,"bbb"},{94,"ccc"} };
    qsort(a, 3, sizeof(student), comp);
    printf("a[0]%s的成绩为%d\n", a[0].name, a[0].score);
    printf("a[1]%s的成绩为%d\n", a[1].name, a[1].score);
    printf("a[2]%s的成绩为%d\n", a[2].name, a[2].score);
}
```
将输出

    a[0]bbb的成绩为94
    a[1]ccc的成绩为94
    a[2]aaa的成绩为98
     
### bsearch()

```c
int* it = (int*) bsearch(&num, c.data(), c.size(), sizeof(int), compare);
```

## 16.5 断言库assert.h

断言库由assert()宏组成，接受一个整型表达式作为参数，如果表达式求值为假，assert()宏就在标准错误流stderr中写入一条错误信息，并调用cstdlib中的函数abort()终止程序。如果认为已经排除了程序的bug，就可以把宏定义#define NDEBUG写在包含assert.h的位置前面，这样编译器就会禁用文件中的所有assert()语句

\_Static\_assert声明可以在编译时检查，它接受两个参数，第1个参数是整型常量表达式，第2个参数是一个字符串，如果第1个表达式求值为0，编译器会显示字符串，并且不编译该程序。

## 16.6 库cstring中的其他函数

由于不能将一个数组赋给另一个数组，所以可用函数memcpy()或者memmove()函数执行该操作。
```c
void* memcpy(void* restrict s1, const void* restrict s2, size_t n);
void* memmove(void* s1, const void* s2, size_t n);
```
==这两个函数都从s2指向的位置拷贝n字节到s1指向的位置，而且都返回s1的值==。不同的是，memcpy()的参数带关键字restrict，意味着它假设两个内存区域之间没有重叠，所以我们使用它时要确保没有重叠；而memmove()不作这样的假设，所以拷贝过程类似于先把所有字节拷贝到一个临时缓冲区，然后再拷贝到最终目的地。这两个函数的第3个参数指明带拷贝的字节数，比如要拷贝含10个double类型的元素的数组，则第3个参数要用10\*sizeof(double)

头文件stdarg.h提供了可变参数，见书P481

# 其余章节

## 第3章 数据和C

以下讨论用于printf()的转换说明

### int类型

转换说明==%d(或%i)以十进制显示数字==，%o以八进制显示数字，%x(或%X)以十六进制显示数字。如果要显示各进制数的前缀，如0(八进制)，0x或0X(十六进制)，则要用对应转换说明%#o，%#x，%#X
要注意上述使用==八进制或者十六进制打印，只能用于无符号整数==

### 其他整数类型

- 打印==unsigned int值，使用%u==
- ==打印long类型的值，使用l前缀==，如果以十进制打印，使用==%ld==；如果要以八进制打印，使用%lo；如果要以十六进制打印，使用%lx
- ==打印short类型的值，使用h前缀，%hd==，%ho，#hx
- h和l前缀都可以和u一起使用，用于表示无符号类型，例==如%lu表示unsigned long，%hu表示unsigned short==
- 对于long long类型，使用==%lld(有符号)，%llu(无符号)==

### char类型

一个字符变量实际上被存储为1字节的整数值，所以用%d打印char类型变量的值，打印的是一个整数，而用==%c==则打印该整数值对应的字符

### 浮点型变量

- 十进制浮点数的指数记数法，如4e16
- 十六进制浮点数的指数计数法，前缀加0x或0X，用p和P分别代替e和E，用2的幂代替10的幂。如0xa.1fp10表示的十进制数值为$(10+1/16+15/256)\times 2^{10}$
- 用==%f打印float和double==类型，用%e或%E打印指数记数法的浮点数，如果要打印十六进制的，则用a和A代替e和E
- 用==%g==则会根据值的不同自动选择%f或%e，%e格式用于指数小于-4或者大于等于精度时；用%G则会根据值的不同自动选择%f或%E，同上
- 打印==long double类型要用%Lf==，%Le或%La

### sizeof()

sizeof()的返回类型用转换说明%zd匹配；指针用%p；字符串用%s；\%\%打印一个百分号

### printf()的转换说明修饰符和标记

![](images/20230329211853.png)

![](images/20230329211905.png)

![](images/20230329211915.png)

![](images/20230329211923.png)

详细示例见书P73
==printf()的返回值(int)是它打印字符的个数，如果输出错误则会返回一个负值==

## 第4章 字符串和格式化输入

以下讨论用于scanf()的转换说明

函数scanf()使用空白(换行符、制表符和空格)把输入分成多个字段，在依次把转换说明和字段匹配时跳过空白。唯一例外的是%c转换说明，根据%c，scanf()会读取每个字符，包括空白。scanf()所用的转换说明与printf()函数几乎相同，唯一要注意%f、%e、%g只能用于float类型，==对于double类型要用l修饰符，即%lf，%le或%lg==。如果使用%s转换说明，当scanf()把字符串放进指定数组中时，会在字符序列末尾加上'\0'使其成为一个C字符串

![](images/20230329212121.png)

![](images/20230329212131.png)

格式字符串中的普通字符：scanf()允许把普通字符放在格式字符串中，但除空格字符外的普通字符必须与输入字符严格匹配。例如scanf("%d,%d", &n, &m); 则scanf()函数将其解释成，用户将输入一个数字、一个逗号、然后在输入一个数字，即必须像88,121这样输入两个整数。而==格式字符串中的空白意味着跳过下一个输入值前面所有的空白==，注意除了%c，其他转换说明都会自动跳过待输入值前面的所有空白，因此scanf("%d%d", &n, &m)与scanf("%d  %d", &n, &m)行为相同。但是对于%c，如果空格在%c前面，如scanf("  %c", &ch)，它会从第1个非空白字符开始读取，但是如scanf("%c", &ch)，它就会从输入中的第1个字符开始读取。

scanf()的返回值(int)是成功读取的项数(不是字符数)，如果没有读取任何项，且需要读取一个数字而用户却输入一个非数值字符串，scanf()便返回0，当scanf()检测到文件结尾时会返回EOF(EOF是stdio.h中定义的特殊值，通常用#define指令把EOF定义为-1)

printf()和scanf()的\*修饰符：
- 对于printf()，如果你不想预先指定字段宽度，希望通过程序来指定，那么可以用\*修饰符代替字段宽度。但还是要用一个参数告诉函数，字段宽度应该是多少，也就是说，如果转换说明是%\*d，那么参数列表中应包含\*和d对应的值
- 对于scanf()，==把\*放在%和转换字符之间时，会使得scanf()跳过相应的输入项==，比如scanf("%\*d %\*d %d", &n); 输入为 2013 2014 2015，则会跳过2013和2014，读取2015拷贝给n

## 第8章 字符输入输出和输入验证

### 字符输入输出函数getchar()和putchar()

函数getchar()不带任何参数，读取下一个字符输入并把该字符作为返回值返回。例如
char ch=getchar(); 该语句与scanf("%c", &ch)效果相同。getchar()读取文件检测到文件结尾时返回EOF。getchar()同转换说明%c一样，也会读取每个字符，包括空格、制表符和换行符

函数putchar()打印它的参数。例如putchar(ch); 该语句与printf("%c", ch)效果相同

### ctype.h系列的字符函数

这些函数接受一个字符作为参数，如果该字符属于某特殊类别就返回一个非零值，否则返回0

![](images/20230329212538.png)

## 第10章 数组和指针

指针加1指的是增加一个存储单元，对数组而言，这意味着加1后的地址是下一个元素的地址，而不是下一个字节的地址。所以指针可以与整数相加，即整数会与指针所指向类型的大小(以字节为单位)相乘，然后把结果与初始地址相加。

指针还可以递增、递减、减去一个整数。指针可以求差，计算两个指针的差值(要两个指针都指向相同的数组，差值即为相差的元素个数)。还可以用关系运算符比较两个指针。

多维数组
```c
int zippo[4][2];
```
- zippo是一个占用两个int大小对象的地址，zippo\[0\]是一个占用一个int大小对象的地址，由于这个内含两个整数的数组和这个整数都开始于同一个地址，所以zippo与zippo\[0\]的值相同
- 给指针或地址加1，其值会增加对应类型大小的数值。所以zippo加1会增加两个int大小，而zippo\[0\]加1只会增加一个int大小
- \*(zippo)即zippo\[0\]，\*(zippo\[0\])即zippo\[0\]\[0\]，所以\*\*zippo即为zippo\[0\]\[0\]




