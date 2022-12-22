# README

## basic認証
### authenticate_or_request_with_http_basic
  * Ruby on RailsでBasic認証を実装するためのメソッド
ブロックを開き、ブロック内部でusernameとpasswordを設定することでBasic認証を利用できる
* Basic認証によるログインの要求は、全てのコントローラで行いたい。そこで、Basic認証の処理をapplication_controller.rbにて、private以下にメソッドとして定義し、before_actionで呼び出すように実装


```
class ApplicationController < ActionController::Base
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