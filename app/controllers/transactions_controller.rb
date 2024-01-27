class TransactionsController < ApplicationController

  def create
    user = User.find_by(id: params[:user_id])
    book = Book.find_by(id: params[:book_id])

    if user.nil? || book.nil?
      render json: { error: "User or Book not found with the given ID." }, status: :not_found
      return
    end
  
    #if user has less than 3 books checked out and no overdue books
    if !user.can_check_out_book
      render json: { error: "Sorry, you can't check out the book. You have reached the limit of checked-out books or have overdue books." }, status: :unprocessable_entity
    #if book has available copies 
    elsif book.available_copies <= 0
      render json: { error: "Sorry, no more available copies of this book. Please check back later." }, status: :unprocessable_entity
    #if both user and book eligable to check out create transaction
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
          #check if book has already been returned
          if transaction.return?
            render json: { error: "Book has already been returned." }, status: :unprocessable_entity
          else
            #updates transaction_type to return and add copy back to book total
            transaction.update(transaction_type: Transaction.transaction_types[:return])
            transaction.book.update(available_copies: transaction.book.available_copies + 1)
    
            render json: { message: "Book returned successfully!", book: transaction.book }
          end
        end
    end
    
end
