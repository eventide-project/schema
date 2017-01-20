require_relative '../automated_init'

context "Data Structure" do
  context "Build" do
    data = Schema::Controls::DataStructure.hash
    data_structure = Schema::Controls::DataStructure::Example.build data

    test "Hash values are the attributes' values" do
      assert(data_structure.some_attribute == 'some value')
    end
  end
end
