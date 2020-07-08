require_relative '../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Get Entry" do
      control_class = Schema::Controls::Comparison.control_class
      compare_class = Schema::Controls::Comparison.compare_class

      context "Present" do
        control_entry = Schema::Controls::Comparison::Entry.example

        entries = [control_entry]

        comparison = Schema::Compare::Comparison.new(control_class, compare_class, entries)

        attribute_name = control_entry.control_attribute_name

        entry = comparison[attribute_name]

        test "Recorded entry" do
          assert(entry == control_entry)
        end
      end

      context "Absent" do
        entries = []

        comparison = Schema::Compare::Comparison.new(control_class, compare_class, entries)

        attribute_name = Schema::Controls::Random.example

        entry = comparison[attribute_name]

        test "No recorded entry" do
          assert(entry.nil?)
        end
      end
    end
  end
end
