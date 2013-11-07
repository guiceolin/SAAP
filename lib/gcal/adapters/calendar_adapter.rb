module Gcal
  module Adapters
    module CalendarAdapter
      include ActiveSupport::Concern

      def clear_calendar(calendar)
        calendar_id = get_id(calendar)
        update_token
        execute(:api_method => service.calendars.clear,
                :parameters => { 'calendarId' => calendar_id })
        true
      end

      def delete_calendar(calendar)
        calendar_id = get_id(calendar)
        update_token
        execute(:api_method => service.calendars.delete,
                       :parameters => {'calendarId' => calendar_id})
        true
      end

      def get_calendar(calendar)
        calendar_id = get_id(calendar)
        update_token
        result = execute(:api_method => service.calendars.get,
                         :parameters => {'calendarId' => calendar_id})
        Calendar.new(HashWithIndifferentAccess.new(result.data.to_hash), self)
      end

      def insert_calendar(attributes)
        update_token
        result = execute(
          api_method:  service.calendars.insert,
          parameters:  {},
          body_object: attributes)
        JSON.parse(result.body)["id"]
      end

      def update_calendar(calendar)
        update_token
        result = client.execute(:api_method => service.calendars.update,
                                :parameters => {'calendarId' => calendar.id},
                                :body_object => calendar.to_hash,
                                :headers => {'Content-Type' => 'application/json'})
        Calendar.new(HashWithIndifferentAccess.new(result.data.to_hash), self)
      end


      private

      def get_id(calendar)
        if calendar.is_a? Gcal::Calendar
          calendar.id
        else
          calendar
        end
      end
    end
  end
end
