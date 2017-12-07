class UploadJobMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.upload_job_mailer.finished.subject
  #
  def finished(job)
    @greeting = "Hi"

    mail to: job.send_report_address, subject: "Upload file processing complete."
    
  end
end
