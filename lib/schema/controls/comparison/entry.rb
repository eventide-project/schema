module Schema
  module Controls
    module Comparison
      module Entry
        def self.example
          SomeAttribute.example
        end

        module SomeAttribute
          def self.example
            ::Schema::Compare::Comparison::Entry.new(
              self.control_attribute_name,
              self.control_value,
              self.compare_attribute_name,
              self.compare_value
            )
          end

          def self.control_attribute_name
            Attribute::Name.some_attribute
          end

          def self.control_value
            Attribute::Value.some_attribute
          end

          def self.compare_attribute_name
            Attribute::Name.some_attribute
          end

          def self.compare_value
            Attribute::Value.some_attribute
          end
        end

        module SomeOtherAttribute
          def self.example
            Same.example
          end

          def self.control_attribute_name
            Same.some_other_attribute
          end

          def self.control_value
            Same.some_other_attribute
          end

          def self.compare_attribute_name
            Same.some_other_attribute
          end

          def self.compare_value
            Same.some_other_attribute
          end

          module Same
            def self.example
              ::Schema::Compare::Comparison::Entry.new(
                self.control_attribute_name,
                self.control_value,
                self.compare_attribute_name,
                self.compare_value
              )
            end

            def self.control_attribute_name
              Attribute::Name.some_other_attribute
            end

            def self.control_value
              Attribute::Value.some_other_attribute
            end

            def self.compare_attribute_name
              Attribute::Name.some_other_attribute
            end

            def self.compare_value
              Attribute::Value.some_other_attribute
            end
          end

          module Different
            def self.example
              ::Schema::Compare::Comparison::Entry.new(
                self.control_attribute_name,
                self.control_value,
                self.compare_attribute_name,
                self.compare_value
              )
            end

            def self.control_attribute_name
              Attribute::Name.some_other_attribute
            end

            def self.control_value
              Attribute::Value.some_other_attribute
            end

            def self.compare_attribute_name
              Attribute::Name.some_other_attribute
            end

            def self.compare_value
              Attribute::Value::Alternate.example
            end
          end

          module Mapped
            def self.example
              SameValues.example
            end

            def self.control_attribute_name
              SameValues.some_other_attribute
            end

            def self.control_value
              SameValues.some_other_attribute
            end

            def self.compare_attribute_name
              SameValues.some_other_attribute
            end

            def self.compare_value
              SameValues.some_other_attribute
            end

            module SameValues
              def self.example
                ::Schema::Compare::Comparison::Entry.new(
                  self.control_attribute_name,
                  self.control_value,
                  self.compare_attribute_name,
                  self.compare_value
                )
              end

              def self.control_attribute_name
                Attribute::Name.some_other_attribute
              end

              def self.control_value
                Attribute::Value.some_other_attribute
              end

              def self.compare_attribute_name
                Attribute::Name.yet_another_attribute
              end

              def self.compare_value
                Attribute::Value.some_other_attribute
              end
            end

            module DifferentValues
              def self.example
                ::Schema::Compare::Comparison::Entry.new(
                  self.control_attribute_name,
                  self.control_value,
                  self.compare_attribute_name,
                  self.compare_value
                )
              end

              def self.control_attribute_name
                Attribute::Name.some_other_attribute
              end

              def self.control_value
                Attribute::Value.some_other_attribute
              end

              def self.compare_attribute_name
                Attribute::Name.yet_another_attribute
              end

              def self.compare_value
                Attribute::Value::Alternate.example
              end
            end
          end
        end

        Same = SomeAttribute

        Different = SomeOtherAttribute::Different

        Mapped = SomeOtherAttribute::Mapped
      end
    end
  end
end

__END__

A namespace with "Different" means different values
A namespace with "Mapped" means different names
A namespace with neither "Different" nor "Mapped" means the sameness is insignificant

puts "SomeAttribute.example"
pp Schema::Controls::Comparison::Entry::SomeAttribute.example
puts

puts "SomeOtherAttribute.example"
pp Schema::Controls::Comparison::Entry::SomeOtherAttribute.example
puts

puts "SomeOtherAttribute::Same.example"
pp Schema::Controls::Comparison::Entry::SomeOtherAttribute::Same.example
puts

puts "SomeOtherAttribute::Different.example"
pp Schema::Controls::Comparison::Entry::SomeOtherAttribute::Different.example
puts

puts "SomeOtherAttribute::Mapped.example"
pp Schema::Controls::Comparison::Entry::SomeOtherAttribute::Mapped.example
puts

puts "SomeOtherAttribute::Mapped::SameValues.example"
pp Schema::Controls::Comparison::Entry::SomeOtherAttribute::Mapped::SameValues.example
puts

puts "SomeOtherAttribute::Mapped::DifferentValues.example"
pp Schema::Controls::Comparison::Entry::SomeOtherAttribute::Mapped::DifferentValues.example
puts
