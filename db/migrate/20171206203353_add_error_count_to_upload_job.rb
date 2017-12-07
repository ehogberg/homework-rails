class AddErrorCountToUploadJob < ActiveRecord::Migration[5.1]
  def change
    add_column(:upload_jobs,:error_count,:integer, default: 0)
  end
end
