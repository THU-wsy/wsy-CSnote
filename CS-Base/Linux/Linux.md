# 第01章_Linux简介

## 1. 简介

Linux，全称GNU/Linux，是一个基于POSIX的多用户、多任务、支持多线程和多CPU的操作系统。Linux内核由Linus Benedict Torvalds在赫尔辛基大学上学时出于个人爱好而编写，于1991年10月5日首次发布，它主要受到Minix和Unix思想的启发，是一个**开源的类Unix操作系统**。

Linux操作系统的特点：

1. **一切皆文件**：Linux系统中的一切都被视为文件，包括命令、硬件和软件设备等
2. 开源免费
3. 兼容POSIX.0标准
4. 支持多用户
5. 支持多种硬件平台

Linux最广泛的应用场景是**作为服务器的操作系统**，因为Linux系统具有以下优势：

1. **安全性高**
2. **稳定性强**
3. **节省资源**

## 2. Linux的发行版本

严格来讲，Linux指的仅仅是Linux内核，而它有很多发行版本，主要有RedHat家族和Debian家族。

### 2.1 RedHat家族

RedHat家族主要包括以下发行版本：

-   RedHat企业版：这个发行版本需要授权费
-   **CentOS**：全名为"社区企业操作系统"，它将RedHat企业版的所有源代码下载下来进行了重新编译，所以CentOS与RedHat企业版功能一致。
-   Fedara：被RedHat公司定位为新技术的实验场地，许多新的技术都会在其中检验

### 2.2 Debian家族

Debian家族主要包括以下发行版本：

-   Debian：运行起来极其稳定，这使得它非常适合用于服务器，Debian这款操作系统并不适合新手用户，而是适合系统管理员和高级用户。
-   **Ubuntu**：Debian的一款衍生版，也是当今最受欢迎的免费操作系统，是一个以桌面应用为主的Linux操作系统

## 3. Linux的目录结构

> 说明：不同版本的Linux目录结构可能略有不同

- **/bin，/usr/bin，/usr/local/bin**：是Binary的缩写，这个目录存放着最经常使用的命令。Linux默认的环境变量已经包含该路径（可以使用`echo $PATH`命令来查看系统环境变量），所以可以直接使用该路径下的指令。
- /sbin，/usr/sbin，/usr/local/sbin：s指的是Super User，所以这里存放的是系统管理员使用的系统管理程序。
- **/home**：存放普通用户的**主目录**。在Linux中每个用户都有一个自己的主目录，一般该目录名是以用户的账号命名的。
- **/root**：系统管理员（超级权限者root）的用户**主目录**。
- /lib：系统开机所需要最基本的动态链接共享库，其作用类似于Windows里的DLL文件。几乎所有的应用程序都需要用到这些共享库。
- **/etc**：所有的系统管理所需要的配置文件和子目录。
- **/usr**：这是一个非常重要的目录，用户的很多应用程序和文件都放在这个目录下，类似于Windows下的program files目录。
- **/boot**：存放的是启动Linux时使用的一些核心文件，包括一些连接文件以及镜像文件。
- /proc：这个目录是一个虚拟的目录，它是系统内存的映射，我们可以通过直接访问这个目录来获取系统信息。
- /srv：service的缩写，该目录存放一些服务启动之后需要提取的数据。
- /sys：这是Linux2.6内核的一个很大的变化，该目录下安装了2.6内核中新出现的一个文件系统sysfs。
- /tmp：这个目录是用来存放一些**临时文件**的，该目录中的文件会定期删除。
- **/dev**：Device(设备)的缩写，类似Windows的设备管理器，把所有的硬件用文件的形式存储。
- /media：Linux系统会自动识别一些设备，例如U盘、光驱等等，当识别后，Linux会把识别的设备挂载到这个目录下。
- **/mnt**：系统提供该目录是为了让用户临时挂载别的文件系统的。
- **/var**：这个目录中存放着在不断扩充着的东西，我们习惯将那些经常被修改的目录放在这个目录下，包括各种日志文件。
- **/opt**：这是给主机**额外安装软件**所摆放的目录。比如**安装JDK、Tomcat则就可以放到这个目录下**。
- **/usr/local**：这是另一个给主机**额外安装软件**所摆放的目录，一般是**通过编译源码方式安装的程序**。



