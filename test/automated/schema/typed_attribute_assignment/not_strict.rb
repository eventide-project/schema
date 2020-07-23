require_relative '../../automated_init'

context "Attribute Definition (Not Strict)" do
  example = Schema::Controls::Schema::Typed::Example.new

  context "Value is not of the same type as the attribute's declared interface" do
    test "Incorrect" do
      assert_raises(Schema::Attribute::TypeError) do
        example.some_attribute = 'some value'
      end
    end
  end

  context "Value is of the same type as the attribute's declared interface" do
    something = Schema::Controls::Schema::Typed::SomeType.new

    test "Correct" do
      refute_raises(Schema::Attribute::TypeError) do
        example.some_attribute = something
      end
    end
  end

  context "Value is of a subtype of the attribute's declared interface" do
    something = Schema::Controls::Schema::Typed::SomeSubtype.new

    test "Correct" do
      refute_raises(Schema::Attribute::TypeError) do
        example.some_attribute = something
      end
    end
  end

  context "Value is nil" do
    test "Correct" do
      refute_raises(Schema::Attribute::TypeError) do
        example.some_attribute = nil
      end
    end
  end
end
