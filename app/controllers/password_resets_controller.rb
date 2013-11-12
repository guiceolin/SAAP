class PasswordResetsController < ApplicationController
  skip_before_action :require_authentication
  layout "sessions"

  before_action :verify_token_presence, only: :edit

  def new; end

  def create
    user = User.where(email: params[:email]).first
    if user.blank?
      flash.now[:danger] = t('flash.messages.password_reset.mail_not_found')
      render :new
    else
      user.generate_password_reset_token
      user.save!
      PasswordMailer.reset(user).deliver
      flash[:success] = t('flash.messages.password_reset.mail_sent')
      redirect_to new_session_path
    end
  end

  def edit; end

  def update
    user = User.where(password_reset_token: params[:password_reset_token]).first
    if user.blank?
      flash[:danger] = t('flash.messages.password_reset.invalid_token')
      redirect_to new_session_path
    else
      user.password = params[:password]
      user.password_confirmation = params[:password_confirmation]
      user.password_reset_token = nil
      user.save!
      flash[:success] = t('flash.messages.password_reset.password_changed')
      redirect_to new_session_path
    end
  end

  private

  def verify_token_presence
    unless params[:token]
      flash[:danger] = t('flash.messages.password_reset.invalid_token')
      redirect_to new_session_path
    end
  end

end

