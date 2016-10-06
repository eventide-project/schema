module Schema
  module Validation
    module NilAttributes
      def nil_attributes
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
