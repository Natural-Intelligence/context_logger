Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :resources do
        resources :context_logger, only: [:index]
      end
    end
  end
end
