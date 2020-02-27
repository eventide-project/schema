require_relative '../automated_init'

context "Compare" do
  context "Not Schema Error" do
    schema = Schema::Controls::Schema.example
    some_object = Object.new

    context "Control Is Not a Schema" do
      test "Is an error" do
        assert_raises(Schema::Compare::Error) do
          Schema::Compare.(some_object, schema)
        end
      end
    end

    context "Compare Is Not a Schema" do
      test "Is an error" do
        assert_raises(Schema::Compare::Error) do
          Schema::Compare.(schema, some_object)
        end
      end
    end
  end
end
