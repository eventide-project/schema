module Schema
  module Controls
    module DataStructure
      def self.example
        example = Example.new
        example.some_attribute = 'some value'
        example
      end

      def self.ancestors
        example.class.ancestors
      end

      def self.attributes
        example.attributes
      end

      def self.hash
        {
          some_attribute: 'some value'
        }
      end

      class Example
        include ::Schema::DataStructure
        attribute :some_attribute
      end

      module ExtraAttributes
        def self.data
          {
            :some_attribute => 'some value',
            :some_other_attribute => 'some other value'
          }
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

      module ImportAndExport
        def self.example
          example = Example.new
          example.some_attribute = 'some value'
          example
        end

        class Example < DataStructure::Example
          def read(data)
            data[:some_attribute] = 'some read value'
          end

          def write(data)
            data[:some_attribute] = 'some written value'
          end
        end

        module Data
          def self.example
            {
              some_attribute: 'some value'
            }
          end
        end
      end
    end
  end
end
