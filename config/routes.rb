Rails.application.routes.draw do
  get 'ratings/index', as: "rate"
  resource :session, only: %i[new create destroy]
  get 'users/index'
  get 'users/new', as: "new_user"
  get 'users/edit', as: "edit_user"
  get 'users/create'
  get 'users/profile', as: "profile"
  get 'users/update'
  post 'users/get_my_courses', to: "users#get_my_courses", as: "my_courses"
  get 'pages/main'
  root 'courses#index', as: "home"
  get 'courses/show/:id', to: "courses#show", as: "show_cu"
  post 'courses/sign/:id', to: "courses#sign"
  post 'courses/unsubscribe/:id', to: "courses#unsubscribe"

  post '/courses/update/:id', to: "courses#update"
  post '/courses/edit/:id', to: "courses#edit"
  post '/courses/add_user/:id', to: "courses#add_user"
  post '/courses/adding_to_course/:id', to: "courses#adding_to_course"

  post '/courses/remove_user/:id', to: "courses#remove_user"
  post '/courses/removing_from_course/:id', to: "courses#removing_from_course"

  get 'ratings/download', as: "down"
  get 'sessions/new', as: 'login'
  get 'users/index', as: 'all'
  post 'users/update'
  post 'users/create'
end
