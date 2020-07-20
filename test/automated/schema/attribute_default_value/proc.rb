require_relative '../../automated_init'

context "Schema" do
  context "Attribute Default Value" do
    context "Proc" do
      example = Schema::Controls::Schema::DefaultValue::Proc::Example.new

      test "Value is set by executing the proc" do
        assert(example.some_attribute == 'some default value')
      end
    end
  end
end
