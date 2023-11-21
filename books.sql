CREATE DATABASE library;
use books;
CREATE TABLE books (`id` BIGINT NOT NULL AUTO_INCREMENT, `title` VARCHAR(2048) NOT NULL, `author` VARCHAR(2048) NOT NULL, `image_pathLocation` VARCHAR(1024) NOT NULL, PRIMARY KEY(`id`));

INSERT INTO books (title, author, image_pathLocation) Values ('Exploring War and Weapons', 'Brian Williams', 'images/resized-ExploringWarandWeapons.jpg');
INSERT INTO books (title, author, image_pathLocation) Values ('Exploring Animal Journeys', 'Theodore Rowland-Entwistle', 'images/resized-ExploringAnimalJourneys.jpg');