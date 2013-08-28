class SessionsController < ApplicationController
  skip_before_action :require_authentication, only: [:new, :create]
  layout "sessions"

  def new; end

  def create
    user = User.where(email: params[:username]).first
    if user && user.authenticate(params[:password])
      sign_in user
    else
      flash.now[:login] = I18n.t('flash.login.failed')
      render :new
    end
  end

  def destroy
    sign_out current_user
  end
end