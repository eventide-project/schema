require_relative '../../../../automated_init'

_context "Compare" do
  context "Attributes" do
    context "Attribute Differences" do
      context "Detection" do
        context "Same Attribute Names" do
          context "Difference" do
            differences = Schema::Controls::AttributeDifferences::Different.example

            attr_name = Schema::Controls::AttributeDifferences::Different::Entry.attr_name
            different = differences.different?(attr_name)

            test "Detected" do
              assert(different)
            end
          end

          context "No Difference" do
            differences = Schema::Controls::AttributeDifferences::Same.example

            different = differences.different?(Schema::Controls::Random.example)

            test "Not Detected" do
              refute(different)
            end
          end
        end
      end
    end
  end
end
