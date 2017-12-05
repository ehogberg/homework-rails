class ApiController < ApplicationController
  before_action :set_default_format
  
  def add
    @new_people = request.body.map do |l|
      p = Person.new.attributes_from_line(l)
      p.save!
      p.reload
      p
    end
    respond_to do |fmt|
      fmt.json { render json: @new_people }
    end
  end

  def gender
    @people = Person.order("gender asc, lname desc")
    respond_to do |fmt|
      fmt.json { render json: @people }
    end
  end

  def name
    @people = Person.order(:lname,:fname)
    respond_to do |fmt|
      fmt.json { render json: @people }
    end
  end

  def birthdate
    @people = Person.order(:birthdate)
    respond_to do |fmt|
      fmt.json { render json: @people }
    end    
  end
  
private

  def set_default_format
    request.format = "json"
  end
end
