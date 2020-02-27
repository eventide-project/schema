require_relative '../automated_init'

context "Schema" do
  context "Validation" do
    context "Nil Attributes" do
      schema = Schema::Controls::Schema::Validation.example

      errors = []
      valid = Validate.(schema, errors, scenario: :nil_attributes)

      test "Is invalid" do
        refute(valid)
      end

      test "An error is recorded for each attribute" do
        assert(errors == Schema::Controls::Schema::Validation.errors)
      end
    end
  end
end
