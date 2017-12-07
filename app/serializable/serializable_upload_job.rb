class SerializableUploadJob < JSONAPI::Serializable::Resource
  type 'upload_jobs'
  attribute :filename
  attribute :completed_at
  attribute :created_at
  attribute :error_count
  attribute :processed_count
  attribute :send_report_address
end
