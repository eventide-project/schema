module Schema
  module DataStructure
    def self.included(cls)
      cls.send :include, Schema
      cls.extend Virtual::Macro
      cls.virtual :configure_dependencies
      cls.extend Build
    end

    module Build
      def build(data=nil)
        data ||= {}
        new.tap do |instance|
          set_attributes(instance, data)
          instance.configure_dependencies
        end
      end

      def set_attributes(instance, data)
        SetAttributes.(instance, data)
      end
    end
  end
end
