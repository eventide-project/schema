require_relative '../automated_init'

context "Incorrect Attribute Definition" do
  context "Strict without type" do
    test "Incorrect" do
      assert_raises Schema::Attribute::Error do
        Class.new do
          include ::Schema
          attribute :some_attribute, strict: true
        end
      end
    end
  end
end
