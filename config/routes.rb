Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :librarians, only: [] do
    collection do
      post 'add_book'
      delete 'remove_book/:id', to: 'librarians#remove_book'
      
  
    end
  end

end
