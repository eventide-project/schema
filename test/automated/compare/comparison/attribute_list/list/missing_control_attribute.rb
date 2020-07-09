require_relative '../../../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Attribute List" do
      context "List" do
        context "Missing Control Attribute" do
          control = Schema::Controls::Schema.example
          compare = Schema::Controls::Schema.example

          list = [Schema::Controls::Attribute::Name.random]

          test "Is an error" do
            assert_raises(Schema::Compare::Comparison::Error) do
              Schema::Compare::Comparison.build(control, compare, list)
            end
          end
        end
      end
    end
  end
end
