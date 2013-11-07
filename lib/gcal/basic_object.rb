module Gcal
  class BasicObject

    def self.attributes(*attributes)
      @attributes = Array.wrap(attributes.flatten)
    end

    def initialize(attributes={}, client=nil)
      extract_attributes(attributes)
      self.client = client
    end

    def inspect
      inspection = attributes.map { |name, value| value && "#{name}: #{value.inspect}" }.compact * ', '
      "#< #{self.class}:#{self.object_id} #{inspection} >"
    end

    private

    def self.get_attributes
      @attributes
    end

    def attributes
      self.class.get_attributes.inject(Hash.new) do |attributes, attr_name|
        attributes[attr_name] = send(attr_name.underscore.to_sym)
        attributes
      end
    end

    def extract_attributes(hash)
      self.class.get_attributes.each do |attr_name|
        send("#{attr_name.underscore}=".to_sym, hash[attr_name.underscore.to_sym] )
      end
    end

  end
end
