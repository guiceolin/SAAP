require 'gcal/event'
module Gcal
  module Adapters
    module EventsAdapter
      include ActiveSupport::Concern

      def list_events(calendar_id, page_hash=nil)
        result = self.execute(
          api_method: service.events.list,
          parameters: { 'calendarId' => calendar_id}
        )
        result.data.items.inject([]) do |memo, event|
          event_hash = event.to_hash.merge!(calendar_id: calendar_id).symbolize_keys
          memo << Gcal::Event.new(event_hash, self)
        end
      end

      def insert_event(calendar_id, attributes)
        result = execute(:api_method => service.events.insert,
                                :parameters => {'calendarId' => calendar_id},
                                :body => JSON.dump(attributes),
                                :headers => {'Content-Type' => 'application/json'})
        event_hash = result.data.to_hash.merge!(calendar_id: calendar_id).symbolize_keys
        Gcal::Event.new(event_hash, self)

      end
    end
  end
end
