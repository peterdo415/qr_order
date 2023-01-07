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
