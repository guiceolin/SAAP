require 'gcal/support/dirty'
module Gcal
  module Support
    module Attributes
      extend ActiveSupport::Concern
      include Gcal::Support::Dirty

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
        clear_changes
      end


      module ClassMethods

        def attributes(*attributes)
          @attributes = Array.wrap(attributes.flatten)
          define_accessors
        end

        def get_attributes
          @attributes
        end

        private

        def define_accessors
          @attributes.each do |attribute|
            attribute = attribute.underscore
            define_method attribute do
              instance_variable_get("@#{attribute}")
            end

            define_method "#{attribute}=" do |value|
              add_change(attribute, instance_variable_get("@#{attribute}"), value)
              instance_variable_set("@#{attribute}", value)
            end
          end
        end

      end
    end
  end
end
