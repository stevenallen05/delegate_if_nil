class Child < ApplicationRecord
  extend DelegateIfNil
  belongs_to :parent

  nil_delegate :fallback, to: :parent
end
