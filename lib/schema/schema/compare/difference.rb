module Schema
  module Compare
    class Difference
      include Initializer

      # initializer :control_class, :compare_class, :attributes

      # def self.build(control, compare)
      #   # attribute_differences = ...

      #   new(control.class, compare.class, attribute_differences)
      # end


      initializer :control_class, :control_attributes, :compare_class, :compare_attributes

      def self.build(control, compare)
        new(control.class, control.attributes, compare.class, compare.attributes)
      end

      def same?
        if not classes_same?
          return false
        end

        control_attributes == compare_attributes
      end

      def classes_same?
        control_class == compare_class
      end

      def different?
        not same?
      end
    end
  end
end
