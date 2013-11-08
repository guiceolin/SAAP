class Task < ActiveRecord::Base
  belongs_to :groups
  belongs_to :parent, class_name: 'Task'
  has_many :children, foreign_key: :parent_id, class_name: 'Task'

  validates :scheduled_start_date, :scheduled_end_date, :description, presence: true
end
