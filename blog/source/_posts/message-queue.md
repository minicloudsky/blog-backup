---
title: 消息队列和使用场景
date: 2020-03-10 16:00:14
tags:
- mq
---

## 消息队列中间件是分布式系统中的重要组件，主要解决应用耦合、异步消息、流量削峰等问题
### 目标: 实现高性能、高可用、高伸缩和最终一致性架构
使用较多的消息队列有 ActiveMQ、RabbitMQ、ZeroMQ、Kafka、MetaMQ、RocketMQ
1. 异步处理
场景说明：用户注册后，需要发注册邮件和注册短信。传统的做法有两种 1. 串行的方式；2. 并行方式

（1）串行方式：将注册信息写入数据库成功后，发送注册邮件，再发送注册短信。以上三个任务全部完成后，返回给客户端
