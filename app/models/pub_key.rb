class PubKey < ActiveRecord::Base
  validate :name, :value, presence: true, uniqueness: :true
  belongs_to :user
end
