module Gcal
  class Calendar
    # List of attributes returned from Google Calendar API.
    # see https://developers.google.com/google-apps/calendar/v3/reference/calendars
    ATTRIBUTES = %w(id summary description location timeZone)

    attr_accessor :summary, :description, :location, :time_zone
    attr_accessor :id, :client

    def initialize(attributes={}, client=nil)
      extract_attributes(attributes)
      self.client = client
    end

    def persist
      persisted? || insert
    end

    def persisted?
      !!self.id
    end

    def events
      @event_proxy ||= EventProxy.new(id, client)
    end

    def inspect
      inspection = attributes.map { |name, value| value && "#{name}: #{value.inspect}" }.compact * ', '
      "#< #{self.class}:#{self.object_id} #{inspection} >"
    end

    private

    def extract_attributes(hash)
      ATTRIBUTES.each do |attr_name|
        send("#{attr_name.underscore}=".to_sym, hash[attr_name.underscore.to_sym] )
      end
    end

    def attributes
      ATTRIBUTES.inject(Hash.new) do |attributes, attr_name|
        attributes[attr_name] = send(attr_name.underscore.to_sym)
        attributes
      end
    end

    def insert
      self.id = client.update_token.insert_calendar(attributes)
    end
  end
end
