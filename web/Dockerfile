FROM daocloud.io/library/node:12 as build

WORKDIR /usr/src

ADD ./am/am-html/package.json ./web/package.json
# ADD ./am/am-html/package-lock.json ./web/package-lock.json
ADD ./am/am-html/src ./web/src
ADD ./am/am-html/public ./web/public

WORKDIR /usr/src/web
RUN npm i 
RUN npm run build

#final-stage
FROM daocloud.io/library/nginx:latest
COPY --from=build /usr/src/web/dist/* /usr/share/nginx/html/
