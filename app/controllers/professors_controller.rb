class ProfessorsController < ApplicationController
  respond_to :html

  def index
    respond_with(@professors = Professor.all)
  end

  def new
    respond_with(@professor = Professor.new)
  end

  def create
    @professor = Professor.new(params[:professor].permit(:email, :password, :password_confirmation, :name, :username))
    @professor.save
    respond_with(@professor)
  end

end
