require 'gcal/basic_object'
module Gcal
  class Event < Gcal::BasicObject
    # List of attributes returned from Google Calendar API
    # See https://developers.google.com/google-apps/calendar/v3/reference/events
    attributes %w(id calendar_id summary description location start end)

    attr_accessor :summary, :description, :location, :start, :end
    attr_accessor :calendar_id, :id, :client
  end
end
