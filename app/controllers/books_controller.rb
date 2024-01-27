class BooksController < ApplicationController
    
    def create
      #If ISBN is already in use add 1 to total copies and available copies or create new Book
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
        if book.total_copies > 1
          # If there is more than 1 copy, decrease total_copies by 1
          book.update(total_copies: book.total_copies - 1, available_copies: book.available_copies - 1)
          render json: { message: "Copy of Book removed successfully!", book: book  }
        else
          # If there is only 1 copy, delete the whole book
          book.destroy
          render json: { message: "Book removed successfully!" }
        end
    
      else
        render json: { error: "Book not found." }, status: :not_found
      end
    end
    
  
    def overdue
      #Find transaction with past due dates and transaction type is checked_out
      overdue_books = Transaction.where("due_date < ? AND transaction_type = ?", Date.today, Transaction.transaction_types[:checked_out]).map(&:book)
      
      render json: overdue_books
    end
  
    private
  
    def book_params
      params.permit(:ISBN, :title, :author, :total_copies, :available_copies)
    end
  end
