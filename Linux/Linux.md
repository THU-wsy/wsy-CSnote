# 1. 创建Linux虚拟机

## 1.1 创建虚拟机

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

## 1.2 安装Linux操作系统

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



# 2. 克隆虚拟机

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


# 3. 安装JDK

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

