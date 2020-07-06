require_relative '../../../automated_init'

context "Compare" do
  context "Attributes" do
    context "Attribute Differences" do
      context "Entries" do
        context "Added" do
          differences = Schema::Compare::Difference::Attributes.new

          attr_name = Schema::Controls::AttributeDifferences::Entry.attr_name
          control_value = Schema::Controls::AttributeDifferences::Entry.control_value
          compare_value = Schema::Controls::AttributeDifferences::Entry.compare_value

          differences.add(attr_name, control_value, compare_value)

          entry = differences[attr_name]

          context "Recorded Entry" do
            test "Attribute name" do
              assert(entry.attr_name == attr_name)
            end

            test "Control value" do
              assert(entry.control_value == control_value)
            end

            test "Compare value" do
              assert(entry.compare_value == compare_value)
            end
          end
        end

        context "Not Added" do
          differences = Schema::Compare::Difference::Attributes.new

          attr_name = Schema::Controls::AttributeDifferences::Entry.attr_name

          entry = differences[attr_name]

          test "No recorded entry" do
            assert(entry.nil?)
          end
        end
      end
    end
  end
end
