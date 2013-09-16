require 'messages'
module Messages
  class Topic < ActiveRecord::Base
    belongs_to :creator, :polymorphic => true
    belongs_to :circle, :polymorphic => true
    has_many :messages

    validates :circle, :subject, :creator, :presence => true
    validates :circle_type, :inclusion => { :in => %w(Crowd Group) }
    validates :creator_type, :inclusion => { :in => %w(User) }

    before_save :check_approvation
    before_save :include_professor_when_crowd

    accepts_nested_attributes_for :messages

    def recipients
      if include_professor
        circle.recipients_with_professor
      else
        circle.recipients
      end
    end

    private

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
