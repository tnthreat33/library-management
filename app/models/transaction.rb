class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :transaction_date, presence: true
  validates :transaction_type, presence: true
  validates :due_date, presence: true
    

  enum transaction_type: { check_out: 0, return: 1 }
end
