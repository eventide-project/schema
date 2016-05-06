require_relative '../bench_init'

context "Equality" do
  context "Instances are equal when" do
    example_1 = Schema::Controls::Schema.example
    example_2 = Schema::Controls::Schema.example

    test "Attributes and values are equal and classes are equal" do
      assert(example_1 == example_2)
    end
  end

  context "Instances are not equal when" do
    example_1 = Schema::Controls::Schema.example

    test "Attributes and values are not equal and classes are equal" do
      example_2 = Schema::Controls::Schema.example
      example_2.some_attribute = 'some other value'

      assert(example_1 != example_2)
    end

    test "Attributes and values are equal and classes are equal" do
      example_2 = Schema::Controls::Schema::Typed::Example.new

      assert(example_1 != example_2)
    end
  end
end
