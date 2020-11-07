---
title: mysql 日期函数
date: 2020-11-01 10:52:24
tags:
---


## 记录下常用的 mysql 日期函数
yesterday = DATE_SUB(CURDATE(), INTERVAL 1 DAY)
last_week = DATE_SUB(CURDATE(), INTERVAL 1 week)
last_month = DATE_SUB(CURDATE(), INTERVAL 1 month)
last_three_month = DATE_SUB(CURDATE(), INTERVAL 3 month)
last_year = DATE_SUB(CURDATE(),INTERVAL 1 year)
### case when 判断
SELECT
CASE
		
	WHEN
		1 = 2 THEN
			1 ELSE 0 
			END AS num

<!-- more -->

