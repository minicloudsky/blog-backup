---
title: 云原生课程学习笔记
date: 2021-01-15 14:01:35
tags:
---


## 云原生技术范畴
- 不可变基础设施 目前实现: 容器镜像
- 云应用编排理论 目前实现: 容器设计模式
![](cncf.png)

### 什么是容器？
容器，是一个视图隔离，资源可限制，独立文件系统的进程集合
- 视图隔离 - 如能看到部分进程，独立主机名等等；
- 控制资源使用率 - 如 2G 内存大小，CPU 使用个数等等
<!-- more -->
### 什么是镜像？
运行容器所需要的所有文件集合 - 容器镜像
Dockerfile - 描述镜像构建步骤
构建步骤所产生出文件系统的变化- changeset
类似 disk snapshot
提高分发效率，减少磁盘压力

### summary
容器 - 和系统其它部分隔离开的进程集合
镜像 - 容器所需要的所有文件集合 - Build once，Run anywhere

### 容器运行时的生命周期
- 单进程模型
   1. Init 进程生命周期 = 容器生命周期
   2. 运行期间可运行 exec 执行运维操作

- 数据持久化
   1. 独立于容器的生命周期
   2. 数据卷 - docker volume vs bind

### moby 容器引擎架构
- containerd 
   1. 容器运行时管理引擎，独立于 moby daemon
   2. containerd-shim 管理容器生命周期，可被 containerd 动态接管

- 容器运行时
   1. 容器徐计划技术方案
   2. runC kata gVisor


   moby daemon
   containerd
shim shim shim
container   container  container
runC         runC          runC

### 容器和VM之间的差异
![](compare.png)

### Kubernetes
自动化的容器编排平台
- 部署
- 弹性
- 管理
核心功能
- 服务发现与负载均衡
- 容器自动装箱
- 存储编排
- 自动容器恢复
- 自动发布与回滚
- 配置与密文管理
- 批量执行
- 水平伸缩

![](recover.png)
![](water.png)
![](schedluer.png)
### Kubernetes 架构
![](master.png)
![](node.png)
![](example.png)

### Kubernetes 核心概念与API
- Pod
   - 最小的调度以及资源单元
   - 由一个或多个容器组成
   - 定义容器运行的方式(Command 或者环境变量等)
   - 提供给容器共享的运行环境(网络、进程空间)
- Volume
   - 声明 Pod 中的容器可访问的文件目录
   - 可以被挂载在 Pod 中一个(或者多个) 容器的指定路径下
   - 支持多种后端存储的抽象
      - 本地存储、分布式存储、云存储。。
- Deployment
   - 定义一组 Pod 的副本数目、版本等
   - 通过控制器(COntroller) 维持Pod的数目
      - 自动恢复失败的 Pod
   - 通过控制器以指定的策略控制版本
      - 滚动升级、重新生成、回滚等
- Service
   - 提供访问一个或多个 Pod 实例的稳定访问地址
   - 支持多种访问方式实现
      - ClusterIP
      - NodePort
      - LoadBalancer
- Namespaces
   - 一个集群内部的逻辑隔离机制(鉴权，资源额度)
   - 每个资源都属于一个Namspace
   - 同一个Namspace 中的资源命名
   - 不同Namspace 中的资源可命名

### API 基础知识
HTTP + JSON/YAML
- kubectl
- UI
- curl

![](api.png)
![](label.png)
