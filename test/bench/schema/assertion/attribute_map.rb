require_relative '../../bench_init'

context "Equality Assertion" do
  context "Attribute Map" do
    context "Equal" do
      context "Specified attributes are equal" do
        example_1 = Schema::Controls::Schema.example
        example_2 = Schema::Controls::Schema::Equivalent.example

        assert(example_1.some_other_attribute == example_2.yet_another_attribute)

        test "Schemas are equal" do
          assert example_1 do
            attributes_equal? example_2, [
              :some_attribute,
              {some_other_attribute: :yet_another_attribute}
            ]
          end
        end
      end
    end

    context "Not Equal" do
      context "Specified attributes are not equal" do
        example_1 = Schema::Controls::Schema.example
        example_2 = Schema::Controls::Schema::Equivalent.example

        example_2.yet_another_attribute = SecureRandom.hex

        refute(example_1.some_other_attribute == example_2.yet_another_attribute)

        test "Schemas are equal" do
          refute example_1 do
            attributes_equal? example_2, [
              :some_attribute,
              {some_other_attribute: :yet_another_attribute}
            ]
          end
        end
      end
    end
  end
end
