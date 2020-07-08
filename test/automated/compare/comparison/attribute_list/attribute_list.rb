require_relative '../../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Attribute List" do
      control = Schema::Controls::Schema.example
      compare = Schema::Controls::Schema.example

      listed_attribute_names = [:some_attribute]

      comparison = Schema::Compare::Comparison.build(control, compare, listed_attribute_names)

      attribute_names = comparison.entries_attribute_names

      context "Listed Attributes" do
        listed = (attribute_names == listed_attribute_names)

        test "Are in the entries list" do
          assert(listed)
        end
      end

      context "Omitted Attributes" do
        included = attribute_names.include?(:some_other_attribute)

        test "Are not in the entries list" do
          refute(included)
        end
      end
    end
  end
end

