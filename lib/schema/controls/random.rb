module Schema
  module Controls
    module Random
      def self.example
        SecureRandom.hex
      end
    end
  end
end
