require_relative '../automated_init'

context "Data Structure" do
  context "Build" do
    data = Schema::Controls::DataStructure.hash

    refute(data[:some_attribute] == 'some imported value')

    data_structure = Schema::Controls::DataStructure::ImportAndExport::Example.build(data)

    test "The input data has been intercepted and modified" do
      assert(data_structure.some_attribute == 'some imported value')
    end
  end
end
