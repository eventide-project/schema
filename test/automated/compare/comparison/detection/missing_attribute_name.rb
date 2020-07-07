require_relative '../../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Detection" do
      context "Missing Attribute Name" do
        comparison = Schema::Controls::Comparison::Different.example

        attr_name = Schema::Controls::Random.example

        test "Is an error" do
          assert_raises(Schema::Compare::Comparison::Error) do
            comparison.different?(attr_name)
          end
        end
      end
    end
  end
end
