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

      module Random
        def self.example
          example_class.new
        end

        def self.example_class
          Class.new do
            include ::Schema

            attribute Attribute::Name.random
          end
        end
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
        def self.example
          Example.new
        end

        class Example
          include ::Schema
          attribute :some_attribute, default: proc { 'some default value' }
          attribute :some_other_attribute
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

      module Check
        def self.check
          lambda do |type, value, strict|
            value == Check.valid_some_attribute
          end
        end

        def self.valid_some_attribute
          "some-valid-value"
        end

        def self.invalid_some_attribute
          "some-invalid-value"
        end

        class Example
          include ::Schema
          attribute :some_attribute, check: Check.check
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
