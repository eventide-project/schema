require_relative '../../bench_init'

context "Equality Assertion" do
  example_1 = Schema::Controls::Schema.example
  example_2 = Schema::Controls::Schema.example

  example_2.some_other_attribute = SecureRandom.hex

  refute(example_1.some_other_attribute == example_2.some_other_attribute)

  context "Specified attributes are equal" do
    test "Schemas are equal" do
      assert example_1 do
        attributes_equal? example_2, :some_attribute
      end
    end
  end

  context "Specified attributes are not equal" do
    test "Schemas are not equal" do
      refute example_1 do
        attributes_equal? example_2, :some_other_attribute
      end
    end
  end
end
