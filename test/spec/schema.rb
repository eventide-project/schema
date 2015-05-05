require_relative 'spec_init'

module Test
  module Schema
    def self.example
      Example.new
    end

    class Example
      include ::Schema
    end
  end
end

describe "Schema" do
  it "Is a Virtus object" do
    ancestors = Test::Schema.example.class.ancestors
    assert(ancestors.include? Virtus::Model::Core)
  end
end
