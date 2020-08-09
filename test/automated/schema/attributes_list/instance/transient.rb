require_relative '../../../automated_init'

context "Attributes List" do
  context "Instance" do
    context "Transient" do
      example = Schema::Controls::Schema::TransientAttributes.example

      attributes = example.attributes

      transient_attributes = Schema::Controls::Schema::TransientAttributes::Example.transient_attributes

      detail "Attributes: #{attributes.inspect}"
      detail "Transient Attributes: #{transient_attributes.inspect}"

      transient_attributes.each do |attribute|
        context "#{attribute}" do
          test "Excluded" do
            refute(attributes.keys.include?(attribute))
          end
        end
      end
    end
  end
end
