require 'active_support/concern'
require 'gcal/client'
require 'gcal/calendar'
require 'gcal/has_gcalendar'
require 'gcal/event_proxy'
require 'gcal/settings'

module Gcal
  extend ActiveSupport::Concern

  module ClassMethods
    def has_gcalendar(options= {})
      self.send :include, Gcal::HasGcalendar
      initialize_settins_callback(options)
    end

    private

    def initialize_settins_callback(options)
      self.send :after_initialize do
        @gcal_settings = Settings.new(self, options)
      end
    end
  end
end
