require_relative '../../../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Attribute List" do
      context "List" do
        context "Missing Compare Attribute" do
          control = Schema::Controls::Schema.example
          compare = Schema::Controls::Schema::Random.example

          test "Is an error" do
            assert_raises(Schema::Compare::Comparison::Error) do
              Schema::Compare::Comparison.build(control, compare)
            end
          end
        end
      end
    end
  end
end
