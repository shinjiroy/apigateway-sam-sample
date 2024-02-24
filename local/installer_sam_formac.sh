#!/bin/bash

# MacでAWS SAM CLI入れるマン
# Homebrewはサポートされてないようなので使わない

set -e

# AWS SAM CLIのバージョンを指定
# 常に最新にしておくべし https://github.com/aws/aws-sam-cli/releases
VERSION="1.108.0"

# MacはCPUアーキテクチャが異なり得る
CPU_ARCH=x86_64
if [[ $(uname -m) != "x86_64" ]]; then
    CPU_ARCH=arm64
fi

# ユーザーに確認を求める
read -p "AWS SAM CLI バージョン${VERSION}をインストールorアップデートします。実行してよろしいですか？ (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# ダウンロードと解凍
curl -L https://github.com/aws/aws-sam-cli/releases/download/v$VERSION/aws-sam-cli-macos-$CPU_ARCH.pkg -o aws-sam-cli.pkg

# インストール
sudo installer -pkg aws-sam-cli.pkg -target /

# 不要なファイルを削除
rm aws-sam-cli.pkg
