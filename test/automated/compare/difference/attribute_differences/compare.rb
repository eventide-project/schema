require_relative '../../../automated_init'

context "Compare" do
  context "Attributes" do
    context "Attribute Differences" do
      context "Compare" do
        control = Schema::Controls::Schema.example

        compare = Schema::Controls::Schema.example
        compare.some_other_attribute = Schema::Controls::Attribute::Value::Random.example

        control_attributes = control.attributes
        compare_attributes = compare.attributes

        attr_names = control_attributes.keys

        attribute_differences = Schema::Compare::Difference::Attributes.compare(
          attr_names,
          control_attributes,
          compare_attributes
        )

        context "Attribute with Different Value" do
          different = attribute_differences.different?(:some_other_attribute)

          test "Different" do
            assert(different)
          end
        end

        context "Attribute with Same Value" do
          different = attribute_differences.different?(:some_attribute)

          test "Not Different" do
            refute(different)
          end
        end
      end
    end
  end
end
