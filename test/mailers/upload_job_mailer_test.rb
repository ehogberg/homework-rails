require 'test_helper'

class UploadJobMailerTest < ActionMailer::TestCase
  test "finished" do
    mail = UploadJobMailer.finished(upload_jobs(:one))
    assert_equal "Upload file processing complete.", mail.subject
    assert_equal ["someone@somewhere.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "completed processing", mail.body.encoded
  end
  
  test "started" do
    mail = UploadJobMailer.started(upload_jobs(:one),"/path/to/job/info/1")
    assert_equal "Thank you for uploading a data file", mail.subject
    assert_equal ["someone@somewhere.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Thanks for submitting a data file for loading",
      mail.body.encoded
    assert_match "\/path\/to\/job\/info\/1", mail.body.encoded
  end

end
