class DashboardsController < ApplicationController
  def show
    @crowds = current_user.crowds
  end
end
