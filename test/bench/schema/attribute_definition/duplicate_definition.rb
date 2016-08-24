require_relative '../../bench_init'

context "Duplicate Attribute Definition" do
  example = Schema::Controls::Schema::Duplicate.example

  test "The last attribute defined is authoritative" do
    assert(example.class.attributes.count == 1)
  end
end
