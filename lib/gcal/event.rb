require 'gcal/basic_object'
require 'gcal/datetime'
module Gcal
  class Event < Gcal::BasicObject
    # List of attributes returned from Google Calendar API
    # See https://developers.google.com/google-apps/calendar/v3/reference/events
    attributes %w(id calendar_id summary description location start end)

    attr_accessor :summary, :description, :location, :start, :end
    attr_accessor :calendar_id, :id, :client

    def extract_attributes(hash)
      hash[:start] = Gcal::DateTime.new(hash[:start])
      hash[:end] = Gcal::DateTime.new(hash[:end])
      super
    end

    def attributes
      hash = super
      hash['start'] = hash['start'].attributes
      hash['end'] = hash['end'].attributes
      hash
    end
  end
end
