require_relative '../../../automated_init'

context "Schema" do
  context "Boolean Attribute" do
    context "Definition" do
      context "Boolean Constant" do
        schema_cls = Controls::Schema::Boolean::Example

        test "Boolean constant is defined under schema namespace" do
          assert(schema_cls.const_defined?(:Boolean, false))
        end

        test "Boolean constant is copied to schema namespace" do
          boolean_constant = schema_cls.const_get(:Boolean, false)

          assert(boolean_constant == ::Schema::Boolean)
        end
      end
    end
  end
end
