require_relative '../../../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Attribute List" do
      context "Map" do
        control = Schema::Controls::Schema.example
        compare = Schema::Controls::Schema::Equivalent.example

        control_name = :some_other_attribute
        compare_name = :yet_another_attribute

        map = [
          { control_name => compare_name }
        ]

        comparison = Schema::Compare::Comparison.build(control, compare, map)

        context "Listed Attributes" do
          entry = comparison[:some_other_attribute]

          test "Control name" do
            assert(entry.control_name == control_name)
          end

          test "Compare name" do
            assert(entry.compare_name == compare_name)
          end
        end

        context "Omitted Attributes" do
          entry = comparison[:some_attribute]

          test "Are not in the entries list" do
            assert(entry.nil?)
          end
        end
      end
    end
  end
end
