require_relative '../../../../automated_init'

context "Compare" do
  context "Attributes" do
    context "Attribute Differences" do
      context "Detection" do
        context "Missing Attribute Name" do
          differences = Schema::Controls::AttributeDifferences::Different.example

          attr_name = Schema::Controls::Random.example

          test "Is an error" do
            assert_raises(Schema::Compare::Difference::Attributes::Error) do
              differences.different?(attr_name)
            end
          end
        end
      end
    end
  end
end
