require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get api_add_url
    assert_response :success
  end

  test "should get gender" do
    get api_gender_url
    assert_response :success
  end

  test "should get name" do
    get api_name_url
    assert_response :success
  end

  test "should get birthdate" do
    get api_birthdate_url
    assert_response :success
  end

end
