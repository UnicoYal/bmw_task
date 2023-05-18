Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]
  get 'users/index'
  get 'users/new'
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

  get 'sessions/new', as: 'login'
  get 'users/index', as: 'all'
  post 'users/update'
  post 'users/create'
end
