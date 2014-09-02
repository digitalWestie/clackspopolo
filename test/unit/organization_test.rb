require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  test "can save two organizations as siblings" do
    Popolo::Organization.create(name:'ABC Org')
    Popolo::Organization.create(name:'DEF Org')
    assert Popolo::Organization.all.size.eql?(2)
  end
end