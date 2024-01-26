class User < ApplicationRecord
    has_many :transactions
  
    def can_check_out_book
      overdue_books = transactions.where("due_date < ? AND transaction_type = ?", Date.today, Transaction.transaction_types[:check_out])
      checked_out_transactions = transactions.where(transaction_type: Transaction.transaction_types[:check_out])
    
      if checked_out_transactions.count >= 3 || !overdue_books.empty?
        puts "User cannot check out a book."
        return false
      end
    end
  end
