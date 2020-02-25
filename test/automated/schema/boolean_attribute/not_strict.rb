require_relative '../../automated_init'

context "Schema" do
  context "Boolean Attribute" do
    context "Not Strict" do
      test "Raises error" do
        assert_raises(Schema::Attribute::Error) do
          Class.new do
            include Schema
            attribute :some_boolean_attribute, Boolean, strict: false
          end
        end
      end
    end
  end
end
