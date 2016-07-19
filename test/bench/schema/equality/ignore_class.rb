require_relative '../../bench_init'

context "Equality" do
  example_1 = Schema::Controls::Schema.example

  context "Not Equal" do
    context "Class is ignored" do
      example_2 = Schema::Controls::Schema.other_example

      test "Schemas are equal" do
        assert(example_1.eql?(example_2, ignore_class: true))
      end
    end
  end
end
