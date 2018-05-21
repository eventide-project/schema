require_relative '../../automated_init'

context "Schema" do
  context "Boolean Attribute" do
    context "Assignment" do
      example = Schema::Controls::Schema::Boolean.example

      context "Value is true" do
        test "Correct" do
          refute proc { example.some_boolean_attribute = true } do
            raises_error?
          end
        end
      end

      context "Value is false" do
        test "Correct" do
          refute proc { example.some_boolean_attribute = false } do
            raises_error?
          end
        end
      end

      context "Value is nil" do
        test "Correct" do
          refute proc { example.some_boolean_attribute = nil } do
            raises_error?
          end
        end
      end

      context "Value is neither a boolean nor nil" do
        test "Inorrect" do
          assert proc { example.some_boolean_attribute = Object.new } do
            raises_error? Schema::Attribute::TypeError
          end
        end
      end
    end
  end
end
