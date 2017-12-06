class ApiController < ApplicationController
  
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
    upload_results = start_upload_job(params[:file])
    
    render jsonapi: nil,
                    meta: standard_meta.merge(upload_results)
  end
 
private

  # DRY out records retrieval, w/ pagination support.
  def get_people(sort)
    Person.order(sort).page(params[:page]).per(params[:per_page])
  end
  
  def standard_pageable_meta
    standard_meta.merge(page: (params[:page] || 1),
                        per_page: (params[:per_page] || 25))
  end
  
  def standard_meta
    now = Time.now
    
    { ns: "org.homework",
      human_readable_date: now.to_s,
      timestamp: now.to_i }
  end
  
  def start_upload_job(data_file)
    temppath = data_file.tempfile.path
    tempname = File.basename(temppath)
    
    upload_file_to_s3(temppath)
    
    ProcessUploadFileJob.perform_later(tempname)
    
    {datafile_name: tempname}
  end
  
  def upload_file_to_s3(tempfile)
    s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])

    bucket = 'homework-data-uploads'
    name = File.basename(tempfile)

    obj = s3.bucket(bucket).object(name)
    obj.upload_file(tempfile)
  end
end
