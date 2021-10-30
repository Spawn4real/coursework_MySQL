DROP DATABASE IF EXISTS online_library;
CREATE DATABASE online_library;


use online_library;


DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, 
    firstname VARCHAR(100),
    lastname VARCHAR(100), 
    email VARCHAR(100) UNIQUE,
    password_hash varchar(100),
    phone BIGINT unsigned,
    INDEX users_firstname_lastname_idx(firstname, lastname),
    UNIQUE INDEX email_unique (email),
    UNIQUE INDEX phone_unique (phone)
);

   
DROP TABLE IF EXISTS books;
CREATE TABLE books (
	id serial primary key,
	name varchar(100) DEFAULT NULL,
	pages smallint DEFAULT null,
	description TEXT DEFAULT NULL, 
	rating TINYINT UNSIGNED DEFAULT NULL,
	logo VARCHAR(31) DEFAULT NULL
);	
	
DROP TABLE IF exists author;	
CREATE TABLE author (
	id SERIAL PRIMARY KEY,
	author_firstname_lastname VARCHAR(100) NOT NULL
);

DROP TABLE IF exists autor_books;	
CREATE TABLE author_books (
	book_id BIGINT UNSIGNED NOT NULL,
    author_id BIGINT UNSIGNED NOT NULL,
    published_at YEAR DEFAULT NULL,
    INDEX fk_author_books_book_idx (book_id),
    INDEX fk_author_books_category_idx (author_id),
    CONSTRAINT fk_author_books_book FOREIGN KEY (book_id) REFERENCES books (id),
    CONSTRAINT fk_author_books_author FOREIGN KEY (author_id) REFERENCES author (id),
    PRIMARY KEY (book_id, author_id)
); 



DROP TABLE IF exists categories;
CREATE TABLE categories (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL unique
);


DROP TABLE IF exists categories_books;
CREATE TABLE categories_books (
	book_id BIGINT UNSIGNED NOT NULL,
    category_id BIGINT UNSIGNED NOT NULL,
    INDEX fk_categories_books_book_idx (book_id),
    INDEX fk_categories_books_category_idx (category_id),
    CONSTRAINT fk_categories_books_book FOREIGN KEY (book_id) REFERENCES books (id),
    CONSTRAINT fk_categories_books_category FOREIGN KEY (category_id) REFERENCES categories (id),
    PRIMARY KEY (book_id, category_id)
);	

DROP TABLE IF exists reviews;
CREATE TABLE reviews (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    book_id BIGINT UNSIGNED NOT NULL,
    txt TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX fk_reviews_user_idx (user_id),
    INDEX fk_reviews_book_idx (book_id),
    CONSTRAINT fk_reviews_users_user FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_reviews_books_book FOREIGN KEY (book_id) REFERENCES books (id)
);


DROP TABLE IF exists review_likes;
CREATE TABLE review_likes (
	user_id BIGINT UNSIGNED NOT NULL,
    review_id BIGINT UNSIGNED NOT NULL,
    like_type BOOLEAN,
    INDEX fk_likes_users_idx (user_id),
    INDEX fk_likes_reviews_idx (review_id),
    CONSTRAINT fk_likes_users_user FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_likes_reviews_review FOREIGN KEY (review_id) REFERENCES reviews (id),
    PRIMARY KEY (user_id, review_id)
);

DROP TABLE IF exists rating_votes;
CREATE TABLE rating_votes (
	user_id BIGINT UNSIGNED NOT NULL,
	book_id BIGINT UNSIGNED NOT NULL,
	vote TINYINT UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- возможно пригодится, чтобы давать свежим голосам больший вес
	INDEX fk_votes_author_idx (user_id),
    INDEX fk_votes_book_idx (book_id),
    CONSTRAINT fk_votes_users_user FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_votes_books_book FOREIGN KEY (book_id) REFERENCES books (id),
    PRIMARY KEY (user_id, book_id)
);


DROP TABLE IF exists users_library;
CREATE TABLE users_library (
	user_id BIGINT UNSIGNED NOT NULL,
    book_id BIGINT UNSIGNED NOT NULL,
    INDEX fk_users_library_user_idx (user_id),
    INDEX fk_users_library_book_idx (book_id),
    CONSTRAINT fk_users_library_user FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_users_library_book FOREIGN KEY (book_id) REFERENCES books (id),
    PRIMARY KEY (user_id, book_id)
);

DROP TABLE IF exists medias;
CREATE TABLE medias (
	book_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	media_type ENUM('img', 'pdf', 'file') NOT NULL,
	INDEX fk_images_books_book_idx (book_id),
    CONSTRAINT fk_images_books_book FOREIGN KEY (book_id) REFERENCES books (id)
);




















