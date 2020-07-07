require_relative '../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Entry Difference" do
      context "Different" do
        entry = Schema::Controls::Comparison::Different::Entry.example

        different = entry.different?

        test do
          assert(different)
        end
      end

      context "Same" do
        entry = Schema::Controls::Comparison::Same::Entry.example

        different = entry.different?

        test do
          refute(different)
        end
      end
    end
  end
end
