# schema

Schema gives an objet the `attribute` macro from Virtus. but, it disables the virtus mass assignment constructor of the activerecord ilk

DataStructure adds a `build` method that can take a hash, and it does mass assignment

both Schema and DataStructure allow `to_h` to be called on the object

the hash returned from `to_h` contains only the declared attributes and their values

warning, don’t override the `initialize` method of either a Schema or DataStructure object

note: DataStructure inherits Schema

## License

The `schema` library is released under the [MIT License](https://github.com/obsidian-btc/schema/blob/master/MIT-License.txt).
