# TODO

- mapped comparison
- equality tests using map: use hash arrow

## Compare.() Multiple attributes

```ruby
comparison = Schema::Compare::Comparison.build(control, compare, [
  :attribute,
  { :some_other_attribute => :yet_another_attribute }
])
```

- Test that each attribute was compared