# 第02章_Linux的安装

## 1. 创建虚拟机

VMware是一款用于创建虚拟计算机的软件。创建虚拟机的步骤如下：

![](images/Snipaste20231216194734.png)

![](images/Snipaste20231216194916.png)

![](images/Snipaste20231216194854.png)

![](images/Snipaste20231216195007.png)

![](images/Snipaste20231216195200.png)

![](images/Snipaste20231216195252.png)

![](images/Snipaste20231216195335.png)

![](images/Snipaste20231216195357.png)

![](images/Snipaste20231216195423.png)

![](images/Snipaste20231216195441.png)

![](images/Snipaste20231216195509.png)

![](images/Snipaste20231216195626.png)

![](images/Snipaste20231216195651.png)

## 2. 安装Linux操作系统

我们首先需要下载Linux的ISO镜像文件，这里选择的版本是Centos7.9，可以从清华大学镜像源网站进行下载 https://mirrors.tuna.tsinghua.edu.cn/

![](images/Snipaste20231216195852.png)

![](images/Snipaste20231216195941.png)

开机后按向上键选择Install CentOS 7并回车

![](images/20231216200355.png)

![](images/20231216200619.png)

![](images/20231216200724.png)

![](images/20231216200817.png)

![](images/20231216200929.png)

![](images/20231216201041.png)

![](images/20231216201217.png)

![](images/20231216201305.png)

然后再创建一个分区：

![](images/20231216201547.png)

然后再创建一个分区：

![](images/20231216201634.png)

![](images/20231216201716.png)

![](images/20231216201839.png)

![](images/Snipaste20231216202114.png)

![](images/Snipaste20231216202323.png)

![](images/20231216202624.png)

![](images/20231216202933.png)

开始安装，然后设置root的密码即可：

![](images/20231216203056.png)

安装完成后重启即可

## 3. 克隆虚拟机

> 我们在未来会通过克隆虚拟机的方式来快速复制创建一个虚拟机。

选择要克隆的虚拟机，右键->管理->克隆

![](images/Snipaste20231216204459.png)

![](images/Snipaste20231216204612.png)

![](images/Snipaste20231216204728.png)

启动克隆好的虚拟机，修改克隆机的IP地址：

```shell
vi /etc/sysconfig/network-scripts/ifcfg-ens33
```

> 将IPADDR修改成自己想要的IP地址，注意要满足网段的要求（可以通过虚拟网络编辑器中查看）

查看并修改主机名：

```shell
hostname
hostnamectl --static set-hostname 新主机名
```

关闭防火墙：

```shell
systemctl disable firewalld
```

## 4. 安装JDK

（1）从官网下载`jdk-17_linux-x64_bin.tar.gz`，然后上传到Linux服务器的`/opt`目录下，并解压

```shell
cd /opt
tar -zxvf /opt/jdk-17_linux-x64_bin.tar.gz
```

（2）配置JDK相关环境变量

```shell
vi /etc/profile
```

在末尾添加如下内容：

```vim
# 声明 JAVA_HOME 环境变量，等号两边不能有空格
JAVA_HOME=/opt/jdk-17.0.8
   
# 给 PATH 环境变量附加 $JAVA_HOME/bin 部分
PATH=$JAVA_HOME/bin:$PATH
   
# 发布变量名，不是引用变量的值，所以前面不写 $ 符号
export JAVA_HOME PATH
```

刷新配置：

```shell
source /etc/profile
```

（3）验证

```shell
java -version
```



# 第03章_Linux常用命令

## 1. 系统类命令

### 1.1 帮助命令

`man 命令或配置文件`：获取帮助信息

