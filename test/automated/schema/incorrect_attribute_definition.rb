require_relative '../automated_init'

context "Incorrect Attribute Definition" do
  context "Strict without type" do
    test "Incorrect" do
      incorrect_attribute_definition = proc do
        Class.new do
          include ::Schema
          attribute :some_attribute, strict: true
        end
      end

      assert incorrect_attribute_definition do
        raises_error? Schema::Attribute::Error
      end
    end
  end
end
