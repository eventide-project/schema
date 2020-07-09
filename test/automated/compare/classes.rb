require_relative '../automated_init'

context "Compare" do
  context "Classes" do
    context "Different" do
      control = Schema::Controls::Schema.example
      compare = Schema::Controls::Schema.other_example

      refute(control.class == compare.class)

      comparison = Schema::Compare.(control, compare)

      test "Schemas are different" do
        assert(comparison.different?)
      end
    end

    context "Same" do
      control = Schema::Controls::Schema.example
      compare = Schema::Controls::Schema.example

      assert(control.class == compare.class)

      comparison = Schema::Compare.(control, compare)

      test "Schemas are not different" do
        refute(comparison.different?)
      end
    end
  end
end
