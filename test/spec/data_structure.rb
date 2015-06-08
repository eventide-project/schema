require_relative 'spec_init'

module Test
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
      include Schema::DataStructure

      attribute :some_attribute
    end
  end
end

describe "Data Structure" do
  specify "Is a Schema object" do
    ancestors = Test::DataStructure.ancestors
    assert(ancestors.include? Schema)
  end

  specify "Can be built from a hash" do
    data = Test::DataStructure.hash
    data_structure = Test::DataStructure::Example.build data
    assert(data_structure.some_attribute == 'some value')
  end
end
