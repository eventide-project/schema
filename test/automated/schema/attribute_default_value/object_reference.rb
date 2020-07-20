require_relative '../../automated_init'

context "Schema" do
  context "Attribute Default Value" do
    context "Default Value Is an Object Reference" do
      example_1 = Schema::Controls::Schema::DefaultValue::ObjectReference.new
      example_2 = Schema::Controls::Schema::DefaultValue::ObjectReference.new

      example_2.some_attribute << 'some value'

      test "Not a shared object reference" do
        refute(example_1.some_attribute == example_2.some_attribute)
      end
    end
  end
end
