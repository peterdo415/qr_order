# README

## basic認証
### authenticate_or_request_with_http_basic
  * Ruby on RailsでBasic認証を実装するためのメソッド
ブロックを開き、ブロック内部でusernameとpasswordを設定することでBasic認証を利用できる
* Basic認証によるログインの要求は、全てのコントローラで行いたい。そこで、Basic認証の処理をapplication_controller.rbにて、private以下にメソッドとして定義し、before_actionで呼び出すように実装


```
class Admin::BaseController < ApplicationController
  before_action :basic_auth

  private
  # 'admin'というユーザー名と、'password'というパスワードでBasic認証できるように設定
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' && password == 'password'
    end
  end
end
```

## foreman
* foremanは、複数のプロセスをまとめて管理するツール
* アプリの外部にあるProcfileというファイルに設定を書き込むと、WEBアプリの立ち上げに必要なさまざまなプロセスを一気に立ち上げることができる

### Procfile.dev
* foremanで行いたいプロセスを記述
```
# bin/railsサーバーをポート番号3000でipアドレス0.0.0.0で起動させる
web: bin/rails server -p 3000 -b 0.0.0.0
# jsをコンパイルしソースコードの変更を自動で反映
js: yarn build --watch
# cssをコンパイルし、ソースコードの変更を自動で反映
css: yarn build:css --watch
```
* コンパイル
特定のプログラミング言語を用いて記述されたコンピュータープログラムを他の言語 (普通はコンピューターが実行できるバイナリ言語) を用いて記述された同じプログラムに形を変えること

## アセットパイプライン
* アセットパイプラインとは、JavaScriptやCSSのアセットを最小化 (minify: スペースや改行を詰めるなど) または圧縮して連結するためのフレームワークです。
* Railsにおけるモジュールバンドラーのフレームワーク
* モジュールバンドラーとは、JavaScriptモジュール間の依存関係を解決しながら、複数のモジュール（関数やクラス）を束ねる仕組み
* cssやjsを個々のモジュールとして扱うとサーバとクライアント間でのリクエスト・レスポンスが増加してしまう

## package.json
```
# esbuildでapp/javascriptのソースコードをbundleで１つのファイルにまとめてapp/assets/buildsに出力する,public-pathにassetsを設定
"build": "esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds --public-path=assets",
#  app/assets/stylesheets/application.tailwind.css を読み込み、app/assets/builds/application.css を生成して最小化を行う
"build:css": "tailwindcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --minify"
```

## The asset "application.css" is not present in the asset pipeline.について
今回の場合、
bin/dev ではなく bin/rails s になっていた -> foremanが使われてなかった -> Procfile.devに書かれてる処理は実行されない -> つまり yarn build:cssも実行されない -> cssがビルドされない -> application.css も生成されない -> The asset "application.css" is not present in the asset pipeline. のエラーが出た

## 【Rails】'ArgumentError (Missing host to link to! Please provide the :host parameter, set default_url_options[:host], or set :only_path to true):'が出たときの対処法

```
# config/environment/development.rb
 host = 'localhost' #←先ほどの上のコードのhost名と合わせる
 Rails.application.routes.default_url_options[:host] = host
 ```

## ActiveRecord
* Railsが採用している ORM (Object RDB Mapper)
* ModelとDBの間でRuby → SQL に翻訳をしてくれる

基本的にDBにはDB言語としてSQLが使われており、
SQLでないとDBの操作ができないが、RailsにはModelにActiveRecordが適用されているおかげで、Rubyを用いてDBからデータを探したり、持ってきたりすることができる。
(厳密にはModelにApplicationRecordを介してActiveRecordが適用されているため)

## tailwind JIT
* tailwindの3系からのJITモードではhtmlのclassをパースし使用しているクラスのみCSSをコンパイルするためclassに変数を使用するとtailwind側からするとそんなスタイルねえって感じ
* 人間的には alert-<%= message_type %>の変化後の alert-sucess のような完全な文字列をコンパイルしてほしいが、tailwindはalert-<%= message_type %> をまんまコンパイルしようとしているからこのようなことが起きる？

## number_to_currencyメソッド
* 数値を通貨のフォーマットに変換
`number_to_currency(数値, オプション={})`
### :precisionオプション
* 小数以下の桁数
`precision: 0`
### :unitオプション
* 通貨単位
`unit: '¥'`
