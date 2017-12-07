class JobController < ApplicationController
  def show
    job = UploadJob.find(params[:id])
    render jsonapi: job,
                    links: {self: job_info_url(params[:id])}
  end
end
