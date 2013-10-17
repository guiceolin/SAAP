class Enunciation < ActiveRecord::Base
  belongs_to :crowd

  validates :end_at, timeliness: { on_or_after: lambda { Date.today } }
  validates :name, :description, presence: true

  has_many :groups

  def to_s
    name
  end

end
