module Schema
  class Attribute
    class TypeError < Schema::Error; end

    attr_reader :name
    attr_reader :type
    attr_reader :strict

    def initialize(name, type, strict)
      @name = name
      @type = type
      @strict = strict
    end
  end
end
