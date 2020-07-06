module Schema
  module Controls
    module Schema
      def self.example
        example = Example.new
        example.some_attribute = some_attribute
        example.some_other_attribute = some_other_attribute
        example
      end

      def self.other_example
        example = OtherExample.new
        example.some_attribute = some_attribute
        example.some_other_attribute = some_other_attribute
        example
      end

      def self.some_attribute
        Attribute::Value.some_attribute
      end

      def self.some_other_attribute
        Attribute::Value.some_other_attribute
      end

      def self.ancestors
        example.class.ancestors
      end

      def self.attributes
        example.attributes
      end

      def self.attribute_names
        example.class.attribute_names
      end

      def self.hash
        example.to_h
      end

      module Attributes
        def self.included(cls)
          cls.class_exec do
            include ::Schema
            attribute :some_attribute
            attribute :some_other_attribute
          end
        end
      end

      class Example
        include Attributes
      end

      class OtherExample
        include Attributes
      end

      module TransientAttributes
        def self.example
          example = Example.new
          example.some_attribute = Attribute::Value.some_attribute
          example.some_other_attribute = Attribute::Value.some_other_attribute
          example.yet_another_attribute = Attribute::Value.yet_another_attribute
          example
        end

        class Example
          include ::Schema
          attribute :some_attribute
          attribute :some_other_attribute
          attribute :yet_another_attribute

          def self.transient_attributes
            [
              :yet_another_attribute
            ]
          end
        end
      end

      module Equivalent
        def self.example
          example = Example.new
          example.some_attribute = Attribute::Value.some_attribute
          example.yet_another_attribute = yet_another_attribute
          example
        end

        def self.yet_another_attribute
          Attribute::Value.some_other_attribute
        end

        class Example
          include ::Schema
          attribute :some_attribute
          attribute :yet_another_attribute
        end
      end

      module DefaultValue
        class Example
          include ::Schema
          attribute :some_attribute, default: 'some default value'
        end

        module Proc
          class Example
            include ::Schema
            attribute :some_attribute, default: proc { 'some default value' }
          end
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

      module Boolean
        def self.example
          Example.new
        end

        class Example
          include ::Schema
          attribute :some_boolean_attribute, Boolean
        end
      end

      module Duplicate
        def self.example
          Example.new
        end

        class Example
          include ::Schema

          attribute :some_attribute, Numeric
          attribute :some_attribute, String
        end
      end

      module Validation
        def self.example
          Example.new
        end

        def self.errors
          [
            "some_attribute can't be nil",
            "some_other_attribute can't be nil"
          ]
        end

        class Example
          include ::Schema

          attribute :some_attribute
          attribute :some_other_attribute

          module Validator
            extend ::Schema::Validation::NilAttributes
          end
        end
      end
    end
  end
end
