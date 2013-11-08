module Gcal
  class EventProxy
    extend Enumerable
    attr_accessor :calendar_id, :client, :events

    delegate :[], :<<, :each, to: :events

    def initialize(calendar_id, client)
      self.calendar_id = calendar_id
      self.client = client
      fetch_events
    end

    def add(attributes_or_event)
      attributes = extract_event_attributes(attributes_or_event)
      self.client.insert_event(self.calendar_id, attributes)
    end

    def inspect
      events.map(&:inspect).inspect
    end

    private

    def extract_event_attributes(attributes_or_event)
      if attributes_or_event.is_a? Gcal::Event
        attributes_or_event.attributes
      else
        Gcal::Event.new(attributes_or_event).attributes
      end
    end

    def fetch_events
      self.events = if calendar_id
        self.client.list_events(calendar_id)
      else
        []
      end
    end
  end
end
