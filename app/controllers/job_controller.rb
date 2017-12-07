class JobController < ApplicationController
  include Meta
  
  def show
    job = UploadJob.find(params[:id])
    render jsonapi: job,
                    meta: standard_meta,
                    links: {self: job_info_url(params[:id])}
  end
end
