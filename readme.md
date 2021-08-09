# WordPress x Node.js用Docker環境構築

Dockerコンテナのオーケストレーションツール `Docker compose` を利用

- `.env` 内にdocker-compose.ymlの環境変数を定義

ディレクトリ構成は以下の通り

~~~bash
.
├── docker-compose.yml
├── node
│   ├── Dockerfile
│   ├── .dockerignore
│   ├── .gitignore
│   └── ...node_projects
├── .gitignore
├── .env
├── ex.env
├── setup.sh
└── readme.md

~~~

# 説明
- `.env` : **作成する環境毎に変更** 環境変数, `docker-compose up`などのコマンド事項の際に読みに行きます。
- `node/` : `Node.js`ベースのフレームワーク(e.g. `React.js`, `Vue.js`)を使用する際に使います. `node/app`直下にプロジェクトを配置します。
- `Dockerコンテナ`内のパスワードは`node/`の場合`node`, `root`ユーザーは`root`

# 使い方

## `Node.js`プロジェクトの場合

`docker-compose.yml`の`node`コンテナの部分のコメントアウトを外す.

`Node.js`のみ必要な場合は適宜不要なコンテナをコメントアウト

`node/app`以下にプロジェクトを配置
`node/app/package.json` となるような配置を想定しています.

`WordPress`をヘッドレスCMSとして`Node.js`のプロジェクトを立てる場合は
`wp/`以下は特に何もコピーしなくていいですが,
コンテナ内で`wp-setup.sh`を回す事を忘れないようにしてください。

```bash
$ docker-compose up -d
$ docker exec -it wpコンテナ名 bash
```

でコンテナ内にログインして

```bash
$ bash wp-wetup.sh
```

以上