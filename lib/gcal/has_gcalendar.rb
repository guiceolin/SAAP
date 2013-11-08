require 'active_support/concern'
module Gcal
  module HasGcalendar
    extend ActiveSupport::Concern

    included do
      before_save :update_gcalendar_id
    end

    def gcalendar
      @gcalendar ||= if @gcal_settings.id
        @gcal_settings.client.get_calendar(@gcal_settings.id)
      else
        Gcal::Calendar.new(@gcal_settings.to_hash, @gcal_settings.client)
      end
    end

    def update_gcalendar_id
      write_attribute(@gcal_settings.options[:id_column], @gcalendar.id) if @gcalendar
    end
  end
end
