require_relative '../../automated_init'

context "Attribute Definition (Strict)" do
  example = Schema::Controls::Schema::Typed::Strict::Example.new

  context "Attribute value is not of the same type as the attribute's declared interface" do
    test "Incorrect" do
      assert_raises(Schema::Attribute::TypeError) do
        example.some_attribute = 'some value'
      end
    end
  end

  context "Attribute value is of the same type as the attribute's declared interface" do
    test "Correct" do
      something = Schema::Controls::Schema::Typed::SomeType.new
      example.some_attribute = something
    end
  end

  context "Attribute value is of a subtype of the attribute's declared interface" do
    test "Incorrect" do
      something = Schema::Controls::Schema::Typed::SomeSubtype.new

      assert_raises(Schema::Attribute::TypeError) do
        example.some_attribute = something
      end
    end
  end

  context "Value is nil" do
    test "Correct" do
      example.some_attribute = nil
    end
  end
end
