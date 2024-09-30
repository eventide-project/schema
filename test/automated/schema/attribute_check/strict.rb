require_relative '../../automated_init'

context "Schema" do
  context "Attribute Check" do
    context "Strict" do
      context "Is strict" do
        test "Raises error" do
          assert_raises(Schema::Attribute::Error) do
            Class.new do
              include Schema
              attribute :some_attribute, Object, check: -> { true }, strict: true
            end
          end
        end
      end

      context "Is not strict" do
        test "Raises error" do
          assert_raises(Schema::Attribute::Error) do
            Class.new do
              include Schema
              attribute :some_attribute, Object, check: -> { true }, strict: false
            end
          end
        end
      end
    end
  end
end
