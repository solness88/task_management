class ApplicationController < ActionController::Base
  before_action :basic_authenticate

  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_user
    # 現在ログイン中のユーザが存在しない場合、ログインページにリダイレクトさせる。
    if @current_user == nil
      flash[:notice] = t('notice.login_needed')
      redirect_to new_session_path
    end
  end

  private
  def basic_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == 'manyo_test' && password == 'manyo_password'
    end
  end
end
