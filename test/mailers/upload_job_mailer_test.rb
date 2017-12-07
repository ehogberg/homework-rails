require 'test_helper'

class UploadJobMailerTest < ActionMailer::TestCase
  test "finished" do
    mail = UploadJobMailer.finished(upload_jobs(:one))
    assert_equal "Upload file processing complete.", mail.subject
    assert_equal ["someone@somewhere.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "completed processing", mail.body.encoded
  end

end
