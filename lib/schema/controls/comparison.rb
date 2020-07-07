module Schema
  module Controls
    module Comparison
      module Different
        def self.example
          entry = Entry.example

          entries = [entry]

          ::Schema::Compare::Comparison.new(entries)
        end

        module Entry
          def self.example
            ::Schema::Compare::Comparison::Entry.new(
              self.control_attr_name,
              self.control_value,
              self.compare_attr_name,
              self.compare_value
            )
          end

          def self.control_attr_name
            Attribute::Name.some_attribute
          end

          def self.control_value
            Attribute::Value.some_attribute
          end

          def self.compare_attr_name
            Attribute::Name.some_attribute
          end

          def self.compare_value
            Attribute::Value::Alternate.example
          end
        end

        module Mapped
          def self.example
            entry = Entry.example

            entries = [entry]

            ::Schema::Compare::Comparison.new(entries)
          end

          module Entry
            def self.example
              ::Schema::Compare::Comparison::Entry.new(
                self.control_attr_name,
                self.control_value,
                self.compare_attr_name,
                self.compare_value
              )
            end

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
          entry = Entry.example

          entries = [entry]

          ::Schema::Compare::Comparison.new(entries)
        end

        module Entry
          def self.example
            ::Schema::Compare::Comparison::Entry.new(
              self.control_attr_name,
              self.control_value,
              self.compare_attr_name,
              self.compare_value
            )
          end

          def self.control_attr_name
            Attribute::Name.some_attribute
          end

          def self.control_value
            Attribute::Value.some_attribute
          end

          def self.compare_attr_name
            Attribute::Name.some_attribute
          end

          def self.compare_value
            Attribute::Value.some_attribute
          end
        end

        module Mapped
          def self.example
            entry = Entry.example

            entries = [entry]

            ::Schema::Compare::Comparison.new(entries)
          end

          module Entry
            def self.example
              ::Schema::Compare::Comparison::Entry.new(
                self.control_attr_name,
                self.control_value,
                self.compare_attr_name,
                self.compare_value
              )
            end

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
              Attribute::Value.some_attribute
            end
          end
        end
      end

      Entry = Same::Entry
    end
  end
end
