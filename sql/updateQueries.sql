--Mark a book as borrowed (by ID)
UPDATE books 
SET available = FALSE 
WHERE id = 1;

--Mark a book as borrowed (by title)
UPDATE books 
SET available = FALSE 
WHERE title = '1984';

--Mark a book as returned/available (by ID)
UPDATE books 
SET available = TRUE 
WHERE id = 1;

--Add a new genre to an existing book
UPDATE books 
SET genres = array_append(genres, 'Classic') 
WHERE id = 1;

--Add multiple genres to a book
UPDATE books 
SET genres = genres || ARRAY['Modern Classic', 'Must Read']
WHERE id = 1;

--Add a borrowed book to a patron's record
UPDATE patrons 
SET borrowed_books = array_append(borrowed_books, 1) 
WHERE id = 1;

--Remove a borrowed book from patron's record (return book)
UPDATE patrons 
SET borrowed_books = array_remove(borrowed_books, 1) 
WHERE id = 1;

-- Update 8: Complete borrow transaction (book + patron)
UPDATE books SET available = FALSE WHERE id = 2;
UPDATE patrons SET borrowed_books = array_append(borrowed_books, 2) WHERE id = 3;

--Mark book as available
UPDATE books SET available = TRUE WHERE id = 2;
UPDATE patrons SET borrowed_books = array_remove(borrowed_books, 2) WHERE id = 3;

--Update author information
UPDATE authors 
SET nationality = 'English' 
WHERE name = 'George Orwell';

--Update patron email
UPDATE patrons 
SET email = 'alice.johnson@newmail.com' 
WHERE name = 'Alice Johnson';

--Update book publication year
UPDATE books 
SET published_year = 1950 
WHERE title = '1984';

--Verify updates
SELECT * FROM books WHERE id = 1;
SELECT * FROM patrons WHERE id = 1;