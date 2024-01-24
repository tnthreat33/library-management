class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum transaction_type: { check_out: 0, return: 1 }
end
