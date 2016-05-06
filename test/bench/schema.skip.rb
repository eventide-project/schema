require_relative 'bench_init'

context "Schema" do
  test "is a Virtus object" do
    ancestors = Schema::Controls::Schema.ancestors
    assert(ancestors.include? Virtus::Model::Core)
  end

  test "has attributes" do
    attributes = Schema::Controls::Schema.attributes
    assert(attributes == { some_attribute: 'some value' })
  end

  test "hash of the object is the same as its attributes" do
    attributes = Schema::Controls::Schema.attributes
    hash = Schema::Controls::Schema.hash
    assert(hash == attributes)
  end

  test "cannot be assigned attributes" do
    example = Schema::Controls::Schema.example

    begin
      example.attributes = :something
    rescue NoMethodError => error
    end

    assert error
  end
end
