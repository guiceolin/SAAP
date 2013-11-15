require 'soft_destroy'
class Crowd < ActiveRecord::Base
  include Importable
  include SoftDestroy

  belongs_to :professor
  belongs_to :subject
  validates :code, :name, :presence => true, uniqueness: { scope: [:subject, :year, :semester] }
  validates :year, :semester, :professor, :subject, :presence => true

  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments
  has_many :topics, class_name: '::Messages::Topic', as: :circle, dependent: :destroy

  has_many :enunciations, dependent: :destroy

  def need_approvation?
    true
  end

  def recipients_with_professor
    students + Array.wrap(professor)
  end

  def to_s
    "#{subject} - #{name}"
  end

  importable do |arry|
    attr = {}
    subject = Subject.where(code: arry.shift).first
    professor = Professor.where(username: arry.shift).first
    raise Importable::InvalidDataException.new unless subject && professor
    attr[:code], attr[:name], attr[:semester], attr[:year], *students = arry
    crowd = Crowd.new(attr)
    crowd.subject = subject
    crowd.professor = professor
    students.each do |username|
      student =  Student.where(username: username).first
      if student
        crowd.students << student
      else
        raise Importable::InvalidDataException.new
      end
    end
    crowd.save
  end
end
