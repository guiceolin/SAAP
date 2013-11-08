module Gcal
  class Calendar < Gcal::BasicObject
    # List of attributes returned from Google Calendar API.
    # see https://developers.google.com/google-apps/calendar/v3/reference/calendars
    attributes %w(id summary description location timeZone)

    attr_accessor :summary, :description, :location, :time_zone
    attr_accessor :id, :client

    def events
      @event_proxy ||= EventProxy.new(id, client)
    end

  end
end
