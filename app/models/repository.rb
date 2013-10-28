class Repository < ActiveRecord::Base
  validate :name, :url, presence: true
  belongs_to :group
  has_many :students, through: :group
end
