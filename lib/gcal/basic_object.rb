require 'gcal/support/attributes'
module Gcal
  class BasicObject
    include Gcal::Support::Attributes

    def initialize(attributes={}, client=nil)
      extract_attributes(attributes)
      self.client = client
    end

    def inspect
      inspection = attributes.map { |name, value| value && "#{name}: #{value.inspect}" }.compact * ', '
      "#< #{self.class}:#{self.object_id} #{inspection} >"
    end

    def persist
      persisted? || insert
    end

    def persisted?
      !!self.id
    end

    private

    def resource_name
      self.class.to_s.demodulize.downcase
    end

    def insert
      self.id = client.update_token.send("insert_#{resource_name}", attributes)
    end

  end
end
