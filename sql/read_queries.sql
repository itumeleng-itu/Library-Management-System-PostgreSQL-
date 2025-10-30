--Get all books
SELECT * FROM books;

--Get all books with author information (JOIN)
SELECT 
    b.id,
    b.title,
    a.name AS author_name,
    b.genres,
    b.published_year,
    b.available
FROM books b
JOIN authors a ON b.author_id = a.id
ORDER BY b.title;

--Get a book by title
SELECT * FROM books 
WHERE title = '1984';

--Get a book by title (case-insensitive search)
SELECT * FROM books 
WHERE LOWER(title) = LOWER('1984');

--Get all books by a specific author
SELECT b.* 
FROM books b
JOIN authors a ON b.author_id = a.id
WHERE a.name = 'George Orwell';

--Get all books by a specific author (with author details)
SELECT 
    b.title,
    b.genres,
    b.published_year,
    b.available,
    a.name AS author_name,
    a.nationality
FROM books b
JOIN authors a ON b.author_id = a.id
WHERE a.name = 'George Orwell';

--Get all available books
SELECT * FROM books 
WHERE available = TRUE;

--Get all available books with author names
SELECT 
    b.title,
    a.name AS author,
    b.published_year,
    b.genres
FROM books b
JOIN authors a ON b.author_id = a.id
WHERE b.available = TRUE
ORDER BY b.title;

--Get all authors
SELECT * FROM authors
ORDER BY name;

--Get all patrons
SELECT * FROM patrons
ORDER BY name;

--Get patrons with borrowed books
SELECT 
    name,
    email,
    array_length(borrowed_books, 1) AS books_borrowed
FROM patrons
WHERE array_length(borrowed_books, 1) > 0;

--Count total books, authors, and patrons
SELECT 
    (SELECT COUNT(*) FROM books) AS total_books,
    (SELECT COUNT(*) FROM authors) AS total_authors,
    (SELECT COUNT(*) FROM patrons) AS total_patrons;