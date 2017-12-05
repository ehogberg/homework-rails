class ApiController < ApplicationController
  
  def add
    @new_people = request.body.map do |l|
      p = Person.new.attributes_from_line(l)
      p.save!
      p.reload
    end

    render json: @new_people 
  end

  def gender
    render jsonapi: get_people("gender asc, lname desc"),
                    meta: standard_meta.merge(sort: :gender),
                    links: {self: api_gender_url}
  end

  def name
    render jsonapi: get_people(:lname,:fname),
                    meta: standard_meta.merge(sort: :name),
                    links: {self: api_name_url}
  end

  def birthdate
    render jsonapi: get_people("birthdate asc, lname desc"),
                    meta: standard_meta.merge(sort: :birthdate),
                    links: {self: api_birthdate_url}
  end
  
private

  # DRY out records retrieval, w/ pagination support.
  def get_people(sort)
    Person.order(sort).page(params[:page]).per(params[:per_page])
  end
  
  def standard_meta
    {ns: "org.homework",page: params[:page] || 1,
     per_page: params[:per_page] || 25}
  end
end
