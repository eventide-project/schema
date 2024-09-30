require_relative '../../automated_init'

context "Attribute Check" do
  example = Schema::Controls::Schema::Check::Example.new

  context "Value is not valid" do
    some_attribute = Schema::Controls::Schema::Check.invalid_some_attribute

    test "Incorrect" do
      assert_raises(Schema::Attribute::TypeError) do
        example.some_attribute = some_attribute
      end
    end
  end

  context "Value is valid" do
    some_attribute = Schema::Controls::Schema::Check.valid_some_attribute

    test "Correct" do
      refute_raises(Schema::Attribute::TypeError) do
        example.some_attribute = some_attribute
      end
    end
  end
end
