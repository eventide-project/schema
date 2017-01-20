require_relative '../../automated_init'

context "Attribute Definition" do
  example = Schema::Controls::Schema::Example.new

  test "Creates a reader" do
    assert(example.respond_to? :some_attribute)
  end

  test "Creates a writer" do
    assert(example.respond_to? :some_attribute=)
  end

  test "Attribute can be written and read" do
    example.some_attribute = 'some value'
    assert(example.some_attribute == 'some value')
  end
end
