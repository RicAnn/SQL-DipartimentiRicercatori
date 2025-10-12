/* 1 - Conteggio record Ricercatori */
SELECT Now() AS DataAttuale, Count(*) as TotaleRicercatori
FROM Ricercatori;

/* 2 - Conteggio record Dipartimenti */
SELECT COUNT(*) as TotaleDipartimenti
FROM Dipartimenti;  

-- 3 -- Stipendio Max
SELECT MAX(Stipendio), Nome, Cognome
FROM Ricercatori;

-- 4 -- Stipendio Min
SELECT MIN(Stipendio), Nome, Cognome
FROM Ricercatori;

-- 5
SELECT Dipartimenti.Descrizione, COUNT(*) as TotaleRicercatoriPerDipartimento
FROM Dipartimenti INNER JOIN Ricercatori 
ON Dipartimenti.Codice = Ricercatori.Codice
GROUP BY Dipartimenti.Codice;  

-- 6
SELECT Codice, COUNT(ID) AS Dipendenti, 
SUM(Stipendio) AS Stipendi
FROM Ricercatori
GROUP BY Codice;

-- 7
SELECT dipartimenti.Codice, Descrizione, COUNT(ID) AS Dipendenti, 
SUM(Stipendio) AS Stipendi
FROM Ricercatori INNER JOIN dipartimenti
ON ricercatori.Codice = dipartimenti.Codice
GROUP BY Descrizione;

-- 8 -- numero  di  ricercatori  e  ricercatrici  e  la  somma  degli  stipendi  per  i  
-- dipartimenti  con  almeno due  dipendenti  
SELECT Codice, COUNT(ID) AS Dipendenti, SUM(Stipendio) AS Stipendi 
FROM Ricercatori
GROUP BY Codice
HAVING COUNT(ID) > 1;

-- 9 -- Come sopra, ma senza i null : numero  di  ricercatori  e  ricercatrici  e  la  somma  degli  stipendi  per  i  
-- dipartimenti  con  almeno due  dipendenti  
SELECT Codice, COUNT(ID) AS Dipendenti, SUM(Stipendio) AS Stipendi 
FROM Ricercatori
WHERE Codice IS NOT NULL
GROUP BY Codice
HAVING COUNT(ID) > 1;

-- 10 -- Come sopra, ma senza i null : numero  di  ricercatori  e  ricercatrici  e  la  somma  degli  stipendi  per  i  
-- dipartimenti  con  almeno due  dipendenti  
SELECT Codice, COUNT(ID) AS Dipendenti, SUM(Stipendio) AS Stipendi 
FROM Ricercatori
WHERE Residenza IN ('Roma','Palermo')
GROUP BY Codice
HAVING COUNT(ID) > 1;