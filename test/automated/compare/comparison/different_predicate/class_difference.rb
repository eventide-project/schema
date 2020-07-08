require_relative '../../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Different Predicate" do
      context "Class Difference" do
        comparison = Schema::Controls::Comparison::Different::Classes.example

        context "Don't Ignore Class" do
          different = comparison.different?

          test "Different" do
            assert(different)
          end
        end

        context "Ignore Class" do
          different = comparison.different?(ignore_class: true)

          test "Not different" do
            refute(different)
          end
        end
      end
    end
  end
end
