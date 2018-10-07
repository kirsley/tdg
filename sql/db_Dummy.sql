-- languages
--	ID (Int)
--	lang (Varchar)
--	langNice (VarChar)

CREATE TABLE language(
	id INT AUTO_INCREMENT,
	lang varchar(50),
	langShort varchar(50),
	CONSTRAINT PKLang PRIMARY KEY(id)
);

INSERT INTO language(lang,langShort) VALUES ('Espa&ntilde;ol','esp'),('Catal&agrave;','cat'),('English','eng');
	
-- Category
-- 	ID (int)
-- 	url (VarChar)

CREATE TABLE category(
	id INT AUTO_INCREMENT,
	url VARCHAR(100),
	CONSTRAINT PKCat PRIMARY KEY(id)
);
INSERT INTO category(url) VALUES ('categoria-0'),('categoria-1'),('categoria-2'),('categoria-3'),('categoria-4'),
('categoria-5'),('categoria-6'),('categoria-7'),('categoria-8'),('categoria-9'),('categoria-10'),('categoria-11'),
('categoria-12'),('categoria-13'),('categoria-14'),('categoria-15'),('categoria-16'),('categoria-17'),('categoria-18'),
('categoria-19'),('categoria-20'),('categoria-21'),('categoria-22'),('categoria-23'),
('categoria-24'),('categoria-25'),('categoria-26'),('categoria-27'),('categoria-28'),('categoria-29');
-- catTrans
-- 	cat_id Refers to category.id
-- 	lang_id Refers to languages.id
-- 	translation (Varchar)

CREATE TABLE cat_trans(
	idElement INT PRIMARY KEY AUTO_INCREMENT,
	cat_id INT,
	lang_id INT,
	translation VARCHAR(100)
);

INSERT INTO cat_trans(cat_id,lang_id,translation) VALUES (1,1,'Categoria 0 - Esp'),(2,1,'Categoria 1 - Esp'),
(3,1,'Categoria 2 - Esp'),(4,1,'Categoria 3 - Esp'),(5,1,'Categoria 4 - Esp'),(6,1,'Categoria 5 - Esp'),
(7,1,'Categoria 6 - Esp'),(8,1,'Categoria 7 - Esp'),(9,1,'Categoria 8 - Esp'),(10,1,'Categoria 9 - Esp'),
(11,1,'Categoria 10 - Esp'),(12,1,'Categoria 11 - Esp'),(13,1,'Categoria 12 - Esp'),(14,1,'Categoria 13 - Esp'),
(15,1,'Categoria 14 - Esp'),(16,1,'Categoria 15 - Esp'),(17,1,'Categoria 16 - Esp'),(18,1,'Categoria 17 - Esp'),
(19,1,'Categoria 18 - Esp'),(20,1,'Categoria 19 - Esp'),(21,1,'Categoria 20 - Esp'),(22,1,'Categoria 21 - Esp'),
(23,1,'Categoria 22 - Esp'),(24,1,'Categoria 23 - Esp'),(25,1,'Categoria 24 - Esp'),(26,1,'Categoria 25 - Esp'),
(27,1,'Categoria 26 - Esp'),(28,1,'Categoria 27 - Esp'),(29,1,'Categoria 28 - Esp'),(30,1,'Categoria 29 - Esp'),
(1,2,'Categoria 0 - Cat'),(2,2,'Categoria 1 - Cat'),(3,2,'Categoria 2 - Cat'),(4,2,'Categoria 3 - Cat'),
(5,2,'Categoria 4 - Cat'),(6,2,'Categoria 5 - Cat'),(7,2,'Categoria 6 - Cat'),(8,2,'Categoria 7 - Cat'),
(9,2,'Categoria 8 - Cat'),(10,2,'Categoria 9 - Cat'),(11,2,'Categoria 10 - Cat'),(12,2,'Categoria 11 - Cat'),
(13,2,'Categoria 12 - Cat'),(14,2,'Categoria 13 - Cat'),(15,2,'Categoria 14 - Cat'),(16,2,'Categoria 15 - Cat'),
(17,2,'Categoria 16 - Cat'),(18,2,'Categoria 17 - Cat'),(19,2,'Categoria 18 - Cat'),(20,2,'Categoria 19 - Cat'),
(21,2,'Categoria 20 - Cat'),(22,2,'Categoria 21 - Cat'),(23,2,'Categoria 22 - Cat'),(24,2,'Categoria 23 - Cat'),
(25,2,'Categoria 24 - Cat'),(26,2,'Categoria 25 - Cat'),(27,2,'Categoria 26 - Cat'),(28,2,'Categoria 27 - Cat'),
(29,2,'Categoria 28 - Cat'),(30,2,'Categoria 29 - Cat'),(1,3,'Categoria 0 - Eng'),(2,3,'Categoria 1 - Eng'),
(3,3,'Categoria 2 - Eng'),(4,3,'Categoria 3 - Eng'),(5,3,'Categoria 4 - Eng'),(6,3,'Categoria 5 - Eng'),
(7,3,'Categoria 6 - Eng'),(8,3,'Categoria 7 - Eng'),(9,3,'Categoria 8 - Eng'),(10,3,'Categoria 9 - Eng'),
(11,3,'Categoria 10 - Eng'),(12,3,'Categoria 11 - Eng'),(13,3,'Categoria 12 - Eng'),(14,3,'Categoria 13 - Eng'),
(15,3,'Categoria 14 - Eng'),(16,3,'Categoria 15 - Eng'),(17,3,'Categoria 16 - Eng'),(18,3,'Categoria 17 - Eng'),
(19,3,'Categoria 18 - Eng'),(20,3,'Categoria 19 - Eng'),(21,3,'Categoria 20 - Eng'),(22,3,'Categoria 21 - Eng'),
(23,3,'Categoria 22 - Eng'),(24,3,'Categoria 23 - Eng'),(25,3,'Categoria 24 - Eng'),(26,3,'Categoria 25 - Eng'),
(27,3,'Categoria 26 - Eng'),(28,3,'Categoria 27 - Eng'),(29,3,'Categoria 28 - Eng'),(30,3,'Categoria 29 - Eng');
-- Product
-- 	ID (int)
-- 	name (VarChar)
-- 	url (VarChar)
-- 	imgPath (varChar)
-- 	cat_id Refers to category.ID
CREATE TABLE product (
	id INT AUTO_INCREMENT,
	name VARCHAR(150),
	url VARCHAR(150),
	img_path VARCHAR(150),
	cat_id INT,
	CONSTRAINT PKProd PRIMARY KEY(id)
);

