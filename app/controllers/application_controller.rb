require 'app_responder'
class ApplicationController < ActionController::Base
  include Concerns::Authenticable
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  self.responder = AppResponder

  add_flash_types :login

end
