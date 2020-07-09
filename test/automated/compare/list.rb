require_relative '../automated_init'

context "Compare" do
  context "List" do
    control = Schema::Controls::Schema.example
    compare = Schema::Controls::Schema::Equivalent.example

    list = [
      :some_attribute,
      { :some_other_attribute => :yet_another_attribute }
    ]

    compare_some_attribute = Schema::Controls::Attribute::Value.random
    compare_yet_another_attribute = Schema::Controls::Attribute::Value.random

    compare.some_attribute = compare_some_attribute
    compare.yet_another_attribute = compare_yet_another_attribute

    comparison = Schema::Compare.(control, compare, list)

    test "Schemas are different" do
      assert(comparison.different?)
    end

    context "Entries" do
      [:some_attribute, :some_other_attribute].each do |attribute_name|
        context "#{attribute_name.inspect}" do
          different = comparison.different?(attribute_name)

          test "Different" do
            assert(different)
          end
        end
      end
    end
  end
end