INSERT into product (name,url,img_path,cat_id) values ('Plato 0', 'plato-0','uploads/sopa-de-melon-14.jpg',1),
('Plato 1', 'plato-1','uploads/sopa-de-melon-14.jpg',1),
('Plato 2', 'plato-2','uploads/sopa-de-melon-14.jpg',1),
('Plato 3', 'plato-3','uploads/sopa-de-melon-14.jpg',1),
('Plato 4', 'plato-4','uploads/sopa-de-melon-14.jpg',1),
('Plato 5', 'plato-5','uploads/sopa-de-melon-14.jpg',1),
('Plato 6', 'plato-6','uploads/sopa-de-melon-14.jpg',1),
('Plato 7', 'plato-7','uploads/sopa-de-melon-14.jpg',1),
('Plato 8', 'plato-8','uploads/sopa-de-melon-14.jpg',1),
('Plato 9', 'plato-9','uploads/sopa-de-melon-14.jpg',1),
('Plato 10', 'plato-10','uploads/sopa-de-melon-14.jpg',2),
('Plato 11', 'plato-11','uploads/sopa-de-melon-14.jpg',2),
('Plato 12', 'plato-12','uploads/sopa-de-melon-14.jpg',2),
('Plato 13', 'plato-13','uploads/sopa-de-melon-14.jpg',2),
('Plato 14', 'plato-14','uploads/sopa-de-melon-14.jpg',2),
('Plato 15', 'plato-15','uploads/sopa-de-melon-14.jpg',3),
('Plato 16', 'plato-16','uploads/sopa-de-melon-14.jpg',3),
('Plato 17', 'plato-17','uploads/sopa-de-melon-14.jpg',3),
('Plato 18', 'plato-18','uploads/sopa-de-melon-14.jpg',3),
('Plato 19', 'plato-19','uploads/sopa-de-melon-14.jpg',3),
('Plato 20', 'plato-20','uploads/sopa-de-melon-14.jpg',3),
('Plato 21', 'plato-21','uploads/sopa-de-melon-14.jpg',3),
('Plato 22', 'plato-22','uploads/sopa-de-melon-14.jpg',3),
('Plato 23', 'plato-23','uploads/sopa-de-melon-14.jpg',3),
('Plato 24', 'plato-24','uploads/sopa-de-melon-14.jpg',3),
('Plato 25', 'plato-25','uploads/sopa-de-melon-14.jpg',3),
('Plato 26', 'plato-26','uploads/sopa-de-melon-14.jpg',3),
('Plato 27', 'plato-27','uploads/sopa-de-melon-14.jpg',3),
('Plato 28', 'plato-28','uploads/sopa-de-melon-14.jpg',3),
('Plato 29', 'plato-29','uploads/sopa-de-melon-14.jpg',3),
('Plato 30', 'plato-30','uploads/sopa-de-melon-14.jpg',4),
('Plato 31', 'plato-31','uploads/sopa-de-melon-14.jpg',4),
('Plato 32', 'plato-32','uploads/sopa-de-melon-14.jpg',4),
('Plato 33', 'plato-33','uploads/sopa-de-melon-14.jpg',4),
('Plato 34', 'plato-34','uploads/sopa-de-melon-14.jpg',5),
('Plato 35', 'plato-35','uploads/sopa-de-melon-14.jpg',5);

-- prodTrans
-- 	prod_id Refers to Product.ID
-- 	lang_id Refers to languages.ID
-- 	translation (Varchar)

