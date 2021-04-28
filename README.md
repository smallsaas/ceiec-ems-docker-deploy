## 中电设备管理系统部署

#### 准备Windows10 或 Windows Server 2016 服务平台
安装Docker Desktop for Windows环境 |
[下载页面](https://hub.docker.com/editions/community/docker-ce-desktop-windows) | 
[下载链接](https://desktop.docker.com/win/stable/amd64/Docker%20Desktop%20Installer.exe)


#### 下载部署仓库
https://github.com/smallsaas/ceiec-ems-docker-deploy/archive/refs/tags/ceiec.zip
>
> 或访问此链接[下载](https://github.com/smallsaas/ceiec-ems-docker-deploy/releases)
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
> 进入目录, 选择`startup.ps1`文件，右键选择`powershell`执行
>
> 以下为命令行执行方式
```shell
cd ceiec-ems-docker-deploy
docker-compose up --detach --build --remove-orphans
## or
sh startup.sh
```

#### 如何中止服务
在`powershell`输入终端键盘快捷键 `Ctrl+C` 中止
> 请不要直接关闭窗口终端

