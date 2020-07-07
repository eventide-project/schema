require_relative '../automated_init'

context "Compare" do
  context "Schema Attributes Differ" do
    control = Schema::Controls::Schema.example
    compare = Schema::Controls::Schema.example

    compare.some_other_attribute = Schema::Controls::Attribute::Value::Random.example

    refute(control.some_other_attribute == compare.some_other_attribute)

    difference = Schema::Compare.(control, compare)

    test "Schemas are different" do
      assert(difference.different?)
    end
  end

  context "Schema Attributes Do Not Differ" do
    control = Schema::Controls::Schema.example
    compare = Schema::Controls::Schema.example

    difference = Schema::Compare.(control, compare)

    test "Schemas are same" do
      assert(difference.same?)
    end
  end
end
