class FinalRepoVersionsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @group.oldfy_versions
    FinalRepoVersion.create!(group: @group, creator: current_user)
    redirect_to @group
  end
end
