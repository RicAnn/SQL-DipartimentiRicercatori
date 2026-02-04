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
    Dipartimento char(5) references Dipartimenti(Codice) 
    On Delete set null
    On Update cascade,
    Unique(Cognome,Nome,Dipartimento)
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
('07','Lingue Straniere','Via Giolitti 45, 38123 Povo (TN)')
;

INSERT INTO Ricercatori (ID, Nome,Cognome, Residenza, Stipendio, Dipartimento) VALUES 
('1','Raffaele', 'D Amico','Via Roma 3, 00100 Roma (RM)', 3000.00, '01'),
('2','Giuseppe', 'Verdi','Via Verdi 3, 00100 Roma (RM)', 2500.00, '02'),
('3','Mario', 'Rossi','Via Rossi 3, 00100 Roma (RM)', 2000.00, '03'),
('4','Luigi', 'Bianchi','Via Bianchi 3, 00100 Roma (RM)', 1500.00, '04'),
('5','Giovanni', 'Neri','Via Neri 3, 00100 Roma (RM)', 1000.00, '05'),
('6','Paolo', 'Verdi','Via Verdi 3, 00100 Roma (RM)', 500.00, '06'),
('7','Giuseppe', 'Rossi','Via Rossi 3, 00100 Roma (RM)', 400.00, '07'),
('8','Lorenzo', 'De Niro','Via Roma, 003450  (XX)', 2400.00, '04'),
('9','Giuseppe', 'Rossi','Via Neri 7, 00140 Roma (RM)', 1200.00, '01');

-- Creazione di un nuovo utente
CREATE USER 'nuovo_utente'@'localhost' IDENTIFIED BY 'password';

-- Assegnazione di privilegi all'utente
GRANT SELECT, INSERT, UPDATE ON DipartimentiRicercatori.* TO 'nuovo_utente'@'localhost';

-- Revoca di privilegi
REVOKE INSERT ON DipartimentiRicercatori.* FROM 'nuovo_utente'@'localhost';

-- Eliminazione dell'utente
DROP USER 'nuovo_utente'@'localhost';