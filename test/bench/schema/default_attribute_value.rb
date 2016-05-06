require_relative '../bench_init'

context "Default Attribute Value" do
  context "Attribute With Default Value Declaration" do
    example = Schema::Controls::Schema::DefaultValue::Example.new

    test "Has a default value" do
      assert(example.some_attribute == 'some default value')
    end
  end

  context "Attribute Without Default Value Declaration" do
    example = Schema::Controls::Schema::Example.new

    test "Has a default value" do
      assert(example.some_attribute.nil?)
    end
  end
end
