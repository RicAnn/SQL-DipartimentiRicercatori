
/* 6 - record Ricercatori SENZA CODICE DIPARTIMENTO */
SELECT ID, Nome, Cognome
FROM Ricercatori
WHERE Codice IS NULL;

/* -- 7 - Stipendi compresi tra 1000 e 2000*/
SELECT ID, Cognome, Nome, Residenza, Stipendio
FROM Ricercatori
WHERE Stipendio BETWEEN 1000 AND 2000;
/* -- WHERE Stipendio>=1000 AND Stipendio<=2000; */

/* 8 -- Residenti IN... */
SELECT *
FROM Ricercatori
WHERE Residenza IN ('Roma','Palermo');
-- WHERE Residenza = 'Roma' OR Residenza = 'Palermo';


/* 9 -- NON Residenti IN... */
SELECT ID, Cognome, Nome, Residenza, Stipendio
FROM Ricercatori
WHERE Residenza NOT IN ('Roma','Palermo');
-- WHERE Residenza <> 'Roma' AND Residenza <> 'Palermo'; 

-- 10 -- LIKE _ %
SELECT *
FROM Ricercatori
WHERE Cognome LIKE 'R%';

-- 11 -- LIKE _ %
SELECT *
FROM Ricercatori
WHERE Cognome LIKE 'Ro%';

-- 12 -- LIKE _ %
SELECT *
FROM Ricercatori
WHERE Cognome LIKE "__ %" OR Cognome LIKE "_%'_%";

-- 13 
