class SessionsController < ApplicationController
  skip_before_action :require_authentication, only: [:new, :create]
  layout "sessions"

  def new; end

  def create
    user = User.where(email: params[:email])
    if user && user.authenticate(params[:password])
      sign_in user
    else
      render :new
    end
  end
end
