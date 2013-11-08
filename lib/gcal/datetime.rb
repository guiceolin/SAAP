module Gcal
  class DateTime
    attr_reader :datetime

    def initialize(attributes)
      @attributes = attributes
      convert_attributes
    end

    def attributes
      {  type => @datetime.rfc3339 }
    end

    private

    def convert_attributes
      @datetime = if @attributes.is_a? Hash
                    from_hash
                  elsif @attributes.is_a?(Date) || @attributes.is_a?(::DateTime)
                    @attributes
                  elsif  @attributes.is_a?(Time)
                    @attributes.to_datetime
                  else
                    raise 'Invalid Date format!'
                  end
    end

    def from_hash
      if @attributes['date']
        ::Date.parse(@attributes['date'])
      else
        ::DateTime.parse(@attributes['dateTime'])
      end
    end

    private

    def type
      if @attributes.is_a?(::DateTime) || @attributes.is_a?(Time)
        'dateTime'
      else
        'date'
      end
    end
  end
end
