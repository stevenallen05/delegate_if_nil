# DelegateIfNil

A simple gem to add nil delegation to an associated model if an attribute is `nil`.

## Usage

Add this to your model:

```ruby
class SomeModel < ApplicationRecord
    extend DelegateIfNil
    belongs_to :owning_model

    nil_delegate :animal, to: :owning_model
end
```

`animal` will now delegate to `owning_model` if it's `nil` on an instance of `SomeModel`.

You also get `_source` methods, which will tell you where the `animal` value comes from. If it's not set on either one, it will return `"unset"`

You'll get the following results:

```ruby
om = OwningModel.create(animal: "Cat")

some_model = SomeModel.create(animal: nil, owning_model = om)
some_model.animal # "Cat"
some_model.animal_source # "owning_model"

some_model = SomeModel.create(animal: "Dog", owning_model = om)
some_model.animal # Dog
some_model.animal_source # "self"

om = OwningModel.create(animal: nil)
some_model = SomeModel.create(animal: nil, owning_model = om)
some_model.animal # nil
some_model.animal_source # "unset"

```

It also works for multiple attributes. EG:

```ruby
class SomeModel < ApplicationRecord
    extend DelegateIfNil
    belongs_to :owning_model

    nil_delegate :animal, :phone_number, :name, to: :owning_model
end
```

It also resolves correctly for recursive delegations. IE: if `owning_model` delgates an attribute if `nil`, it will correctly report the source all the way down the chain, terminating either in `self`, `unset`, or the association name.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'delegate_if_nil', git: 'https://github.com/stevenallen05/delegate_if_nil.git'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install delegate_if_nil
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
