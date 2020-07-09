require_relative '../../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Different Predicate" do
      context "No Differences" do
        comparison = Schema::Controls::Comparison::Same.example

        different = comparison.different?

        test "Not different" do
          refute(different)
        end
      end
    end
  end
end
