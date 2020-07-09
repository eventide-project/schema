require_relative '../../../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Attribute List" do
      context "Map" do
        context "Coerce Single Attribute to List" do
          control = Schema::Controls::Schema.example
          compare = Schema::Controls::Schema::Equivalent.example

          control_name = :some_other_attribute
          compare_name = :yet_another_attribute

          map = { control_name => compare_name }

          comparison = Schema::Compare::Comparison.build(control, compare, map)

          entry = comparison[control_name]

          context "Coerced" do
            test "Control name" do
              assert(entry.control_name == control_name)
            end

            test "Compare name" do
              assert(entry.compare_name == compare_name)
            end
          end
        end
      end
    end
  end
end
