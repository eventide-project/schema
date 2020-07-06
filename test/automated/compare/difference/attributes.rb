## Failing, Scott Mon Jul 6 2020

require_relative '../../automated_init'

context "Compare" do
  context "Attributes" do
    context "Schema Attributes Differ" do
      control = Schema::Controls::Schema.example
      compare = Schema::Controls::Schema.example

      compare.some_other_attribute = SecureRandom.hex

      difference = Schema::Compare::Difference.build(control, compare)

      test "Schemas are different" do
        assert(difference.different?)
      end
    end

    context "Schema Attributes Do Not Differ" do
      control = Schema::Controls::Schema.example
      compare = Schema::Controls::Schema.example

      difference = Schema::Compare::Difference.build(control, compare)

      test "Schemas are same" do
        assert(difference.same?)
      end
    end
  end
end
