class Professor < User
  has_many :crowds, dependent: :restrict_with_error

  def need_approvation?
    false
  end

  def circles
    crowds.to_a
  end

  importable do |arry|
    raise Importable::InvalidFormatException if arry.size != 4
    attr = {}
    attr[:username], attr[:name], attr[:email], password = arry
    professor = Professor.new(attr)
    professor.password = password
    professor.password_confirmation = password
    professor.save
  end
end
