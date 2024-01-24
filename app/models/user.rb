class User < ApplicationRecord
    has_many :transactions
    has_many :checked_out_books, through: :transactions, source: :book, conditions: ["return_date IS NULL"]

    def can_check_out_book?
        overdue_books = checked_out_books.where("due_date < ?", Date.today)
      
        if checked_out_books.count >= 3 || !overdue_books.empty?
          return false
        else
          return true
        end
      end
      
end
