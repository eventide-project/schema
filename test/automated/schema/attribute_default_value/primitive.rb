require_relative '../../automated_init'

context "Schema" do
  context "Default Attribute Value" do
    context "Primitive Value" do
      example_1 = Schema::Controls::Schema::DefaultValue::Primitive.new
      example_2 = Schema::Controls::Schema::DefaultValue::Primitive.new

      example_2.some_attribute = example_1.some_attribute * 2

      test "Not a shared object reference" do
        refute(example_1.some_attribute == example_2.some_attribute)
      end
    end
  end
end
