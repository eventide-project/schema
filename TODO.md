# TODO

- mapped comparison

## Attributes specified

```ruby
comparison = Schema::Compare::Comparison.build(control, compare, [:some_attribute])
```

- Test that just the given attributes are in entries
  - Start with a control with multiple entries
  - control schema
  - compare schema
  - Build using control name that's the same
  - Assert that entries only have the one named in the whitelist

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
