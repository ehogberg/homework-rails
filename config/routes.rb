Rails.application.routes.draw do

  scope '/records', as: "records", controller: :api  do
    post '/', action: :add
    get '/gender', action: :gender
    get '/name', action: :lname
    get '/birthdate', action: :birthdate
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
