## Failing, Scott Mon Jul 6 2020

require_relative '../../automated_init'

context "Difference" do
  context "Classes" do
    context "Schema Classes Are Different" do
      control = Schema::Controls::Schema.example
      compare = Schema::Controls::Schema.other_example

      difference = Schema::Compare::Difference.build(control, compare)

      test "Schemas are different" do
        assert(difference.different?)
      end
    end

    context "Schema Classes Are the Same" do
      control = Schema::Controls::Schema.example
      compare = Schema::Controls::Schema.example

      difference = Schema::Compare::Difference.build(control, compare)

      test "Schemas are the same" do
        assert(difference.same?)
      end
    end
  end
end
