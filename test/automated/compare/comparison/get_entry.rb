require_relative '../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Get Entry" do
      context "Present" do
        control_entry = Schema::Controls::Comparison::Entry.example

        entries = [control_entry]

        comparison = Schema::Compare::Comparison.new(entries)

        attr_name = control_entry.control_attr_name

        entry = comparison[attr_name]

        test "Recorded entry" do
          assert(entry == control_entry)
        end
      end

      context "Absent" do
        entries = []

        comparison = Schema::Compare::Comparison.new(entries)

        attr_name = Schema::Controls::Random.example

        entry = comparison[attr_name]

        test "No recorded entry" do
          assert(entry.nil?)
        end
      end
    end
  end
end
