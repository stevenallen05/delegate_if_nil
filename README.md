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

`delegate_if_nil` is available as an alias:

```ruby
class SomeModel < ApplicationRecord
    extend DelegateIfNil
    belongs_to :owning_model

    nil_delegate :animal, to: :owning_model
    delegate_if_nil :animal, to: :owning_model # Exact same as the line above
    
end
```

You also get `_source` methods, which will tell you where the `animal` value comes from. If it's not set on either one, it will return `"unset"`

You'll get the following results:

```ruby
om = OwningModel.create(animal: "Cat")

some_model = SomeModel.create(animal: nil, owning_model = om)
some_model.animal # "Cat"
some_model.animal_source # "owning_model"
some_model.animal_delegated? # true

some_model = SomeModel.create(animal: "Dog", owning_model = om)
some_model.animal # Dog
some_model.animal_source # "self"
some_model.animal_delegated? # false

om = OwningModel.create(animal: nil)
some_model = SomeModel.create(animal: nil, owning_model = om)
some_model.animal # nil
some_model.animal_source # "unset"
some_model.animal_delegated? # true
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

## Example

This is an example based off a real-world project.

A `User` has many `notification_channels`. Each `user` and `notification_channel` has a `notifications_enabled` boolean flag.

With this setup, a `user` can set a default value for `notifications_enabled`, and each channel can override the default.

eg:

```ruby
class User < ActiveRecord::Base
    # notifications_enabled is a boolean attribute on the user model
    has_many :notification_channels
end

class NotificationChannel < ActiveRecord::Base
    # notifications_enabled is a boolean attribute on the notification_channel model
    belongs_to :user
    nil_delegate :notifications_enabled, to: :user
end
```

Now, to see if a specific channel should be enabled, simple call `notification_channel.notifications_enabled`, and it will resolve the correct value for that channel. 

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'delegate_if_nil'
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
