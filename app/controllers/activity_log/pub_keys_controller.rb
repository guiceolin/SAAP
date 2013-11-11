class ActivityLog::PubKeysController < ApplicationController

  def index
    authorize! :manage, ActivityLog
    if params[:q]
      @q = ActivityLog.where(action: %w(pub_key_creation pub_key_destruction)).search(params[:q])
      @activities = @q.result(distinct: true)
    else
      @q = ActivityLog.search({})
      @activities = []
    end
  end
end
