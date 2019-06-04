---
title: docker学习笔记
date: 2019-05-15 08:33:42
tags: docker
categories: docker
---

Docker 容器镜像删除
---
* 停止所有的 container，这样才能够删除其中的 images：

docker stop $(docker ps -a -q)

如果想要删除所有 container 的话再加一个指令：

docker rm $(docker ps -a -q)
<!-- more -->

* 查看当前有些什么 images

docker images

* 删除 images，通过 image 的 id 来指定删除谁

docker rmi <image id>

想要删除 untagged images，也就是那些 id 为 <None> 的 image 的话可以用

docker rmi $(docker images | grep "^<none>" | awk "{print $3}")

要删除全部 image 的话

docker rmi $(docker images -q)
---
docker安装nginx
1. docker search nginx  // 搜索镜像
2. docker pull nginx    // 拉取官方镜像
3. docker images nginx   //查看镜像
4. docker run --name nginx -p 80:80 -d nginx
+ nginx 容器名称。
+ the -d 设置容器在在后台一直运行。
+ the -p 端口进行映射，将本地 80 端口映射到容器内部的 80 端口。

PORTS 部分表示端口映射，本地的 80端口映射到容器内部的 80 端口。

在浏览器中打开 http://127.0.0.1:8081/，效果如下：
