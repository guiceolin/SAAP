class Group < ActiveRecord::Base
  belongs_to :enunciation
  has_many :memberships
  has_many :students, through: :memberships
end
