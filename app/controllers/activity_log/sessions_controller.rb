class ActivityLog::SessionsController < ApplicationController
  def index
    authorize! :show, ActivityLog
    @q =  ActivityLog.where(action: %w(login logout)).search(params[:q])
    @activities = @q.result(distinct: true)
  end
end
