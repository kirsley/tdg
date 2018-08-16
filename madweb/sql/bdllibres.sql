CREATE TABLE autor(
	idAutor INT AUTO_INCREMENT,
	nomAutor varchar(50),
	cognomAutor varchar(50),
	CONSTRAINT PKAutor PRIMARY KEY(idAutor)
);
	
CREATE TABLE classifcontinguts(
	idClassificacio INT AUTO_INCREMENT,
	classificacio VARCHAR(20),
	CONSTRAINT PKClass PRIMARY KEY(idClassificacio)
);

CREATE TABLE tipus(
	idTipus INT AUTO_INCREMENT,
	nomTipus varchar(50),
	constraint PKTipus Primary key(idTipus)
);

CREATE TABLE imatges (
  idImatge int NOT NULL AUTO_INCREMENT,
  tipusImatge varchar(25) NOT NULL,
  imatge longblob NOT NULL,
  tamanyImatge varchar(25) NOT NULL,
  image_ctgy varchar(25) NOT NULL,
  nomImatge varchar(50) NOT NULL,
  CONSTRAINT PKImatge PRIMARY KEY(idImatge)
);
	
CREATE TABLE element(
	idElement INT PRIMARY KEY AUTO_INCREMENT,
	titol VARCHAR(150),
	idAutor INT,
	idImatge int,
	anyPublicacio INT,
	tipusElement INT,
	CONSTRAINT FKAutor FOREIGN KEY(idAutor) REFERENCES autor(idAutor),
	CONSTRAINT FKTipus FOREIGN KEY(tipusElement) REFERENCES tipus(idTipus) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT FKImatgeLlibre FOREIGN KEY(idImatge) REFERENCES imatges(idImatge)
);

CREATE TABLE llibres(
	idLlibre INT,
	titolAlternatiu VARCHAR(150),
	numToms INT,
	llegit BOOLEAN,
	
	CONSTRAINT PKLlibres PRIMARY KEY(idLlibre),
	CONSTRAINT FKLlibre FOREIGN KEY(idLlibre) REFERENCES element(idElement) ON DELETE CASCADE
);

CREATE TABLE serie(
	idSerie INT,
	totalTemporades TINYINT,
	totalCapitols INT,

	CONSTRAINT PKSerie PRIMARY KEY(idSerie),
	CONSTRAINT FKSerie FOREIGN KEY(idSerie) REFERENCES element(idElement)  ON DELETE CASCADE
);

CREATE TABLE classificacions(
	idElement INT,
	idClassificacio INT,
	
	CONSTRAINT PKClassIf PRIMARY KEY(idElement,idClassificacio),
	CONSTRAINT FKElement FOREIGN KEY(idElement) REFERENCES element(idElement),
	CONSTRAINT FKClass FOREIGN KEY(idClassificacio) REFERENCES classifcontinguts(idClassificacio)  ON DELETE CASCADE
);
