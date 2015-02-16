# StrongJSON

This library allows you to test the structure of JSON objects.

This is similar to Strong Parameters, which is introduced by Rails 4, but expected to work with more complex structures.
It may help you to understand what this is as: Strong Parameter is for simple structures, like HTML forms, and StrongJSON is for complex structures, like JSON objects posted to API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'strong_json'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install strong_json

## Usage

```ruby
s = StrongJSON.new do
  let :item, object(id: prohibited, name: string, count: numeric)
  let :custoemr, object(name: string, address: string, phone: string, email: optional(string))
  let :order, object(customer: customer, items: array(item))
end

json = s.order.coerce(JSON.parse(input))
```

If the input JSON data is conformant with `order`'s structure, the `json` will be that value.

If the input JSON contains attributes which is not white-listed in the definition, the fields will be droped.

If an attribute has a value which does not match with given type, the `coerce` method call will raise an exception `StrongJSON::Type::Error`.
If the input JSON contains `prohibited` attributes, `id` of `item` in the example, it also will result in an exception.

## Catalogue of Types

### object(f1: type1, f2: type2, ...)

* The value must be an object
* Fields, `f1`, `f2`, and ..., must be present and its values must be of `type1`, `type2`, ..., respectively
* Other fields will be ignored

### array(type)

* The value must be an array
* All elements in the array must be value of given `type`

### optional(type)

* The value can be `nil` (or not contained in an object)
* If an value exists, it must be of given `type`

### Base types

* `number` The value must be an instance of `Numeric`
* `string` The value must be an instance of `String`
* `boolean` The value must be `true` or `false`
* `numeric` The value must be an instance of `Numeric` or a string which represents a number
* `any` Any value except `nil` is accepted
* `prohibited` Any value will be rejected

## Contributing

1. Fork it ( https://github.com/soutaro/strong_json/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request