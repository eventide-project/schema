module Schema
  class Attribute
    class Error < Schema::Error; end
    class TypeError < Schema::Attribute::Error; end

    attr_reader :name
    attr_reader :type

    def initialize(name, type)
      @name = name
      @type = type
    end
  end
end
