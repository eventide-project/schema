require_relative '../../automated_init'

context "Equality" do
  context "Attribute Map (Classes are Ignored)" do
    context "Equal" do
      context "Attributes and mapped attributes and values are equal" do
        control = Schema::Controls::Schema.example
        compare = Schema::Controls::Schema::Equivalent.example

        list = [
          :some_attribute,
          { :some_other_attribute => :yet_another_attribute }
        ]

        equal = control.eql?(compare, list, ignore_class: true)

        test "Schemas are equal" do
          assert(equal)
        end
      end
    end

    context "Not Equal" do
      context "Attributes and mapped attributes and values are not equal" do
        control = Schema::Controls::Schema.example
        compare = Schema::Controls::Schema::Equivalent.example

        compare.yet_another_attribute = Schema::Controls::Attribute::Value.random

        list = [
          :some_attribute,
          { :some_other_attribute => :yet_another_attribute }
        ]

        equal = control.eql?(compare, list, ignore_class: true)

        test "Schemas are equal" do
          refute(equal)
        end
      end
    end
  end
end
