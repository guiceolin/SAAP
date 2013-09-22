class Enunciation < ActiveRecord::Base
  belongs_to :crowd

  validates :end_at, timeliness: { on_or_after: lambda { Date.today } }

end
