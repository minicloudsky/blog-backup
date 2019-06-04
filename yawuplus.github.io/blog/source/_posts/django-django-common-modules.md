---
title: django 开发常用模块
date: 2018-03-08 11:02:50
tags:
categories: django
---
Django 的好处就是大而全，不仅内置了 ORM、表单、模板引擎、用户系统等，而且第三方应用的生态也是十分完善，开发中大部分常见的功能都能找到对应的第三方实现。在这里给大家推荐 10 个十分优秀的 Django 第三方库（GitHub 星星数基本都在 1000 以上，而且都在持续维护与更新中）。虽然这些库很适合用于社交网站的开发，但也有很大一部分是通用的，可以用于任何用 Django 开发的项目。使用这些库将大大提高开发效率和生产力。
<!-- more -->
django-model-utils
简介：Django model mixins and utilities.

GitHub 地址：https://github.com/jazzband/django-model-utils

文档地址：http://django-model-utils.readthedocs.io/en/latest/

点评：增强 Django 的 model 模块。内置了一些通用的 model Mixin，例如 TimeStampedModel 为模型提供一个创建时间和修改时间的字段，还有一些有用的 Field，几乎每个 Django 项目都能用得上。

django-allauth
简介：Integrated set of Django applications addressing authentication, registration, account management as well as 3rd party (social) account authentication.

GitHub 地址：https://github.com/pennersr/django-allauth

文档地址：https://django-allauth.readthedocs.io/en/latest/

点评：增强 Django 内置的 django.contrib.auth 模块，提供登录、注册、邮件验证、找回密码等一切用户验证相关的功能。另外还提供 OAuth 第三方登录功能，例如国内的微博、微信登录，国外的 GitHub、Google、facebook 登录等，几乎囊括了大部分热门的第三方账户登录。配置简单，开箱即用。

django-crispy-forms
简介：The best way to have DRY Django forms. The app provides a tag and filter that lets you quickly render forms in a div format while providing an enormous amount of capability to configure and control the rendered HTML.

GitHub 地址：https://github.com/django-crispy-forms/django-crispy-forms

文档地址：http://django-crispy-forms.rtfd.org/

点评：大大增强 Django 内置的表单功能，Django 内置的表单生成原生的 HTML 表单代码还可以，但为其设置样式是一个麻烦的事情。django-crispy-forms 帮助你使用一行代码渲染一个 Bootstrap 样式的表单，当然它还支持其它一些热门的 CSS 框架样式的渲染。

django-mptt
简介：Utilities for implementing a modified pre-order traversal tree in django.

GitHub 地址：https://github.com/django-mptt/django-mptt

文档地址：https://django-mptt.readthedocs.io/

点评：配合 Django 的 ORM 系统，为数据库的记录生成树形结构，并提供便捷的操作树型记录的 API。例如可以使用它实现一个多级的评论系统。总之，只要你的数据结构可能需要使用树来表示，django-mptt 将大大提高你的开发效率。

django-contrib-comments
简介：Django used to include a comments framework; since Django 1.6 it's been separated to a separate project. This is that project.

This framework can be used to attach comments to any model, so you can use it for comments on blog entries, photos, book chapters, or anything else.

GitHub 地址：https://github.com/django/django-contrib-comments

文档地址：https://django-contrib-comments.readthedocs.io/

点评：用于提供评论功能，最先集成在 django 的 contrib 内置库里，后来被移出来单独维护（可能觉得评论并非是一个通用的库吧）。这个评论库提供了基本的评论功能，但是只支持单级评论。好在这个库具有很好的拓展性，基于上边提到的 django-mptt，就可以构建一个支持层级评论的评论库，就像 我的博客评论区 中展示的这样（个人博客的评论模块就是基于 django-contrib-comments 和 django-mptt 写的）。

django-imagekit
简介：Automated image processing for Django.

GitHub 地址：https://github.com/matthewwithanm/django-imagekit

文档地址：http://django-imagekit.rtfd.org/

点评：社交类网站免不了处理一些图片，例如头像、用户上传的图片等内容。django-imagekit 帮你配合 django 的 model 模块自动完成图片的裁剪、压缩、生成缩略图等一系列图片相关的操作。

django-brace
简介：Reusable, generic mixins for Django

GitHub 地址：https://github.com/brack3t/django-braces

文档地址：http://django-braces.readthedocs.io/en/latest/index.html

点评：django 内置的 class based view 很 awesome，但还有一些通用的类视图没有包含在 django 源码中，这个库补充了更多常用的类视图。类视图是 django 的一个很重要也很优雅的特性，使用类视图可以减少视图函数的代码编写量、提高视图函数的代码复用性等。深入学习类视图可以看Django类视图源码分析。

django-notifications-hq
简介：GitHub notifications alike app for Django

GitHub 地址：https://github.com/django-notifications/django-notifications

文档地址：https://pypi.python.org/pypi/django-notifications-hq/

点评：没什么好说的，为你的网站提供类似于 GitHub 这样的通知功能。未读通知数、通知列表、标为已读等等。

django-simple-captcha
简介：Django Simple Captcha is an extremely simple, yet highly customizable Django application to add captcha images to any Django form.

GitHub 地址：https://github.com/mbi/django-simple-captcha

文档地址：http://django-simple-captcha.readthedocs.io/en/latest/

点评：配合 django 的表单模块，方便地为表单添加一个验证码字段。对验证性要求不高的需求，例如注册表单防止机器人自动注册等使用起来非常方便。

django-anymail
简介：Django email backends and webhooks for Mailgun, Mailjet, Postmark, SendGrid, SparkPost and more

GitHub 地址：https://github.com/anymail/django-anymail

文档地址：https://anymail.readthedocs.io/

点评：配合 django 的 email 模块，只需简单配置，就可以使用 Mailgun、SendGrid 等发送邮件。

django-activity-stream
简介：Generate generic activity streams from the actions on your site. Users can follow any actors' activities for personalized streams.

GitHub 地址：https://github.com/justquick/django-activity-stream

文档地址：http://django-activity-stream.rtfd.io/en/latest/

点评：社交类网站免不了关注、收藏、点赞、用户动态等功能，这一个 app 全搞定。甚至用它实现一个朋友圈也不是不可能。


