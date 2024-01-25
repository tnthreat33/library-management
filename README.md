# Coding Assignment
This simple Rails application provides an API for managing a library's book inventory. It includes two main components: Librarian endpoints for book management and User endpoints for end-user actions.

## LibrariansController
Endpoint: POST /librarians/add_book
Endpoint: DELETE /librarians/remove_book/:id
Endpoint: GET /librarians/overdue_books

## UsersController
Endpoint: POST /users/check_out_book
Endpoint: POST /users/return_book
Endpoint: GET /users/checked_out_books/:id

## Models
    -  Book
        Represents a book in the library.
        Attributes: ISBN, title, author, total_copies, available_copies.
        Associations: Has many transactions.
    -Transaction
        Represents a transaction involving a user and a book.
        Attributes: user_id, book_id, transaction_type, transaction_date, due_date.
        Associations: Belongs to a user and a book.
    -User
        Represents a user of the library.
        Attributes: name, email, librarian.
        Associations: Has many transactions.