### 1.2 查看历史命令

`history`：查看已经执行过的历史命令

### 1.3 关机类命令

`sync`：将内存中的数据同步到硬盘中

`poweroff`：关机

`reboot`：重启

### 1.4 服务管理命令

`systemctl start 服务名`：开启服务

`systemctl stop 服务名`：关闭服务

`systemctl restart 服务名`：重启服务

`systemctl status 服务名`：查看服务状态

`systemctl enable 服务名`：使服务开机自启

`systemctl disable 服务名`：禁止服务开机自启

`systemctl is-enabled 服务名`：查看服务是否开机自启

`systemctl --type service`：查看正在运行的所有服务

## 2. 文件目录类命令

### 2.1 基本操作

`pwd`：即print working directory，打印当前工作目录的绝对路径

`ls [选项] [目录]`：即list，列出目录内容

| 选项 | 功能                                                         |
| ---- | ------------------------------------------------------------ |
| -a   | 列出全部文件（包括隐藏文件）                                 |
| -l   | 长数据串列出，包含文件的属性与权限等。注意，`ls -l`也可以用衍生命令`ll`替代。 |

`cd [参数]`：即change directory，切换路径

| 示例       | 功能                     |
| ---------- | ------------------------ |
| cd 路径    | 切换路径                 |
| cd ~或者cd | 回到自己的家目录         |
| cd -       | 回到上一次所在目录       |
| cd ..      | 回到当前目录的上一级目录 |

`mkdir [选项] 目录`：即make directory，创建目录。可以使用`-p`选项来递归创建多层目录。

`rmdir 目录`：即remove directory，删除空目录

`touch 文件`：创建空文件

`cp [选项] source dest`：复制source文件到dest。可以使用`-r`选项来递归复制整个目录。

`mv source dest`：移动source文件到dest。该命令也可以用于对文件进行重命名。

`rm [选项] 文件或目录`：删除文件或目录

| 选项 | 功能                               |
| ---- | ---------------------------------- |
| -r   | 递归删除目录中的所有内容           |
| -f   | 强制删除，此时不会提示用户进行确认 |
| -v   | 显示指令的详细执行过程             |

### 2.2 查看文件内容

`cat [选项] 文件`：查看文件内容，可以使用`-n`选项来显示行号。一般用于查看较小的文件。

`more 文件`：分屏查看文件内容。详细操作如下

| 操作           | 功能说明                                 |
| -------------- | ---------------------------------------- |
| 空白键 (space) | 代表向下翻一页；                         |
| Enter          | 代表向下翻『一行』；                     |
| q              | 代表立刻离开 more ，不再显示该文件内容。 |
| Ctrl+F         | 向下滚动一屏                             |
| Ctrl+B         | 返回上一屏                               |
| =              | 输出当前行的行号                         |
| :f             | 输出文件名和当前行的行号                 |

`less 文件`：分屏查看文件内容（比more更强大）。详细操作如下

| 操作        | 功能说明                                           |
| ----------- | -------------------------------------------------- |
| 空白键      | 向下翻动一页；                                     |
| \[pagedown] | 向下翻动一页                                       |
| \[pageup]   | 向上翻动一页；                                     |
| /字串       | 向下搜寻『字串』的功能；n：向下查找；N：向上查找； |
| ?字串       | 向上搜寻『字串』的功能；n：向上查找；N：向下查找； |
| q           | 离开 less 这个程序；                               |

`head -n 文件`：显示文件的前n行

`tail -n 文件`：显示文件的末尾n行。还可以使用`-f`选项，来实时显示文件最新追加的内容，监视文件变化。

### 2.3 echo

`echo [选项] 内容`：输出内容到控制台，一般字符串内容使用双引号包括。可以使用`-e`选项，使字符串中支持转义字符。

说明：在Linux中，`>`代表覆盖，`>>`代表追加，例如

