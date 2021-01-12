# 程序员之家平台网站介绍

**由于各种原因，该项目已经废弃，故不再维护！！**

[TOC]

> 程序员之家平台网站是一个面向有志成为程序员或相关从业人员的大学生群体而开发的，同时它也是一个大学社团即程序员之家社团的唯一官方平台，该平台的核心开发及维护成员也均为该社团成员，当然我们也欢迎非社团成员前来协助。

## 概况

平台网站主要面向大学生群体，其主要包含有四大模块，分为用户模块，文章模块，讨论模块以及学堂模块。

### 用户模块

包括用户的登录注册、用户个人资料的编辑、用户站内信，用户中心的个性化修改、用户对自己文章、收藏、讨论及评论的管理，对其他用户的关注，以及后台管理员对用户的权限管理等。

### 文章模块

用户文章的撰写与浏览，文章评论的发表、个人文章的收藏，文章个性化推荐系统，管理员对文章及其评论的管理。

### 讨论模块

小型社交网络，用户讨论的实时发布和讨论分享。

### 学堂模块

成体系的学习路线规划以及用户自定义学习路线规划。

## 技术实现细节

平台整体使用MVVM设计模式，前端负责页面渲染、数据展示、路由的导航等，后端负责各类API接口的实现

### 前端技术栈

语言：HTML、CSS、JavaScript

服务器：Node.js

框架：Nuxt、Vue.js

UI框架：Element UI、Vuetify

开发工具：Webstorm、Cmder

版本管理工具：git

第三方库：axios、lodash、qs、zxcvbn（太多就不列了）...

### 后端技术栈

语言：Java、SQL、JavaScript

服务器：Tomcat、Node.js、Elasticsearch

项目自动化建构工具：Gradle

框架：Spring Boot、Spring Security、Spring Data、Koa

数据库：MySql、Redis、MongoDB

开发工具：IDEA、Webstorm

版本管理工具：git

第三方库：JJWT、socket.io、lombok（暂时）

### 说明

前端部分为了解决SEO问题同时保证首屏渲染的效率使用了SSR，而Nuxt作为Vue官方推荐的SSR框架也是一个不二的选择，UI框架方面选择了Vuetify与Element，但整体还是以Vuetify为主，Element作为一个补充，虽然一开始想使用Quasar，但由于其对于Nuxt的支持还在进行中，所以只能舍弃，最后前端项目页面的渲染服务器使用Node，同时其也作为与后端服务器交互的中间层。

后端分为两部分，一部分是以Java为核心的主服务器，另一个是以JS为核心的辅助服务器。

主服务器用于运行平台网站主要的业务逻辑，框架上使用Spring Boot+Spring Security+Spring Data，Spring Boot用于实现RESTful API服务，Spring Security配合JWT协议用于服务器的访问权限控制，Spring Data用于对MySql与Redis的访问，使用Elasticsearch作为文档检索服务器。

辅助服务器用于运行平台网站的一个子服务，即用户站内信功能，因为考虑到Node.js对于web-socket的完美支持，而且JavaScript对callback同步模式具有原生态支持，所以与java相比，JavaScript十分适合用于该功能的实现，且不存在性能上的问题。具体框架搭配使用Koa+Sockt.io+MongoDB来进行相关的实现。

## 项目进度

符号说明：

`*：开发中`

`#：未开始`

`-`：前后端对接或DEBUG状态

1. 用户模块
   - [x] 用户登录、注册、忘记密码
   - [x] 用户信息修改及个人中心的个性化修改
   - [ ] 用户关注功能以及相关列表信息的获取`-`
   - [ ] 用户个人中心`*`
   - [ ] 第三方登录`#`
   - [ ] 后台管理`#`
2. 文章模块
   - [ ] 文章列表的获取`-`
   - [ ] 文章标签系统`*`
   - [ ] 文章撰写功能`-`
   - [ ] 文章评论系统`*`
   - [ ] 后台管理`#`

3. 讨论模块`#`
4. 学堂模块`#`

## 相关设计文档

1. [API设计文档](https://www.eolinker.com/#/share/index?shareCode=d9dbhT)（有些地方可能会因为更新不及时与项目有冲突）
2. [UI设计（前台·新版）](https://free.modao.cc/app/66d954fac42a1e3c0e4ae7d616b9609531e382cc#screen=s25615085e0dc00ad25bcc2)（仅供参考，以项目实例为主）
3. [UI设计（前台·旧版）](https://free.modao.cc/app/J8er6v7j4fjhaTsbw1SowJHz7c41WoQ#screen=sEEEF5346B51510381810655)
4. [UI设计（后台）](https://free.modao.cc/app/jQOWsoXVG4VUZ2gWAKvvI31dZ77QOh3)(项目后台还未开始做，可能做的时候，该UI界面变动会较大))
5. [数据库](https://github.com/CXYZJ408/-/blob/master/cxyzj.sql)(包含了一些测试数据)
6. [测试说明文档](https://github.com/CXYZJ408/-/blob/master/%E6%B5%8B%E8%AF%95%E8%AF%B4%E6%98%8E/%E6%B5%8B%E8%AF%95%E8%AF%B4%E6%98%8E%E6%96%87%E6%A1%A3.md)
7. [代码规范文档](https://github.com/CXYZJ408/-/blob/master/%E4%BB%A3%E7%A0%81%E8%A7%84%E8%8C%83.md)
8. [用户安全验证系统说明](https://github.com/CXYZJ408/-/blob/master/%E7%94%A8%E6%88%B7%E5%AE%89%E5%85%A8%E9%AA%8C%E8%AF%81%E7%B3%BB%E7%BB%9F.md)
9. [接口编写说明文档](https://github.com/CXYZJ408/-/blob/master/%E6%8E%A5%E5%8F%A3%E7%BC%96%E5%86%99%E8%AF%B4%E6%98%8E.md)


## 项目地址

1. [前端](https://github.com/CXYZJ408/cxyzjFront)
2. [后端](https://github.com/CXYZJ408/cxyzjback)

