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

    def self.hash
      example.to_h
    end

    class Example
      include ::Schema

      attribute :some_attribute
    end
  end
end

context "Schema" do
  test "is a Virtus object" do
    ancestors = Test::Schema.ancestors
    assert(ancestors.include? Virtus::Model::Core)
  end

  test "has attributes" do
    attributes = Test::Schema.attributes
    assert(attributes == { some_attribute: 'some value' })
  end

  test "hash of the object is the same as its attributes" do
    attributes = Test::Schema.attributes
    hash = Test::Schema.hash
    assert(hash == attributes)
  end

  test "cannot be assigned attributes" do
    example = Test::Schema.example

    begin
      example.attributes = :something
    rescue NoMethodError => error
    end

    assert error
  end
end
