class GroupsController < ApplicationController
  respond_to :html, :json
  def create
    @group = Group.new(group_params)
    @group.save!
    redirect_to [@group.enunciation.crowd, @group.enunciation]
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      respond_with @group
    else
      render json: { errors: @group.errors.to_json }
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    head :ok
  end

  private
  def group_params
    params.require(:group).permit(:enunciation_id, :name, :student_ids => [])
  end
end
