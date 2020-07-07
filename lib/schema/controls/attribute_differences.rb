module Schema
  module Controls
    module AttributeDifferences
      def self.example
        differences = ::Schema::Compare::Difference::Attributes.new

        differences.add(
          Entry::Different.attr_name,
          Entry::Different.control_value,
          Entry::Different.attr_name,
          Entry::Different.compare_value
        )

        differences
      end

      module Entry
        module Different
          def self.attr_name
            Attribute::Name.some_attribute
          end

          def self.control_value
            Attribute::Value.some_attribute
          end

          def self.compare_value
            Attribute::Value::Alternate.example
          end
        end
      end

      module Mapped
        def self.example
          differences = ::Schema::Compare::Difference::Attributes.new

          differences.add(
            Entry::Different.control_attr_name,
            Entry::Different.control_value,
            Entry::Different.compare_attr_name,
            Entry::Different.compare_value
          )

          differences
        end

        module Entry
          module Different
            def self.control_attr_name
              Attribute::Name.some_attribute
            end

            def self.control_value
              Attribute::Value.some_attribute
            end

            def self.compare_attr_name
              Attribute::Name.some_other_attribute
            end

            def self.compare_value
              Attribute::Value.some_other_attribute
            end
          end
        end
      end
    end
  end
end
