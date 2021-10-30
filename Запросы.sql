USE online_library;

CREATE OR REPLACE VIEW books_table AS
SELECT
	books.name,
	(SELECT author_firstname_lastname FROM author WHERE id = pg.author_id) AS author,
	published_at,
	pages,
	books.description,
	rating / 10 AS rating
FROM books JOIN author_books AS pg ON books.id = pg.book_id;

SELECT * FROM books_table;


SELECT
	books.name,
	rating / 10 AS rating,
	vote,
	(select firstname FROM users WHERE user_id = id) AS user
FROM rating_votes JOIN books ON book_id = id ORDER BY name,vote;