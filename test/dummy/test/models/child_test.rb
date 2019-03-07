require 'test_helper'

class ChildTest < ActiveSupport::TestCase
  test "concern creates _source method" do
    assert_respond_to child, :fallback_source
  end

  test "concern gets the fallback value" do
    assert_not_equal falling_back.fallback, nil
  end

  test "_source reports getting from the parent when falling back" do
    assert_equal falling_back.fallback_source, "parent"
  end

  test "_source reports getting from self when not falling back" do
    assert_equal not_falling_back.fallback_source, "self"
  end

  def child
    @child ||= Child.first
  end

  def not_falling_back
    @not_falling_back ||= Child.where.not(fallback: nil).first
  end

  def falling_back
    @falling_back ||= Child.find_by(fallback: nil)
  end
end
