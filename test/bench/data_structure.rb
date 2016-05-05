require_relative 'bench_init'

context "Data Structure" do
  test "Is a Schema object" do
    ancestors = Schema::Controls::DataStructure.ancestors
    assert(ancestors.include? Schema)
  end

  test "Can be built from a hash" do
    data = Schema::Controls::DataStructure.hash
    data_structure = Schema::Controls::DataStructure::Example.build data
    assert(data_structure.some_attribute == 'some value')
  end

  test "Can configure its dependencies" do
    example = Schema::Controls::DataStructure.configure_dependencies_example
    assert(example.some_dependency = :set)
  end
end
