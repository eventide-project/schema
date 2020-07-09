require_relative '../../../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Attribute List" do
      context "Map" do
        context "Missing Control Attribute" do
          control = Schema::Controls::Schema.example
          compare = Schema::Controls::Schema::Equivalent.example

          control_name = Schema::Controls::Attribute::Name.random
          compare_name = :yet_another_attribute

          map = [
            { control_name => compare_name }
          ]

          test "Is an error" do
            assert_raises(Schema::Compare::Comparison::Error) do
              Schema::Compare::Comparison.build(control, compare, map)
            end
          end
        end
      end
    end
  end
end
