class Professor < User
  has_many :crowds, -> { where(deleted_at: nil)}, dependent: :restrict_with_error
  has_many :enunciations, through: :crowds
  has_many :groups, through: :enunciations

  def need_approvation?
    false
  end

  def circles
    crowds.to_a + groups.to_a
  end

  def approved_topics
    super.select(&:include_professor)
  end

  # DEMETER LAW!!!!
  def groups_topics
    topics.select { |t| t.circle_type == "Group" }.select { |t| !t.include_professor }
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
