module Schema
  module DataStructure
    def self.included(cls)
      cls.send :include, Schema
      cls.extend Build
    end

    module Build
      def build(data=nil)
        data ||= {}
        new.tap do |instance|
          set_attributes(instance, data)
        end
      end

      def set_attributes(instance, data)
        SetAttributes.! instance, data
      end
    end
  end
end
