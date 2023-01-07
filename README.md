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

## form内のbutton要素が全てsubmitされる
* button の type 属性の初期値が 'type="submit"'
* 'type='button'`で明示的に表記すると安全


## stimulusのコントローラ
### data-controller
* HTMLにコントローラーを割り当てている
### data-action
* ボタンがクリックされたら、~~コントローラーの ~~~メソッドを呼びますよ、という指定
`<button data-action="click->order-count#minus" class="btn btn-sm">-</button>`
クリックされたら、order_countのminusメソッドを呼ぶ
### data-target
* DOMへの参照を得ることができる
* JSの中から要素を簡単に呼び出せるようにしている
* これによって、JSで必要になる要素をいちいち探してくる必要がなくなる

## コードについて
### <%= hidden_field_tag "orders[#{index}][drink_id]", drink.id %>
* drink.id を orders の配列の要素として値を設定

### <%= hidden_field_tag "orders[#{index}][count]", 0, 'data-order-count-target': 'count' %>
* data-order-count-target 属性を指定して、0 を orders の配列の要素として値を設定

### ページのbuttonタグが全てsubmitするようになった
* button の type 属性の初期値が type="submit"
https://zenn.dev/phi/articles/form-submit-button-type-default#submit-%E3%81%99%E3%82%8B%E3%83%9C%E3%82%BF%E3%83%B3

## formオブジェクト
* モデルとフォームの責務を切り分けられる事で、単体のモデルに依存しない場合や、フォーム専用の特別な処理をモデルに書きたくない場合に用いたりする
* 1つのフォームで複数モデルの操作をしたいときにForm Objectを使うと、処理がすっきりかける。またログインに関する処理など、特定のフォームでしか行わない処理もForm Objectに書くと良い

今回は
1. drinksからorder_unitsに注文を入れていく
2. order_unitsからordersに情報が入り、お会計が完了する

これより、1つのフォームで複数のモデルの操作をしている？のでformオブジェクトを使う理由になるのかなと思いました。またお店のHPにこの注文フォームを組み込むとしたら、このフォームは特定でしか行わない処理だと思うのでこれも当てはまりそうな気がしました。

## ApplicationRecordの継承の有無
* application_record.rbを継承する

### primary_abstract_classメソッド
* `ActiveRecord::Base`を継承するクラスを指定するため？

つまりActiveRecord::Baseを継承していないため、モデルとテーブルをつなぎ合わせることでRailsからテーブルのレコードにアクセスできるようにする役割があるActiveRecordを扱えない

## テーブルがないモデルの書き方
```
# 通常のモデルのようにvalidationなどを使えるようにする
include ActiveModel::Model
# ActiveRecordのカラムのような属性を加えられるようにする
include ActiveModel::Attributes
```

### まとめ
* テーブルがないモデルはformオブジェクトというテクニック
* モデルの振る舞いをさせるため2行ほどincludeでの記述が必要
* ActiveRecordを扱えない
* 1つのフォームで複数モデルの操作をしたいとき
* 大きなアプリではmodelsディレクトリの肥大化を少し抑えれる？
* formオブジェクト内にメソッドを定義できるのでモデル自体の肥大化も抑えられる？

## positive?メソッド
self が 0 より大きい場合に true を返す。そうでない場合に false を返す