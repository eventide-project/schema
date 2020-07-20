require_relative '../../automated_init'

context "Schema" do
  context "Attribute Default Value" do
    context "No Default" do
      example = Schema::Controls::Schema::Example.new

      test "Attribute has no default value" do
        assert(example.some_attribute.nil?)
      end
    end
  end
end
