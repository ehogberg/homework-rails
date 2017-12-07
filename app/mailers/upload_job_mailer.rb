class UploadJobMailer < ApplicationMailer

  def started(job,status_link)
      @job = job
      @status_link = status_link
      mail to: job.send_report_address, subject: "Thank you for uploading a data file"
  end
  
  def finished(job)
      mail to: job.send_report_address, subject: "Upload file processing complete."
  end
end
