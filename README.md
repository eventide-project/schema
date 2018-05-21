# schema

Primitives for schema and data structure

## Example

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
```

## License

The `schema` library is released under the [MIT License](https://github.com/eventide-project/schema/blob/master/MIT-License.txt).
