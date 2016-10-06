require_relative '../bench_init'

context "Schema" do
  context "Validation" do
    context "Nil Attributes" do
      schema = Controls::Schema::Validation.example

      errors = []
      valid = Validate.(schema, errors, scenario: :nil_attributes)

      test "Is invalid" do
        refute(valid)
      end

      test "An error is recorded for each attribute" do
        assert(errors == Controls::Schema::Validation.errors)
      end
    end
  end
end
