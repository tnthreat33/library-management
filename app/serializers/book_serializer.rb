class BookSerializer < ActiveModel::Serializer
  attributes :id, :ISBN, :title, :author, :total_copies, :available_copies

   has_many :transactions
end
