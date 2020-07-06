require_relative '../../../automated_init'

_context "Compare" do
  context "Attributes" do
    context "Attribute Differences" do
      context "Compare" do
        attr_names = Schema::Controls::Attribute.names
        control_values = Schema::Controls::Attribute.control_values
        compare_values = Schema::Controls::Attribute.compare_values
      end
    end
  end
end


__END__
        attr_names = Schema::Controls::Attribute.names
        control_values = Schema::Controls::Attribute.control_values
        compare_values = Schema::Controls::Attribute.compare_values
