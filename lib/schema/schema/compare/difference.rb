module Schema
  module Compare
    class Difference
      # attr_reader :control
      # attr_reader :compare

      # def control_class
      #   control.class
      # end

      # def compare_class
      #   compare.class
      # end

      # def initialize(control, compare)
      #   @control = control
      #   @compare = compare
      # end

      include Initializer

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
