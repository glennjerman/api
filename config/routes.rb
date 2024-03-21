Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/login", to: "sessions#create"
      delete "/logout", to: "sessions#destroy"
      resources :users
      post "/tasks/routine", to: "tasks#create_routine"
      patch "/tasks/:id/routine", to: "tasks#update_routine"
      patch "/tasks/:id/completed", to: "tasks#complete"
      patch "/tasks/:id/uncomplete", to: "tasks#uncomplete"
      resources :tasks
      post "/favorite_tasks/routine", to: "favorite_tasks#create_routine"
      patch "/favorite_tasks/:id/routine", to: "favorite_tasks#update_routine"
      resources :favorite_tasks
    end
  end
end
