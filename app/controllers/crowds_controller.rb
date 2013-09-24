class CrowdsController < ApplicationController
  authorize_resource
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

  def show
    respond_with(@crowd = Crowd.find(params[:id]))
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

  def import; end

  def upload
    file = params[:upload].required(:file).tempfile
    Crowd.import file
    redirect_to crowds_path
  end

  private

  def crowd_params
    params[:crowd].permit(:code, :name, :year, :semester, :professor_id, :subject_id)
  end
end
