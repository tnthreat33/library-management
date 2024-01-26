class TransactionsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    book = Book.find(params[:book_id])
  
    if !user.can_check_out_book
      render json: { error: "Sorry, you can't check out the book. You have reached the limit of checked-out books or have overdue books." }, status: :unprocessable_entity
    elsif book.available_copies <= 0
      render json: { error: "Sorry, no more available copies of this book. Please check back later." }, status: :unprocessable_entity
    else
      transaction = Transaction.create(
        user: user,
        book: book,
        transaction_type: Transaction.transaction_types[:checked_out],
        transaction_date: Date.today,
        due_date: 2.weeks.from_now
      )
  
      book.update(available_copies: book.available_copies - 1)
  
      render json: transaction
    end
  end
    
    def update
      transaction = Transaction.find_by(id: params[:id])
    
        if transaction.present?
          if transaction.return?
            render json: { error: "Book has already been returned." }, status: :unprocessable_entity
          else
            transaction.update(transaction_type: Transaction.transaction_types[:return])
            transaction.book.update(available_copies: transaction.book.available_copies + 1)
    
            render json: { message: "Book returned successfully!" }
          end
        else
          render json: { error: "Invalid transaction or book is not checked out by the user." }, status: :unprocessable_entity
        end
    end
    
end
