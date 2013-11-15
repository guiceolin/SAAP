class DestroyedCrowdsController < ApplicationController
  def index
    @q = Crowd.soft_destroyed.search(params[:q])
    @crowds = @q.result(distinct: true)
  end
end
