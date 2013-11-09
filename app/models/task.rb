class Task < ActiveRecord::Base
  belongs_to :group
  belongs_to :parent, class_name: 'Task'
  has_many :children, foreign_key: :parent_id, class_name: 'Task'

  validates :scheduled_start_date, :scheduled_end_date, :description, presence: true

  def start
    if self.start_date.blank?
      self.start_date = Date.today
      self.save!
    end
  end

  def started?
    start_date.present? && !completed?
  end

  def complete
    if self.start_date.present?
      self.end_date = Date.today
      self.save!
    end
  end

  def completed?
    end_date.present?
  end

  def status
    if completed?
      :low
    elsif started?
      :medium
    else
      :high
    end
  end

  def real_start_date
    start_date || scheduled_start_date
  end

  def real_end_date
    end_date || scheduled_end_date
  end

  def to_s
    description
  end

end
