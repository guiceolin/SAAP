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

    def inspect
      events.map(&:inspect).inspect
    end

    private

    def fetch_events
      self.events = if calendar_id
        self.client.list_events(calendar_id)
      else
        []
      end
    end
  end
end
