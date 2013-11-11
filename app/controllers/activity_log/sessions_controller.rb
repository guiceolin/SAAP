class ActivityLog::SessionsController < ApplicationController
  def index
    @q =  ActivityLog.where(action: %w(login logout)).search(params[:q])
    @activities = @q.result(distinct: true)
  end
end
