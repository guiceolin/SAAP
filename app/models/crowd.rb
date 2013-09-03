class Crowd < ActiveRecord::Base
  include Importable
  belongs_to :professor
  belongs_to :subject
  validates :code, :name, :presence => true, uniqueness: { scope: [:subject, :year, :semester] }
  validates :year, :semester, :professor, :subject, :presence => true

  has_many :enrollments
  has_many :students, through: :enrollments

end
