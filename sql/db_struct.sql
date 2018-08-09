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

CREATE TABLE users (
     id int NOT NULL AUTO_INCREMENT,
     username VARCHAR(50),
     user_pass VARCHAR(255),
     isAdmin INT,
     CONSTRAINT PKusers PRIMARY KEY(id)
);

insert into users (username,user_pass,isAdmin) values ('kirsley','85ec9aa83eaf2427a3f49a2b0d0b5b47',1);

