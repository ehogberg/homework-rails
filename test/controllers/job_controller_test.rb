require 'test_helper'

class JobControllerTest < ActionDispatch::IntegrationTest
  test "should get job info" do
    get job_info_url(upload_jobs(:one))
    assert_response :success
    
    response_hash = JSON.parse(@response.body)
    assert_equal response_hash["data"]["attributes"]["filename"],
      upload_jobs(:one).filename
      
    assert_equal response_hash["links"]["self"],
      job_info_url(upload_jobs(:one))
  end

end
