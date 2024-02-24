# apigateway-sam-sample

## これはなに

RDBを使うAPIをLambda+API Gatewayで作る時のサンプルです。

## 使用技術

- AWS SAM
  - API Gateway
  - Lambda
- Docker
  - RDB(MySQL)
  - Proxy(Nginx) ※APIをSSL化したり、何かしら処理を挟みたい時に使う

## 説明

これが目指すものは、アプリケーション開発者がAPIを開発する時にインフラ周りを(ほぼ)気にしないで作れる事です。  
したがって、AWS SAMで管理する物はAPI GatewayとLambdaのみの想定です。それ以外のAWSリソースは別でTerraformなり、CloudFormationなりで、アプリケーション開発者以外によって管理される想定としています。

アプリケーション開発者が気にするものは、APIの仕様(特にURL、HTTPメソッドと、処理を対応させること。ルーティングみたいなもの)、APIの実装、DBの中身だけという前提です。  
具体的に言うと、Lambdaに必要なIAMや、CloudFront、SQS、S3、Cognito等は、例えばインフラ担当者とかそういう人が担当する物という前提としています。

> template.yamlを書くのはLaravelで例えるならばroute.phpを書くようなもので、Lambdaのコードを書くのはControllerを書くようなものだ

### ローカル環境の説明

AWS SAMはローカルの端末にインストールする想定とし、コマンドにて各Lambda用のコンテナがローカルの端末に建ちます。  
docker-composeの管理下に作らないのは、Docker In Dockerの構成を作るのが面倒くさいからです。

docker-composeで管理する物はRDBとAPIのProxyサーバーです。docker-composeの外にある、AWS SAMによって建てられたコンテナがRDBに接続できるよう、  
ここで作ったネットワークをAWS SAMで起動する時に指定することで、LambdaがRDBに接続できます。

実際にデプロイする時は、LambdaはVPC上に作成することになります。

また、ProxyはローカルでもSSL化した状態で確認したかったり、Amazon Cognitoを利用する場合、認証後想定のシークレットか何かをCookieやヘッダに入れてからAPIに転送するような仕組みを準備したい時に使います。  
それらが不要な場合は直接 `localhost:{PROXY_API_PORT}` 等で呼ぶという使い方でも構いません。

## ローカル環境構築

前提

- Mac or Linux or WSLの想定です。Windowsで直接実行するのは想定していません。
- Dockerが入っていること。
  - Docker Desktopが入ってるとProxyが動きますが、LinuxでDocker CLIを直接使う方式だとProxyは現状だと動きません。[docker-compose.yaml参照](./docker-compose.yaml)

手順

1. Linux, WSLの人は`local/installer_sam_forlinux.sh`を、Macの人は`local/installer_sam_formac.sh`を叩いて指定のバージョンのAWS SAM CLIをインストールする。
   1. Linux, WSLの人で既に古いバージョンが入ってる人は`local/installer_sam_forlinux.sh --update`
2. `cp .env.example .env`を叩いて.env作成し、必要に応じて内容を編集する。
3. `./start_local/sh`を叩いて、コンテナとAPIを起動する。

   ```sh
    * Tip: There are .env or .flaskenv files present. Do "pip install python-dotenv" to use them.
    2024-02-24 15:52:25 WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
    * Running on http://127.0.0.1:3001
    2024-02-24 15:52:25 Press CTRL+C to quit
   ```

   とかが出ればOK
4. ブラウザなり、CURLなりで`http://127.0.0.1:{HTTP_PORT}/`にアクセス
   1. Proxy経由でなければ`http://127.0.0.1:{PROXY_API_PORT}/`にアクセス

## Swagger起動

TODO あとで
