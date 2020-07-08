require_relative '../../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Different Predicate" do
      context "Attribute Difference" do
        comparison = Schema::Controls::Comparison::Different::Attributes.example

        different = comparison.different?

        test do
          assert(different)
        end
      end
    end
  end
end
