module Schema
  module Controls
    module Comparison
      def self.example
        Same.example
      end

      def self.control_class
        Same.control_class
      end

      def self.compare_class
        Same.compare_class
      end

      def self.entries
        Same.entries
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
          [
            Entry::SomeAttribute.example,
            Entry::SomeOtherAttribute.example
          ]
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
            [
              Entry::SomeAttribute.example,
              Entry::SomeOtherAttribute::Mapped.example
            ]
          end
        end
      end

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
            [
              Entry::SomeAttribute.example,
              Entry::SomeOtherAttribute::Different.example
            ]
          end
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
            Same.entries
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
            [
              Entry::SomeAttribute.example,
              Entry::SomeOtherAttribute::Mapped::DifferentValues.example
            ]
          end
        end
      end
    end
  end
end

__END__

Controls::Comparison.example
- Alias for Same

Controls::Same.example
- Same classes
- Same attribute values
- Same attribute names

Controls::Same::Mapped.example
- Different classes
- Same attribute values
- One attribute's name is different

Controls::Different.example
- Different classes
- One attribute's values are different
- The other attribute's values are the same
- Same attribute names

Controls::Different::Attributes.example
- Same classes
- One attribute's values are different
- The other attribute's values are the same
- Same attribute names

Controls::Different::Classes.example
- Different classes
- Same attribute values
- Same attribute names

Controls::Different::Mapped.example
- Different classes
- One attribute's values are different
- The other attribute's values are the same
- One attribute's name is different
