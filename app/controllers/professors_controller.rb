class ProfessorsController < ApplicationController
  respond_to :html

  def index
    @q = Professor.search(params[:q])
    respond_with(@professors = @q.result(distinct: true))
  end

  def new
    respond_with(@professor = Professor.new)
  end

  def create
    @professor = Professor.new(professor_params)
    @professor.save
    respond_with(@professor)
  end

  def edit
    respond_with(@professor = Professor.find(params[:id]))
  end

  def update
    @professor = Professor.find(params[:id])
    @professor.update_attributes(professor_params)
    @professor.save
    respond_with(@professor)
  end

  def destroy
    @professor = Professor.find(params[:id])
    @professor.destroy
    respond_with(@professor)
  end

  def import; end

  def upload
    file = params[:upload].require(:file).tempfile
    Professor.import file
    redirect_to professors_path
  end

  private

  def professor_params
    params[:professor].permit(:email, :password, :password_confirmation, :name, :username)
  end

end
