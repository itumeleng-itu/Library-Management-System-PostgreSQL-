DELETE FROM books WHERE id = 10;

DELETE FROM books WHERE title = 'The Hobbit';

DELETE FROM books WHERE published_year < 1850;

--Delete an author by ID
DELETE FROM authors WHERE id = 10;

-- Delete 5: Delete an author by name
DELETE FROM authors WHERE name = 'J.R.R. Tolkien';

-- Delete 6: Delete a patron by ID
DELETE FROM patrons WHERE id = 10;

-- Delete 7: Delete a patron by email
DELETE FROM patrons WHERE email = 'jack@example.com';

-- Delete 8: Delete patrons with no borrowed books
DELETE FROM patrons 
WHERE array_length(borrowed_books, 1) IS NULL 
   OR array_length(borrowed_books, 1) = 0;

-- Delete 9: Delete all unavailable books
DELETE FROM books WHERE available = FALSE;

-- Delete 10: Delete books by specific genre
DELETE FROM books WHERE 'Fantasy' = ANY(genres);


-- Preview books to be deleted by title
SELECT * FROM books WHERE title = 'The Hobbit';

-- Preview books to be deleted by author
SELECT b.* FROM books b
JOIN authors a ON b.author_id = a.id
WHERE a.name = 'J.R.R. Tolkien';

-- Preview patrons with no borrowed books
SELECT * FROM patrons 
WHERE array_length(borrowed_books, 1) IS NULL 
   OR array_length(borrowed_books, 1) = 0;

-- Check deletions
SELECT COUNT(*) AS remaining_books FROM books;
SELECT COUNT(*) AS remaining_authors FROM authors;
SELECT COUNT(*) AS remaining_patrons FROM patrons;