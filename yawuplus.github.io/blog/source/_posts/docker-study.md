---
title: docker学习笔记
date: 2019-05-15 08:33:42
tags:
- docker
categories: docker
---

### 什么是docker
docker包括一个命令行程序、一个后台守护进程、以及一组远程服务。它解决了常见的软件问题，并建华路安装、运行、发布和删除软件。这一切能够实现是使用一项Unix技术，称为容器。
### 容器不是虚拟化
在没有docker时代，使用硬件虚拟化(虚拟机),以提供隔离，虚拟机提供虚拟硬件，可安装一个os和其他程序，需要很长时间创建，资源开销打，因为除了要执行你需要的软件，还需要运行整个操作系统的副本。
docker容器不使用硬件虚拟化，运行在docker容器中的程序接口和逐渐的Linux内核直接打交道，容器中运行的程序与计算机操作系统直接没有额外的中间层，没有资源被冗余软件的运行或者虚拟硬件模拟而浪费掉，docker不是虚拟化技术，相反，它可以帮助使用已经内置到操作系统中的容器技术。
### 隔离容器中运行软件
docker使用已经成为linux一部分的linux命名空间和cgroups，docker不提供容器技术，但它使得容器更易于使用要了解系统中在容器什么样子，让我们先建立一条基线，如下为计算机系统体系结构上运行的基本容器示例。
![](instance.png)

运行docker可以认为是在用户控件运行两个程序，首先是docker守护进程，如果正确安装，该进程应该始终处于运行状态。另一个为docker CLI，它是与用户交互的docker程序，如果要启动，停止，运行或安装软件，你可以用docker CLI执行相应命令。
![](three.png)

### docker容器隔离
docker构建容器隔离包括8个方面，具体如下:  

* `PID命令空间` ----- 进程标识符和能力
* `UTS命名空间` ----- 主机名和域名
* `MNT命名空间` ----- 文件系统访问和结构
* `IPC命名空间` ----- 通过共享内存的进程间通信
* `NET命名空间` ----- 网络访问和结构 
* `chroot()`   ----- 控制文件系统根目录的位置
* `cgroups`    ----- 资源保护  

Linux命名空间和`cgroups`管理着运行时容器，docker采用另一套技术，就像运输集装箱一样为文件提供容器。  
### 分发容器
docker容器可以看成物理运输的集装箱，这是你存储、运行应用程序及其所有依赖的盒子。docker可以执行、复制、轻松地分发容器。docker通过一种打包和分发软件，完成传统容器的封装。这个用来充当容器分发角色的组件被称为`镜像`。  
Docker镜像，是一个容器中运行程序的所有文件的捆绑快照。你可以从镜像中创造尽可能多的容器，但是你这样做时候，从相同的镜像启动的容器不共享文件系统的更改。当你用docker分发软件，其实就是分发这些镜像，并在接收的机器上创建容器镜像在docker生态系统中是可交付的基本单位。



------

### docker下安装常用工具命令总结

查看docker磁盘占用

`docker system df`

查看虚悬镜像

`docker image ls  -f dangling=true`

删除虚悬镜像

`docker image  prune`

根据仓库名列出镜像

`docker images ls Ubuntu`

列出镜像和标签

`docker images ls Ubuntu:18.04`

容器重命名 

docker rename name1 name2

## Dockerfile

from 指定基础镜像

以一个镜像为基础，在其上进行定制。必须是第一条命令

#### mysql

##### 拉取mysql镜像

`docker pull mysql`

启动一个镜像，并将mysql映射到服务器3306端口

`docker run --name mysql5.7 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root  -d mysql:5.7`

默认用户为root

--name为容器名

-p指定端口

MYSQL_ROOT_PASSWORD 指定密码

进入mysql

`docker exec -it mysql5.7-2  bash`

`mysql     -uroot  -p`

#### nginx服务器

`docker pull nginx`

运行nginx

`docker run --name  nginx-test -p 80:80 -d nginx`

将nginx映射到本地目录

首先在/usr/local下新建目录

`mkdir -p /usr/local/docker-nginx/www /usr/local/docker-nginx/logs /usr/local/docker-nginx/conf`

将docker中nginx配置文件复制到到服务器

`docker cp 63185c51103a:/etc/nginx/nginx.conf /usr/local/docker-nginx/conf/`

关闭上一个容器，重新启动一个nginx容器

`docker run -d -p 80:80 --name nginx-server -v /usr/local/docker-nginx/www:/usr/share/nginx/html -v /usr/local/docker-nginx/conf/nginx.conf:/etc/nginx/nginx.conf -v /usr/local/docker-nginx/logs:/var/log/nginx nginx`

由此配置好以后，修改/usr/local/docker-nginx目录下的conf中的nginx.conf，就可以完成对nginx的配置，修改www目录下的html文件即可更新nginx部署的网页

#### redis数据库

`docker pull redis`

`docker run --restart=always -d -p 6379:6379 -v /usr/local/docker-redis/data/:/data --name redis redis redis-server --appendonly yes --requirepass "redis"`

##### 命令说明：

`-p 6388:6379 : 将容器的 6379 端口映射到主机的 6379 端口`
`-v /usr/local/docker-redis/data/ : 将主机中 /usr/local/docker-redis/data/ 目录下的 redis 挂载到容器的 /data`
`redis-server --appendonly yes : 在容器执行 redis-server 启动命令，并打开 redis 持久化配置`

连接redis

`docker exec -ti 5f4c4cf5a5f5 redis-cli a "redis passwd"`

[https://luoliangdsga.github.io/2018/04/26/%E4%BD%BF%E7%94%A8Docker%E9%83%A8%E7%BD%B2Redis/](https://luoliangdsga.github.io/2018/04/26/使用Docker部署Redis/)

#### mongodb

`docker pull mongo`

```bash
docker run -p 27017:27017 -v /usr/local/docker-mongodb/data:/data/db -d mongo
```

进入mongo

`docker exec -it mongo mongo admin`



