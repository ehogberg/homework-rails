Rails.application.routes.draw do
  post 'api/add'

  get 'api/gender'

  get 'api/name'

  get 'api/birthdate'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
