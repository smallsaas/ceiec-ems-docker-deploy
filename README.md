## 中电设备管理系统部署
请参考 [中电设备管理系统部署文档](./中电设备管理系统部署文档.md)

#### 代码目标结构

>下载部署代码
```shell
git clone https://github.com/smallsaas/ceiec-ems-docker-deploy.git
```
>
> 源代码目录结构如下
```
+ am
  + am-equipment
  + am-fault
  + am-html
  + am-pack
  + am-report
  + am-warehouse
  + dashboard
  + sb-category
  + sb-document
  + sb-infrastructure
  + sb-organization
  - pom.xml
+ ceiec-ems-docker-deploy
  + api
  + gateway
  + io
  + mysql
  + redis
  + web
  - docker-compose.yml
```

#### 复制 `.dockerignore` 文件
> 复制 .dockerignore 文件到根目录
```shell
cd ceiec-ems-docker-deploy
cp .dockerignore ..
```

#### 构建`api`镜像
```
docker-compose build api
```

#### 构建`web`镜像
