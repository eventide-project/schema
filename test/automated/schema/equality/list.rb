require_relative '../../automated_init'

context "Equality" do
  context "List" do
    control = Schema::Controls::Schema.example
    compare = Schema::Controls::Schema.example

    compare.some_other_attribute = Schema::Controls::Attribute::Value.random

    refute(control.some_other_attribute == compare.some_other_attribute)

    context "Equal" do
      context "Specified attributes are equal" do
        test "Schemas are equal" do
          assert(control.eql?(compare, :some_attribute))
        end
      end
    end

    context "Not Equal" do
      context "Specified attributes are not equal" do
        test "Schemas are not equal" do
          refute(control.eql?(compare, :some_other_attribute))
        end
      end
    end
  end
end
