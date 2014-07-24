Rails.application.routes.draw do

  resources :cats, except: [:new, :edit]

 # cats GET    /cats(.:format)     cats#index
 #      POST   /cats(.:format)     cats#create
 #  cat GET    /cats/:id(.:format) cats#show
 #      PATCH  /cats/:id(.:format) cats#update
 #      PUT    /cats/:id(.:format) cats#update
 #      DELETE /cats/:id(.:format) cats#destroy
end
