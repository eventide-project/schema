module Schema
  module Controls
    module Comparison
      module Different
        def self.example
          comparison = ::Schema::Compare::Comparison.new

          comparison.add(
            Entry.attr_name,
            Entry.control_value,
            Entry.attr_name,
            Entry.compare_value
          )

          comparison
        end

        module Entry
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

        module Mapped
          def self.example
            comparison = ::Schema::Compare::Comparison.new

            comparison.add(
              Entry.control_attr_name,
              Entry.control_value,
              Entry.compare_attr_name,
              Entry.compare_value
            )

            comparison
          end

          module Entry
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

      module Same
        def self.example
          comparison = ::Schema::Compare::Comparison.new

          comparison.add(
            Entry.attr_name,
            Entry.value,
            Entry.attr_name,
            Entry.value
          )

          comparison
        end

        module Entry
          def self.attr_name
            Attribute::Name.some_attribute
          end

          def self.value
            Attribute::Value.some_attribute
          end
        end

        module Mapped
          def self.example
            comparison = ::Schema::Compare::Comparison.new

            comparison.add(
              Entry.control_attr_name,
              Entry.value,
              Entry.compare_attr_name,
              Entry.value,
            )

            comparison
          end

          module Entry
            def self.control_attr_name
              Attribute::Name.some_attribute
            end

            def self.value
              Attribute::Value.some_attribute
            end

            def self.compare_attr_name
              Attribute::Name.some_other_attribute
            end
          end
        end
      end
    end
  end
end
