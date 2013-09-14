require 'messages'
module Messages
  class Message < ActiveRecord::Base
    belongs_to :topic
    has_one :circle, through: :topic
    belongs_to :sender, class_name: 'User'
    has_many :deliveries

    validates :body, :sender, :topic, :presence => true
  end
end
