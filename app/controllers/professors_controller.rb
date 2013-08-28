class ProfessorsController < ApplicationController
  respond_to :html

  def new
    respond_with(@professor = Professor.new)
  end

  def create
    @professor = Professor.new(params[:professor].permit(:email, :password, :password_confirmation))
    @professor.save
    respond_with(@professor)
  end

end
