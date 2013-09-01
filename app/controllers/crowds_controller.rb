class CrowdsController < ApplicationController
  respond_to :html
  def index
    @q = Crowd.search(params[:q])
    respond_with(@crowds = @q.result(distinct: true))
  end
end
