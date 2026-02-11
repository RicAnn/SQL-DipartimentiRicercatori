DROP DATABASE IF EXISTS ProprietariCase;
CREATE DATABASE IF NOT EXISTS ProprietariCase;
USE ProprietariCase;
CREATE TABLE Casa(
    ID smallint(6) Primary Key,
    via varchar(20) not null,
    mq int(5) not null
); 
CREATE TABLE Proprietario(
    ID   smallint(6) Primary Key,
    nome varchar(20) not null,
    cognome varchar(20) not null
);

CREATE TABLE Possiede(
    proprietarioID smallint(6) references Proprietario(ID)
    On Delete cascade
    On Update cascade,
    casaID smallint(6) references Casa(ID)
    On Delete cascade
    On Update cascade,
    Primary Key (proprietarioID, casaID)
);
INSERT INTO Casa (ID, via, mq) VALUES 
(1, 'Via Roma 3, 00100 Roma (RM)', 120),
(2, 'Via Verdi 3, 00100 Roma (RM)', 80),
(3, 'Via Rossi 3, 00100 Roma (RM)', 60),
(4, 'Via Bianchi 3, 00100 Roma (RM)', 90),
(5, 'Via Neri 3, 00100 Roma (RM)', 70),
(6, 'Via De Niro 7, 00140 Roma (RM)', 50),
(7, 'Via Giolitti 43, 38123 Povo (TN)', 110);

INSERT INTO Proprietario (ID, nome, cognome) VALUES 
(1, 'Raffaele', 'D Amico'),
(2, 'Giuseppe', 'Verdi'),
(3, 'Mario', 'Rossi'),
(4, 'Luigi', 'Bianchi'),
(5, 'Giovanni', 'Neri'),
(6, 'Paolo', 'Verdi'),
(7, 'Lorenzo', 'De Niro'),
(8, 'Anna', 'Bianchi'),
(9, 'Sara', 'Rossi');

INSERT INTO Possiede (proprietarioID, casaID) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(2, 3),
(3, 5),
(6, 6),
(7, 7),
(8, 1),
(9, 2);
