# Schema

Primitives for schema and data structure

## Example

```ruby
class SomeClass
  include Schema

  attribute :name, String
  attribute :amount, Numeric
end

some_object = SomeClass.new

some_object.name = 'Some Name'
some_object.amount = 11

some_object.inspect
# => #<SomeClass:0x00555710f467c8 @name="Some Name", @amount=11>

some_object.to_h
# => {:name=>"Some Name", :amount=>11}
```

## Type-Checked Attributes

Attributes that are declared with a data type can only accept values of that type. When values are assigned that are not of that type, a `Schema::Attribute::TypeError` error is raised.

```ruby
class SomeClass
  include Schema

  attribute :name, String
  attribute :amount, Numeric
end

some_object = SomeClass.new

some_object.name = 'Some Name'
# => "Some Name"

some_object.amount = 123
# => 123

some_object.amount = 'foo'
# => Schema::Attribute::TypeError
```

## Optional Type Checking

Type checking for attributes is optional. If an attribute's type is not declared, then a value of any type can be assigned to the attribute.

```ruby
class SomeClass
  include Schema

  attribute :name
end

some_object = SomeClass.new

some_object.name = 'Some Name'
# => "Some Name"

some_object.name = 123
# => 123
```

## Strict Attributes and Polymorphism

A type-checked attribute will, by default, accept a value that is either the attribute's exact type, or a subtype of that type.

```ruby
class Animal
end

class Dog < Animal
end

class SomeClass
  include Schema

  attribute :animal_only, Animal, strict: true
  attribute :animal_or_subtype, Animal
end

some_object = SomeClass.new

some_object.animal_only = Animal.new

some_object.animal_only = Dog.new
# => Schema::Attribute::TypeError

some_object.animal_or_subtype = Animal.new
some_object.animal_or_subtype = Dog.new
```

If an attribute is defined as strict, it must be declared with a type. If it is not declared with a type, an error will be raised when the class is loaded.

```ruby
class SomeClass
  include Schema

  attribute :name, strict: true
end

# => raises Schema::Attribute::Error
```

## Boolean Type

Ruby does not have an explicit boolean data type. The `false` and `true` values in Ruby are instances of `FalseClass` and `TrueClass`, respectively. This makes it quite difficult to declare a boolean attribute that is type-checked without adding branching logic that checks whether the value's class is `FalseClass` or `TrueClass`.

Importing the Schema namespace into a class makes a `Boolean` data type available. Declaring an attribute as `Boolean` will ensure that its value can only be `false`, `true`, or `nil`.

```ruby
class SomeClass
  include Schema

  attribute :active, Boolean
end

some_object = SomeClass.new

some_object.active = true
# => true

some_object.active = false
# => false

some_object.active = 'foo'
# => Schema::Attribute::TypeError
```

## Default Values

Attribute values are `nil` by default. An attribute declaration can specify a default value using the optional `default` argument. To specify a default value to an attribute, it is assigned a `proc`.

```ruby
class Planet
  include Schema

  attribute :name, String, default: proc { 'Earth' }
  attribute :age, Numeric, default: proc { 4_500_000_000 }
  attribute :description, String
end

some_object = Planet.new

some_object.name
# => "Earth"

some_object.age
# => 4500000000

some_object.description
# => nil
```

Default values can also be specified for attributes without that are not declared with types:

```ruby
class SomeClass
  include Schema

  attribute :something, default: proc { Object.new }
end
```

NOTE: An attribute's default value is not type-checked when the class that they are members of is initialized. They are checked when the attribute is accessed.

```ruby
class SomeClass
  include Schema

  attribute :age, Numeric, default: 'Some Name'
end

some_object = SomeClass.new

some_object.age
# => Schema::Attribute::TypeError
```

## Schema::DataStructure

The `DataStructure` module is a specialization of `Schema` that augments the receiver with operations that are useful when implementing typical applicative code.

