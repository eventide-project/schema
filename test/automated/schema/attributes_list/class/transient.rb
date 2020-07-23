require_relative '../../../automated_init'

context "Attributes List" do
  context "Class" do
    context "Transient" do
      schema_class = Schema::Controls::Schema::TransientAttributes::Example

      attributes = schema_class.attribute_names
      transient_attributes = schema_class.transient_attributes

      intersection = attributes.intersection(transient_attributes)

      test "Are excluded from the list of attribute names" do
        assert(intersection.empty?)
      end
    end
  end
end
