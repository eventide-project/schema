require_relative 'bench_init'

module Test
  module DataStructure
    def self.example
      example = Example.new
      example.some_attribute = 'some value'
      example
    end

    def self.configure_dependencies_example
      ConfigureDependenciesExample.build
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
      include Schema::DataStructure
      attribute :some_attribute
    end

    class ConfigureDependenciesExample
      include Schema::DataStructure

      attr_accessor :some_dependency

      def configure_dependencies
        self.some_dependency = :set
      end
    end
  end
end

context "Data Structure" do
  test "Is a Schema object" do
    ancestors = Test::DataStructure.ancestors
    assert(ancestors.include? Schema)
  end

  test "Can be built from a hash" do
    data = Test::DataStructure.hash
    data_structure = Test::DataStructure::Example.build data
    assert(data_structure.some_attribute == 'some value')
  end

  test "Can configure its dependencies" do
    example = Test::DataStructure.configure_dependencies_example
    assert(example.some_dependency = :set)
  end
end
