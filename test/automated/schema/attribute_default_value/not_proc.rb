require_relative '../../automated_init'

context "Schema" do
  context "Attribute Default Value" do
    context "Default Value Is Not a Proc" do
      object = Object.new

      test "Raises an error" do
        assert_raises(Schema::Attribute::Error) do
          Class.new do
            include Schema
            attribute :some_incorrect_attribute, default: object
          end
        end
      end
    end
  end
end
