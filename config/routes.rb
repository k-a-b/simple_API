Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module:  'api' do
    scope module: 'v1' do
      resources :links, only: [] do
        post :visited_links, on: :collection
        get :visited_domains, on: :collection
      end
    end
  end
end
