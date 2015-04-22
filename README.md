# docker-wordpress

WordPressのテーマ開発をするためのテンプレートです。  
dockerを使用し、WordPressの設定、テーマ、データベースの状態をgitで管理できるようになっています。

- [DockerでWordPressサイトを開発してみよう](http://www.slideshare.net/mookjp/dockerword-press)
- [tutum-docker-wordpress](https://github.com/tutumcloud/tutum-docker-wordpress)
- [docker](https://www.docker.com/)

## dockerの初期セットアップ

[VirtualBox](https://www.virtualbox.org/)とboot2dockerを使用します（dockerも一緒に入ります）

```
$ brew install boot2docker
$ boot2docker init
$ boot2docker start

// 下記を指示通りに.bash_profileなどに追加（mgaoshimaは読みかえて下さい）
// $ export DOCKER_HOST=tcp://192.168.59.103:2376
// $ export DOCKER_CERT_PATH=/Users/mgaoshima/.boot2docker/certs/boot2docker-vm
// $ export DOCKER_TLS_VERIFY=1
```

## WordPressコンテナのビルドと立ち上げ

`yoursitename`は適宜置き換えて下さい

```
$ git clone git@github.com:mgaoshima/docker-wordpress.git yoursitename
$ cd yoursitename
$ chmod +x docker_*.sh
```

プロジェクトのリポジトリを新たに作成して下さい。

```
$ rm -rf .git
```

[`hub`](https://github.com/github/hub)が入っている場合は
```
$ git init && git add -A . && git commit -m init
$ git create
$ git push -u origin master
```

WordPressコンテナをビルドして実行します。

```
$ ./docker_build.sh
```

終了したら下記を実行するとWordPressの初期設定画面が立ち上がります  
※サーバとMySQLが立ち上がるまで少し時間がかかる場合があります

```
$ open -a Google\ Chrome "http://$(boot2docker ip)"
```

テーマ開発中は基本的に立ち上げっぱなしで大丈夫です。  
`git pull`した際は変更を反映するために、再度`./docker_build.sh`を実行して下さい。

`./docker_build.sh`を実行すると、それまでの変更を破棄してコンテナを再構築するので、
DBの変更を保持する場合は予め`./docker_mysqldump.sh`を実行して下さい。

- 開発が終わったら`./docker_stop.sh`でWordPressコンテナを停止させます。
- 開発を再開する場合は`./docker_start.sh`でWordPressコンテナを再開させます。
- コンテナを完全に破棄する場合は`./docker_destroy.sh`で完全に破棄します。

## 変更内容をコミットする

Gitに登録するファイルは

- `mysql.dump.sql` ... DBのダンプファイル
- `wp-config.php` ... WordPressの初期設定ファイル
- `wp-content` ... WordPressのテーマやアップロードした画像、プラグインなど

の3つです。  

```
$ ./docker-mysqldump.sh
$ git add mysql.dump.sql wp-config.php wp-content
$ git commit
```
