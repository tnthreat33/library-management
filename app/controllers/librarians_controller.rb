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

      private
    
      def book_params
        params.permit(:ISBN, :title, :author, :total_copies, :available_copies)
      end

end

