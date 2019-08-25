# frozen_string_literal: true

require "delegate_if_nil/railtie"

module DelegateIfNil
  extend ActiveSupport::Concern

  def nil_delegate(*attrs, to:)
    attrs.each do |attr|
      define_method attr do
        self[attr].nil? ? send(to)&.send(attr) : self[attr]
      end

      source_method = "#{attr}_source".to_sym
      define_method source_method do
        return "self" unless self[attr].nil?

        if send(to)&.respond_to?(source_method)
          to_source = send(to).send(source_method)
          return to.to_s if to_source == "self"

          return to_source
        else
          return send(to)&.send(attr).nil? ? "unset" : to.to_s
        end
      end

      delegted_bool_method = "#{attr}_delegated?".to_sym
      define_method delegted_bool_method do
        self[attr].nil?
      end
    end
  end
end
