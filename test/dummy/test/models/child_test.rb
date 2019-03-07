require 'test_helper'

# On child: attribute_one and attribute_two delegate if nil to parent
# On parent: attribute_one delgates if nil to grandparent
# On grandparent: no attributes delegate

class ChildTest < ActiveSupport::TestCase
  test "concern creates _source method" do
    assert_respond_to build(:child), :attribute_one_source
    assert_respond_to build(:child), :attribute_two_source
    assert_not_respond_to build(:child), :attribute_three_source
  end

  test "concern gets the fallback value" do
    assert_not_equal build(:child, :falls_back).attribute_one, nil
  end

  test "_source reports getting from the parent when falling back" do
    assert_equal build(:child, :falls_back).attribute_one_source, "parent"
    assert_equal build(:child, :falls_back, parent: build(:parent, :falls_back)).attribute_one_source, "grandparent"
    assert_equal build(:child, :falls_back, parent: build(:parent, :falls_back)).attribute_two_source, "unset"
  end

  test "_source reports getting from self when not falling back" do
    assert_equal build(:child).attribute_one_source, "self"
  end

  test "_source reports unset when source has no fallback value" do
    assert_equal build(:child, :falls_back, parent: build(:parent, :falls_back)).attribute_two_source, "unset"
  end

  test "_source reports unset when source falls back another level" do
    assert_equal build(:child, :falls_back, 
                        parent: build(:parent, :falls_back, 
                                      grandparent: build(:grandparent, :all_unset))).attribute_one_source, "unset"
  end


  test "_source reports unset when source delegation target is nil" do
    assert_equal build(:child, :falls_back, 
                        parent: build(:parent, :falls_back, 
                                      grandparent: nil)).attribute_one_source, "unset"
  end

end
