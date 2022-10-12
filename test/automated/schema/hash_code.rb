require_relative '../automated_init'

context "Schema" do
  context "Hash Code" do
    example = Schema::Controls::Schema.example

    attributes = example.raw_attributes
    control_hash_code = attributes.hash

    hash_code = example.hash

    test "Is the hash code of the raw attributes" do
      assert(hash_code == control_hash_code)
    end
  end
end
