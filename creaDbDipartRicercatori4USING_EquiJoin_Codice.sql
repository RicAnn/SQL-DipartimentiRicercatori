DROP DATABASE IF EXISTS DipartimentiRicercatori;
CREATE DATABASE IF NOT EXISTS DipartimentiRicercatori;
USE DipartimentiRicercatori;

/*  creo la tabella Ricercatori */

CREATE TABLE Ricercatori(
    ID smallint(6) Primary Key,
    Nome varchar(20) not null,
    Cognome varchar(30) not null,
    Residenza varchar(40) default "*** Manca Residenza",
    Stipendio decimal(9,2),
    Codice char(5) references Dipartimenti(Codice) 
    On Delete set null
    On Update cascade,
    Unique(Cognome,Nome,Codice)
);

CREATE TABLE Dipartimenti(
    Codice char(5),
    Descrizione varchar(40) not null,
    Sede varchar(40),
    Primary Key (Codice),
    Unique (Descrizione)
);

INSERT INTO Dipartimenti (Codice, Descrizione,Sede) VALUES 
    ('01','Informatica','Via Piave 3, 38123 Povo (TN)'),
    ('02','Biologia','Via Piave 9, 38123 Povo (TN)'),
    ('03','Ingegneria','Via Colombo 10, 38123 Povo (TN)'),
    ('04','Chimica e Tecniche Farmaceutiche','Via Piave 3, 38123 Povo (TN)'),
    ('05','Matematica','Via Piave 12, 38123 Povo (TN)'),
    ('06','Lettere','Via Giolitti 43, 38123 Povo (TN)'),
    ('07','Lingue Straniere','Via Giolitti 45, 38123 Povo (TN)'),
    ('08','Fisica','Via Giolitti 47, 38123 Povo (TN)'),
    ('09','Filosofia','Via Giolitti 49, 38123 Povo (TN)'),
    ('10','Storia','Via Giolitti 51, 38123 Povo (TN)')
;

INSERT INTO Ricercatori (ID, Nome,Cognome, Residenza, Stipendio, Codice) VALUES 
    ('1','Raffaele', 'D\' Amico','Torino', 3000.00, '01'),
    ('2','Giuseppe', 'Verdi','Roma', 2500.00, '02'),
    ('3','Mario', 'D\' Onofrio','Roma', 2000.00, '03'),
    ('4','Luigi', 'Bianchi','Torino', 1500.00, '04'),
    ('5','Giovanni', 'Neri','Venezia', 1000.00, '05'),
    ('6','Paolo', 'Verdi','Palermo', 500.00, '06'),
    ('7','Giuseppe', 'Rossi','Venezia', 400.00, '07'),
    ('8','Lorenzo', 'De Niro','Roma', 2400.00, '04'),
    ('9','Domenico', 'Riefoli','Palermo', 1500.00, '01'),
    ('10','Roberto', 'Rossini','Roma', 1800.00, '01'),
    ('11','Stefano', 'Rossetti','Torino', 2200.00, '05'),
    ('12', 'Piero', 'Totti', '*** Manca Residenza', '2000', NULL),
    ('13', 'Domenico', 'De Niro', '*** Manca Residenza', '3000', NULL),
    ('14', 'Pino', 'Mastroianni', '*** Manca Residenza', '2000', NULL)
;