class ProcessUploadFileJob < ApplicationJob
  queue_as :default

  def perform(job)
    
    begin
      job.create_processing_file
    
      count_errors = 0
      count_added = 0
      IO.foreach(job.processing_tempfile) do |l|
        begin
          Person.new.attributes_from_line(l).save!
          count_added += 1
        rescue
          count_errors += 1
        end
      end
      job.purge_processing_file
      job.update_attributes(completed_at: DateTime.now,
                            error_count: count_errors,
                            processed_count: count_added)
    rescue Exception => e
      log.error "Problem while processing upload file: #{e.to_s}"
    end
    
    UploadJobMailer.finished(job).deliver_later unless job.send_report_address.nil?
  end
end
