require_relative '../../automated_init'

context "Data Structure" do
  context "Build" do
    context "From Empty Hash" do
      test "Data is not transformed" do
        refute_raises Schema::Controls::DataStructure::TransformReadFail::Error do
          Schema::Controls::DataStructure::TransformReadFail::Example.build
        end
      end
    end
  end
end
