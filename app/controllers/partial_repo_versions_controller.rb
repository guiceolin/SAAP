class PartialRepoVersionsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    PartialRepoVersion.create!(group: @group, creator: current_user)
    redirect_to @group
  end
end
