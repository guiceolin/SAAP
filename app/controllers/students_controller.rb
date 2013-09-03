class StudentsController < ApplicationController
  respond_to :html

  def index
    @q = Student.search(params[:q])
    respond_with(@students = @q.result(distinct: true))
  end

  def new
    respond_with(@student = Student.new)
  end

  def create
    @student = Student.new(student_params)
    @student.save
    respond_with(@student)
  end

  def edit
    respond_with(@student = Student.find(params[:id]))
  end

  def update
    @student = Student.find(params[:id])
    @student.update_attributes(student_params)
    @student.save
    respond_with(@student)
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    respond_with(@student)
  end

  def import; end

  def upload
    file = params[:upload].require(:file).tempfile
    Student.import file
    redirect_to students_path
  end

  private

  def student_params
    params[:student].permit(:email, :password, :password_confirmation, :name, :username)
  end

end