- `echo "hello1" > abc.txt`则会用`hello1`来覆盖文件`abc.txt`中的内容
- `echo "hello2" >> abc.txt`则会将`hello2`追加到文件`abc.txt`末尾

### 2.4 链接

`ln [-s] 源文件 链接名`：创建硬链接（文件的引用计数加1），如果使用`-s`选项则创建软链接（类似于快捷方式）。链接其实就表示目标资源另外的访问方式，现代系统中使用硬链接的场景越来越少，主流都是使用软链接。

## 3. VI和VIM编辑器

vi是Unix操作系统中出现的通用文本编辑器，vim是从vi发展出来的一个性能更强大的文本编辑器，它可以主动地以字体颜色辨别语法的正确性，vi和vim编辑器完全兼容，通过命令`vi 文件`或者`vim 文件`即可使用。

vim编辑器有三种模式，可以通过如下方式切换：

![](images/vim5_Oecz0qPFT2.png)

### 3.1 VIM的一般模式

VIM的一般模式中，可以使用【上下左右】按键来移动光标，可以使用【删除字符】或【删除整行】来处理档案内容，也可以使用【复制、粘贴】来处理文件数据。

**删除和复制操作**

![](images/vim1_gDMEBpv1eB.png)

**光标移动操作**

![](images/vim2_MEF0TdsCdJ.png)

### 3.2 VIM的编辑模式

在一般模式中我们无法编辑文件内容，必须要按下【i,a,o,s,S,R】等任何一个字母后进入编辑模式才可编辑文件内容。

![](images/vim3_NLWC6RBYz_.png)

### 3.3 VIM的命令模式

命令模式中可以进行存盘、退出、显示行号、搜索、批量替换等操作。需要在一般模式下输入【`:`,`/`】才可进入命令模式，按ESC或者命令执行完毕后会回到一般模式。

![](images/vim4_rT-Bi1oF_I.png)

## 4. 用户权限管理类命令

### 4.1 文件类型和权限的表示

![](images/q1_nv6bwk6rOu.png)

- 0首位表示文件类型，例如`-`代表文件，`d`代表目录，`l`代表链接
- 第1-3位确定属主（该文件的所有者）拥有该文件的权限
- 第4-6位确定属组（所有者的同组用户）拥有该文件的权限
- 第7-9位确定其他用户拥有该文件的权限

**rwx作用到文件的含义**：

```txt
[r]代表可以读取、查看该文件
[w]代表可以修改该文件（但不能删除该文件）
[x]代表可以执行该文件
```

**rwx作用到目录的含义**：

```txt
[r]代表可以通过ls查看目录内容
[w]代表可以重命名目录，并且能在目录内创建、删除文件
[x]代表可以进入该目录
```

说明：通过`ls -l`可以查看文件属性

![](images/q2_pSl919toNE.png)

> 注意：对于文件，链接数指的是硬链接个数；对于目录，链接数指的是子目录个数。

### 4.2 用户相关命令

```shell
sudo xxx                  # 让普通用户以root权限执行该命令

useradd liubei            # 添加新用户，默认所在组名与用户名相同
useradd -g sanguo sunquan # 添加新用户到某个组
passwd liubei             # 设置用户密码
id liubei                 # 查看用户是否存在
cat /etc/passwd           # 查看创建的所有用户
su liubei                 # 切换用户（输入exit可以回退到上一个用户）
userdel -r liubei         # 删除用户及用户主目录

groupadd sanguo           # 新增组
groupdel sanguo           # 删除组
cat /etc/group            # 查看创建的所有组
usermod -g sanguo liubei  # 修改用户的所属组
```

### 4.3 权限相关命令

```shell
chmod 755 abc.txt         # 改变文件权限（三个数分别对应属主、属组、其他用户权限的二进制表示）
chmod -R 777 /mynote/     # 递归改变目录及其中所有文件的权限
chown liubei abc.txt      # 改变文件的属主
chgrp sanguo abc.txt      # 改变文件的属组
```

## 5. 搜索查找类命令

