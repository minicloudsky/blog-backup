---
title: Mysql必知必会笔记
date: 2019-09-22 15:35:30
tags:
mysql
categories:
mysql
---

##### 数据库是一个以某种方式有组织的形式存储的数据集合

##### 数据库(database) 保存有组织的数据的容器。（一个文件或者一组文件）

##### 数据库表特性:  定义数据如何存储，存储什么数据，数据如何分解。

##### 模式(scheme): 关于数据库和表布局以及特性的信息

##### 列(column): 表中一个字段

##### 行(row): 表中的一个记录

##### 主键(primary key) : 一列(或者一组列 ，其值能够唯一区分表中每一行

##### 成为主键条件：

1. 任意两行都不具有相同主键值
2. 每行都必须有一个主键值(主键列不允许NULL值)

##### 主键习惯:

1. 不更新主键列的值
2. 不重样主键列的值
3. 不在主键列中使用可能会更改的值

查看数据库

`show databases;`

查看表

`show tables;`

查看表的字段

`show columns from shops(table_name);`

显示服务器状态

`show status`

##### 检索

select * from girl_firends;

select name from my_girlfriends;



