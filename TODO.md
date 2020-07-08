# TODO

- attribute_name, rather than attr_name

## No attributes specified, uses control's attributes

```ruby
comparison = Schema::Compare::Comparison.build(control, compare)
```

- Test that every control attribute was compared

## Attributes specified

```ruby
comparison = Schema::Compare::Comparison.build(control, compare, [:some_attribute])
```

- Test that just the given attributes were compared
- Raise if a missing control attribute is given
- Raise if a missing compare attribute is given

## Attributes with mapping specified

```ruby
comparison = Schema::Compare::Comparison.build(control, compare, [
  { :some_attribute => :yet_another_attribute }
])
```

- Test that the control attribute was compared against the compare attribute
- Raise if a missing control attribute is given
- Raise if a missing compare attribute is given

```ruby
Entry.new(
  "some_attribute",
  "some-value", # control.some_attribute
  "yet_another_attribute",
  "alternate-value" # compare.yet_another_attribute
)
```

## Multiple attributes

```ruby
comparison = Schema::Compare::Comparison.build(control, compare, [
  :attribute,
  { :some_other_attribute => :yet_another_attribute }
])
```

- Test that each attribute was compared
