class ApiController < ApplicationController
  include Meta
  
  def add
    person = Person.new.attributes_from_line(request.body.first)
    
    if person.save
      render jsonapi: person,
             meta: standard_meta,
             status: :created
    else
      render jsonapi_errors: person.errors,
            meta: standard_meta,
            status: :unprocessable_entity
    end
  end

  def gender
    render jsonapi: get_people("gender asc, lname desc"),
                    meta: standard_pageable_meta.merge(sort: :gender),
                    links: {self: records_gender_url}
  end

  def lname
    render jsonapi: get_people([:lname,:fname]),
                    meta: standard_pageable_meta.merge(sort: :name),
                    links: {self: records_name_url}
  end

  def birthdate
    render jsonapi: get_people("birthdate asc, lname desc"),
                    meta: standard_pageable_meta.merge(sort: :birthdate),
                    links: {self: records_birthdate_url}
  end
  
  def upload
    upload_results = start_upload_job(params[:file], params[:report_to_address])

    if upload_results
      render jsonapi: nil,
                      meta: standard_meta.merge(upload_results)
    else
      render json: {errors: [{message: "Problem starting upload job."}],
                    meta: standard_meta},
                    status: :unprocessable_entity
    end
  end
 
private

  # DRY out records retrieval, w/ pagination support.
  def get_people(sort)
    Person.order(sort).page(params[:page]).per(params[:per_page])
  end
  
  def start_upload_job(data_file,send_report_address)
    temppath = data_file.tempfile.path
    tempname = File.basename(temppath)
    
    upload_file_to_s3(temppath)
    
    job = UploadJob.new(filename: tempname,
                        send_report_address: send_report_address)
    if job.save
      ProcessUploadFileJob.perform_later(job)
      UploadJobMailer.started(job,job_info_url(job)).deliver_later unless job.send_report_address.nil?
      { datafile_name: tempname,
        send_report_to: send_report_address,
        job_id: job.id  }
    else
      log.error "Problem creating upload job"
      nil
    end
  end
  
  def upload_file_to_s3(tempfile)

    s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])

    bucket = ENV['S3_BUCKET']
    name = File.basename(tempfile)

    obj = s3.bucket(bucket).object(name)
    obj.upload_file(tempfile)
  end
end
