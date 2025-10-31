--  Find books published after 1950
SELECT * FROM books 
WHERE published_year > 1950
ORDER BY published_year;

--Find books published after 1950 with author info
SELECT 
    b.title,
    a.name AS author,
    b.published_year,
    b.genres
FROM books b
JOIN authors a ON b.author_id = a.id
WHERE b.published_year > 1950
ORDER BY b.published_year;

--Find all American authors
SELECT * FROM authors 
WHERE nationality = 'American'
ORDER BY name;

--Set all books as available (bulk update)
UPDATE books SET available = TRUE;

--Find all books that are available AND published after 1950
SELECT * FROM books 
WHERE available = TRUE AND published_year > 1950
ORDER BY published_year;

--Find authors whose names contain "George"
SELECT * FROM authors 
WHERE name LIKE '%George%';

--Find authors whose names contain "George" (case-insensitive)
SELECT * FROM authors 
WHERE name ILIKE '%George%';

--Increment the published year 1869 by 1
UPDATE books 
SET published_year = published_year + 1 
WHERE published_year = 1869;

--Count books by each author
SELECT 
    a.name AS author_name,
    COUNT(b.id) AS book_count
FROM authors a
LEFT JOIN books b ON a.id = b.author_id
GROUP BY a.name
ORDER BY book_count DESC;

--Find the most popular genre
SELECT 
    UNNEST(genres) AS genre,
    COUNT(*) AS count
FROM books
GROUP BY genre
ORDER BY count DESC;

--Find books by specific genre
SELECT title, genres 
FROM books 
WHERE 'Dystopian' = ANY(genres);

--Find authors who died before 1900
SELECT 
    name,
    birth_year,
    death_year,
    (death_year - birth_year) AS age_at_death
FROM authors 
WHERE death_year < 1900
ORDER BY death_year;

--Find the oldest and newest books
(SELECT 'Oldest' AS category, title, published_year 
 FROM books 
 ORDER BY published_year ASC 
 LIMIT 1)
UNION ALL
(SELECT 'Newest' AS category, title, published_year 
 FROM books 
 ORDER BY published_year DESC 
 LIMIT 1);

--Find books NOT currently borrowed
SELECT b.title, b.available
FROM books b
WHERE b.id NOT IN (
    SELECT UNNEST(borrowed_books) 
    FROM patrons
    WHERE array_length(borrowed_books, 1) > 0
);

--Find patron names and their borrowed book titles
SELECT 
    p.name AS patron_name,
    p.email,
    ARRAY_AGG(b.title) AS borrowed_book_titles
FROM patrons p
JOIN LATERAL UNNEST(p.borrowed_books) AS book_id ON TRUE
JOIN books b ON b.id = book_id
GROUP BY p.name, p.email
ORDER BY p.name;

--Find books by decade
SELECT 
    FLOOR(published_year / 10) * 10 AS decade,
    COUNT(*) AS book_count
FROM books
GROUP BY decade
ORDER BY decade;

--Find British authors and their books
SELECT 
    a.name AS author,
    a.nationality,
    STRING_AGG(b.title, ', ') AS books
FROM authors a
LEFT JOIN books b ON a.id = b.author_id
WHERE a.nationality = 'British'
GROUP BY a.name, a.nationality
ORDER BY a.name;

--Find available books in multiple genres
SELECT 
    title,
    genres,
    array_length(genres, 1) AS genre_count
FROM books
WHERE available = TRUE 
  AND array_length(genres, 1) > 1
ORDER BY genre_count DESC;

--Calculate average publication year by nationality
SELECT 
    a.nationality,
    ROUND(AVG(b.published_year), 0) AS avg_pub_year,
    COUNT(b.id) AS book_count
FROM authors a
JOIN books b ON a.id = b.author_id
GROUP BY a.nationality
ORDER BY avg_pub_year DESC;

--Find patrons who have borrowed more than 1 book
SELECT 
    name,
    email,
    array_length(borrowed_books, 1) AS books_borrowed,
    borrowed_books
FROM patrons
WHERE array_length(borrowed_books, 1) > 1
ORDER BY books_borrowed DESC;