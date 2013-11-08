module Gcal
  module Support
    module Dirty
      extend ActiveSupport::Concern

      def changes
        @changes ||= {}
      end

      def changed?
        @changes.keys.any?
      end

      def add_change(attribute, old, new)
        @changes ||= {}
        @changes[attribute] ||= {}
        @changes[attribute][:old] ||= old
        @changes[attribute][:new] =  new
      end

      def clear_changes
        @changes = {}
      end

    end
  end
end
