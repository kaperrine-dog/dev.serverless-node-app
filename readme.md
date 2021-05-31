# WordPress用環境構築ファイルセット
Dockerコンテナのオーケストレーションツール `Docker compose` を利用

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
# 説明
- `php/` : `WordPress`や`PHP`のみで動く環境の場合に使用するボリューム`php/src/`で`git clone`を行う
- `wp/` : `WordPress`をバックエンドCMSに用いたHeadlessCMS用ボリューム何も置かなくていい
- `mysql/` : データベースの設定ファイルなどを入れるボリューム
- `mysql/db_data/` : データベースの永続化のためのデータ格納用ボリューム
- `.env` : **状況に応じて適宜変更のこと** 環境変数, `docker-compose up`などのコマンド事項の際に読みに行きます。
- `node/` : `Node.js`ベースのフレームワーク(`React.js`, `Vue.js`等)を使用する際に使います. `node/app`にプロジェクトを配置します。

- `Dockerコンテナ`内のパスワードは`node/`の場合`node`のような感じ. `root`ユーザーは`root`
- `php/`と`wp/`の方は常にコンテナ内に`root`で入るようになっていたと思います.


# 使い方
## `Node.js`を使わない`WordPress`プロジェクトの場合,
プロジェクトディレクトリを予め`dev.new-project.com`と作成しておき, 
`dev.wp-docker/*`を`$ cp dev.wp-docker/* dev.new-project.com`などしてコピーする.

その後`php/src`に移動し,
```
$ cd php/src
```
目的のプロジェクトを`git clone`
```
$ git clone git@v133-130-69-92.myvps.jp:$GITUSERNAME/new-project.com.git
```
そうすると
`dev.new-project.com/php/src/new-project.com/httpdocs/...`

となる

`wp-config.php`ファイルは
`dev.new-project.com/php/src/new-project.com/httpdocs/cms/wp-config.php`に配置し, `docker`内のDB情報と合わせる.

`phpMyAdmin`に入って
`wordpress`のDBでSQLのDBインポート.

データベースの環境変数として以下に設定してあるので
```:docker-compose.yml
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
```
これに合うように`wp-config.php`を書き換えてください.


`docker-compose.yml`のあるディレクトリ(開発プロジェクトルート)に戻って
(ここでは`dev.new-project.com`)
```
$ docker-compose up -d
```
を行う

```
$ docker exec -it コンテナ名 bash
```
でコンテナ内にSSHでログイン.
コンテナ名は`docker-compose.yml`のあるディレクトリの`.env`に書くようにしています.

`WordPress`の場合は, 初回のみ,
コンテナにログインした後
```
$ bash wp-setup.sh
```
を回してください.
`wp-cli`で自動で`WordPress`環境を構築してくれます.


## `Node.js`プロジェクトの場合

`docker-compose.yml`の`node`コンテナの部分のコメントアウトを外す.

`Node.js`のみ必要な場合は適宜不要なコンテナをコメントアウト

`node/app`以下にプロジェクトを配置
`node/app/package.json` となるような配置を想定しています.

`WordPress`をヘッドレスCMSとして`Node.js`のプロジェクトを立てる場合は
`wp/`以下は特に何もコピーしなくていいですが,
コンテナ内で`wp-setup.sh`を回すのを忘れないようにしてください。

```
$ docker-compose up -d
$ docker exec -it wpコンテナ名 bash
```
でコンテナ内にログインして

```
$ bash wp-wetup.sh
```





以上.