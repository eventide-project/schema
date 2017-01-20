require_relative '../automated_init'

context "Data Structure" do
  context "Strictness" do
    context "Hash with extra attributes" do
      context "Not Strict (Default)" do
        data = Schema::Controls::DataStructure::ExtraAttributes.data
        data_structure = Schema::Controls::DataStructure::Example.build(data)

        test "Sets matching attributes" do
          assert(data_structure.some_attribute == 'some value')
        end
      end

      context "Strict" do
        data = Schema::Controls::DataStructure::ExtraAttributes.data

        test "Is incorrect" do
          assert proc { Schema::Controls::DataStructure::Example.build(data, strict=true) } do
            raises_error? Schema::Error
          end
        end
      end
    end
  end
end
