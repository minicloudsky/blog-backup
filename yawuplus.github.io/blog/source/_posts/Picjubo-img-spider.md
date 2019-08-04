---
title: 爬取Picjubo图片
date: 2017-04-27 11:04:53
categories: 
- Python
tags:
- 爬虫
---
Python爬虫: 一蓑烟雨任平生
 周末起床闲来无事，就写个爬虫，收集些图片练练手，话不多说，打开Pycharm就是敲代码
今天要爬的是 这个图片网站https://picjumbo.com

仔细观察后可以发现


<!-- more -->
机智的你肯定已经发现了，它网站的url有如下规律
网站url = https://picjumbo.com/category/nature/page/2/
即url = https://picjumbo.com/category/+图片分类+页码
由此分析可得如下代码: 
```python
# -*- coding: utf-8 -*-
import requests
import urllib
import re
import os
import urllib2

#spider类
class getImage():
# 初始化,传入正则和图片要爬取的图片链接
    def __init__(self,url,pattern):
        self.page = input("请输入要下载多少页图片:\n")
        self.page = int(self.page)
        self.pattern = pattern
        print "你已经成功设置了下载 %s页图片" %(self.page)
        self.site_url =[]
        count =1
#将要爬取的每一个page的url进行预处理成正确的url
        for i in range(self.page):
            self.site_url.append(url+"/"+str(count)+"/")
            count = count+1
            self.start_download()
            print "爬虫程序即将开启运行"
#启动爬虫程序
    def start_download(self):
        count=0
        self.img_url =[]
        for i in self.site_url:
            image = self.getImg_Url(i)
        print "已经获取到第%s页的所有图片链接" %(count)
        count = count+1
        for li in image:
        self.img_url.append(li)
        print "一共有%s张图片" %(len(self.img_url))
        print "已经将所有图片链接添加到list中，即将开始下载"
        for i in self.img_url:
            print i
        self.download_img()

    def getImg_Url(self,site):
#传入header以模拟用户访问
        header = {'User-Agent':'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Mobile Safari/537.36'}
        request = requests.get(site,headers=header)
        html_text = request.text
        self.pattern = re.compile(self.pattern)
        regex = str(self.pattern.pattern)
        img_url = re.findall(regex,html_text)
        real = []
        for imgs in img_url:
            if imgs[0] =='/' :
        real.append("https:"+imgs+".jpg")
        for reals in real:
            if reals[7]=='w' and reals[8] =='p':
                del reals
        #利用set去除重复的图片url
        real = set(real)
#将所有的图片url返回到list列表中
    return real

#下载图片
    def download_img(self):
        count = 0
        for li in self.img_url:
            count =count+1
            flag=0
            if flag%2==0:
                print "正在尝试下载第 %s 张图片" %(count)
        try:
    #如果目录存在，直接下载，否则的话创建目录后下载
        if os.path.isdir('E:\\image'):
            urllib.urlretrieve(li,'E:\\love\\%s.jpg' %(count))
        else:
            os.mkdir('E:\\image')
            urllib.urlretrieve(li,'E:\\image\\%s.jpg' %(count))
        except IOError:
            print "下载图片失败"
        flag = flag+1

# main函数调用getImage类
if __name__ =='__main__':
#要爬取的图片网站的regex
    pattern = r'src="(.*?).jpg'
#要爬取的网站url
    site_url = "https://picjumbo.com/category/nature/page"
#传入图片网站的url和regex
    pa = getImage(site_url,pattern)
```
然后调试运行，输入要下载多少页图片

然后会获取所有图片链接


获取到所有链接后会自动将图片下载到电脑的E盘image目录下，这个目录个人电脑磁盘视情况而定
 
 
然后到E盘就可以查看到下载的图片了


由于图片都是高清的大图，因此可能会运行的有些慢，出去转转看下风景，过一会回来就可以看到下载的图了
先分享个风景图


3992*2661 绝对是超清的了，做PPT等素材是再好不过了可爱 
休息完后发现，图片已经全部下载好了，一共1842张，10.5G的高清风景图片，足够用了



 
其实最好可以再多启动几个线程，可以提高爬虫效率，但是由于网速恒定，因此每个线程抢夺网络，会导致每个线程获取到的流量变少，因此在网络够好的时候可以import threading 类加个多线程，提高搬砖效率 或者用scrapy实现分布式搬砖也可以，
亦余心之所善兮 ，虽九死其犹未悔，兴趣是人类最好的老师 