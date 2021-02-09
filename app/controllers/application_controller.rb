class ApplicationController < ActionController::Base
  before_action :basic_authenticate
  before_action :authenticate_user, only: [:index]

  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def basic_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == 'manyo_test' && password == 'manyo_password'
    end
  end

  def authenticate_user
    unless logged_in?
      flash[:notice] = t('notice.login_needed')
      redirect_to new_session_path
    end
  end
end
