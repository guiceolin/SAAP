module Gcal
  class Event
    # List of attributes returned from Google Calendar API
    # See https://developers.google.com/google-apps/calendar/v3/reference/events
    ATTRIBUTES = %w(id summary description location start end)

    attr_accessor :summary, :description, :location, :start, :end
    attr_accessor :id, :client

    def initialize(attributes={}, client=nil)
      extract_attributes(attributes)
      self.client = client
    end

    def inspect
      inspection = attributes.map { |name, value| value && "#{name}: #{value.inspect}" }.compact * ', '
      "#< #{self.class}:#{self.object_id} #{inspection} >"
    end

    private

    def attributes
      ATTRIBUTES.inject(Hash.new) do |attributes, attr_name|
        attributes[attr_name] = send(attr_name.underscore.to_sym)
        attributes
      end
    end

    def extract_attributes(hash)
      ATTRIBUTES.each do |attr_name|
        send("#{attr_name.underscore}=".to_sym, hash[attr_name.underscore.to_sym] )
      end
    end

  end
end
