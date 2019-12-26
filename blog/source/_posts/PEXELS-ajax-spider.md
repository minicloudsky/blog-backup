---
title: PEXELS ajax图片爬虫
date: 2017-10-01 13:03:57
categories: 
- Python
- 爬虫
tags:
- python
- 爬虫
---
PEXELS-ajax图片爬虫
最近在实验室做 php 的项目，需要几张插图，我就在想，能不能利用自己所学的 python，去抓取一些图片为我所用呢? 说干就干，打开 pycharm。
1 首先我们打开 pexels，分析网页。
![](https://pic2.zhimg.com/v2-35acf492dd997844124f6bff673d2ca5_b.png)
![](https://pic1.zhimg.com/v2-e4d64beef614c02413e2637c8f363698_b.png)
<!-- more -->
首先我们可以看到的是图片分类，打开一个分类，下拉后可以发现，这些图片是 javascript异步加载的，我们 F12 调试下，看看这些图片是如何加载的。
1[](https://pic1.zhimg.com/v2-e4d64beef614c02413e2637c8f363698_b.png)
这里的 RequestsUrl 是什么呢? 我们复制粘贴用浏览器打开看下。
![](https://pic2.zhimg.com/v2-96ad0ced68c38d1080af55e545af1611_b.png)
可以看到这些全是 js 代码，我们 Ctrl+F 查找下有没有图片呢?
![](https://pic1.zhimg.com/v2-1fb4584fd735b8fc23d3e8f90c29adac_b.png)
可以看到，有这些图片链接，到了这里，我们理清下思路:
pexels 图片网站，是通过 js 异步加载，当你下拉滚动条时候，它才加载 js 代码，从而形成瀑布流的图片样式。
那么，我们就可以通过获取这些 js 源代码，就可以得到图片链接，获取图片了。
于是，我们先分析下这个 js 链接。
https://www.pexels.com/search/books/?page=3&seed=2017-09-15+17%3A23%3A32++0000&format=js&seed=2017-09-15%2017:23:32%20+0000
可以看到，books 很明显是图片分类，page 是页面数，后面的 seed=2017-9-15, 是一个日期格式，format=js 代表格式是 js，由此，我们就可以构造一个生成 js 的链接了。
```Python
 def get_js(page_num,keyword):
        list = []
        for i in range(1,page_num+1):
            list.append("https://www.pexels.com/search/"+
            str(keyword)+"/?page="+str(i)+
            "&seed=2017-09-08+22%3A19%3A08++0000&format=js&seed=2017-09-08%2022:19:08%20+0000")
        return list
```
生成 js 链接后，我们查看下 js 里面的图片链接，发现相同 id 的竟然有两个:

src=\"https://images.pexels.com/photos/36428/book-read-relax-lilac.jpg?h=350&amp;auto=compress&amp;cs=tinysrgb\"

src="https://images.pexels.com/photos/36428/book-read-relax-lilac.jpg?w=800&amp;h=1200&amp;fit=crop&amp;auto=compress&amp;cs=tinysrgb\"

? 后面的一长溜参数是什么鬼?
我们先打开这个链接看下再说
![](https://pic4.zhimg.com/v2-cbcd70854386c8c5e6c27bddff2facff_b.png)
可以发现，一个是大图，一个是小图，我们下载下看看
![](https://pic1.zhimg.com/v2-1c03fb1c4ebe9259e2a0489383c999b8_b.png)
可以看到，一个是大图，一个是小图，如果我们把? 后面的参数去掉呢?
![](https://pic2.zhimg.com/v2-3ad5d6771715343662b7f3a81eb97eb1_b.png)
原来不带参数的才是大图，要下载当然是超清的才是最好的。
然后，我们写个获取 js 中图片链接的函数.
 ```python
 #获取每一页 js 中的图片链接
     def get_img_url_list(js_url):
        regex ='https://images.pexels.com/photos/\d+/pexels-photo-\d+.jpeg?'
        reg = re.compile(regex)
        req = requests.get(js_url,headers = self.header)
        text = req.text
        list = re.findall(reg,text)
        return list
```
如何下载图片呢? 当然是再写个下载的函数了。
```python
def downloadPic(url,count):
        print("downloading :"+url)
        try:
            req = requests.get(url,headers = self.header)
            f = open(path+"\\"+str(count)+ ".jpg", 'wb')
            f.write(req.content)
            f.close()
        except:
            print(" 下载失败 ")
            pass
```
但是，这个网站这么多分类的图片，这样下载者多慢呀，肿么办，，，当然是召唤我们的多线程妹妹了，说来就来，我们用 python 的 threading 模块开启多线程。

#key 为图片关键词，即图片分类，page为下载页数，p
```python
def start_thread(key,page,path):
    t = threading.Thread(target=download_keyword,args=(key,page,path))
    t.start()
```
现在，让我们再来理清下思路，爬取 pexels 图片网站的图片，我们首先爬取图片分类，然后获取每个分类对应的 js 代码，从 js 代码中，用正则表达式找出图片链接，最后，再实现下载每一张图片，为了提高下载效率，我们需要用 threading 模块来实现多线程，加速下载。

这样感觉好麻烦呀，好多函数，怎么才能提高代码复用性呢？

当然是面向对象了，然而程序员哪有女朋友，只能手动 new 一个了。嗯呐，你的对象如下:
```python
class pexels():
    def __init__(self,keyword,page_num,path):
        self.keyword  = keyword
        self.page_num = page_num
        #header,就是你的浏览器标识，把你的py代码伪装成浏览器访问
        self.header = {'User-Agent': 'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6' }
        self.path = path +"\\pexels_picture\\"+self.keyword
        if not os.path.exists(self.path):
            os.makedirs(self.path)
        self.js_urls = []
        self.download()
    #控制下载
     def download(self):
        js_url = self.get_js()
        print("%s 的 js 文件获取成功 " %(self.keyword))
        img_url = []
        for i in js_url:
            temp = self.get_img_url_list(i)
            for li in temp:
                img_url.append(li)
        print("%s 类型的图片一共有 %s 张 " %(self.keyword,len(img_url)))
        img_url = set(img_url)
        img_number = 1
        count =1
        for li in img_url:
            if(count%2!=0):
                self.downloadPic(li,img_number)
                print(" 正在下载 %s 的第 %s 张图片 " %(self.keyword,img_number))
            img_number +=1
            count+=1
    """ 获取网站 ajax 异步加载的 JavaScript 代码，
    这些代码异步加载从而实现下拉即可加载图片, 所以得到了 js 文件也就得到了
    所有的图片链接 """
    def get_js(self):
        list = []
        for i in range(1,self.page_num+1):
            list.append("https://www.pexels.com/search/"+str(self.keyword)+"/?page="+str(i)+"&seed=2017-09-08+22%3A19%3A08++0000&format=js&seed=2017-09-08%2022:19:08%20+0000")
        return list
    #获取每一页 js 中的图片链接
     def get_img_url_list(self,js_url):
        regex ='https://images.pexels.com/photos/\d+/pexels-photo-\d+.jpeg?'
        reg = re.compile(regex)
        req = requests.get(js_url,headers = self.header)
        text = req.text
        list = re.findall(reg,text)
        return list
    #下载每一张图片
     def downloadPic(self,url,count):
        print("downloading :"+url)
        try:
            req = requests.get(url,headers = self.header)
            f = open(self.path+"\\"+str(count)+ ".jpg", 'wb')
            f.write(req.content)
            f.close()
        except:
            print(" 下载失败 ")
            pass
    #调用每个 keyword 对应的页面
下面让我们来提取下关键词。

#从 js 文件中提取出图片类型的关键词
 def get_pexels_pic_type():
    js_type = []
    img_type = []
    for i in range(1,10):
        js_type.append("https://www.pexels.com/popular-searches/?page="+str(i)+"&format=js&seed=298640966")
    header = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.79 Safari/537.36'}
    for i in js_type:
        r = requests.get(i,headers = header)
        text = str(r.text)
        reg = r'img alt=\\"(.+?)\\"'
        reg = re.compile(reg)
        list = re.findall(reg,text)
        for i in list:
            img_type.append(i)
        count = 1
    for i in img_type:
        print(i+" ",end="")
        if count%10==0:
            print()
        count +=1
    print("")
    print("pexels 图片网站一共有以上英文所示的 %s 种类型图片 " %(len(img_type)))
    return img_type
为了计时，我导入了 time 模块统计下载时间。

    start = time.time()
    print(" 正在抓取 pexels 网站的图片分类 ")
    keyword = get_pexels_pic_type()
    page_num = int(input(" 请输入要下载的页数:"))
    #获取当前文件所在的目录
    path = str(os.getcwd())
    print(" 图片将被保存在 %s" %(path))
    for i in keyword:
        start_thread(i,page_num,path)
    end = time.time()
    print(" 一共耗费 %s s" %(str(end-start)))
```
接下来做什么?
当然是调试运行了!!!
![](https://pic2.zhimg.com/v2-8f9feba1445db9d100eccbb6e39ce8d9_b.png)
嗯，一共 203 个图片分类，然后我们输入下载页数，也就是下载多少页的图片，我们输入 1，看下会发生什么。
![](https://pic2.zhimg.com/v2-cd30d1645caf94bb7f276d5cddb3bdd9_b.png)
![](https://pic4.zhimg.com/v2-5ad4e6c6d3f817bf9f973c0cc9959d73_b.png)
嗯，先获取 js 源代码，从 js 中获取到图片链接之后，开始下载。
由于我设置的下载路径是在该 python 代码所在的文件目录里下载，因此我们打开该目录。
![](https://pic4.zhimg.com/v2-cfe6cbe977464e4c281d3c5ef6d89953_b.png)
可以看到文件夹创建成功，跑了大概 30 秒，我为了不让电脑卡，就暂停了，你可以自己根据需要，爬取适合自己需要数量的图片。我们看下多大。
![](https://pic2.zhimg.com/v2-1924760d30d552b35ba8dac05114b905_b.png)
嗯，效率还是很高的，打开个图片看下。
![](https://pic3.zhimg.com/v2-19fcb14ffb271d968998d4d98ac15326_b.png)
![](https://pic3.zhimg.com/v2-a385d574407e9d59817db9e7fc54d0b2_b.png)
嗯，图片挺清晰的，不过，我建议大家根据需要下载，尽量不要全站下载，这样容易给人家服务器造成很大的访问压力。
最后，这里给大家附上源代码，供初学者学习，我的环境是 win10+python3.5+pycharm。大神还请轻喷。
```python

# coding: utf-8
import re
import requests
import os
import time
import threading
class pexels():
    def __init__(self,keyword,page_num,path):
        self.keyword  = keyword
        self.page_num = page_num
        self.header = {'User-Agent': 'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6' }
        self.path = path +"\\pexels_picture\\"+self.keyword
        if not os.path.exists(self.path):
            os.makedirs(self.path)
        self.js_urls = []
        self.download()
    #控制下载
     def download(self):
        js_url = self.get_js()
        print("%s 的 js 文件获取成功 " %(self.keyword))
        img_url = []
        for i in js_url:
            temp = self.get_img_url_list(i)
            for li in temp:
                img_url.append(li)
        print("%s 类型的图片一共有 %s 张 " %(self.keyword,len(img_url)))
        img_url = set(img_url)
        img_number = 1
        count =1
        for li in img_url:
            if(count%2!=0):
                self.downloadPic(li,img_number)
                print(" 正在下载 %s 的第 %s 张图片 " %(self.keyword,img_number))
            img_number +=1
            count+=1
    """ 获取网站 ajax 异步加载的 JavaScript 代码，
    这些代码异步加载从而实现下拉即可加载图片, 所以得到了 js 文件也就得到了
    所有的图片链接 """
    def get_js(self):
        list = []
        for i in range(1,self.page_num+1):
            list.append("https://www.pexels.com/search/"+str(self.keyword)+"/?page="+str(i)+"&seed=2017-09-08+22%3A19%3A08++0000&format=js&seed=2017-09-08%2022:19:08%20+0000")
        return list
    #获取每一页 js 中的图片链接
     def get_img_url_list(self,js_url):
        regex ='https://images.pexels.com/photos/\d+/pexels-photo-\d+.jpeg?'
        reg = re.compile(regex)
        req = requests.get(js_url,headers = self.header)
        text = req.text
        list = re.findall(reg,text)
        return list
    #下载每一张图片
     def downloadPic(self,url,count):
        print("downloading :"+url)
        try:
            req = requests.get(url,headers = self.header)
            f = open(self.path+"\\"+str(count)+ ".jpg", 'wb')
            f.write(req.content)
            f.close()
        except:
            print(" 下载失败 ")
            pass
    #调用每个 keyword 对应的页面
 def download_keyword(key,page,path):
    img = pexels(key,page,path)
#开启多线程，加速下载
 def start_thread(key,page,path):
    t = threading.Thread(target=download_keyword,args=(key,page,path))
    t.start()
#从 js 文件中提取出图片类型的关键词
 def get_pexels_pic_type():
    js_type = []
    img_type = []
    for i in range(1,10):
        js_type.append("https://www.pexels.com/popular-searches/?page="+str(i)+"&format=js&seed=298640966")
    header = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.79 Safari/537.36'}
    for i in js_type:
        r = requests.get(i,headers = header)
        text = str(r.text)
        reg = r'img alt=\\"(.+?)\\"'
        reg = re.compile(reg)
        list = re.findall(reg,text)
        for i in list:
            img_type.append(i)
        count = 1
    for i in img_type:
        print(i+" ",end="")
        if count%10==0:
            print()
        count +=1
    print("")
    print("pexels 图片网站一共有以上英文所示的 %s 种类型图片 " %(len(img_type)))
    return img_type
if __name__ == '__main__':
    start = time.time()
    print(" 正在抓取 pexels 网站的图片分类 ")
    keyword = get_pexels_pic_type()
    page_num = int(input(" 请输入要下载的页数:"))
    path = str(os.getcwd())
    print(" 图片将被保存在 %s" %(path))
    for i in keyword:
        start_thread(i,page_num,path)
    end = time.time()
    print(" 一共耗费 %s s" %(str(end-start)))
```
