module Schema
  module Controls
    module Attribute
      module Name
        def self.example
          some_attribute
        end

        def self.some_attribute
          :some_attribute
        end

        def self.some_other_attribute
          :some_other_attribute
        end

        def self.yet_another_attribute
          :yet_another_attribute
        end

        def self.random
          :"random_attribute_#{Controls::Random.example}"
        end
      end

      module Value
        def self.some_attribute
          'some value'
        end

        def self.some_other_attribute
          'some other value'
        end

        def self.yet_another_attribute
          'yet another value'
        end

        def self.alternate
          'some alternate value'
        end

        def self.random
          Controls::Random.example
        end
      end
    end
  end
end
