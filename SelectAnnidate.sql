
-- 1 -- Ricercatori con Stipendi minori della media
SELECT Nome, Cognome, Stipendio
FROM Ricercatori 
WHERE Stipendio < (SELECT AVG(Stipendio) FROM Ricercatori);

-- 2 -- Ricercatori con Stipendi massimi
SELECT * 
FROM Ricercatori 
WHERE Stipendio = (SELECT MAX(Stipendio) FROM Ricercatori);

-- 3 -- Ricercatori NON RESIDENTI A ROMA
SELECT ID, Nome, Cognome, Residenza 
FROM Ricercatori 
WHERE ID NOT IN (SELECT ID FROM Ricercatori WHERE Residenza = 'Roma');

-- 4 -- Ricercatori con codice dipartimento diverso da NULL
SELECT ID, Nome, Cognome 
FROM Ricercatori 
WHERE ID NOT IN (SELECT ID FROM Ricercatori WHERE Codice IS NOT NULL);

-- 5 -- calcolare da quante differenti città di residenza provengono i ricercatori e 
-- le ricercatrici del dipartimento Informatica
SELECT COUNT(DISTINCT Residenza) AS ResidenzeDiverseDipartimentoInformatica
FROM Ricercatori WHERE Codice = '01';

-- 6 -- calcolare da quante differenti città di residenza provengono i ricercatori e
-- le ricercatrici di ciascun dipartimento
SELECT Descrizione, COUNT(DISTINCT Residenza) AS ResidenzeDiversePerDipartimento
FROM Ricercatori, Dipartimenti
WHERE Ricercatori.Codice = Dipartimenti.Codice
GROUP BY Descrizione;

-- 7 -- calcolare da quante differenti città di residenza provengono i ricercatori e
-- le ricercatrici di ciascun dipartimento con almeno due residenzr diverse
SELECT Descrizione, COUNT(DISTINCT Residenza) AS ResidenzeDiverseDipartimenti
FROM Ricercatori, Dipartimenti
WHERE Ricercatori.Codice = Dipartimenti.Codice
GROUP BY Descrizione;
HAVING COUNT(DISTINCT Residenza) > 1;