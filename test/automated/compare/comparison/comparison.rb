require_relative '../../automated_init'

context "Compare" do
  context "Comparison" do
    control = Schema::Controls::Schema.example

    compare = Schema::Controls::Schema.example
    compare.some_other_attribute = Schema::Controls::Attribute::Value::Random.example

    control_attributes = control.attributes
    compare_attributes = compare.attributes

    attr_names = control_attributes.keys

    comparison = Schema::Compare::Comparison.build(
      control_attributes,
      compare_attributes,
      attr_names
    )

    context "Attribute with Same Value" do
      different = comparison.different?(:some_attribute)

      test "Not Different" do
        refute(different)
      end
    end

    context "Attribute with Different Value" do
      different = comparison.different?(:some_other_attribute)

      test "Different" do
        assert(different)
      end
    end
  end
end
