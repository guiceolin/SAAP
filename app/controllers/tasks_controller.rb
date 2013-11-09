class TasksController < ApplicationController
  respond_to :html, :js
  before_action :find_group

  def create
    @group.tasks.create!(task_params)
    redirect_to @group
  end

  def start
    @group.tasks.find(params[:id]).start
    redirect_to @group
  end

  def complete
    @group.tasks.find(params[:id]).complete
    redirect_to @group
  end

  private

  def task_params
    params[:task].permit(:scheduled_start_date, :scheduled_end_date, :description)
  end

  def find_group
    @group = Group.find(params[:group_id])
  end

end
