require_relative '../automated_init'

context "Schema" do
  context "Hash Code" do
    schema_class = Class.new do
      include Schema

      attribute :some_attribute
    end

    attribute_value = "some-value"

    context "Same Class" do
      context "Same Attribute Values" do
        schema = schema_class.new
        schema.some_attribute = attribute_value

        other_schema = schema_class.new
        other_schema.some_attribute = attribute_value

        test "Equivalent" do
          assert(schema.hash == other_schema.hash)
        end

        test "Schemas instances are equal when hash codes are equal" do
          assert(schema.eql?(other_schema))
        end
      end

      context "Different Attribute Values" do
        schema = schema_class.new
        schema.some_attribute = attribute_value

        other_schema = schema_class.new
        other_schema.some_attribute = SecureRandom.hex

        test "Not Equivalent" do
          refute(schema.hash == other_schema.hash)
        end

        test "Schemas instances are not equal when hash codes are not equal" do
          refute(schema.eql?(other_schema))
        end
      end
    end

    context "Different Class" do
      other_schema_class = Class.new do
        include Schema

        attribute :some_attribute, String
      end

      context "Same Attribute Values" do
        schema = schema_class.new
        schema.some_attribute = attribute_value

        other_schema = other_schema_class.new
        other_schema.some_attribute = attribute_value

        test "Not Equivalent" do
          refute(schema.hash == other_schema.hash)
        end

        test "Schemas instances are not equal when hash codes are not equal" do
          refute(schema.eql?(other_schema))
        end
      end

      context "Different Attribute Values" do
        schema = schema_class.new
        schema.some_attribute = attribute_value

        other_schema = other_schema_class.new
        other_schema.some_attribute = SecureRandom.hex

        test "Not Equivalent" do
          refute(schema.hash == other_schema.hash)
        end

        test "Schemas instances are not equal when hash codes are not equal" do
          refute(schema.eql?(other_schema))
        end
      end
    end
  end
end
