require_relative '../../../../automated_init'

context "Compare" do
  context "Attributes" do
    context "Attribute Differences" do
      context "Detection" do
        context "Same Attribute Names" do
          context "Difference" do
            differences = Schema::Controls::AttributeDifferences.example

            attr_name = Schema::Controls::AttributeDifferences::Entry::Different.attr_name
            different = differences.different?(attr_name)

            test "Detected" do
              assert(different)
            end
          end

          context "No Difference" do
            differences = Schema::Compare::Difference::Attributes.new

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
