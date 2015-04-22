# docker-wordpress

WordPressのテーマ開発をするためのテンプレートです。  
dockerを使用し、WordPressの設定、テーマ、データベースの状態をgitで管理できるようになっています。

- [DockerでWordPressサイトを開発してみよう](http://www.slideshare.net/mookjp/dockerword-press)
- [tutum-docker-wordpress](https://github.com/tutumcloud/tutum-docker-wordpress)
- [docker](https://www.docker.com/)

## dockerの初期セットアップ（boot2dockerを使用します）

```
$ brew install boot2docker
```

## WordPressコンテナのビルドと立ち上げ

`yoursitename`は適宜置き換えて下さい

```
$ git clone git@github.com:mgaoshima/docker-wordpress.git yoursitename
$ cd yoursitename
$ chmod +x *.sh
$ ./docker_build.sh
$ ./docker_start.sh
```

上記が終了したらWordPressが立ち上がります（サーバとMySQLが立ち上がるまで少し時間がかかります）

```
$ open -a Google\ Chrome "http://$(boot2docker ip)"
```

テーマ開発中は基本的に立ち上げっぱなしで大丈夫です。  
`git pull`した際は変更を反映するために、
再度`./docker_build.sh && ./docker_start.sh`を実行して下さい。

`./docker_build.sh`を実行すると、それまでの変更を破棄してコンテナを再構築するので、
DBの変更を保持する場合は予め`./docker_mysqldump.sh`を実行して下さい。

開発が終わったら`./docker_stop.sh`でWordPressコンテナを停止させます。

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

## WordPressコンテナを停止する

```
$ ./docker_stop.sh
```

## WordPressコンテナを破棄する

WordPressコンテナを停止し、ビルドしたイメージを破棄します。  
**それまでの変更内容が破棄されます**

```
$ ./docker_destroy.sh
```