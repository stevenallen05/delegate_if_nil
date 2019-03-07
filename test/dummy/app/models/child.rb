class Child < ApplicationRecord
  extend DelegateIfNil
  belongs_to :parent

  nil_delegate :attribute_one, :attribute_two, to: :parent
end
