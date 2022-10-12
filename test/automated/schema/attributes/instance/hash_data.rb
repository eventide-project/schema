require_relative '../../../automated_init'

context "Attributes" do
  context "Instance" do
    context "Hash Data" do
      example = Schema::Controls::Schema::TransientAttributes.example

      attributes = example.attributes
      hash_data = example.to_h

      test "Hash data is the same as the attributes" do
        assert(hash_data == attributes)
      end
    end
  end
end
