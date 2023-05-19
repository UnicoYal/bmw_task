Rails.application.routes.draw do
  get 'tests/ans', to: "tests#ans", as: "tests_ans"
  post 'tests/show_question', to: "tests#show_question", as: "show_question"
  post 'tests/testing', to: "tests#testing"
  get 'tests/index'
  get 'tests/show/:id', to: "tests#show", as: "show_test"
  get 'lessons/index'
  get 'lessons/show/:id', to: "lessons#show", as: "show_les"
  get 'ratings/index', as: "rate"
  resource :session, only: %i[new create destroy]
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
  post 'users/update_role/:id', to: "users#update_role"
  post 'users/changing_role/:id', to: "users#changing_role"

  post 'courses/create_course', to: "courses#create_course"
  post 'courses/create', to: "courses#create"
end
