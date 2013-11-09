class Gtask < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  delegate :gcalendar, :oauth_authenticated?, to: :user
  delegate :description, :real_start_date, :real_end_date, to: :task

  after_create :create_gevent

  def update_gevent
    GcalTaskUpdatedWorker.perform_async(self.id)
  end

  private

  def create_gevent
    GcalTaskCreatedWorker.perform_async(self.id)
  end
end
