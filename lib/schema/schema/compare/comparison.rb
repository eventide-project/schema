module Schema
  module Compare
    class Comparison
      include Initializer

      Error = Class.new(RuntimeError)

      def attribute_names
        entries.map { |entry| entry.control_name }
      end

      initializer :control_class, :compare_class, :entries

      def self.build(control, compare, attribute_names=nil)
        control_attributes = control.attributes
        compare_attributes = compare.attributes

        attribute_names ||= control_attributes.keys

        entries = attribute_names.map do |attribute_name|
          build_entry(attribute_name, control_attributes, attribute_name, compare_attributes)
        end

        new(control.class, compare.class, entries)
      end

      def self.build_entry(control_name, control_attributes, compare_name, compare_attributes)
        control_value = control_attributes[control_name]
        compare_value = compare_attributes[compare_name]

        entry = Entry.new(
          control_name,
          control_value,
          compare_name,
          compare_value
        )

        entry
      end

      def entry(attribute_name)
        entries.find do |entry|
          entry.control_name == attribute_name
        end
      end
      alias :[] :entry

      def different?(attribute_name=nil, ignore_class: nil)
        if not attribute_name.nil?
          return attribute_different?(attribute_name)
        end

        ignore_class ||= false

        if not ignore_class
          return true if classes_different?
        end

        attribute_names.each do |attribute_name|
          return true if attribute_different?(attribute_name)
        end

        false
      end

      def classes_different?
        control_class != compare_class
      end

      def attribute_different?(attribute_name)
        entry = self[attribute_name]

        if entry.nil?
          raise Error, "No attribute difference entry for #{attribute_name.inspect}"
        end

        entry.different?
      end
    end
  end
end
