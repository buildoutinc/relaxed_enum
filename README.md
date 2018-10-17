# RelaxedEnum

Relax rails enum setter.  Allows setting an enum by supplying an integer, string or symbol.

Given a class like

```ruby
class MyModel < ApplicationRecord
  enum status: [:foo, :bar]
end
```

rails will throw an `ArgumentError` if you try to assign string that represents a number to status

```
model.status = "1"
# Raises error
```

With this gem, you're free to assign an integer, string or symbol to an enum

```
model.status = "1"
model.status
# "foo"
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'relaxed_enum'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install relaxed_enum

## Usage

Relax an enum by adding this to your class
```
relax_enum :enum_field
```

For example
```ruby
class MyModel < ApplicationRecord
  enum status: [:foo, :bar]
  relax_enum :status
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/relaxed_enum.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
