class SubtasksController < TasksController
  def create
    task = @group.tasks.find(params[:task_id]).children.build(task_params)
    task.group = @group
    task.save!
    redirect_to @group
  end

end
