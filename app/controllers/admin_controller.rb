class AdminController < ApplicationController
  def purge
    Person.delete_all
    render json: {meta: {message: "person records deleted"}}
  end
end
