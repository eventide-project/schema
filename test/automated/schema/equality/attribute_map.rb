require_relative '../../automated_init'

context "Equality" do
  context "Attribute Map (Classes are Ignored)" do
    context "Equal" do
      context "Attributes and mapped attributes and values are equal" do
        example_1 = Schema::Controls::Schema.example
        example_2 = Schema::Controls::Schema::Equivalent.example

        test "Schemas are equal" do
          assert(example_1.eql?(example_2,
            [
              :some_attribute,
              { some_other_attribute: :yet_another_attribute }
            ],
            ignore_class: true
          ))
        end
      end
    end

    context "Not Equal" do
      context "Attributes and mapped attributes and values are not equal" do
        example_1 = Schema::Controls::Schema.example
        example_2 = Schema::Controls::Schema::Equivalent.example

        example_2.yet_another_attribute = Schema::Controls::Attribute::Value.random

        test "Schemas are equal" do
          refute(example_1.eql?(example_2,
            [
              :some_attribute,
              { some_other_attribute: :yet_another_attribute }
            ],
            ignore_class: true
          ))
        end
      end
    end
  end
end
