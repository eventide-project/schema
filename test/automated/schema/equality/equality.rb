require_relative '../../automated_init'

context "Equality" do
  context "Whole Object" do
    context "Equal" do
      context "Attributes and values are equal and classes are equal" do
        control = Schema::Controls::Schema.example
        compare = Schema::Controls::Schema.example

        test "Schemas are equal" do
          assert(control == compare)
        end
      end
    end

    context "Not Equal" do
      control = Schema::Controls::Schema.example

      context "Attributes and values are not equal and classes are equal" do
        compare = Schema::Controls::Schema.example
        compare.some_attribute = 'some other value'

        test "Schemas are not equal" do
          refute(control == compare)
        end
      end

      context "Attributes and values are equal and classes are not equal" do
        compare = Schema::Controls::Schema.other_example

        test "Schemas are not equal" do
          refute(control == compare)
        end
      end

      context "Attributes are different and classes are not equal" do
        compare = Schema::Controls::Schema::Random.example

        test "Schemas are not equal" do
          refute(control == compare)
        end
      end
    end
  end
end
