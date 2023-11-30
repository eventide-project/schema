require_relative '../../automated_init'

context "Compare" do
  context "Comparison" do
    control = Schema::Controls::Schema.example

    compare = Schema::Controls::Schema.example
    compare.some_other_attribute = Schema::Controls::Attribute::Value.random

    comparison = Schema::Compare::Comparison.build(control, compare)

    detail "Comparison: #{comparison.pretty_inspect}"

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
