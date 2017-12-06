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
    upload_results = process_upload(params[:file])
    
    render json: {meta: standard_meta.merge(upload_results)}
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
  
  def process_upload(tempfile)
    new_people = 0
    errs = 0

    lines = StringIO.new(tempfile.read)
    lines.each_line do |l|
        begin
          Person.new.attributes_from_line(l).save!
          new_people += 1
        rescue Exception
          errs += 1
        end
    end 
    
    {records_created: new_people, errors: errs}
    
  end
  
end
