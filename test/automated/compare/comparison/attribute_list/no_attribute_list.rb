require_relative '../../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Attribute List" do
      context "No Attribute List" do
        control = Schema::Controls::Schema.example
        compare = Schema::Controls::Schema.example

        listed_attribute_names = control.class.attribute_names

        comparison = Schema::Compare::Comparison.build(control, compare)

        attribute_names = comparison.entries_attribute_names

        context "Listed Attributes" do
          listed = (attribute_names == listed_attribute_names)

          test "Are in the entries list" do
            assert(listed)
          end
        end
      end
    end
  end
end
