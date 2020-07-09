require_relative '../../../automated_init'

context "Schema" do
  context "Boolean Attribute" do
    context "Definition" do
      context "Default Strictness" do
        schema_cls = Schema::Controls::Schema::Boolean::Example

        test "Strict" do
          attribute = schema_cls.attributes[0]

          assert(attribute.strict == true)
        end
      end
    end
  end
end
