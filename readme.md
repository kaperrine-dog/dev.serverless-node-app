# WordPress用環境構築ファイルセット
Dockerとそのオーケストレーションツール `Docker compose` を利用

- `.env` 内にdocker-compose.ymlの環境変数を定義

ディレクトリ構成は以下の通り

~~~
.
├── .env
├── .gitignore
├── docker-compose.yml
├── mysql
├── node
│   ├── .dockerignore
│   ├── .gitignore
│   ├── Dockerfile
│   └── app
│       ├── ...
│       ├── ...
├── php
│   ├── .dockerignore
│   ├── Dockerfile
│   ├── config
│   │   └── php.ini
│   ├── src
│   │   └── foobar.com
│   │       └── httpdocs
│   └── wp-setup.sh
├── readme.md
└── wp
    ├── .dockerignore
    ├── Dockerfile
    ├── config
    │   └── php.ini
    ├── gulpfile.babel.js
    ├── package-lock.json
    ├── package.json
    ├── webpack.config.js
    ├── wp-content
    │   ├── themes
    │   └── uploads
    └── wp-setup.sh
~~~

# 使い方
開発プロジェクトルートで

```
$ docker-compose up -d
```