### 5.1 find

find命令将从指定目录向下递归地遍历其各个子目录，将满足条件的文件显示在终端：

```shell
find 指定目录 -name "*.txt"
```

> 说明：`-name`选项表示按文件名查找

### 5.2 grep过滤

管道符`|`表示将前一个命令的结果输出传递给后面的命令处理，而grep可以根据指定内容进行过滤查找（可以使用`-n`选项来显示行号）。例如，以下命令可以查找根目录下所有名称中包含字母`e`的子目录/文件：

```shell
ls / | grep -n e
```

## 6. 压缩和解压缩命令

### 6.1 gzip和gunzip

- 压缩xxx文件。注意，该命令无法压缩目录，并且只能将文件压缩为`*.gz`文件，而且压缩后不保留源文件。

```shell
gzip abc.txt
```

- 解压缩xxx.gz文件

```shell
gunzip abc.txt.gz
```

### 6.2 zip和unzip

- 压缩文件或目录为xxx.zip，注意要使用`-r`选项才能压缩目录。zip压缩命令在Windows和Linux系统通用，且压缩后会保留源文件。

```shell
zip wsy.zip abc.txt def.txt
```

- 解压缩xxx.zip文件，可以使用`-d`选项来指定解压后文件的存放目录

```shell
unzip wsy.zip -d /opt/test
```

### 6.3 tar

- 压缩文件或目录为xxx.tar.gz

```shell
tar -zcvf wsy.tar.gz abc.txt def.txt
```

- 解压缩xxx.tar.gz文件，可以使用`-C`选项来指定解压后文件的存放目录

```shell
tar -zxvf wsy.tar.gz -C /opt/test
```

## 7. 进程类命令

```shell
ps -aux                   # 查看系统中所有进程
ps -aux | grep java       # 查看系统中所有进程（过滤查看java相关进程）
ps -ef                    # 查看子父进程之间的关系
ps -ef | grep java        # 查看子父进程之间的关系（过滤查看java相关进程）
kill -9 pid               # 强制终止进程号为pid的进程
```

## 8. 软件包安装命令

### 8.1 RPM

RPM（RedHat Package Manager）是RedHat软件包管理工具。

```shell
rpm -qa                 # 查询安装的所有rpm软件包
rpm -qa | grep xxx      # 过滤查找xxx软件包
rpm -e --nodeps xxx     # 卸载xxx软件包
rpm -ivh xxx            # 安装xxx软件包
```

### 8.2 YUM

YUM（全称为Yellow dog Updater, Modified）是一个在Fedora、RedHat、CentOS中的Shell前端软件包管理器。基于RPM包管理，能够从指定的服务器自动下载RPM包并安装，可以自动处理依赖性关系，并且一次安装所有依赖的软件包。该功能类似在Java中使用Maven工具从远程仓库中下载依赖一样，可以自动处理依赖关系。

- 使用yum安装rpm软件包（选项`-y`表示对所有提问都回答yes）

```shell
yum -y install xxx
```



# 第04章_Shell编程

## 1. 简介

Shell是一个命令行解释器，它接收用户命令，然后调用操作系统内核。Shell也是一个功能强大的编程语言，易编写、易调试、灵活性强。**Linux默认的Shell解析器是`/bin/bash`**。

一个典型的Shell脚本文件如下：

```shell
#!/bin/bash

echo "hello world"
```

执行Shell脚本文件有以下**两种方式**：

1. `bash hello.sh`或者`sh hello.sh`，注意`/bin/sh`其实是一个软链接，它指向`/bin/bash`
2. `./hello.sh`或者直接使用绝对路径`/root/hello.sh`，注意这种方式必须要求该Shell脚本文件具有可执行权限

## 2. 变量

### 2.1 系统变量

常见的系统变量有`HOME`、`PWD`、`SHELL`、`USER`等

```shell
echo $HOME     # 查看系统变量的值
```

### 2.2 自定义变量

