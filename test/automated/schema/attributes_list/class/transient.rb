require_relative '../../../automated_init'

context "Attributes List" do
  context "Class" do
    context "Transient" do
      attributes = Schema::Controls::Schema::TransientAttributes::Example.attribute_names

      test "Are excluded from the list of attribute names" do
        assert(attributes == [:some_attribute, :some_other_attribute])
      end
    end
  end
end
