require_relative '../../../../automated_init'

context "Attributes" do
  context "Class" do
    context "All Attributes" do
      context "Has No Transient Attributes" do
        schema_class = Schema::Controls::Schema::Example

        refute(schema_class.respond_to?(:transient_attributes))

        attributes = schema_class.attribute_names

        all_attributes = schema_class.all_attribute_names

        test "Is the list of attribute names" do
          assert(all_attributes == attributes)
        end
      end
    end
  end
end