When `Schema::DataStructure` is included in a class, the class method `build` is defined on the class.

The `build` method allows the class to be constructed from a hash of values whose keys correspond to the object's attribute names.

```ruby
class SomeClass
  include Schema::DataStructure

  attribute :name, String
  attribute :amount, Numeric
end

data = { name: 'Some Name', amount: 11 }

some_object = SomeClass.build(data)

puts some_object.inspect
# => #<SomeClass:0x00555710f467c8 @name="Some Name", @amount=11>
```

## Intercepting and Modifying Input and Output Data

By default, a data structure whose attributes are primitive values like strings, numbers, or booleans can be converted to hash data implicitly without any additional implementation.

A message that has nested objects that aren't just primitive values requires specific instructions for transforming those custom types to and from hash data.

### Input Data

A Schema::DataStructure that implements the `transform_read(data)` method can intercept the input data that the class is constructed with. The data can be modified and customized by this method, and the object's attributes can be manipulated.

Note that the read stage of construction of a data structure from hash data happens before the input hash's attributes are assigned to the object.

To affect changes to the input data, the `transform_read` method implementation must directly modify the hash data that the method receives as an argument.

```ruby
class Address
  include Schema::DataStructure

  attribute :city, String
  attribute :state, String
end

class SomeClass
  include Schema::DataStructure

  attribute :name, String
  attribute :address, Address

  def transform_read(data)
    address = Address.build(data[:address])
    data[:address] = address
  end
end
```

### Output Data

A Schema::DataStructure that implements the `transform_write(data)` method can intercept the output data that the object outputs when either `to_h` or `attributes` is invoked. The data can be modified and customized by this method.

Note that the write stage of converting a data structure to a hash happens after the object's attributes have been converted to a hash but just before the hash data is returned to the receiver.

To affect changes to the output data, the `transform_write` method implementation must directly modify the hash data that the method receives as an argument. Changes made to the argument have no effect on the state of the data structure object itself.

```ruby
class Address
  include Schema::DataStructure

  attribute :city, String
  attribute :state, String
end

class SomeClass
  include Schema::DataStructure

  attribute :name, String
  attribute :address, Address

  def transform_write(data)
    data[:address] = address.to_h
  end
end
```

## Attribute Names

Attribute names can be retrieved from a schema class.

```ruby
class SomeClass
  include Schema

  attribute :name, String
  attribute :amount, Numeric
  attribute :active, Boolean
end

SomeClass.attribute_names
# => [:name, :amount, :active]
```

## Transient Attributes

Transient attributes offer a way to exclude attributes and their values from the hash representation of a schema object.

```ruby
class SomeClass
  include Schema

  attribute :name, String
  attribute :amount, Numeric
  attribute :active, Boolean

  def self.transient_attributes
    [:active]
  end
end

SomeClass.attribute_names
# => [:name, :amount]

some_object = SomeClass.new

some_object.name = 'Some Name'
some_object.amount = 11
some_object.active = true

some_object.to_h
# => {name: "Some Name", amount: 11}
```

## Equality

Two instances of a schema can be compared using Ruby's common equality operator, `==`, and the `eql?` method.

The `==` operator and the `eql?` method can be used interchangeably. They have identical implementations and signatures. The `eql?` method is an alias of the `==` operator.

``` ruby
eql?(other, attribute_names=nil, ignore_class: nil)
```

**Returns**

Boolean value indicating whether the schemas are equal or not

**Alias**

`==`

_Note that the `==` alias can only be invoked with the first parameter_

**Parameters**

| Name | Description | Type | Default |
| --- | --- | --- | --- |
| other | The right-hand side object to compare to the left-hand side object | Schema | |
| attribute_names | Optional list of attribute names to which equality evaluation is limited | Array of Symbol | Attribute names of left-hand side object |
| ignore_class | Optionally controls whether the classes of the objects are considered in the evaluation of equality | Boolean | False |

### Basic Equality

Two schema objects are equal if:

