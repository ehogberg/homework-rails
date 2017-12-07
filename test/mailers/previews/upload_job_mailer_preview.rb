# Preview all emails at http://localhost:3000/rails/mailers/upload_job_mailer
class UploadJobMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/upload_job_mailer/finished
  def finished
    UploadJobMailer.finished(UploadJob.find(1))
  end

end
