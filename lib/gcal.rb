require 'active_support/concern'
require 'gcal/client'
require 'gcal/calendar'
require 'gcal/has_gcalendar'
module Gcal
  extend ActiveSupport::Concern

  module ClassMethods
    def has_gcalendar(name=nil)
      @gcalendar_name = name
      self.send :include, Gcal::HasGcalendar
    end
  end
end
