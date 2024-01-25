Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :librarians, only: [] do
    collection do
      post 'add_book'
      delete 'remove_book/:id', to: 'librarians#remove_book'
      get 'overdue_books'
      
    end
  end

  resources :users, only: [] do
    collection do
      post 'check_out_book'
      post 'return_book'
      get 'checked_out_books/:id', to: 'users#checked_out_books'
    end
  end


end
