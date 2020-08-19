require_relative '../../automated_init'

context "Equality" do
  context "Class is ignored" do
    context "Classes are not equal" do
      context "Attributes are the same" do
        control = Schema::Controls::Schema.example
        compare = Schema::Controls::Schema.other_example

        test "Schemas are equal" do
          assert(control.eql?(compare, ignore_class: true))
        end
      end

      context "Attributes have different values" do
        control = Schema::Controls::Schema.example
        compare = Schema::Controls::Schema.other_example

        compare.some_attribute = Schema::Controls::Random.example

        test "Schemas are not equal" do
          refute(control.eql?(compare, ignore_class: true))
        end
      end

      context "Attributes are different" do
        control = Schema::Controls::Schema.example
        compare = Schema::Controls::Schema::Random.example

        test "Is an error" do
          assert_raises(Schema::Compare::Comparison::Error) do
            control.eql?(compare, ignore_class: true)
          end
        end
      end
    end
  end
end
