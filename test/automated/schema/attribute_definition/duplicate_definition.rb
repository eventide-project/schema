require_relative '../../automated_init'

context "Duplicate Attribute Definition" do
  example = Schema::Controls::Schema::Duplicate.example

  test "Only one attribute definition is retained" do
    assert(example.class.attributes.count == 1)
  end

  test "The last attribute defined is authoritative" do
    attribute = example.class.attributes.attribute(:some_attribute)
    assert(attribute.type == String)
  end
end
