require_relative '../../../automated_init'

context "Attributes List" do
  context "Instance" do
    context "Transient" do
      example = Schema::Controls::Schema::TransientAttributes.example

      test "Excluded from attributes" do
        assert(example.attributes == { some_attribute: 'some value', some_other_attribute: 'some other value' })
      end

      test "Excluded from hash" do
        assert(example.to_h == example.attributes)
      end
    end
  end
end
