class CrowdsController < ApplicationController
  respond_to :html
  def index
    @q = Crowd.search(params[:q])
    respond_with(@crowds = @q.result(distinct: true))
  end

  def new
    respond_with(@crowd = Crowd.new)
  end

  def create
    @crowd = Crowd.new(crowd_params)
    @crowd.save
    respond_with(@crowd)
  end

  def edit
    respond_with(@crowd = Crowd.find(params[:id]))
  end

  def update
    @crowd = Crowd.find(params[:id])
    @crowd.update_attributes(crowd_params)
    respond_with(@crowd)
  end

  def destroy
    @crowd = Crowd.find(params[:id])
    @crowd.destroy
    respond_with(@crowd)
  end

  private

  def crowd_params
    params[:crowd].permit(:code, :name, :year, :semester, :professor_id, :subject_id)
  end
end
