class Book < ApplicationRecord
    has_many :transactions

    validates :ISBN, presence: true
    validates :total_copies, :available_copies, numericality: { greater_than_or_equal_to: 0 }
    validates :title, presence: true
    validates :author, presence: true

    def self.add_or_update_book(book_params)
        existing_book = find_by(ISBN: book_params[:ISBN])
    
        if existing_book
          existing_book.update(total_copies: existing_book.total_copies + 1, available_copies: existing_book.available_copies + 1)
          existing_book
        else
          new_book = new(book_params.merge(total_copies: 1, available_copies: 1))
          new_book.save ? new_book : nil
        end
      end
end
