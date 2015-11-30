Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :resources do
        resources :context_loggers, only: [:index]
      end
    end
  end
end
