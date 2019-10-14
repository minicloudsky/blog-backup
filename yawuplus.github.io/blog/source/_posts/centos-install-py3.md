---
title: centos安装python3
date: 2019-05-13 23:07:52
tags:
- 环境
categories: 环境
---
折腾环境是最麻烦的，因为装这个py3环境还重装系统了好几次，记录下吧.
---
+ 查看 当前系统python版本和位置
```bash
[root@iZ2ze23v8zk8gxfgl040msZ Python-3.6.4]# whereis python
python: /usr/bin/python /usr/bin/python2.7-config /usr/bin/python.bak /usr/bin/python2.7 /usr/lib/python2.7 /usr/lib64/python2.7 /etc/python /usr/include/python2.7 /usr/share/man/man1/python.1.gz
cd /usr/bin/
ll python*
-rwxr-xr-x 1 root root 12665200 May 13 22:39 python
-rw-r--r-- 1 root root     3125 May 13 22:40 python-config
-rw-r--r-- 1 root root     2050 May 13 22:40 python-config.py
-rw-r--r-- 1 root root    63994 May 13 22:40 python-gdb.py

```

* 可以看到，python 指向的是 python2，python2 指向的是 python2.7，因此我们可以装个 python3，然后将 python 指向 python3，然后 python2 指向 python2.7，那么两个版本的 python 就能共存了。

* 因为我们要安装 python3，所以要先安装相关包，用于下载编译 python3：
yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make 
运行了以上命令以后，就安装了编译 python3 所用到的相关依赖

* 默认的，centos7 也没有安装 pip，不知道是不是因为我安装软件的时候选择的是最小安装的模式。

* 运行这个命令添加epel扩展源

  <!-- more -->
---
yum -y install epel-release

* 安装pip

yum install python-pip
4. 用 pip 装 wget

pip install wget

* 用 wget 下载 python3 的源码包

wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tar.xz

- 编译 python3 源码包
* 解压

xz -d Python-3.6.4.tar.xz

tar -xf Python-3.6.4.tar

* 进入解压后的目录，依次执行下面命令进行手动编译

./configure prefix=/usr/local/python3
make && make install

如果最后没提示出错，就代表正确安装了，在 /usr/local/ 目录下就会有 python3 目录
* 添加软链接

将原来的链接备份

mv /usr/bin/python /usr/bin/python.bak

添加python3的软链接

ln -s /usr/local/python3/bin/python3.6 /usr/bin/python

为 Python3 设置 PIP

由于源码安装的过程中，Python3 其中已经是默认安装了 pip 及 setuptools，所以只需要我们为其设置 Linux 的环境变量，创建软件连到 /usr/bin/ 下即可

ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3
* 测试是否安装成功了

python -V
* 更改 yum 配置，因为其要用到 python2 才能执行，否则会导致 yum 不能正常使用

vi /usr/bin/yum

把#! /usr/bin/python修改为#! /usr/bin/python2

vi /usr/libexec/urlgrabber-ext-down

把#! /usr/bin/python 修改为#! /usr/bin/python2


