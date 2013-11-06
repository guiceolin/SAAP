require 'active_support/concern'
module Gcal
  module HasGcalendar
    extend ActiveSupport::Concern

    def gcalendar
      @gcalendar ||= Gcal::Calendar.new(name, self, self.gcalendar_id)
    end

    def update_gcalendar_id(id)
      self.gcalendar_id = id
      self.save!
    end
  end
end
