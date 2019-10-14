require_relative '../../automated_init'

context "Schema" do
  context "Boolean Attribute" do
    context "Assignment" do
      example = Schema::Controls::Schema::Boolean.example

      context "Value is true" do
        test "Correct" do
          refute_raises do
            example.some_boolean_attribute = true
          end
        end
      end

      context "Value is false" do
        test "Correct" do
          refute_raises do
            example.some_boolean_attribute = false
          end
        end
      end

      context "Value is nil" do
        test "Correct" do
          refute_raises do
            example.some_boolean_attribute = nil
          end
        end
      end

      context "Value is neither a boolean nor nil" do
        test "Inorrect" do
          assert_raises Schema::Attribute::TypeError do
            example.some_boolean_attribute = Object.new
          end
        end
      end
    end
  end
end
