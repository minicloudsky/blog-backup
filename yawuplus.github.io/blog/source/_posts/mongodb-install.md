---
title: MongoDB安装使用
date: 2017-12-10 11:48:50
tags:
categories: 数据库
---
我的 win7 32 的，注意版本要正确！
<!-- more -->
一、下载 mongodb 压缩包：mongodb-win32-i386-2.6.9.zip（）

二、在 D 盘新建文件夹 mongodb，将压缩我的解压文件放进去（有一个 bin 文件夹和另外三个文件）

三、创建数据库文件存放位置：D：/mongodb/data/db
四、打开 cmd 进入 bin 目录，输入命令 mongod --dbpath D:\mongodb\data\db，启动服务，mongodb 默认连接端口为 27017，可以使用浏览器打开 http://localhost:27017 查看，如果看到 it looks like you are ..... 说明启动成功

五、可以将 mongodb 设置成 windows 服务，这样就不用使用命令启动了，设置方法如下：

1、在 data 文件夹下新建一个 log 文件夹，用于存放日志文件，在 log 文件夹下新建文件 mongodb.log

2、在 D:\mongodb 文件夹下新建文件 mongo.config，并用记事本打开 mongo.config 输入以下内容:

dbpath=D:\mongodb\data\db  

logpath=D:\mongodb\data\log\mongodb.log

3、以管理员身份打开 cmd 命令框（开始——输入 cmd 找到 cmd.exe——右键——以管理员身份运行）

4、进入 bin 文件夹输入以下命令 mongod --config D:\mongodb\mongo.config --install --serviceName "MongoDB" --journal  

5、右键计算机——系统服务，打开 win7 服务框，本地服务服务列表中会看到 MongoDB，表示已经成功将 mongodb 加入到了系统服务，但是此时服务还没有开启！

6、在 cmd 中输入 net start mongoDB  开启服务，重新查看 win7 服务显示窗口，发现 mongodb 的状态栏显示 “已启动”，表示启动成功。

7、cmd 中在 bin 目录下输入 mongo，就连接了 mongodb 服务了，可以玩 mongodb 啦！！！

centos下安装
Packages包说明
MongoDB官方源中包含以下几个依赖包：
mongodb-org: MongoDB元数据包，安装时自动安装下面四个组件包：
1.mongodb-org-server: 包含MongoDB守护进程和相关的配置和初始化脚本。
2.mongodb-org-mongos: 包含mongos的守护进程。
3.mongodb-org-shell: 包含mongo shell。
4.mongodb-org-tools: 包含MongoDB的工具： mongoimport, bsondump, mongodump, mongoexport, mongofiles, mongooplog, mongoperf, mongorestore, mongostat, and mongotop。

安装步骤

1.配置MongoDB的yum源

创建yum源文件：
vim /etc/yum.repos.d/mongodb-org-3.4.repo
添加以下内容：
[mongodb-org-3.4]  
name=MongoDB Repository  
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.4/x86_64/  
gpgcheck=1  
enabled=1  
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc

这里可以修改 gpgcheck=0, 省去gpg验证

安装之前先更新所有包 ：yum update （可选操作）

2.安装MongoDB
安装命令：
yum -y install mongodb-org
安装完成后

查看mongo安装位置 whereis mongod

查看修改配置文件 ： vim /etc/mongod.conf
 
3.启动MongoDB 
启动mongodb ：systemctl start mongod.service
停止mongodb ：systemctl stop mongod.service
查到mongodb的状态：systemctl status mongod.service
4.外网访问需要关闭防火墙：
CentOS 7.0默认使用的是firewall作为防火墙，这里改为iptables防火墙。
关闭firewall：
systemctl stop firewalld.service #停止firewall
systemctl disable firewalld.service #禁止firewall开机启动

5.设置开机启动
systemctl enable mongod.service
6.启动Mongo shell
命令：mongo 
查看数据库：show dbs
7.设置mongodb远程访问：
编辑mongod.conf注释bindIp,并重启mongodb.
vim /etc/mongod.conf
重启mongodb：systemctl restart mongod.service
卸载mongodb

1.service mongod stop

2.sudo yum erase $(rpm -qa | grep mongodb-org)

3.移除日志数据文件

sudo rm -r /var/log/mongodb
sudo rm -r /var/lib/mongo
