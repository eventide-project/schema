module Schema
  module Controls
    module Comparison
      module Different
        def self.example
          ::Schema::Compare::Comparison.new(control_class, compare_class, entries)
        end

        def self.control_class
          Classes.control_class
        end

        def self.compare_class
          Classes.compare_class
        end

        def self.entries
          Attributes.entries
        end

        module Classes
          def self.example
            ::Schema::Compare::Comparison.new(control_class, compare_class, entries)
          end

          def self.control_class
            Controls::Schema::Example
          end

          def self.compare_class
            Controls::Schema::OtherExample
          end

          def self.entries
            entry = Same::Entry.example

            [entry]
          end
        end

        module Attributes
          def self.example
            ::Schema::Compare::Comparison.new(control_class, compare_class, entries)
          end

          def self.control_class
            Controls::Schema::Example
          end

          def self.compare_class
            Controls::Schema::Example
          end

          def self.entries
            entry = Entry.example

            [entry]
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
        end

        module Mapped
          def self.example
            ::Schema::Compare::Comparison.new(control_class, compare_class, entries)
          end

          def self.control_class
            Controls::Schema::Example
          end

          def self.compare_class
            Controls::Schema::Equivalent
          end

          def self.entries
            entry = Entry.example

            [entry]
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
          ::Schema::Compare::Comparison.new(control_class, compare_class, entries)
        end

        def self.control_class
          Controls::Schema::Example
        end

        def self.compare_class
          Controls::Schema::Example
        end

        def self.entries
          entry = Entry.example

          [entry]
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
            ::Schema::Compare::Comparison.new(control_class, compare_class, entries)
          end

          def self.control_class
            Controls::Schema::Example
          end

          def self.compare_class
            Controls::Schema::Equivalent
          end

          def self.entries
            entry = Entry.example

            [entry]
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
