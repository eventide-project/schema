require_relative '../../../../automated_init'

context "Attributes" do
  context "Instance" do
    context "All Attributes" do
      context "Has Transient Attributes" do
        example = Schema::Controls::Schema::TransientAttributes.example

        attributes = example.all_attributes

        attribute_names = example.class.all_attribute_names

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
end
