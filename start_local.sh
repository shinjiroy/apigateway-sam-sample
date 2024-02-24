#!/bin/bash

# API Gatewayローカル環境起動用スクリプト
# 先にlocal/installer_sam_forlinux.shかlocal/installer_sam_formac.shでSAM CLIをインストールしてね。

set -e

# .envの値を実行時に環境変数として展開する
set -a
source .env
set +a

# やりたい人はどうぞ
# export SAM_CLI_TELEMETRY=0

# API Gateway以外起動
docker-compose up -d

# API Gateway起動

# 関数をコンテナを使ってビルド
sam build --use-container --skip-pull-image
# sam build --use-container --debug

# docker-composeで作成したコンテナにつなげられる状態で起動
# ※--debugを付けるとEventの中身とかが全部出て便利
# ※.envのPROXY_API_PORTを変えたら docker compose build web をしてから実行してね。
sam local start-api --docker-network ${COMPOSE_PROJECT_NAME}-network --env-vars ./local/sam_api_env.json --skip-pull-image --port $PROXY_API_PORT
