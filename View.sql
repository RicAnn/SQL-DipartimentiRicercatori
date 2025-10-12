-- creo una view
CREATE VIEW DirezioneProgetti AS
SELECT ID, Nome, Cognome, Codice
FROM Ricercatori
WHERE ID IN (1,2,3,4);

-- e poi la uso in una select
SELECT * FROM direzioneprogetti WHERE ID<3;

CREATE OR REPLACE VIEW DirezioneProgetti AS
SELECT ID, Nome, Cognome, Codice, Residenza
FROM Ricercatori
WHERE ID IN (1,2,3);

CREATE VIEW RicercatoriDipartimenti AS
SELECT ID, Nome, Cognome, Dipartimenti.Descrizione
FROM Ricercatori INNER JOIN Dipartimenti
ON Ricercatori.Codice = Dipartimenti.Codice
WHERE ID IN (1,2,3,4);