- `变量名=变量值`：定义变量（注意等号两边不能有空格）。在Shell中，变量默认都是字符串类型，如果变量值有空格，则需要使用双引号或者单引号括起来。
- `unset 变量名`：撤销变量
- `readonly 变量名=变量值`：定义静态变量（静态变量不能修改，不能撤销）
- `export 变量名`：将变量提升为全局环境变量，可供其他Shell程序使用

```shell
[root@thuwsy001 ~]# A=5
[root@thuwsy001 ~]# echo $A
5
[root@thuwsy001 ~]# A=8
[root@thuwsy001 ~]# echo $A
8
[root@thuwsy001 ~]# unset A
[root@thuwsy001 ~]# echo $A

[root@thuwsy001 ~]# readonly B=2
[root@thuwsy001 ~]# B=5
-bash: B: 只读变量
```

### 2.3 特殊变量

- `$0`表示该Shell脚本名称
- `$n`表示第`n`个参数，其中`n`为正整数。如果`n`大于等于10，则需要用大括号包含，例如`${10}`
- `$#`表示输入的参数个数
- `$*`表示输入的所有参数，并将所有参数看作一个整体
- `$@`表示输入的所有参数，并将每个参数区分对待
- `$?`表示最后一次执行的命令的返回状态。值为0表示上一个命令正确执行。

举例：

```shell
#!/bin/bash

echo $0
echo $1
echo $#
echo $*
echo $@
```

```shell
[root@thuwsy001 ~]# ./param.sh aaa bbb ccc
./param.sh
aaa
3
aaa bbb ccc
aaa bbb ccc
[root@thuwsy001 ~]# echo $?
0
```

### 2.4 运算式

通过`[运算式]`可以进行数值运算：

```shell
[root@thuwsy001 ~]# S=$[(2+3)*4]
[root@thuwsy001 ~]# echo $S
20
```

## 3. 条件判断

`[ condition ]`表示条件判断，注意condition前后必须要有空格。条件判断为true则返回0，条件判断为false则返回1。多个条件判断可以使用`&&`或`||`连接。常用的条件判断运算符有：

- `-eq`等于
- `-ne`不等于
- `-lt`小于
- `-le`小于等于
- `-gt`大于
- `-ge`大于等于
- `-r`文件具有读权限
- `-w`文件具有写权限
- `-x`文件具有执行权限
- `-e`文件存在
- `-f`文件存在且文件类型是普通文件
- `-d`文件存在且文件类型是目录

举例：

```shell
[root@thuwsy001 ~]# [ 23 -ge 24 ]
[root@thuwsy001 ~]# echo $?
1
[root@thuwsy001 ~]# [ -e param.sh ]
[root@thuwsy001 ~]# echo $?
0
```

## 4. 流程控制

### 4.1 if分支

```shell
#!/bin/bash

if [ $1 -le 37 ]; then
    echo "temperature is ok"
elif [ $1 -le 45 ]; then
    echo "temperature is too high"
else
    echo "temperature error"
fi
```

```shell
[root@thuwsy001 ~]# ./if.sh 37
temperature is ok
[root@thuwsy001 ~]# ./if.sh 39
temperature is too high
[root@thuwsy001 ~]# ./if.sh 100
temperature error
```

### 4.2 case分支

```shell
#!/bin/bash

case $1 in
"start")
    echo "service start"
;;
"stop")
    echo "service stop"
;;
*)
    echo "param error"
;;
esac
```

```shell
[root@thuwsy001 ~]# ./case.sh start
service start
[root@thuwsy001 ~]# ./case.sh stop
service stop
[root@thuwsy001 ~]# ./case.sh restart
param error
```

### 4.3 for循环

**语法一**：

```shell
#!/bin/bash

sum=0

for ((i=1;i<=100;i++))
do
    sum=$[$sum+$i]
done

echo $sum
```

```shell
[root@thuwsy001 ~]# ./for1.sh 
5050
```

**语法二**：

