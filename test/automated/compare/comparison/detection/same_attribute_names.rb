require_relative '../../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Detection" do
      context "Same Attribute Names" do
        context "Difference" do
          comparison = Schema::Controls::Comparison::Different::Attributes.example

          different = comparison.different?(:some_other_attribute)

          test "Detected" do
            assert(different)
          end
        end

        context "No Difference" do
          comparison = Schema::Controls::Comparison::Same.example

          different = comparison.different?(:some_other_attribute)

          test "Not Detected" do
            refute(different)
          end
        end
      end
    end
  end
end
