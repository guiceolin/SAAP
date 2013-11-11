class ActivityLog::EnunciationsController < ApplicationController

  def index
    authorize! :manage, ActivityLog
    if params[:q]
      @q = ActivityLog.where(action: 'enunciation_end_change').search(params[:q])
      @activities = @q.result(distinct: true)
    else
      @q = ActivityLog.search({})
      @activities = []
    end
  end
end
