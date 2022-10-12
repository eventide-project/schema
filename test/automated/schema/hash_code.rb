require_relative '../automated_init'

context "Schema" do
  context "Hash Code" do
    example = Schema::Controls::Schema.example

    attributes = example.raw_attributes
    schema_class = example.class
    control_hash_code = [schema_class, attributes].hash

    hash_code = example.hash

    test "Is the hash code of the class and raw attributes" do
      assert(hash_code == control_hash_code)
    end
  end
end
