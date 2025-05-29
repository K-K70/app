#! /bin/bash

app_name=$1
if [ -z $app_name ]; then
    echo 'Please set app name'
    echo '$ ./build.sh XXXX'
    exit -1
fi
export APP_NAME=${app_name}
rm -rf ./.env
if [ ! -d ./${app_name} ]; then
    echo "Please run:$ ./build.sh ${APP_NAME}"
    exit 0
fi

cp ./${app_name}/.env ./.env

# イメージビルド時にca-certificatesがインストール済みでなければ、以下のDockerfile修正を優先してください。
# ここでは念のためキャッシュをクリアしてビルド
docker compose build --no-cache

docker compose up --build

rm -rf ./.env
