require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should put add" do
    put records_url, params: "lname fname gender color 2000-01-01"
    assert_response :success
  end

  test "add with incomplete information should bork" do
    put records_url, params: "lname fname gender"
    assert_response :unprocessable_entity
  end
  
  test 'adding record actually adds a record' do
    assert_difference 'Person.count' do
      put records_url, params: "lname fname gender color 2000-01-01"
    end
  end
  
  test "should get gender" do
    get records_gender_url
    assert_response :success
  end

  test "should get name" do
    get records_name_url
    assert_response :success
  end

  test "should get birthdate" do
    get records_birthdate_url
    assert_response :success
  end

  test "upload accepts a file and starts a job" do
    post records_upload_url, 
      params: {file: fixture_file_upload("files/upload_data.txt"),
               report_to_address: "someone@somewhere.com" }
    assert_response :success
    
    response_hash = JSON.parse @response.body
    assert response_hash["meta"]["job_id"].present?
    assert response_hash["meta"]["send_report_to"] == "someone@somewhere.com"
  end
  
end
