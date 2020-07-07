require_relative '../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Entries" do
      context "Added" do
        comparison = Schema::Compare::Comparison.new

        attr_name = Schema::Controls::Attribute::Name.some_attribute
        control_value = Schema::Controls::Attribute::Value.some_attribute
        compare_value = Schema::Controls::Attribute::Value::Alternate.example

        comparison.add(attr_name, control_value, attr_name, compare_value)

        entry = comparison[attr_name]

        context "Recorded Entry" do
          test "Control attribute name" do
            assert(entry.control_attr_name == attr_name)
          end

          test "Control value" do
            assert(entry.control_value == control_value)
          end

          test "Compare attribute name" do
            assert(entry.compare_attr_name == attr_name)
          end

          test "Compare value" do
            assert(entry.compare_value == compare_value)
          end
        end
      end

      context "Not Added" do
        comparison = Schema::Compare::Comparison.new

        attr_name = Schema::Controls::Random.example

        entry = comparison[attr_name]

        test "No recorded entry" do
          assert(entry.nil?)
        end
      end
    end
  end
end
