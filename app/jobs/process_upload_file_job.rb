class ProcessUploadFileJob < ApplicationJob
  queue_as :default

  def perform(filename)
    processing_file = "#{Dir.tmpdir()}/process-#{filename}"
    
    s3 = Aws::S3::Resource.new(region: ENV["AWS_REGION"])
    s3.bucket('homework-data-uploads')
      .object(filename)
      .download_file(processing_file)
      
    count_errors = 0
    count_added = 0
    IO.foreach(processing_file) do |l|
      begin
        Person.new.attributes_from_line(l).save!
        count_added += 1
      rescue
        count_errors += 1
      end
    end
    File.delete(processing_file)
  end
end
