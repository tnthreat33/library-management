class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token

  
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
  
end