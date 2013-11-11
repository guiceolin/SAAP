class ActivityLog::SessionsController < ApplicationController
  def index
    authorize! :show, ActivityLog
    if params[:q]
      @q =  ActivityLog.where(action: %w(login logout)).search(params[:q])
      @activities = @q.result(distinct: true)
    else
      @q = ActivityLog.search({})
      @activities = []
    end
  end
end
