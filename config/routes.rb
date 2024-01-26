Rails.application.routes.draw do
  
  resources :books, only: [:create, :destroy] do
    collection do
      get 'overdue'
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
