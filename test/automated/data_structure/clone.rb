require_relative '../automated_init'

context "Data Structure" do
  context "Clone" do
    context "Shallow Copy" do
      data_structure = Schema::Controls::DataStructure.example

      duplicate = data_structure.clone

      data_structure.some_attribute = Schema::Controls::Attribute::Value.random

      test "Duplicate is not the same object as the original" do
        refute(duplicate.object_id == data_structure.object_id)
      end

      test "Attribute references are different" do
        refute(duplicate.some_attribute == data_structure.some_attribute)
      end
    end

    context "Deep Copy Via Transformation" do
      data = Schema::Controls::DataStructure.hash

      refute(data[:some_attribute] == 'some read value')

      data_structure = Schema::Controls::DataStructure::ReadAndWrite::Example.build(data)

      duplicate = data_structure.clone

      test "Duplicate is not the same object as the original" do
        refute(duplicate.object_id == data_structure.object_id)
      end

      test "Attributes are transformed" do
        refute(duplicate.some_attribute.object_id == data_structure.some_attribute.object_id)
      end
    end

    context "Frozen" do
      context "Frozen Data Structure" do
        data_structure = Schema::Controls::DataStructure.example

        data_structure.freeze

        duplicate = data_structure.clone

        test "Duplicate is frozen" do
          assert(duplicate.frozen?)
        end
      end

      context "Not Frozen" do
        data_structure = Schema::Controls::DataStructure.example

        duplicate = data_structure.clone

        test "Duplicate is not frozen" do
          refute(duplicate.frozen?)
        end
      end
    end
  end
end
