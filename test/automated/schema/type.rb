require_relative '../automated_init'

context "Schema" do
  context "Type" do
    example = Schema::Controls::Schema.example

    type = example.class.type

    test "Class name without the namespace" do
      assert(type == example.class.name.split('::').last)
    end
  end
end
