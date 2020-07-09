require_relative '../../../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Attribute List" do
      context "List" do
        control = Schema::Controls::Schema.example
        compare = Schema::Controls::Schema.example

        control_name = :some_attribute

        list = [control_name]

        comparison = Schema::Compare::Comparison.build(control, compare, list)

        context "Listed Attributes" do
          entry = comparison[control_name]

          test "Control name" do
            assert(entry.control_name == control_name)
          end
        end

        context "Omitted Attributes" do
          entry = comparison[:some_other_attribute]

          test "Are not in the entries list" do
            assert(entry.nil?)
          end
        end
      end
    end
  end
end
