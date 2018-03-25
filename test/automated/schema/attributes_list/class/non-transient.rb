require_relative '../../../automated_init'

context "Attributes List" do
  context "Class" do
    context "Non-Transient" do
      attributes = Schema::Controls::Schema::Example.attribute_names

      test "Are included in the list of attribute names" do
        assert(attributes == [:some_attribute, :some_other_attribute])
      end
    end
  end
end
