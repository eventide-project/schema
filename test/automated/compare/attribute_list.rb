require_relative '../automated_init'

context "Compare" do
  context "Attribute List" do
    control = Schema::Controls::Schema.example
    compare = Schema::Controls::Schema.example

    compare.some_other_attribute = Schema::Controls::Attribute::Value.random

    assert(control.some_attribute == compare.some_attribute)
    refute(control.some_other_attribute == compare.some_other_attribute)

    context "Different" do
      comparison = Schema::Compare.(control, compare, [:some_other_attribute])

      test "Schemas are different" do
        assert(comparison.different?)
      end
    end

    context "Same" do
      comparison = Schema::Compare.(control, compare, [:some_attribute])

      test "Schemas are not different" do
        refute(comparison.different?)
      end
    end
  end
end
