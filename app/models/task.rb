class Task < ActiveRecord::Base
  require 'soft_destroy'
  include SoftDestroy
  belongs_to :group
  belongs_to :parent, class_name: 'Task'
  has_many :children, foreign_key: :parent_id, class_name: 'Task', dependent: :destroy
  has_many :gtasks, dependent: :destroy

  validates :scheduled_start_date, :scheduled_end_date, :description, presence: true

  after_create :create_gtasks
  after_update :update_gtasks

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

  private

  def create_gtasks
    group.students.each do |student|
      Gtask.create!(user: student, task: self)
    end
  end

  def update_gtasks
    gtasks.map(&:update_gevent)
  end

end
