class ActivityLog < ActiveRecord::Base

  serialize :serialized_object

  ACTIONS = %w(
    enunciation_end_change
  )
  belongs_to :user
  belongs_to :item, polymorphic: true
  validates :action, inclusion: { in: ACTIONS}
end
