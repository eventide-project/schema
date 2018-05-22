# schema

Primitives for schema and data structure

## Example

### Basic usage

```ruby
class SomeClass
  include Schema

  attribute :name, String
  attribute :amount, Numeric
  attribute :active, Boolean
end

some_object = SomeClass.new

some_object.name = 'Some Name'
some_object.amount = 11
some_object.active = true

puts some_object.inspect
# => #<SomeClass:0x00555710f467c8 @name="Some Name", @amount=11, @active=true>

puts some_object.to_h
# => {:name=>"Some Name", :amount=>11, :active=>true}

some_object.amount = 'foo' # => raises Schema::Attribute::TypeError
```

A special type called `Boolean` is provided which only allows the values
`true` and `false`

### No type checking

You can have attributes with no type checking

```ruby
class SomeClass
  include Schema

  attribute :name
end

some_object = SomeClass.new

some_object.name = 'Some Name'
some_object.name = 123
puts some_object.name.inspect # => 123
```

### Default values

All attributes default to `nil` upon initialization, but you can customize it
with `default` key. You can use a `proc` to assign a value that will be
calculated during initialization

```ruby
class SomeClass
  include Schema

  attribute :name, String, default: '<no name>'
  attribute :birth_date, Time, default: proc { Time.now }
  attribute :description, String
end

some_object = SomeClass.new

puts some_object.name # => "<no name>"
puts some_object.birth_date.to_s # => "2018-05-21 16:57:21 -0700"
puts some_object.description # => nil
```

You can also provide default values for attributes without types, like:

```ruby
class SomeClass
  include Schema

  attribute :something, default: proc { Object.new }
end
```

Remember that default values are **not type-checked upon initialization**.
However when retrieving from attributes with invalid default values, an error
is raised:

```ruby
class SomeClass
  include Schema
  attribute :age, default: 'Some Name'
end

some_object = SomeClass.new
some_object.age # => raises Schema::Attribute::TypeError
```

### Strict

Your attribute will accept any subtype of the specified type. `strict` defaults
to `false`, except for `Boolean` which is a special case and cannot be `false`

```ruby
class Animal
end
class Dog < Animal
end

class SomeClass
  include Schema

  attribute :animal_only, Animal, strict: true
  attribute :any_animal, Animal, strict: false
  attribute :any_animal_no_strict, Animal
end

some_object = SomeClass.new

some_object.animal_only = Animal.new
some_object.animal_only = Dog.new # => raises Schema::Attribute::TypeError

some_object.any_animal = Animal.new
some_object.any_animal = Dog.new
puts some_object.any_animal.inspect # => #<Dog:0x00561154140fd0>

some_object.any_animal_no_strict = Animal.new
some_object.any_animal_no_strict = Dog.new
# As mentioned, behaves like `strict: false`
puts some_object.any_animal_no_strict.inspect # => #<Dog:0x00561154140fd0>
```

You **cannot define** an attribute as strict if it doesn't have a type:

```ruby
class SomeClass
  attribute :name, strict: true
end
# => raises Schema::Attribute::Error
```

### Repeated attribute definition

In case you define 2 or more times the same attribute, the last one is the only
valid one:

```ruby
class SomeClass
  attribute :name, Numeric
  attribute :name, String
end

some_object = SomeClass.new
some_object.name = 123 # => raises Schema::Attribute::TypeError
some_object.name = 'Some Name'
puts some_object.name # => "Some Name"
```

### Schema::DataStructure

Behaves like schema, but also provides a class method `build` which allows to
provide attributes as hash during initialization

```ruby
class SomeClass
  include Schema::DataStructure

  attribute :name, String
  attribute :amount, Numeric
  attribute :active, Boolean
end

some_object = SomeClass.build(name: 'Some Name', amount: 11)
some_object.active = true

puts some_object.inspect
# => #<SomeClass:0x00555710f467c8 @name="Some Name", @amount=11, @active=true>
```

### Transient attributes

You can list all attributes defined by `Schema`

```ruby
class SomeClass
  include Schema::DataStructure

  attribute :name, String
  attribute :amount, Numeric
  attribute :active, Boolean
end

SomeClass.attribute_names # => [:name, :amount, :active]
```

You can also hide attributes from the list:

```ruby
class SomeClass
  include Schema::DataStructure

  attribute :name, String
  attribute :amount, Numeric
  attribute :active, Boolean

  def self.transient_attributes
    [:active]
  end
end

SomeClass.attribute_names # => [:name, :amount]
```

When attributes are hidden from the list and you transform the object to a 
Hash using `to_h`, they will be excluded:

```ruby
class SomeClass
  include Schema::DataStructure

  attribute :name, String
  attribute :amount, Numeric
  attribute :active, Boolean

  def self.transient_attributes
    [:active]
  end
end

some_object = SomeClass.new
some_object.name = 'Some Name'
some_object.amount = 11
some_object.active = true
SomeClass.to_h # => {name: "Some Name", amount: 11}
```

## Equality

You can compare two entities using `==`, `eql?` and `===`:

- `==` returns `true` if:
  - The objects are of the same class
  - Attributes have the same values
- `===` returns `true` if:
  - Attributes have the same values
- `eql?` (no options) returns `true` if:
  - The objects are of the same class
  - Attributes have the same values
- `eql?` with `ignore_class: true` returns `true` if:
  - Attributes have the same values
- `eql?` can also check only some attributes or alias some:
  - `obj1.eql?(obj2, [:name, :age], ignore_class: true)` will check only the
    `:name` and `:age` values
  - `obj1.eql?(obj2, [:name, {age: :amount}], ignore_class: true)` will check
    `obj1.name == obj2.age` and that `obj1.age == ob2.amount`

## Validation

TODO: Describe `nil` validation with `Validate`

## License

The `schema` library is released under the [MIT License](https://github.com/eventide-project/schema/blob/master/MIT-License.txt).
