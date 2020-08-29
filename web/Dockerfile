FROM daocloud.io/library/nginx:latest
COPY ./dist /usr/share/nginx/html
# 开放80端口
EXPOSE 80
 
STOPSIGNAL SIGTERM
 
# 启动nginx命令
CMD ["nginx", "-g", "daemon off;"]


