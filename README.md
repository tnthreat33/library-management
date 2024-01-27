# Coding Assignment
This is a simple Library API built with Ruby on Rails. It allows librarians to manage books, users to check out and return books, and provides information on overdue books.

## BooksController
  - Librarian creates a new book
  - Endpoint: POST /books
  - Params:
    ```json
    {
      "ISBN": "isbn number",
      "title": "book title",
      "author": "author book"
    }

    -Librarian removes a book
        Endpoint: DELETE /books/:id

    -Librarian sees all overdue books
        Endpoint: GET /overdue_books

## TransactionsController
    -User checks out a book
        Endpoint: POST /transactions
        Params 
            {"user_id": "user id",
             "book_id": "book id"
            }

    -User returns a book
        Endpoint: PUT /transactions/:id

## UsersController
    - User see all their checked out books
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