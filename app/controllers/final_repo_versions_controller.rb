class FinalRepoVersionsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    enunciation = @group.enunciation
    binding.pry
    if enunciation.end_at < Date.today
      if  enunciation.accepts_after_deadline
        LateRepoVersion.create!(group: @group, creator: current_user)
      end
    else
      @group.oldfy_versions
      FinalRepoVersion.create!(group: @group, creator: current_user)
    end
    redirect_to @group
  end
end
