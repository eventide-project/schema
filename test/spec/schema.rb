require_relative 'spec_init'

module Test
  module Schema
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

    class Example
      include ::Schema

      attribute :some_attribute
    end
  end
end

describe "Schema" do
  it "is a Virtus object" do
    ancestors = Test::Schema.ancestors
    assert(ancestors.include? Virtus::Model::Core)
  end

  it "has attributes" do
    example = Test::Schema.example
    assert(example.attributes == { some_attribute: 'some value' })
  end

  it "cannot be assigned attributes" do
    example = Test::Schema.example

    assert_raises NoMethodError do
      example.attributes = :something
    end
  end
end
