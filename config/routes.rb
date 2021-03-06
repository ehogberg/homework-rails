Rails.application.routes.draw do

  get 'job/:id' => 'job#show', as: "job_info"

  get 'admin/purge'

  scope '/records', as: "records", controller: :api  do
    put '/', action: :add
    post '/upload', action: :upload
    get '/gender', action: :gender
    get '/name', action: :lname
    get '/birthdate', action: :birthdate
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
