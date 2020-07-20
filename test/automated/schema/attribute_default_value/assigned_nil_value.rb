require_relative '../../automated_init'

context "Schema" do
  context "Default Attribute Value" do
    context "Assigned a Nil Value" do
      example = Schema::Controls::Schema::DefaultValue::Example.new

      example.some_attribute = nil

      test "Retains the nil value rather than reverting to the default value" do
        assert(example.some_attribute.nil?)
      end
    end
  end
end
