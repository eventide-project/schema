require_relative '../../../../automated_init'

context "Attributes" do
  context "Class" do
    context "All Attributes" do
      context "Has Transient Attributes" do
        schema_class = Schema::Controls::Schema::TransientAttributes::Example

        attributes = schema_class.attribute_names
        transient_attributes = schema_class.transient_attributes

        combined_attributes = attributes + transient_attributes

        all_attributes = schema_class.all_attribute_names

        test "Is the list of attribute names combined with the list of transient attribute names" do
          assert(all_attributes == combined_attributes)
        end
      end
    end
  end
end
