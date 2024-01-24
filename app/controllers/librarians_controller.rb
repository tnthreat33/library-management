class LibrariansController < ApplicationController
  skip_before_action :verify_authenticity_token

    def add_book
        book = Book.new(book_params)
    
        if book.save
          render json: book, status: :created
        else
          render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      def remove_book
        book = Book.find_by(id: params[:id])
         if book.present?
          book.destroy
          render json: { message: "Book removed successfully!" }
        else
          render json: { error: "Book not found." }, status: :not_found
        end
      end

      def overdue_books
        overdue_transactions = Transaction.where("due_date < ? AND transaction_type = ?", Date.today, Transaction.transaction_types[:check_out])
        
        render json: overdue_transactions
      end

      private
    
      def book_params
        params.permit(:ISBN, :title, :author, :total_copies, :available_copies)
      end

end

