class CreateUploadJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :upload_jobs do |t|
      t.string :filename
      t.timestamp :completed_at
      t.text :report

      t.timestamps
    end
  end
end
