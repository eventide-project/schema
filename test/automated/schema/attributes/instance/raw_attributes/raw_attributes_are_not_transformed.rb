require_relative '../../../../automated_init'

context "Attributes List" do
  context "Instance" do
    context "Raw Attributes" do
      context "Raw Attributes Are Not Transformed" do
        data_structure = Schema::Controls::DataStructure::ReadAndWrite.example

        data = data_structure.raw_attributes

        test do
          refute(data_structure.some_attribute == 'some written value')
        end

        test do
          assert(data[:some_attribute] == 'some value')
        end
      end
    end
  end
end
