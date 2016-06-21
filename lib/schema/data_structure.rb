module Schema
  module DataStructure
    def self.included(cls)
      cls.class_exec do
        include Schema
        extend Build
        extend Virtual::Macro

        virtual :configure
        virtual :configure_dependencies do
          configure
        end
      end
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
