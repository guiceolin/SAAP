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
          memo << Event.from_google_api(event)
        end
      end
    end
  end
end
