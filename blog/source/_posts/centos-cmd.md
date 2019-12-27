---
title: centos常用命令
date: 2019-04-26 00:35:12
categories: centos
tags: 
- centos
- cmd
---


1. 关机命令
2. 关机   shutdown h now
3.   shutdown h hours:minutes & 按照预定时间关闭系统
4.  shutdown r now
5.    reboot 重启
6.    logout 注销
<!-- more -->
7. 查看系统信息的命令
    * arch 显示机器的处理器架构
    * uname m 显示机器的处理器架构
    * uname r 显示正在使用的内核版本
    * cat /proc/cpuinfo 显示cpu info信息
    * cat /procinterrupts 显示中断
    * cat /proc/version 显示内核版本
    * date 显示系统日期
    * cal 2019 显示2019的日历表
8. 文件和目录操作命令
    * cd /home  进入'/home'目录
    * cd ..  返回上一级目录
    * cd 进入个人的主目录
    * cd  返回上次所在的目录
    * pwd 显示工作路径
    * ls 查看目录中的文件
    * ls F 查看目录中的文件
    * ls l 显示文件和目录的详细资料
    * ls a 显示隐藏文件
    * mkdir code 创建名为code的目录
    * mkidr p /tmp/dir1/dir2 创建目录树
    * rm f hello.txt 删除一个叫做"hello.txt的文件"
    * rm dir1 删除叫做dir1的目录
    * mv dir1 new_dir 重命名/移动一个目录
    * cp file1 file2 复制一个文件
    * cp dir/* 复制一个目录下的所有文件到当前目录
    * cp a /tmp/dir1 复制一个目录到当前目录
    * cp a dir1 dir2 复制一个目录
    * ln s file1 lnk1 创建一个纸箱文件或目录的软链接
    * ln file1 lnk1 创建一个指向文件或目录的物理链接
    * touch file1 创建一个文件
9. 文件搜索命令
   * find / name file1 从 '/' 开始进入根文件系统搜索文件和目录
   * find / user user1 搜索属于用户 'user1' 的文件和目录
   * find /home/user1 name \*.bin 在目录 '/ home/user1' 中搜索带有'.bin' 结尾的文件
   * find /usr/bin type f atime +100 搜索在过去100天内未被使用过的执行文件
   * find /usr/bin type f mtime 10 搜索在10天内被创建或者修改过的文件
   * locate \*.ps 寻找以 '.ps' 结尾的文件  先运行 'updatedb' 命令
   * whereis file 显示一个二进制文件、源码或man的位置
   * which file 显示一个二进制文件或可执行文件的完整路径
10. 查看文件内容
  * cat file1 从第一个字节开始正向查看文件的内容
  * tac file1 从最后一行开始反向查看一个文件的内容
  * more file1 查看一个长文件的内容
  * less file1 类似于 'more' 命令，但是它允许在文件中和正向操作一样的反向操作
  * head 2 file1 查看一个文件的前两行
  * tail 2 file1 查看一个文件的最后两行 5.挂载命令
  * mount /dev/hda2 /mnt/hda2 挂载一个叫做hda2的盘 (注：确定目录 '/ mnt/hda2' 已经存在)
  * umount /dev/hda2 卸载一个叫做hda2的盘 (先从挂载点 '/ mnt/hda2' 退出)
  * fuser km /mnt/hda2 当设备繁忙时强制卸载
  * umount n /mnt/hda2 运行卸载操作而不写入 /etc/mtab 文件(当文件为只读或当磁盘写满时非常有用)
  * mount /dev/fd0 /mnt/floppy 挂载一个软盘
  * mount /dev/cdrom /mnt/cdrom 挂载一个光盘
  * mount /dev/hdc /mnt/cdrecorder 挂载一个cdrw或dvdrom
  * mount /dev/hdb /mnt/cdrecorder 挂载一个cdrw或dvdrom
  * mount o loop file.iso /mnt/cdrom 挂载一个文件或ISO镜像文件
  * mount t vfat /dev/hda5 /mnt/hda5 挂载一个Windows FAT32文件系统
  * mount /dev/sda1 /mnt/usbdisk 挂载一个usb 捷盘或闪存设备
  * mount t smbfs o username=user,password=pass //WinClient/share /mnt/share 挂载一个windows网络共享
11. 磁盘空间操作的命令
  * df h 显示已经挂载的分区列表
  * ls lSr |more 以尺寸大小排列文件和目录
  * du sh dir1 估算目录 'dir1' 已经使用的磁盘空间'
  * du sk * | sort rn 以容量大小为依据依次显示文件和目录的大小
  * 查看磁盘大小    df hl
12. 用户和群组相关命令
  * groupadd group_name 创建一个新用户组
  * groupdel group_name 删除一个用户组
  * groupmod n new_group_name old_group_name 重命名一个用户组
  * useradd c "Name Surname " g admin d /home/user1 s /bin/bash user1 创建一个属于 "admin" 用户组的用户
  * useradd user1 创建一个新用户
  * userdel r user1 删除一个用户 ( 'r' 同时删除除主目录)
  * passwd user1 修改一个用户的口令 (只允许root执行)
  * chage E 20051231 user1 设置用户口令的失效期限
  * ls lh 显示权限
  * chmod 777 directory1 设置目录的所有人(u)、群组(g)以及其他人(o)以读(r )、写(w)和执行(x)的权限
  * chmod 700 directory1 删除群组(g)与其他人(o)对目录的读写执行权限
  * chown user1 file1 改变一个文件的所有人属性，为use1。
  * chown R user1 directory1 改变一个目录的所有人属性并同时改变改目录下所有文件的属性都为use1所有
  * chgrp group1 file1 改变文件的群组为group1
  * chown user1:group1 file1 改变一个文件的所有人和群组属性，所属组为group1，用户为use1。
  * find / perm u+s 罗列一个系统中所有使用了SUID控制的文件
  * chmod u+s /bin/file1 设置一个二进制文件的 SUID 位  运行该文件的用户也被赋予和所有者同样的权限
  * chmod us /bin/file1 禁用一个二进制文件的 SUID位
  * chmod g+s /home/public 设置一个目录的SGID 位  类似SUID ，不过这是针对目录的
  * chmod gs /home/public 禁用一个目录的 SGID 位
  * chmod o+t /home/public 设置一个文件的 STIKY 位  只允许合法所有人删除文件
  * chmod ot /home/public 禁用一个目录的 STIKY 位
13. .打包和解压缩文件的命令
  * bunzip2 file1.bz2 解压一个叫做 'file1.bz2'的文件
  * bzip2 file1 压缩一个叫做 'file1' 的文件
  * gunzip file1.gz 解压一个叫做 'file1.gz'的文件
  * gzip file1 压缩一个叫做 'file1'的文件
  * gzip 9 file1 最大程度压缩
  * rar a file1.rar test_file 创建一个叫做 'file1.rar' 的包
  * rar a file1.rar file1 file2 dir1 打包 'file1', 'file2' 以及目录 'dir1'
  * rar x file1.rar 解rar包
  * unrar x file1.rar 解rar包
  * tar cvf archive.tar file1 创建一个非压缩的tar包
  * tar cvf archive.tar file1 file2 dir1 创建一个包含了 'file1', 'file2' 'dir1'的包
  * tar tf archive.tar 显示一个包中的内容
  * tar xvf archive.tar 释放一个包
  * tar xvf archive.tar C /tmp 将压缩包释放到 /tmp目录下 (c是指定目录)
  * tar cvfj archive.tar.bz2 dir1 创建一个bzip2格式的压缩包
  * tar xvfj archive.tar.bz2 解压一个bzip2格式的压缩包
  * tar cvfz archive.tar.gz dir1 创建一个gzip格式的压缩包
  * tar xvfz archive.tar.gz 解压一个gzip格式的压缩包
  * zip file1.zip file1 创建一个zip格式的压缩包
  * zip r file1.zip file1 file2 dir1 将几个文件和目录同时压缩成一个zip格式的压缩包
  * unzip file1.zip 解压一个zip格式压缩包
14. 关于RPM 包的命令
  * rpm ivh package.rpm 安装一个rpm包
  * rpm ivh nodeeps package.rpm 安装一个rpm包而忽略依赖关系警告
  * rpm U package.rpm 更新一个rpm包但不改变其配置文件
  * rpm F package.rpm 更新一个确定已经安装的rpm包
  * rpm e package_name.rpm 删除一个rpm包
  * rpm qa 显示系统中所有已经安装的rpm包
  * rpm qa | grep httpd 显示所有名称中包含 "httpd" 字样的rpm包
  * rpm qi package_name 获取一个已安装包的特殊信息
  * rpm ql package_name 显示一个已经安装的rpm包提供的文件列表
  * rpm qc package_name 显示一个已经安装的rpm包提供的配置文件列表
  * rpm q package_name whatrequires 显示与一个rpm包存在依赖关系的列表
  * rpm q package_name whatprovides 显示一个rpm包所占的体积
  * rpm q package_name scripts 显示在安装/删除期间所执行的脚本l
  * rpm q package_name changelog 显示一个rpm包的修改历史
  * rpm qf /etc/httpd/conf/httpd.conf 确认所给的文件由哪个rpm包所提供
  * rpm qp package.rpm l 显示由一个尚未安装的rpm包提供的文件列表
  * rpm import /media/cdrom/RPMGPGKEY 导入公钥数字证书
  * rpm checksig package.rpm 确认一个rpm包的完整性
  * rpm qa gpgpubkey 确认已安装的所有rpm包的完整性
  * rpm V package_name 检查文件尺寸、 许可、类型、所有者、群组、MD5检查以及最后修改时间
  * rpm Va 检查系统中所有已安装的rpm包 小心使用
  * rpm Vp package.rpm 确认一个rpm包还未安装
  * rpm2cpio package.rpm | cpio extract makedirectories *bin* 从一个rpm包运行可执行文件
  * rpm ivh /usr/src/redhat/RPMS/`arch`/package.rpm 从一个rpm源码安装一个构建好的包
  * rpm build rebuild package_name.src.rpm 从一个rpm源码构建一个 rpm 包
15. YUM 软件包升级器
  * yum install package_name 下载并安装一个rpm包

  * yum localinstall package_name.rpm 将安装一个rpm包，使用你自己的软件仓库为你解决所有依赖关系

  * yum update package_name.rpm 更新当前系统中所有安装的rpm包

  * yum update package_name 更新一个rpm包

  * yum remove package_name 删除一个rpm包

  * yum list 列出当前系统中安装的所有包

  * yum search package_name 在rpm仓库中搜寻软件包

  * yum clean packages 清理rpm缓存删除下载的包

  * yum clean headers 删除所有头文件

  * yum clean all 删除所有缓存的包和头文件   

    ### 查看端口

lsof -i :端口号

kill -9 port