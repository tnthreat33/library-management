# Coding Assignment
This simple Rails application provides an API for managing a library's book inventory. 

## LibrariansController
    -Librarian creates new book
        Endpoint: POST /librarians/add_book
    -Librarian removes a book
        Endpoint: DELETE /librarians/remove_book/:id
    -Librarian sees all overdue books
        Endpoint: GET /librarians/overdue_books

## UsersController
    -User checks out a book
        Endpoint: POST /users/check_out_book
    -User returns a book
        Endpoint: POST /users/return_book
    -User see all their checked out books
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