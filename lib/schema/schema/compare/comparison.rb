module Schema
  module Compare
    class Comparison
      include Initializer

      Error = Class.new(RuntimeError)

      def entries_attribute_names
        entries.map { |entry| entry.control_name }
      end
      alias :attribute_names :entries_attribute_names

      initializer :control_class, :compare_class, :entries

      def self.build(control, compare, attribute_names=nil)
        assure_schemas(control, compare)

        attribute_names ||= control.class.attribute_names

        if not attribute_names.is_a?(Array)
          attribute_names = [attribute_names]
        end

        entries = build_entries(control, compare, attribute_names)

        new(control.class, compare.class, entries)
      end

      def self.assure_schemas(control, compare)
        if not control.is_a?(Schema)
          raise Error, "Control object is not an implementation of Schema (Control Class: #{control.class.name})"
        end

        if not compare.is_a?(Schema)
          raise Error, "Compare object is not an implementation of Schema (Compare Class: #{compare.class.name})"
        end
      end

      def self.build_entries(control, compare, attribute_names)
        attribute_names.map do |attribute_name|
          if attribute_name.is_a?(Hash)
            control_name, compare_name = attribute_name.keys.first, attribute_name.values.first
          else
            control_name, compare_name = attribute_name, attribute_name
          end

          build_entry(control_name, control, compare_name, compare)
        end
      end

      def self.build_entry(control_name, control, compare_name, compare)
        control_class = control.class
        if not control_class.all_attribute_names.include?(control_name)
          raise Error, "Attribute is not defined (Attribute Name: #{control_name.inspect}, Schema Class: #{control_class})"
        end

        compare_class = compare.class
        if not compare_class.all_attribute_names.include?(compare_name)
          raise Error, "Attribute is not defined (Attribute Name: #{compare_name.inspect}, Schema Class: #{compare_class})"
        end

        control_value = control.public_send(control_name)
        compare_value = compare.public_send(compare_name)

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
          raise Error, "No attribute difference entry (Attribute Name: #{attribute_name.inspect})"
        end

        entry.different?
      end
    end
  end
end
