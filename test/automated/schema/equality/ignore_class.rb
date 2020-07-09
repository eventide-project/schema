require_relative '../../automated_init'

context "Equality" do
  context "Class is ignored" do
    context "Classes are not equal" do
      control = Schema::Controls::Schema.example
      compare = Schema::Controls::Schema.other_example

      test "Schemas are equal" do
        assert(control.eql?(compare, ignore_class: true))
      end
    end
  end
end
