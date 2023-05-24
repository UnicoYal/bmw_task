Rails.application.routes.draw do

  root 'courses#index', as: "home"
  get 'courses/show/:id', to: "courses#show", as: "show_cu"
  post 'courses/sign/:id', to: "courses#sign"
  post 'courses/unsubscribe/:id', to: "courses#unsubscribe"
  post '/courses/update/:id', to: "courses#update"
  post '/courses/edit/:id', to: "courses#edit"
  post '/courses/destroy/:id', to: "courses#destroy"
  post 'courses/create_course', to: "courses#create_course"
  post 'courses/create', to: "courses#create"

  resource :session, only: %i[new create destroy]
  get 'sessions/new', as: 'login'

  get 'ratings/index', as: "rate"
  get 'ratings/download', as: "down"

  get 'users/index', as: 'all'
  get 'users/new', as: "new_user"
  get 'users/edit', as: "edit_user"
  get 'users/create'
  get 'users/profile', as: "profile"
  get 'users/update'
  post 'users/get_my_courses', to: "users#get_my_courses", as: "my_courses"
  post 'users/update'
  post 'users/create'

  get 'lessons/index'
  get 'lessons/show/:id', to: "lessons#show", as: "show_les"
  post 'lessons/new/:id', to: "lessons#new", as: "new_les"
  post 'lessons/create/:id', to: "lessons#create", as: "create_les"
  post 'lessons/destroy/:id', to: "lessons#destroy"

  get 'tests/index'
  get 'tests/show/:id', to: "tests#show", as: "show_test"
  get 'tests/ans', to: "tests#ans", as: "tests_ans"
  get 'tests/questions_api/:id', to: "tests#questions_api", as: "q_api"
  post 'tests/results', to: "tests#results_post"
  post 'tests/show_question', to: "tests#show_question", as: "show_question"
  post 'tests/testing', to: "tests#testing"
  post 'tests/select_num/:id', to: "tests#select_num", as: "selnum_test"
  post 'tests/create/:id', to: "tests#create", as: "create_test"
  post 'tests/create_questions/:id', to: "tests#create_questions", as: "cr_quests"
  post 'tests/destroy/:id', to: "tests#destroy"

  post 'admins/update_role/:id', to: "admins#update_role"
  post 'admins/changing_role/:id', to: "admins#changing_role"
  post 'admins/modal_create_user', to: "admins#modal_create_user"
  post 'admins/create_user', to: "admins#create_user"
  post 'admins/destroy_user/:id', to: "admins#destroy_user"
  post '/admins/add_user/:id', to: "admins#add_user"
  post '/admins/adding_to_course/:id', to: "admins#adding_to_course"
  post '/admins/remove_user/:id', to: "admins#remove_user"
  post '/admins/removing_from_course/:id', to: "admins#removing_from_course"

  get 'pages/main'

end
