class SubjectsController < ApplicationController
  respond_to :html

  def index
    @q =  Subject.search(params[:q])
    respond_with(@subjects = @q.result(distinct: true))
  end

  def new
    respond_with(@subject = Subject.new)
  end

  def create
    @subject = Subject.new(subject_params)
    @subject.save
    respond_with(@subject)
  end

  def edit
    respond_with(@subject = Subject.find(params[:id]))
  end

  def update
    @subject = Subject.find(params[:id])
    @subject.update_attributes(subject_params)
    @subject.save
    respond_with(@subject)
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    respond_with(@subject)
  end

  private

  def subject_params
    params[:subject].permit(:name, :code, :description)
  end

end
