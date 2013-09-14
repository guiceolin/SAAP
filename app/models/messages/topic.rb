require 'messages'
module Messages
  class Topic < ActiveRecord::Base
    belongs_to :creator, :polymorphic => true
    belongs_to :circle, :polymorphic => true

    validates :circle, :subject, :creator, :presence => true
    validates :circle_type, :inclusion => { :in => %w(Crowd Group) }
    validates :creator_type, :inclusion => { :in => %w(User) }

    before_save :check_approvation
    before_save :include_professor_when_crowd

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
