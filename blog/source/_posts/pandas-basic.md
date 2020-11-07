---
title: pandas 基础
date: 2020-10-09 16:42:37
tags:
---


## pandas 是一个开源的数据分析和数据操作库，这里记录下 pandas 常用的基础操作
1. 创建 `DataFrame`
   ```python
   In [14]: df = pd.DataFrame({ 
    ...:     'item_name':['cup','pants','shoes','coat','sunglasses'],   
    ...:         'brand': ['Yum Yum', 'Yum Yum', 'Indomie', 'Indomie', 'Indomie'], 
    ...:             'style': ['cup', 'cup', 'cup', 'pack', 'pack'], 
    ...:                 'rating': [4, 4, 3.5, 15, 5], 
    ...:                     'price': [12,34.3,78.1,61,91], 
    ...:                     })                             
    In [15]: df                                                                                        
    Out[15]: 
    item_name    brand style  rating  price
    0         cup  Yum Yum   cup     4.0   12.0
    1       pants  Yum Yum   cup     4.0   34.3
    2       shoes  Indomie   cup     3.5   78.1
    3        coat  Indomie  pack    15.0   61.0
    4  sunglasses  Indomie  pack     5.0   91.0

In [16]:  
   ```

<!-- more -->

