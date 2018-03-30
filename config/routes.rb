Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }, controllers: { registrations: "user_registrations" }



  resources :products do
    resources :comments
  end

  resources :users

  root 'simple_pages#landing_page'

  get 'simple_pages/about'

  get 'simple_pages/contact'

  get 'simple_pages/index'

  post 'simple_pages/thank_you'

  post 'payments/create'

  get 'payments/create'






  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders, only: [:index, :show, :create, :destroy]

end
