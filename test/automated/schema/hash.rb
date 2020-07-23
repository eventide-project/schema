require_relative '../automated_init'

context "Attributes List" do
  context "Instance" do
    context "Hash" do
      example = Schema::Controls::Schema::TransientAttributes.example

      attributes = example.attributes
      hash = example.to_h

      test "Hash of object is the same as its attributes" do
        assert(example.to_h == attributes)
      end
    end
  end
end
