module Schema
  module Controls
    module DataStructure
      def self.example
        example = Example.new
        example.some_attribute = some_attribute
        example
      end

      def self.some_attribute
        Attribute::Value.some_attribute
      end

      def self.ancestors
        example.class.ancestors
      end

      def self.attributes
        example.attributes
      end

      def self.hash
        {
          some_attribute: some_attribute
        }
      end

      class Example
        include ::Schema::DataStructure
        attribute :some_attribute
      end

      module ExtraAttributes
        def self.data
          {
            :some_attribute => DataStructure.some_attribute,
            :some_other_attribute => some_other_attribute
          }
        end

        def self.some_other_attribute
          Attribute::Value.some_other_attribute
        end
      end

      module ConfigureDependencies
        def self.example
          Example.build
        end

        class Example
          include ::Schema::DataStructure

          attr_accessor :some_dependency

          def configure
            self.some_dependency = :set
          end
        end
      end

      module ReadAndWrite
        def self.example
          example = Example.new
          example.some_attribute = DataStructure.some_attribute
          example
        end

        class Example < DataStructure::Example
          def transform_read(data)
            data[:some_attribute] = 'some read value'
          end

          def transform_write(data)
            data[:some_attribute] = 'some written value'
          end
        end

        module Data
          def self.example
            {
              some_attribute: DataStructure.some_attribute
            }
          end
        end
      end
    end
  end
end
