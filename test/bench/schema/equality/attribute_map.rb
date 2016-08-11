require_relative '../../bench_init'

context "Equality" do
  context "Attribute Map" do
    context "Equal" do
      context "Attributes and values are equal and classes are equal" do
        example_1 = Schema::Controls::Schema.example
        example_2 = Schema::Controls::Schema.example

        test "Schemas are equal" do
          assert(example_1 == example_2)
        end
      end
    end

    context "Not Equal" do
      example_1 = Schema::Controls::Schema.example

      context "Attributes and values are not equal and classes are equal" do
        test "Schemas are not equal" do
          example_2 = Schema::Controls::Schema.example
          example_2.some_attribute = 'some other value'

          refute(example_1 == example_2)
        end
      end

      context "Attributes and values are equal and classes are not equal" do
        test "Schemas are not equal" do
          example_2 = Schema::Controls::Schema.other_example

          refute(example_1 == example_2)
        end
      end
    end
  end
end
