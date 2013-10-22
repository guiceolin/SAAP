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

  def edit
    @enunciation = Enunciation.find(params[:id])
    respond_with @enunciation
  end

  def update
    @enunciation = Enunciation.find(params[:id])
    @enunciation.crowd = Crowd.find(params[:crowd_id])
    if @enunciation.update_attributes(enunciation_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  def clone
    @new_enunciation = Enunciation.find(params[:id]).clone_for_crowd(clone_params[:target_id])
    @new_enunciation.crowd = Crowd.find(clone_params[:target_id])
    @new_enunciation.save!
    redirect_to edit_crowd_enunciation_path(@new_enunciation.crowd, @new_enunciation)
  end

  def show
    @enunciation = Enunciation.find(params[:id])
    respond_with @enunciation
  end

  private
  def enunciation_params
    params.require(:enunciation).permit(:name, :description, :end_at, :crowd_id, attachments_attributes: [ :document])
  end

  def clone_params
    params[:clone_enunciation].permit(:origin_id, :target_id)
  end

end
