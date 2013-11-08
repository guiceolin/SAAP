require 'gcal/support/attributes'
require 'gcal/support/dirty'
module Gcal
  class BasicObject
    include Gcal::Support::Attributes
    include Gcal::Support::Dirty

    def initialize(attributes={}, client=nil)
      extract_attributes(attributes)
      self.client = client
    end

    def inspect
      inspection = attributes.map { |name, value| value && "#{name}: #{value.inspect}" }.compact * ', '
      "#< #{self.class}:#{self.object_id} #{inspection} >"
    end

    def persist
      if !persisted?
        insert
      elsif changed?
        update
      else
        false
      end
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
      clear_changes
    end

    def update
      new_event = client.update_token.send("update_#{resource_name}", self)
      clear_changes
      new_event
    end

  end
end
