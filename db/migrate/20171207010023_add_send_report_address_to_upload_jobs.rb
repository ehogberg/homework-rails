class AddSendReportAddressToUploadJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :upload_jobs, :send_report_address, :string
  end
end
