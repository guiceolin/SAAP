class Student < User

  has_many :enrollments, -> { where(deleted_at: nil) }, dependent: :destroy
  has_many :crowds, through: :enrollments
  has_many :memberships, -> { where(deleted_at: nil) }, dependent: :destroy
  has_many :groups, through: :memberships
  has_many :repositories, through: :groups

  def need_approvation?
    true
  end

  def circles
    crowds.to_a + groups.to_a
  end

  importable do |arry|
    raise Importable::InvalidFormatException if arry.size != 4
    attr = {}
    attr[:username], attr[:name], attr[:email], password = arry
    student = Student.new(attr)
    student.password = password
    student.password_confirmation = password
    student.save
  end
end
