class Crowd < ActiveRecord::Base
  belongs_to :professor
  belongs_to :subject
  validates :code, :name, :presence => true, uniqueness: { scope: [:subject, :year, :semester] }
  validates :year, :semester, :professor, :subject, :presence => true

end
