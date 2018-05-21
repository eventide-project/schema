require_relative '../../automated_init'

context "Schema" do
  context "Boolean Attribute" do
    context "Not Strict" do
      define_schema = proc {
        Class.new do
          include Schema
          attribute :some_boolean_attribute, Boolean, strict: false
        end
      }

      test "Raises error" do
        assert define_schema do
          raises_error?(Schema::Attribute::Error)
        end
      end
    end
  end
end
