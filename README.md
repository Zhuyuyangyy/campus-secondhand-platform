# 校园二手交易平台（后端）
> 基于 SpringBoot + MySQL + Redis 开发的校园二手交易系统后端  
> 前端暂未开发，当前完成后端接口、业务逻辑、数据层设计与实现  
> 解决校园二手交易的核心业务问题，接口遵循 RESTful 规范，支持后续前端快速对接

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Java](https://img.shields.io/badge/Java-11+-red.svg)](https://www.java.com/)
[![SpringBoot](https://img.shields.io/badge/SpringBoot-2.7.x-green.svg)](https://spring.io/projects/spring-boot)

## 一、项目背景
高校学生闲置物品交易需求大，但线下交易效率低、信息不透明。本项目先完成**后端核心能力**搭建，为后续前端开发提供稳定、可扩展的接口支撑，旨在打造校园专属的二手交易后端服务。

## 二、核心后端功能（已完成）
### 👤 用户模块
- 学生注册/登录（校园邮箱验证、密码加密存储）
- 个人信息CRUD（头像、联系方式、收货地址管理）
- 权限控制（学生/管理员角色分离，基于Spring Security实现）

### 📦 商品模块
- 商品发布/修改/删除（参数校验、数据合法性验证）
- 商品检索（支持关键词、分类、价格区间、发布时间多条件筛选）
- 商品状态管理（上架/下架/审核中/违规封禁）

### 🤝 交易模块
- 交易流程逻辑（借书、还书、续借、逾期提醒）
- 交易状态流转（待付款→待发货→待收货→已完成/已取消）
- 交易记录查询、分页、导出（支持Excel导出）

### 🛠️ 通用能力
- 全局异常处理（统一返回格式、自定义异常类）
- 接口限流（防止恶意请求）
- 日志记录（操作日志、异常日志分级别存储）
- 数据校验（基于JSR380/Validated实现参数校验）

## 三、技术栈（后端）
| 技术         | 版本       | 用途                     |
|--------------|------------|--------------------------|
| Java         | 11+        | 后端开发语言             |
| SpringBoot   | 2.7.x      | 后端核心框架             |
| MyBatis-Plus | 3.5.x      | 数据库操作简化，支持分页/条件查询 |
| MySQL        | 8.0.x      | 关系型数据库（存储核心业务数据） |
| Redis        | 6.2.x      | 缓存（登录态、商品热搜、高频查询数据） |
| Spring Security | 5.7.x    | 权限控制、登录认证       |
| JWT          | 0.11.5     | 接口token认证（无状态登录） |
| Lombok       | 1.18.x     | 简化实体类代码           |
| Hutool       | 5.8.x      | 工具类（加密、日期、Excel处理） |

## 四、项目结构
campus-secondhand-platform/
├── src/main/java/com/campus/
│ ├── SecondhandApplication.java # 启动类
│ ├── config/ # 配置类（Redis、Security、MyBatis 等）
│ ├── controller/ # 接口层（RESTful 接口定义）
│ ├── service/ # 业务逻辑层（核心业务实现）
│ ├── mapper/ # 数据库映射层（MyBatis-Plus Mapper）
│ ├── entity/ # 数据库实体类
│ ├── dto/ # 入参 DTO（前端请求参数封装）
│ ├── vo/ # 出参 VO（后端返回结果封装）
│ ├── exception/ # 全局异常处理（统一返回格式）
│ ├── enums/ # 枚举类（交易状态、商品分类等）
│ └── util/ # 工具类（JWT、加密、分页等）
├── src/main/resources/
│ ├── application.yml # 核心配置（数据库、Redis、端口等）
│ └── db/ # 数据库脚本（建表、初始化数据）
└── README.md # 项目说明
plaintext

## 五、快速启动（后端）
### 1. 环境准备
- 安装 Java 11+、MySQL 8.0+、Redis 6.0+
- 克隆项目到本地：
  ```bash
  git clone https://github.com/你的GitHub用户名/campus-secondhand-platform.git
  cd campus-secondhand-platform
2. 配置修改
   修改 src/main/resources/application.yml 中的核心配置：
   yaml
   spring:
# 数据库配置
datasource:
url: jdbc:mysql://localhost:3306/campus_secondhand?useSSL=false&serverTimezone=Asia/Shanghai
username: root  # 你的MySQL用户名
password: root  # 你的MySQL密码
# Redis配置
redis:
host: localhost
port: 6379
password:  # 你的Redis密码（无则留空）
server:
port: 8080  # 后端端口
3. 初始化数据库
   执行 src/main/resources/db/init.sql 脚本，自动创建数据库表并插入初始数据：
   初始管理员账号：admin / admin123
   初始学生账号：student1 / 123456
4. 启动后端
   方式 1：IDE 中运行 SecondhandApplication.java
   方式 2：Maven 打包运行：
   bash
   运行
   mvn clean package -DskipTests
   java -jar target/campus-secondhand-platform-1.0.0.jar
   六、核心接口示例（可直接测试）
1. 学生登录（POST）
   http
   POST /api/user/login
   Content-Type: application/json

{
"username": "student1",
"password": "123456"
}
返回结果：
json
{
"code": 200,
"msg": "登录成功",
"data": {
"token": "eyJhbGciOiJIUzI1NiJ9.xxx.xxx",  // JWT令牌
"userId": 1001,
"role": "STUDENT"
}
}
2. 商品发布（POST，需携带 token）
   http
   POST /api/goods/publish
   Content-Type: application/json
   Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.xxx.xxx

{
"title": "九成新Java编程思想教材",
"categoryId": 1,
"price": 35.0,
"negotiable": true,
"description": "仅用过一学期，无笔记无破损",
"userId": 1001
}
返回结果：
json
{
"code": 200,
"msg": "商品发布成功，待审核",
"data": {
"goodsId": 10001,
"publishTime": "2026-03-09 15:30:00"
}
}
3. 商品列表查询（GET，需携带 token）
   http
   GET /api/goods/list?keyword=Java&pageNum=1&pageSize=10
   Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.xxx.xxx
   七、后续规划（前端待开发）
   基于 Vue + Element UI 开发前端页面，对接现有后端接口；
   实现前端权限控制、商品图片上传 / 预览、交易状态可视化；
   新增消息推送功能（交易提醒、议价通知）；
   优化接口性能（新增索引、批量处理）。
   八、联系方式
   开发者：朱玉阳（安徽中医药大学 大数据专业）
   邮箱：2024207335060@stu.ahtcm.edu.cn
   GitHub：https://github.com/ZhuYuyang
   plaintext

### 核心调整点（适配“前端未写”）
1. 标题明确标注「后端」，避免误解；
2. 删掉所有前端相关内容，重点突出**后端已完成的功能、接口设计、技术选型**；
3. 新增「后续规划」模块，体现你的整体思考（不是只写了后端就没想法了）；
4. 接口示例保留“可直接测试”的特点，面试官能通过Postman调用验证你的代码能力。
