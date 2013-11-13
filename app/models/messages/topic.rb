require 'messages'
module Messages
  class Topic < ActiveRecord::Base
    belongs_to :creator, :polymorphic => true
    belongs_to :circle, :polymorphic => true
    has_many :messages, dependent: :destroy

    validates :circle, :subject, :creator, :presence => true
    validates :circle_type, :inclusion => { :in => %w(Crowd Group) }
    validates :creator_type, :inclusion => { :in => %w(User) }

    before_create :check_approvation
    before_save :include_professor_when_crowd
    after_save :create_welcome_message

    accepts_nested_attributes_for :messages

    def recipients
      if include_professor
        circle.recipients_with_professor
      else
        circle.recipients
      end
    end

    def readed_messages_for(user)
      messages.includes(:deliveries).where('messages_deliveries.recipient_id = ? && messages_deliveries.readed = true', user.id)
    end

    private

    def create_welcome_message
      if self.approved && self.messages.none?
        messages << Messages::Message.create(sender: self.creator, body: I18n.t('messages.welcome_message'), readed: true)
      end
    end

    def check_approvation
      if creator.need_approvation? && circle.need_approvation?
        self.approved = false
      end
      true
    end

    def include_professor_when_crowd
      if circle_type == 'Crowd'
        self.include_professor = true
      end
      true
    end

  end
end
