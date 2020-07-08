require_relative '../../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Detection" do
      context "Same Attribute Names" do
        context "Difference" do
          comparison = Schema::Controls::Comparison::Different.example

          attr_name = Schema::Controls::Comparison::Different::Attributes::Entry.control_attr_name
          different = comparison.different?(attr_name)

          test "Detected" do
            assert(different)
          end
        end

        context "No Difference" do
          comparison = Schema::Controls::Comparison::Same.example

          attr_name = Schema::Controls::Comparison::Same::Entry.control_attr_name
          different = comparison.different?(attr_name)

          test "Not Detected" do
            refute(different)
          end
        end
      end
    end
  end
end
