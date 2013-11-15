require 'messages'
module Messages
  class Message < ActiveRecord::Base
    require 'soft_destroy'
    include SoftDestroy

    attr_accessor :readed

    belongs_to :topic, touch: true
    has_one :circle, through: :topic
    belongs_to :sender, class_name: 'User'
    has_many :deliveries, class_name: '::Messages::Delivery', dependent: :destroy
    has_many :recipients, class_name: 'User', through: :deliveries

    validates :body, :sender, :topic, :presence => true

    after_save :create_deliveries

    private

    def create_deliveries
      self.recipients = topic.recipients
      self.deliveries.update_all(readed: true) if readed
    end
  end
end
