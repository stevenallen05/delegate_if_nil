require "delegate_if_nil/railtie"

module DelegateIfNil
  extend ActiveSupport::Concern

  def nil_delegate(*attrs, to:)
    attrs.each do |attr|
      define_method attr do
        self[attr].nil? ? self.send(to)&.send(attr) : self[attr]
      end

      define_method "#{attr}_source".to_sym do
        return "self" unless self[attr].nil?
        return to.to_s unless self.send(to).send(attr).nil?
        "unset"
      end
    end
  end
end
