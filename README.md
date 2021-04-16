## 中电设备管理系统部署
请参考 [中电设备管理系统部署文档](./中电设备管理系统部署文档.md)

#### 代码目标结构
ems
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
   + mysql
   + redis
   + web
   - docker-compose.yml
 - .dockerignore

### 操作步骤
> 复制 .dockerignore 文件到`ems`根目录
```
cp ./ceiec-ems-docker-deploy/.dockerignore .
```

#### 构建`api`镜像
```
sh docker-build.sh
docker-compose up
```
