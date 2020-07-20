require_relative '../../automated_init'

context "Schema" do
  context "Default Attribute Value" do
    context "Attribute With Default Value Declaration" do
      context "Primitive Value" do
        context do
          example = Schema::Controls::Schema::DefaultValue::Example.new

          test "Has a default value" do
            assert(example.some_attribute == 'some default value')
          end
        end

        context do
          example_1 = Schema::Controls::Schema::DefaultValue::Example.new
          example_2 = Schema::Controls::Schema::DefaultValue::Example.new

          same_object = example_1.some_attribute.object_id == example_2.some_attribute.object_id

          test "Not a shared object reference" do
            assert(same_object)
          end
        end
      end

      context "Default Value Is an Object Reference" do
        example = Schema::Controls::Schema::DefaultValue::Proc::Example.new

        test "Has a default value set by executing proc" do
          assert(example.some_attribute == 'some default value')
        end
      end
    end
  end
end
