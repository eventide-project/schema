module Schema
  module DataStructure
    def self.included(cls)
      cls.class_exec do
        include Virtual
        include Schema
        extend Build

        virtual :configure
        virtual :configure_dependencies do
          configure
        end
        virtual :import
        virtual :export
      end
    end

    module Build
      def build(data=nil, strict=nil)
        data ||= {}
        strict ||= false

        new.tap do |instance|
          instance.import(data)
          set_attributes(instance, data, strict)
          instance.configure_dependencies
        end
      end

      def set_attributes(instance, data, strict)
        begin
          SetAttributes.(instance, data, strict: strict)
        rescue SetAttributes::Attribute::Error => e
          raise Schema::Error, e.message
        end
      end
    end
  end
end
