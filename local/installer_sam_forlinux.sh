#!/bin/bash

# LinuxでAWS SAM CLI入れるマン

set -e

# AWS SAM CLIのバージョンを指定
# 常に最新にしておくべし https://github.com/aws/aws-sam-cli/releases
VERSION="1.108.0"

if [ "$1" == "--update" ]; then
    echo "バージョン${VERSION}にアップデートします。"
else
    echo "バージョン${VERSION}をインストールします。"
fi

read -p "実行してよろしいですか？ (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# ダウンロードと解凍
wget https://github.com/aws/aws-sam-cli/releases/download/v$VERSION/aws-sam-cli-linux-x86_64.zip
unzip aws-sam-cli-linux-x86_64.zip -d sam-installation

if [ "$1" == "--update" ]; then
    # アップデート
    sudo ./sam-installation/install --update
else
    # インストール
    sudo ./sam-installation/install
fi

# 不要なファイルとディレクトリを削除
rm ./aws-sam-cli-linux-x86_64.zip
rm -r ./sam-installation
