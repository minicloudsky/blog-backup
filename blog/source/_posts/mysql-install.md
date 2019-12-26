---
title: MYSQL安装使用总结
date: 2017-12-10 11:06:07
tags:
- MySQL
categories:
- MySQL
---
安装
1. 下载路径
https://dev.mysql.com/downloads/mysql/
直接点no,thanks.
2. 解压放到指定盘中 
笔者：D:\mysql5.7
3. 配置环境变量
MYSQL_HOME:D:\mysql5.7
在 path 后面添加 ;%MYSQL_HOME%\bin
4. 添加文件 my.ini 文件

<!-- more -->

5. 
将如下代码放入 my.ini 文件中
```C
[mysql]
# 设置mysql客户端默认字符集
default-character-set=utf8
[mysqld]
#设置3306端口
port = 3306
# 设置mysql的安装目录
basedir=D:\mysql5.7
# 设置mysql数据库的数据的存放目录
datadir=D:\mysql5.7\data
# 允许最大连接数
max_connections=200
# 服务端使用的字符集默认为8比特编码的latin1字符集
character-set-server=utf8
# 创建新表时将使用的默认存储引擎
default-storage-engine=INNODB
```
亲爱的请注意:
basedir 和 datadir，请根据自己的实际安装目录进行修改
创建空的data文件夹和my.ini
![](http://images2015.cnblogs.com/blog/628627/201705/628627-20170502154507101-1848453299.png)
5. 打开 cmd.exe, 必须以管理员的身份运行 
5.1 初始化数据库
mysqld --initialize --user=mysql --console
记住分配的密码:
![](http://images2015.cnblogs.com/blog/628627/201705/628627-20170502154601523-1759649304.png)
5.2 安装服务
mysqld --install MySQL
5.3 启动服务
net start MySQL
============= 华丽的分割线 ============
以上的步骤已经可以安装成功
以下其他可能用到的命令
5.4 停止服务
net stop MySQL 
5.5 删除服务 
sc delete MySQL (出现问题时，可执行)
6. 可能出现的问题
6.1 msvcp120.dll 丢失
安装 vcredist_x86.exe 或者 vcredist_x64.exe，根据自己的系统而定。
6.2 其他问题
如果执行 sc delete MySQL 指令，记得清除 data 文件夹下所有的文件。
如果执行 net start MySQL 指令，
出现: 
'MySQL 服务正在启动。
MySQL 服务无法启动。
服务没有报告任何错误。
'
要配置环境变量或者环境变量配置有误，请仔细检查，亲爱的。 
7. 修改初始化密码
使用初始密码登陆后, 执行下面指令
1
set password for root@localhost=password('你的密码');
可能出现的错误
Mysql net start mysql 启动, 提示发生系统错误 5 拒绝访问 解决之道
![](http://img.my.csdn.net/uploads/201212/17/1355705448_8045.png)
解决问题方法如下:
在 dos 下运行 net  start mysql 不能启动 mysql！提示发生系统错误 5；拒绝访问！切换到管理员模式就可以启动了。所以我们要以管理员身份来运行 cmd 程序来启动 mysql。
那么如何用管理员身份来运行 cmd 程序呢？
1. 在开始菜单的搜索框张收入 cmd，然后右键单击，并选择以管理员身份运行！
如果每天都要启动 mysql 服务，这样不很麻烦？所以：
2. 右键单击 cmd 选择 “附到【开始】菜单 (U)”; 这是就可以到开始菜单上找到 cmd 了，
3. 右击选择属性，选择快捷方式，再选择高级，在选择以管理员身份运行，再单击确定即可！
以后只要打开开始菜单单击上面的快捷方式就可以以管理员的身份运行 cmd 了！
这样再输入 net start mysql 就不会出错了！
net start mysql 报发生系统错误 2 -- 找不到文件路径
http://blog.csdn.net/lxlmycsdnfree/article/details/72758655