class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :book_id, :transaction_type, :transaction_date, :due_date

belongs_to :book
end
