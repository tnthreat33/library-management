# require 'faker'

# # Librarian
# librarian = User.create!(
#   name: "Jill Librarian",
#   email: "jill@gmail.com",
#   librarian: true
# )

# # Regular Users
# user1 = User.create!(
#   name: "John Smith",
#   email: "john@gmail.com",
#   librarian: false
# )

# user2 = User.create!(
#   name: "Jane Doe",
#   email: "jane@gmail.com",
#   librarian: false
# )

# user3 = User.create!(
#   name: "Tom Jones",
#   email: "tom@gmail.com",
#   librarian: false
# )
# 20.times do
#     Book.create!(
#       ISBN: Faker::Code.isbn,
#       title: Faker::Book.title,
#       author: Faker::Book.author,
#       total_copies: 2,
#       available_copies: 2
#     )
#   end

#   puts "completed seed"