require_relative '../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Class Difference" do
      comparison = Schema::Controls::Comparison::Difference::Class.example

      context "Don't Ignore Class" do
        different = comparison.different?

        test "Different" do
          refute(different)
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
