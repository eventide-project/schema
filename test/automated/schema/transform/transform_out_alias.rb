require_relative '../../automated_init'

context "Schema" do
  context "Transform Out Alias" do
    data_structure = Schema::Controls::DataStructure::ReadAndWrite.example

    refute(data_structure.some_attribute == 'some written value')

    data = data_structure.to_h

    test "The output data has been intercepted and modified" do
      assert(data[:some_attribute] == 'some written value')
    end
  end
end
