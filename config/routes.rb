Rails.application.routes.draw do
  
  resources :books, only: [:create, :destroy] do
    collection do
      get 'overdue'
    end
  end

  resources :transactions, only: [:create, :update]

  resources :users, only: [] do
    collection do
      get 'checked_out_books/:id', to: 'users#checked_out_books'
    end
  end


end