```shell
#!/bin/bash

for i in redis1 redis2 redis3
do
    echo "cluser==>$i"
done
```

```shell
[root@thuwsy001 ~]# ./for2.sh 
cluser==>redis1
cluser==>redis2
cluser==>redis3
```

### 4.4 while循环

```shell
[root@thuwsy001 ~]# vi while.sh

#!/bin/bash

sum=0
i=1

while [ $i -le 100 ]
do
    sum=$[$sum+$i]
    i=$[$i+1]
done

echo $sum
```

```shell
[root@thuwsy001 ~]# ./while.sh 
5050
```

## 5. 读取控制台输入

使用`read [选项] 变量名`可以读取控制台输入并赋值给变量。选项`-p`用于指定读取值时的提示文字，选项`-t`用于指定读取值时的最长等待时间（单位秒）。

```shell
#!/bin/bash

read -p "enter username:" NAME
echo $NAME
```

```shell
[root@thuwsy001 ~]# ./read.sh 
enter username:wsy
wsy
```

## 6. 函数

### 6.1 常见的系统函数

函数basename用于获取文件名：

```shell
[root@thuwsy001 ~]# basename /root/wsy/test.sh
test.sh
```

函数dirname用于获取文件所在的目录：

```shell
[root@thuwsy001 ~]# dirname /root/wsy/test.sh
/root/wsy
```

### 6.2 自定义函数

> 注意：在调用函数前，必须先声明函数

```shell
#!/bin/bash

function sum()
{
    s=0
    s=$[$1+$2]
    echo "$s"
}

read -p "input number1:" num1
read -p "input number2:" num2
sum $num1 $num2
```

```shell
[root@thuwsy001 ~]# ./function.sh 
input number1:33
input number2:44
77
```

## 7. Shell工具

### 7.1 cut

```shell
# 切割得到文件/etc/passwd的第1列（以:分割列）
cut -d ":" -f 1 /etc/passwd
```

### 7.2 awk

**基本语法**：`awk [选项] '/pattern/{action}' filename`

> 其中pattern表示在文件中查找的内容（是一个正则表达式），action则是在找到匹配内容时所执行的一系列命令。

举例：

```shell
# 搜索文件/etc/passwd中以root关键字开头的所有行，并输出该行的第7列（以:分割列）
awk -F ":" '/^root/{print $7}' /etc/passwd
```

### 7.3 sort

sort命令可以将文件内容进行排序，并将排序结果标准输出。基本语法为`sort [选项] filename`

| 选项 | 说明                     |
| ---- | ------------------------ |
| -n   | 依照数值的大小排序       |
| -r   | 以相反的顺序来排序       |
| -t   | 设置排序时所用的分隔字符 |
| -k   | 指定需要排序的列         |

举例：以如下example.txt文件为例

```txt
bd:20:4.2
bb:40:5.4
xz:50:2.3
cls:10:3.5
ss:30:1.6
```

```shell
# 按照:分割后的第3列倒序排序
[root@thuwsy001 ~]# sort -t ":" -nrk 3 example.txt
bb:40:5.4
bd:20:4.2
cls:10:3.5
xz:50:2.3
ss:30:1.6
```

### 7.4 wc

wc命令用来统计文件信息，利用wc命令我们可以统计文件的行数、字节数、字符数等。基本语法为`wc [选项] filename` 

| 选项参数 | 功能             |
| -------- | ---------------- |
| -l       | 统计文件行数     |
| -w       | 统计文件的单词数 |
| -m       | 统计文件的字符数 |
| -c       | 统计文件的字节数 |

举例：

```shell
[root@thuwsy001 ~]# wc -l /etc/passwd
45 /etc/passwd
[root@thuwsy001 ~]# wc -w /etc/passwd
92 /etc/passwd
[root@thuwsy001 ~]# wc -m /etc/passwd
2354 /etc/passwd
[root@thuwsy001 ~]# wc -c /etc/passwd
2354 /etc/passwd
```

