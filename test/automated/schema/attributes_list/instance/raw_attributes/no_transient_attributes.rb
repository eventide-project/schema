require_relative '../../../../automated_init'

context "Attributes List" do
  context "Instance" do
    context "Raw Attributes" do
      context "Has No Transient Attributes" do
        example = Schema::Controls::Schema.example

        raw_attributes = example.raw_attributes

        all_attribute_names = example.class.all_attribute_names

        detail "Raw Attributes: #{raw_attributes.inspect}"
        detail "Attributes Names: #{all_attribute_names.inspect}"

        all_attribute_names.each do |attribute|
          context "#{attribute}" do
            test "Included" do
              assert(raw_attributes.keys.include?(attribute))
            end
          end
        end
      end
    end
  end
end
