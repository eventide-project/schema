require_relative '../automated_init'

context "Schema" do
  context "Export" do
    data_structure = Schema::Controls::DataStructure::ImportAndExport.example

    refute(data_structure.some_attribute == 'some exported value')

    data = data_structure.to_h

    test "The output data has been intercepted and modified" do
      assert(data[:some_attribute] == 'some exported value')
    end
  end
end