- The objects are of the same class
- The attributes of the left-hand side object are also present on the object of the right-hand side
- The common attributes of the left-hand side and right-hand side objects have values that are equal

``` ruby
class SomeClass
  include Schema

  attribute :some_attribute, String
  attribute :some_other_attribute, String
end

some_object = SomeClass.new
some_object.some_attribute = 'some value'
some_object.some_other_attribute = 'some other value'

some_other_object = SomeClass.new
some_other_object.some_attribute = 'some value'
some_other_object.some_other_attribute = 'some other value'

some_object == some_other_object
# => true

some_object.eql?(some_other_object)
# => true

some_other_object.some_other_attribute = 'yet another value'

some_object.eql?(some_other_object)
# => false

some_object.eql?(some_other_object, [:some_attribute])
# => true
```

### Equality Irrespective of Class Differences

Two schema objects are equal if:

- The objects are either of the same class, or they're not
- The attributes of the left-hand side object are also present on the object of the right-hand side
- The common attributes of the left-hand side and right-hand side objects have values that are equal

``` ruby
class SomeOtherClass
  include Schema

  attribute :some_attribute, String
  attribute :some_other_attribute, String
end

some_other_object = SomeOtherClass.new
some_other_object.some_attribute = 'some value'
some_other_object.some_other_attribute = 'some other value'

some_object.eql?(some_other_object)
# => false

some_object.eql?(some_other_object, ignore_class: true)
# => true

some_other_object.some_other_attribute = 'yet another value'

some_object.eql?(some_other_object, ignore_class: true)
# => false

some_object.eql?(some_other_object, [:some_attribute], ignore_class: true)
# => true
```

## Comparison and Difference

Two instances of schema objects can be compared and a comparison object is produced that illustrates which attributes have equal values and which do not.

``` ruby
Schema::Compare.(control, compare, attribute_names=nil)
```

**Returns**

Instance of `Schema::Compare::Comparison` containing an entry for each attribute compared

**Parameters**

| Name | Description | Type |
| --- | --- | --- |
| control | Baseline object for comparison | Schema |
| compare | Object to compare to the baseline | Schema |
| attribute_names | Optional list of attribute names to which comparison is limited | Array of Symbol or Hash |

``` ruby
class SomeClass
  include Schema

  attribute :some_attribute, String
  attribute :some_other_attribute, String
end

control = SomeClass.new
control.some_attribute = 'some value'
control.some_other_attribute = 'some other value'

compare = SomeClass.new
compare.some_attribute = 'some value'
compare.some_other_attribute = 'yet another value'

comparison = Schema::Compare.(control, compare)
#=> #<Schema::Compare::Comparison:0x...
 @compare_class=SomeClass,
 @control_class=SomeClass,
 @entries=
  [#<struct Schema::Compare::Comparison::Entry
    control_name=:some_attribute,
    control_value="some value",
    compare_name=:some_attribute,
    compare_value="some value">,
   #<struct Schema::Compare::Comparison::Entry
    control_name=:some_other_attribute,
    control_value="some other value",
    compare_name=:some_other_attribute,
    compare_value="yet another value">]>

comparison.different?
# => true

comparison.different?(:some_attribute)
# => false

comparison.different?(:some_other_attribute)
# => true


# Different classes, same attribute values

class SomeOtherClass
  include Schema

  attribute :some_attribute, String
  attribute :some_other_attribute, String
end

compare = SomeOtherClass.new
compare.some_attribute = 'some value'
compare.some_other_attribute = 'some other value'

comparison = Schema::Compare.(control, compare)
#=> #<Schema::Compare::Comparison:0x...
 @compare_class=SomeClass,
 @control_class=SomeOtherClass,
 @entries=
  [#<struct Schema::Compare::Comparison::Entry
    control_name=:some_attribute,
    control_value="some value",
    compare_name=:some_attribute,
    compare_value="some value">,
   #<struct Schema::Compare::Comparison::Entry
    control_name=:some_other_attribute,
    control_value="some other value",
    compare_name=:some_other_attribute,
    compare_value="some other value">]>

comparison.different?
# => true

comparison.different?(:some_attribute)
# => false

comparison.different?(:some_other_attribute)
# => false
```

