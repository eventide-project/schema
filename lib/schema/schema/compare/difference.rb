module Schema
  module Compare
    class Difference
      include Initializer

      Entry = Struct.new(
        :control_name,
        :control_value,
        :compare_name,
        :compare_value
      )

      def attribute_differences
        @attribute_differences ||= []
      end

      # initializer :control_class, :control_attributes, :compare_class, :compare_attributes
      initializer :control_class, :compare_class

      def self.build(control, compare)
        # new(control.class, control.attributes, compare.class, compare.attributes)
        new(control.class, compare.class)
      end

      def same?
        if not classes_same?
          return false
        end

        # control_attributes == compare_attributes
        true
      end

      def classes_same?
        control_class == compare_class

        ## attribute lists must also be same
      end

      def different?
        not same?
      end
    end
  end
end
