FROM nginx:latest

COPY conf/nginx.conf.template /etc/nginx/templates/nginx.conf.template

ARG DEV_HOSTNAME
ARG FRONTEND_HOST
ARG FRONTEND_PORT
ARG PROXY_API_PORT

# 環境変数を展開して設定ファイルを配置する
RUN envsubst '${DEV_HOSTNAME},${FRONTEND_HOST},${FRONTEND_PORT},${PROXY_API_PORT}' < /etc/nginx/templates/nginx.conf.template > /etc/nginx/nginx.conf