### Limit the Attributes Compared

The comparison can be limited to a subset of the schema objects' attributes.

``` ruby
compare = SomeClass.new
compare.some_attribute = 'some value'
compare.some_other_attribute = 'yet another value'

comparison = Schema::Compare.(control, compare, [:some_attribute])
#=> #<Schema::Compare::Comparison:0x...
 @compare_class=SomeClass,
 @control_class=SomeClass,
 @entries=
  [#<struct Schema::Compare::Comparison::Entry
    control_name=:some_attribute,
    control_value="some value",
    compare_name=:some_attribute,
    compare_value="some value">]>

comparison.different?
# => false

comparison.different?(:some_attribute)
# => false

comparison.different?(:some_other_attribute)
# => No attribute difference entry (Attribute Name: :some_other_attribute) (Schema::Compare::Comparison::Error)

comparison = Schema::Compare.(control, compare, [:some_other_attribute])
#=> #<Schema::Compare::Comparison:0x...
 @compare_class=SomeClass,
 @control_class=SomeClass,
 @entries=
  [#<struct Schema::Compare::Comparison::Entry
    control_name=:some_other_attribute,
    control_value="some other value",
    compare_name=:some_other_attribute,
    compare_value="yet another value">]>

comparison.different?
# => true

comparison.different?(:some_other_attribute)
# => true

comparison.different?(:some_attribute)
# => No attribute difference entry (Attribute Name: :some_attribute) (Schema::Compare::Comparison::Error)
```

#### Mapped Attributes

The list of limited attributes used for a comparison can also account for mapping different attribute names.

``` ruby
compare = SomeClass.new
compare.some_attribute = 'some value'
compare.some_other_attribute = 'some other value'

class SomeOtherClass
  include Schema

  attribute :some_attribute, String
  attribute :yet_another_attribute, String
end

compare = SomeOtherClass.new
compare.some_attribute = 'some value'
compare.yet_another_attribute = 'some other value'

map = [
  :some_attribute,
  { :some_other_attribute => :yet_another_attribute }
]

comparison = Schema::Compare.(control, compare, map)
#=> #<Schema::Compare::Comparison:0x...
 @compare_class=SomeOtherClass,
 @control_class=SomeClass,
 @entries=
  [#<struct Schema::Compare::Comparison::Entry
    control_name=:some_attribute,
    control_value="some value",
    compare_name=:some_attribute,
    compare_value="some value">,
  #<struct Schema::Compare::Comparison::Entry
    control_name=:some_other_attribute,
    control_value="some other value",
    compare_name=:yet_another_attribute,
    compare_value="some other value">]>

  ]>

comparison.different?
# => false

comparison.different?(:some_attribute)
# => false

comparison.different?(:some_other_attribute)
# => false


compare.yet_another_attribute = 'yet another value'

comparison = Schema::Compare.(control, compare, map)
#=> #<Schema::Compare::Comparison:0x...
 @compare_class=SomeOtherClass,
 @control_class=SomeClass,
 @entries=
  [#<struct Schema::Compare::Comparison::Entry
    control_name=:some_attribute,
    control_value="some value",
    compare_name=:some_attribute,
    compare_value="some value">,
  #<struct Schema::Compare::Comparison::Entry
    control_name=:some_other_attribute,
    control_value="some other value",
    compare_name=:yet_another_attribute,
    compare_value="yet another value">]>

  ]>

comparison.different?
# => true

comparison.different?(:some_attribute)
# => false

comparison.different?(:some_other_attribute)
# => true
```

## License

The `schema` library is released under the [MIT License](https://github.com/eventide-project/schema/blob/master/MIT-License.txt).
