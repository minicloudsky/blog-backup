---
title: Python爬虫入门
date: 2017-04-23 00:43:30
categories:
- Python
tags:
- python

---


<!-- more -->
```python
# -*- coding: utf-8 -*-
import urllib
import re
import requests
import urllib2
#获取图片链接
def getImgUrl(url,regex):
    request = urllib.urlopen(url)   #打开要下载的网址链接
    html = request.read()           #获取网页源码
    reg = re.compile(regex)          #将正则表达式编译，提高正则匹配效率
    url = re.findall(reg,html)        #查找符合正则表达式的链接
    img_add = []
    for li in url:
        if len(li) ==60:
            img_add.append(li+".jpg")     #将链接存到列表中
    return img_add
# 下载图片
def downloadImg(url):
    count =0
    for li in url:
        count = count+1
        print "正在下载第 %s 张图片 " %(count)
        urllib.urlretrieve(li,'E:\\img\\%s.jpg' %(count))    #下载图片，注意最好指定下载路径，否则就会下载在源代码的路径里，同时如果不设置下载路径容易出错
if __name__ =='__main__':
    url = "https://www.zhihu.com/question/43551423"
    regex = r'data-actualsrc="(.+?).jpg"'
    img_url = getImgUrl(url,regex)
    downloadImg(img_url)




```
