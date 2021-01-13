class ApplicationController < ActionController::Base
  before_action :basic_authenticate

  private

  def basic_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == 'manyo_test' && password == 'manyo_password'
    end
  end
end
