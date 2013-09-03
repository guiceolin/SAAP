class ProfilesController < ApplicationController
  respond_to :html
  def edit
    respond_with(@user = current_user)
  end

  def update
    @user = current_user
    @user.update_attributes(params[:user].permit(:name, :email, :password, :password_confirmation))
    if @user.valid?
      redirect_to profile_path
    else
      render :edit
    end
  end

  def show
    respond_with(@user = current_user)
  end
end
