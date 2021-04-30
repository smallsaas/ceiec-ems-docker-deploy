## 中电设备管理系统部署

#### 准备Windows10 或 Windows Server 2016 服务平台
安装Docker Desktop for Windows环境 |
[下载页面](https://hub.docker.com/editions/community/docker-ce-desktop-windows) | 
[下载链接](https://desktop.docker.com/win/stable/amd64/Docker%20Desktop%20Installer.exe)


#### 下载部署仓库
https://github.com/smallsaas/ceiec-ems-docker-deploy/archive/refs/tags/ceiec.zip
>
> 或访问此链接[下载](https://github.com/smallsaas/ceiec-ems-docker-deploy/releases) 并解压
>
> 或通过 `git bash`克隆
```shell
git clone https://github.com/smallsaas/ceiec-ems-docker-deploy.git
```

#### 下载`app.jar`放置在根目录下
> 根目录为 `ceiec-ems-docker-deploy`
>
> 下载地址 | [app.jar](https://github.com/smallsaas/ceiec-ems-docker-deploy/releases/download/app/app.jar)
>
```shell
ls ceiec-ems-docker-deploy
api
bin
web
...
app.jar
docker-compose.yml
...
```

#### 构建并运行镜像
> 进入目录, 选择`startup.cmd`文件，右键选择`powershell`执行
>
> 或选择解压目录（ceiec-ems-docker-deploy）按鼠标右键在该目录下打开`powershell`
> 
> 并执行以下命令
```shell
powershell> ./startup.cmd
powershell> #or
powershell> docker-compose up --detach --build --remove-orphans
```

#### 如何中止服务
```shell
powershell>docker-compose stop 
```

## 常见问题

#### 硬盘没有共享
```
Error response from daemon: status code not OK but 500: {"Message":"Unhandled exception: Drive has not been shared"}
```
解决步骤
> [docker-drive-has-not-been-shared](https://stackoverflow.com/questions/59942110/docker-drive-has-not-been-shared)
- 打开 docker desktop 
- 进入设置 -> Resource -> FILESHARING 
- 增加共享 `c:` 盘 (若部署文件在 `c:` 盘）
