class PasswordResetsController < ApplicationController
  skip_before_action :require_authentication
  layout "sessions"

  before_action :verify_token_presence, only: :edit

  def new; end

  def create
    user = User.where(email: params[:email]).first
    if user.blank?
      redirect_to root_path
    else
      user.password_reset_token = SecureRandom.hex(64)
      user.save!
      PasswordMailer.reset(user).deliver
      flash.now[:reset] = 'Instruções foram enviadas para seu email'
      redirect_to new_session_path
    end
  end

  def edit; end

  def create
    user = User.where(password_reset_token: params[:password_reset_token]).first
    if user.blank?
      redirect_to new_session_path
    else
      user.password = params[:password]
      user.password_confirmation = params[:password_confirmation]
      user.password_reset_token = nil
      user.save!
      redirect_to new_session_path
    end
  end

  private

  def verify_token_presence
    redirect_to new_session_path unless params[:token]
  end

end

