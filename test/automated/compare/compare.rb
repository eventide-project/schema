require_relative '../automated_init'

context "Compare" do
  context "Schema Attributes Differ" do
    schema_1 = Schema::Controls::Schema.example
    schema_2 = Schema::Controls::Schema.example

    schema_2.some_other_attribute = SecureRandom.hex

    refute(schema_1.some_other_attribute == schema_2.some_other_attribute)

    difference = Schema::Compare.(schema_1, schema_2)

    test "Difference is determined" do
      refute(difference.nil?)
    end
  end
end
