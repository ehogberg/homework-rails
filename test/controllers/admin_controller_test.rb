require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get purge" do
    get admin_purge_url
    assert_response :success
  end
  
  test "purge should empty the person table" do
    get admin_purge_url
    assert Person.count == 0  
  end

end
