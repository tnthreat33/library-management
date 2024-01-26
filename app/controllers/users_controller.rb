class UsersController < ApplicationController

  
    def check_out_book
        user = User.find(params[:userId])
  
      if user.can_check_out_book
        book = Book.find(params[:book_id])
  
        if book.available_copies.positive?
          transaction = user.transactions.create(
            book: book,
            transaction_type: Transaction.transaction_types[:check_out],
            transaction_date: Date.today,
            due_date: 2.weeks.from_now
          )
  
          book.update(available_copies: book.available_copies - 1)
  
          render json: transaction 
        else
          render json: { error: "No available copies of the book." }, status: :unprocessable_entity
        end
      else
        render json: { error: "User is not eligible to check out a book." }, status: :unprocessable_entity
      end
    end

    def return_book
    user = User.find(params[:userId])
    transaction = user.transactions.find_by(id: params[:transaction_id])

    if transaction.present?
      transaction.update(transaction_type: Transaction.transaction_types[:return])

      transaction.book.update(available_copies: transaction.book.available_copies + 1)

      render json: { message: "Book returned successfully!" }
    else
      render json: { error: "Invalid transaction or book is not checked out by the user." }, status: :unprocessable_entity
    end
  end

  def checked_out_books
    user = User.find(params[:id])
    checked_out_books = user.transactions.where(transaction_type: Transaction.transaction_types[:check_out]).map(&:book)

    render json: checked_out_books
  end


  
end