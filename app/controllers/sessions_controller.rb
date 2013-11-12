class SessionsController < ApplicationController
  skip_before_action :require_authentication, only: [:new, :create]
  layout "sessions"

  def new; end

  def create
    user = User.where(username: params[:username]).first
    if user && user.authenticate(params[:password])
      sign_in user
    else
      flash.now[:danger] = I18n.t('flash.messages.login.failed')
      render :new
    end
  end

  def destroy
    sign_out
  end
end
