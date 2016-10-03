module Schema
  module Validation
    module HasAllAttributes
      def has_all_attributes
        Validator
      end

      module Validator
        def self.call(schema, errors=nil)
          errors ||= []
          schema.class.attribute_names.each do |attribute|
            if schema.public_send(attribute).nil?
              errors << "#{attribute} is missing"
            end
          end
          errors.empty?
        end
      end
    end
  end
end
