class Parent < ApplicationRecord
  extend DelegateIfNil
  belongs_to :grandparent

  nil_delegate :attribute_one, to: :grandparent
end
