require_relative '../bench_init'

context "Class Attributes List" do
  context do
    attributes = Schema::Controls::Schema::Example.attributes

    test "Each defined attribute is included in the class's attribute list" do
      assert(attributes.length == 1)
    end

    test "Name is the declared name" do
      attribute = attributes[0]
      assert(attribute.name == :some_attribute)
    end

    test "Attribute names is a list of just the declared names" do
      attribute_names = Schema::Controls::Schema::Example.attribute_names
      assert(attribute_names = [:some_attribute])
    end
  end

  context "Not Typed" do
    attributes = Schema::Controls::Schema::Example.attributes

    context "Attribute List Entry" do
      attribute = attributes[0]

      test "Type is not declared" do
        assert(attribute.type.nil?)
      end

      test "Strict is false" do
        refute(attribute.strict)
      end
    end
  end

  context "Typed" do
    context "Not Strict" do
      attributes = Schema::Controls::Schema::Typed::Example.attributes

      context "Attribute List Entry" do
        attribute = attributes[0]

        test "Type is the declared type" do
          assert(attribute.type == Schema::Controls::Schema::Typed::SomeType)
        end

        test "Strict is false" do
          refute(attribute.strict)
        end
      end
    end

    context "Strict" do
      attributes = Schema::Controls::Schema::Typed::Strict::Example.attributes

      context "Attribute List Entry" do
        attribute = attributes[0]

        test "Strict is true" do
          assert(attribute.strict)
        end
      end
    end
  end
end
