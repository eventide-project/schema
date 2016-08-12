module Schema
  module Assertions
    def attributes_equal?(other, attributes=nil, print: nil)
      attributes ||= self.class.attribute_names

      print = true if print.nil?
      print ||= false

      equal = self.eql?(other, attributes, ignore_class: true)

      if !equal && print
        attributes = Array(attributes)

        require 'pp'
        puts "self: #{self.class.name}"
        pp self.attributes.select { |k, v| attributes.include? k }
        puts "other #{other.class.name}:"
        pp other.attributes.select { |k, v| attributes.include? k }
        puts "attributes:"
        attributes.each { |a| puts a.inspect}
      end

      equal
    end
  end
end
