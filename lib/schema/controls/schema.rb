module Schema
  module Controls
    module Schema
      def self.example
        example = Example.new
        example.some_attribute = 'some value'
        example.some_other_attribute = 'some other value'
        example
      end

      def self.other_example
        example = OtherExample.new
        example.some_attribute = 'some value'
        example.some_other_attribute = 'some other value'
        example
      end

      def self.ancestors
        example.class.ancestors
      end

      def self.attributes
        example.attributes
      end

      def self.hash
        example.to_h
      end

      class Example
        include ::Schema
        attribute :some_attribute
        attribute :some_other_attribute
      end

      class OtherExample < Example
      end

      module DefaultValue
        class Example
          include ::Schema
          attribute :some_attribute, default: 'some default value'
        end
      end

      module Typed
        class SomeType
        end

        class SomeSubtype < SomeType
        end

        class Example
          include ::Schema
          attribute :some_attribute, SomeType
        end

        module Strict
          class Example
            include ::Schema
            attribute :some_attribute, SomeType, strict: true
          end
        end
      end
    end
  end
end
