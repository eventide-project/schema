require_relative '../../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Detection" do
      context "Mapped Attribute Names" do
        context "Difference" do
          comparison = Schema::Controls::Comparison::Different::Mapped.example

          different = comparison.different?(:some_other_attribute)

          test "Detected" do
            assert(different)
          end
        end

        context "No Difference" do
          comparison = Schema::Controls::Comparison::Same::Mapped.example

          different = comparison.different?(:some_other_attribute)

          test "Not Detected" do
            refute(different)
          end
        end
      end
    end
  end
end
