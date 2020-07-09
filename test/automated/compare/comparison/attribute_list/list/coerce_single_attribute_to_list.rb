require_relative '../../../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Attribute List" do
      context "List" do
        context "Coerce Single Attribute to List" do
          control = Schema::Controls::Schema.example
          compare = Schema::Controls::Schema.example

          control_name = :some_attribute

          comparison = Schema::Compare::Comparison.build(control, compare, control_name)

          coerced = comparison.entries_attribute_names == [control_name]

          test "Coerced" do
            assert(coerced)
          end
        end
      end
    end
  end
end
