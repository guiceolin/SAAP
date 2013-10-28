class Group < ActiveRecord::Base
  belongs_to :enunciation
  has_many :memberships
  has_many :students, through: :memberships
  has_many :topics, class_name: 'Messages::Topic', as: :circle
  has_one :repository

  delegate :subject, :crowd, :professor, to: :enunciation

  def need_approvation?
    false
  end

  def recipients
    students
  end

  def recipients_with_professor
    students + Array.wrap(professor)
  end

  def to_s
    "#{crowd} - #{enunciation} - #{name}"
  end
end
