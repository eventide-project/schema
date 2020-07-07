require_relative '../../../automated_init'

context "Compare" do
  context "Comparison" do
    context "Detection" do
      context "Mapped Attribute Names" do
        context "Difference" do
          comparison = Schema::Controls::Comparison::Different::Mapped.example

          attr_name = Schema::Controls::Comparison::Different::Mapped::Entry.control_attr_name
          different = comparison.different?(attr_name)

          test "Detected" do
            assert(different)
          end
        end

        context "No Difference" do
          comparison = Schema::Controls::Comparison::Same::Mapped.example

          attr_name = Schema::Controls::Comparison::Same::Mapped::Entry.control_attr_name
          different = comparison.different?(attr_name)

          test "Not Detected" do
            refute(different)
          end
        end
      end
    end
  end
end
