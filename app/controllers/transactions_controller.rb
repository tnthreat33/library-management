class TransactionsController < ApplicationController

    def create
        user = User.find(params[:user_id])
        book = Book.find(params[:book_id])
    
        if user.can_check_out_book && book.available_copies.positive?
            transaction = user.transactions.create(
            book: book,
            transaction_type: Transaction.transaction_types[:check_out],
            transaction_date: Date.today,
            due_date: 2.weeks.from_now
          )
    
          book.update(available_copies: book.available_copies - 1)
    
          render json: transaction
        else
          render json: { error: "Invalid request for check-out." }, status: :unprocessable_entity
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
