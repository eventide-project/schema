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

        virtual :transform_read do |data|
          transform_in(data)
        end
        virtual :transform_in
      end
    end

    module Build
      def build(data=nil, strict=nil)
        data ||= {}
        strict ||= false

        new.tap do |instance|
          instance.transform_read(data)
          set_attributes(instance, data, strict)
          instance.configure_dependencies
        end
      end

      def set_attributes(instance, data, strict)
        begin
          SetAttributes.(instance, data, strict: strict)
        rescue SetAttributes::Assign::Error => e
          raise Schema::Error, e.message
        end
      end
    end

    def deep_copy
      data = to_h
      self.class.build(data)
    end
    alias :dup :deep_copy

    def clone
      duplicate = deep_copy

      if frozen?
        duplicate.freeze
      end

      duplicate
    end
  end
end
