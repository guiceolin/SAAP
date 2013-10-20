class Enunciation < ActiveRecord::Base
  belongs_to :crowd

  validates :end_at, timeliness: { on_or_after: lambda { Date.today } }
  validates :name, :description, presence: true

  has_many :groups
  has_many :grouped_students, class_name: 'Student', through: :groups, source: :students
  has_many :students, through: :crowd

  def ungrouped_students
    students - grouped_students
  end

  def to_s
    name
  end

end
