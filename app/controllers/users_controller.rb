class UsersController < ApplicationController


  def checked_out_books
    user = User.find(params[:id])
    checked_out_books = user.transactions.where(transaction_type: Transaction.transaction_types[:check_out]).map(&:book)

    render json: checked_out_books
  end


  
end