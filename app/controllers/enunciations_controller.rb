class EnunciationsController < ApplicationController
  respond_to :html, :json

  def new
    @enunciation = Enunciation.new(crowd_id: params[:crowd_id])
    respond_with @enunciation
  end

  def create
    @enunciation = Enunciation.new(enunciation_params)
    @enunciation.crowd = Crowd.find(params[:crowd_id])
    if @enunciation.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def show
    @enunciation = Enunciation.find(params[:id])
    respond_with @enunciation
  end

  private
  def enunciation_params
    params[:enunciation].permit(:name, :description, :end_at, :crowd_id)
  end

end
