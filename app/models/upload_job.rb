class UploadJob < ApplicationRecord
    attr_reader :processing_tempfile
    
    def processing_tempfile
        "#{Dir.tmpdir()}/process-#{self.filename}"
    end
    
    def create_processing_file
        s3 = Aws::S3::Resource.new(region: ENV["AWS_REGION"])
        s3.bucket(ENV["S3_BUCKET"])
            .object(self.filename)
            .download_file(processing_tempfile)
    end
    
    def purge_processing_file
        if File.exists?(self.processing_tempfile)
            File.delete(self.processing_tempfile)
        end
    end
end
