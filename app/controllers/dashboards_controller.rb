class DashboardsController < ApplicationController
  def show
    if current_user.is_a? Professor
      render_professor
    else
      render_student
    end
  end

  private

  def render_professor
    @crowds = current_user.crowds
    render :professor
  end

  def render_student
    @crowds_with_groups = current_user.groups.group_by(&:crowd)
    render :student
  end
end
