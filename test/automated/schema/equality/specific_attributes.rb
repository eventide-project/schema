require_relative '../../automated_init'

context "Equality" do
  context "Specific Attributes" do
    example_1 = Schema::Controls::Schema.example
    example_2 = Schema::Controls::Schema.example

    example_2.some_other_attribute = Schema::Controls::Attribute::Value::Random.example

    refute(example_1.some_other_attribute == example_2.some_other_attribute)

    context "Equal" do
      context "Specified attributes are equal" do
        test "Schemas are equal" do
          assert(example_1.eql?(example_2, :some_attribute))
        end
      end
    end

    context "Not Equal" do
      context "Specified attributes are not equal" do
        test "Schemas are not equal" do
          refute(example_1.eql?(example_2, :some_other_attribute))
        end
      end
    end
  end
end