CREATE TABLE prod_trans(
	idElement INT PRIMARY KEY AUTO_INCREMENT,
	prod_id INT,
	lang_id INT,
	translation VARCHAR(100)
);
INSERT INTO prod_trans(prod_id,lang_id,translation) VALUES(1,1,'Plato 0 Esp'),(2,1,'Plato 1 Esp'),(3,1,'Plato 2 Esp'),
(4,1,'Plato 3 Esp'),(5,1,'Plato 4 Esp'),(6,1,'Plato 5 Esp'),(7,1,'Plato 6 Esp'),(8,1,'Plato 7 Esp'),
(9,1,'Plato 8 Esp'),(10,1,'Plato 9 Esp'),(11,1,'Plato 10 Esp'),(12,1,'Plato 11 Esp'),(13,1,'Plato 12 Esp'),
(14,1,'Plato 13 Esp'),(15,1,'Plato 14 Esp'),(16,1,'Plato 15 Esp'),(17,1,'Plato 16 Esp'),(18,1,'Plato 17 Esp'),
(19,1,'Plato 18 Esp'),(20,1,'Plato 19 Esp'),(21,1,'Plato 20 Esp'),(22,1,'Plato 21 Esp'),(23,1,'Plato 22 Esp'),
(24,1,'Plato 23 Esp'),(25,1,'Plato 24 Esp'),(26,1,'Plato 25 Esp'),(27,1,'Plato 26 Esp'),(28,1,'Plato 27 Esp'),
(29,1,'Plato 28 Esp'),(30,1,'Plato 29 Esp'),(31,1,'Plato 30 Esp'),(32,1,'Plato 31 Esp'),(33,1,'Plato 32 Esp'),
(34,1,'Plato 33 Esp'),(35,1,'Plato 34 Esp'),(36,1,'Plato 35 Esp'),(1,2,'Plato 0 Cat'),(2,2,'Plato 1 Cat'),
(3,2,'Plato 2 Cat'),(4,2,'Plato 3 Cat'),(5,2,'Plato 4 Cat'),(6,2,'Plato 5 Cat'),(7,2,'Plato 6 Cat'),
(8,2,'Plato 7 Cat'),(9,2,'Plato 8 Cat'),(10,2,'Plato 9 Cat'),(11,2,'Plato 10 Cat'),(12,2,'Plato 11 Cat'),
(13,2,'Plato 12 Cat'),(14,2,'Plato 13 Cat'),(15,2,'Plato 14 Cat'),(16,2,'Plato 15 Cat'),(17,2,'Plato 16 Cat'),
(18,2,'Plato 17 Cat'),(19,2,'Plato 18 Cat'),(20,2,'Plato 19 Cat'),(21,2,'Plato 20 Cat'),(22,2,'Plato 21 Cat'),
(23,2,'Plato 22 Cat'),(24,2,'Plato 23 Cat'),(25,2,'Plato 24 Cat'),(26,2,'Plato 25 Cat'),(27,2,'Plato 26 Cat'),
(28,2,'Plato 27 Cat'),(29,2,'Plato 28 Cat'),(30,2,'Plato 29 Cat'),(31,2,'Plato 30 Cat'),(32,2,'Plato 31 Cat'),
(33,2,'Plato 32 Cat'),(34,2,'Plato 33 Cat'),(35,2,'Plato 34 Cat'),(36,2,'Plato 35 Cat'),(1,3,'Plato 0 Eng'),
(2,3,'Plato 1 Eng'),(3,3,'Plato 2 Eng'),(4,3,'Plato 3 Eng'),(5,3,'Plato 4 Eng'),(6,3,'Plato 5 Eng'),
(7,3,'Plato 6 Eng'),(8,3,'Plato 7 Eng'),(9,3,'Plato 8 Eng'),(10,3,'Plato 9 Eng'),(11,3,'Plato 10 Eng'),
(12,3,'Plato 11 Eng'),(13,3,'Plato 12 Eng'),(14,3,'Plato 13 Eng'),(15,3,'Plato 14 Eng'),(16,3,'Plato 15 Eng'),
(17,3,'Plato 16 Eng'),(18,3,'Plato 17 Eng'),(19,3,'Plato 18 Eng'),(20,3,'Plato 19 Eng'),(21,3,'Plato 20 Eng'),
(22,3,'Plato 21 Eng'),(23,3,'Plato 22 Eng'),(24,3,'Plato 23 Eng'),(25,3,'Plato 24 Eng'),(26,3,'Plato 25 Eng'),
(27,3,'Plato 26 Eng'),(28,3,'Plato 27 Eng'),(29,3,'Plato 28 Eng'),(30,3,'Plato 29 Eng'),(31,3,'Plato 30 Eng'),
(32,3,'Plato 31 Eng'),(33,3,'Plato 32 Eng'),(34,3,'Plato 33 Eng'),(35,3,'Plato 34 Eng'),(36,3,'Plato 35 Eng');

CREATE TABLE users (
     id int NOT NULL AUTO_INCREMENT,
     username VARCHAR(50),
     user_pass VARCHAR(255),
     isAdmin INT,
     CONSTRAINT PKusers PRIMARY KEY(id)
);

insert into users (username,user_pass,isAdmin) values ('kirsley','85ec9aa83eaf2427a3f49a2b0d0b5b47',1);

