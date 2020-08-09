require_relative '../../../automated_init'

context "Attributes List" do
  context "Instance" do
    context "Non-Transient" do
      example = Schema::Controls::Schema::TransientAttributes.example

      attributes = example.attributes

      attribute_names = Schema::Controls::Schema::TransientAttributes::Example.attribute_names

      detail "Attributes: #{attributes.inspect}"
      detail "Attributes Names: #{attribute_names.inspect}"

      attribute_names.each do |attribute|
        context "#{attribute}" do
          test "Included" do
            assert(attributes.keys.include?(attribute))
          end
        end
      end
    end
  end
end
