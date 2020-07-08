require_relative '../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Entry Difference" do
      context "Different" do
        entry = Schema::Controls::Comparison::Entry::Different.example

        different = entry.different?

        test do
          assert(different)
        end
      end

      context "Same" do
        entry = Schema::Controls::Comparison::Entry::Same.example

        different = entry.different?

        test do
          refute(different)
        end
      end
    end
  end
end
