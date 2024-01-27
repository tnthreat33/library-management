class User < ApplicationRecord
    has_many :transactions
  
    def can_check_out_book
      #checks User has less than 3 books out and no overdue books
      overdue_books = transactions.where("due_date < ?", Date.today)
      checked_out_transactions = transactions.where(transaction_type: Transaction.transaction_types[:checked_out])
    
      if checked_out_transactions.count >= 3 || !overdue_books.empty?
        return false
      else
        return true
      end
    end
    
  end
