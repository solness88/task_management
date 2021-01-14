## usersモデル
|データ型|カラム名|
|---|---|
|string|name|
|string|email|
|string|password_digest|
|text|image|

## taskモデル
|データ型|カラム名|
|---|---|
|bigint|user_id|
|string|task_name|
|text|detail|
|string|deadline|
|string|status|
|string|priority|


## labelモデル
|データ型|カラム名|
|---|---|
|string|label_name|

## Herokuへのデプロイ手順
* rails assets:precompile RAILS_ENV=productionでアセットプリコンパイル(一度だけ実施)
* git add -A, その後 git commit -m "" でコミット（その都度実施)
* heroku create で新しいアプリケーションを作成(一度だけ実施)
* heroku buildpacks:set heroku/ruby, heroku buildpacks:add --index 1 heroku/nodejs でHeroku buildpack を追加(一度だけ実施)
* heroku run rails db:migrate でマイグレーションを実施（その都度実施)
* git push heroku master でHerokuにデプロイ（その都度実施)
