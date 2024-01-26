class BooksController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        book = Book.add_or_update_book(book_params)
    
        if book
          render json: book, status: :created
        else
          render json: { errors: ['Failed to add or update the book.'] }, status: :unprocessable_entity
        end
    end
  
    def destroy
      book = Book.find_by(id: params[:id])
  
      if book.present?
        book.destroy
        render json: { message: "Book removed successfully!" }
      else
        render json: { error: "Book not found." }, status: :not_found
      end
    end
  
    def overdue
      overdue_transactions = Transaction.where("due_date < ? AND transaction_type = ?", Date.today, Transaction.transaction_types[:check_out])
      render json: overdue_transactions
    end
  
    private
  
    def book_params
      params.permit(:ISBN, :title, :author, :total_copies, :available_copies)
    end
  end
