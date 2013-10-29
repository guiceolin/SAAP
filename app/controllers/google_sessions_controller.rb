class GoogleSessionsController < ApplicationController
  def create
    current_user.add_oauth_credentials(request.env["omniauth.auth"]['credentials'])
    redirect_to profile_path
  end
end
