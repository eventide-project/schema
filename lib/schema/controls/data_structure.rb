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
        example.to_h
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
    end
  end
end
