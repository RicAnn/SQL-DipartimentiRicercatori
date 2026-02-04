
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
-- le ricercatrici di ciascun dipartimento con almeno due residenze diverse
SELECT Descrizione, COUNT(DISTINCT Residenza) AS ResidenzeDiverseDipartimenti
FROM Ricercatori, Dipartimenti
WHERE Ricercatori.Codice = Dipartimenti.Codice
GROUP BY Descrizione;
HAVING COUNT(DISTINCT Residenza) > 1;

-- 8 -- calcolare la media degli stipendi dei ricercatori e delle ricercatrici per ciascun dipartimento
SELECT Descrizione, AVG(Stipendio) AS MediaStipendiPerDipartimento
FROM Ricercatori, Dipartimenti
WHERE Ricercatori.Codice = Dipartimenti.Codice    
GROUP BY Descrizione;

-- 9 -- calcolare la media degli stipendi dei ricercatori e delle ricercatrici per ciascun dipartimento
-- con media degli stipendi superiore a 2500    
SELECT Descrizione, AVG(Stipendio) AS MediaStipendiDipartimenti
FROM Ricercatori, Dipartimenti
WHERE Ricercatori.Codice = Dipartimenti.Codice      
GROUP BY Descrizione
HAVING AVG(Stipendio) > 2500;

-- 10 -- ALTER TABLE: Aggiungere una colonna Email ai Ricercatori con valore DEFAULT
ALTER TABLE Ricercatori
ADD Email VARCHAR(100) DEFAULT 'noemail@example.com';

-- 11 -- ALTER TABLE: Aggiungere una colonna DataAssunzione
ALTER TABLE Ricercatori
ADD DataAssunzione DATE;

-- 12 -- UPDATE: Aggiornare gli stipendi con un calcolo (aumento del 10%)
UPDATE Ricercatori
SET Stipendio = Stipendio * 1.10
WHERE Codice = '01';

-- 13 -- UPDATE: Impostare la DataAssunzione per alcuni ricercatori
UPDATE Ricercatori
SET DataAssunzione = '2020-01-15'
WHERE ID IN (1, 2, 3);

-- 14 -- CREATE INDEX: Creare un indice sulla colonna Residenza
CREATE INDEX idx_residenza ON Ricercatori(Residenza);

-- 15 -- CREATE UNIQUE INDEX: Creare un indice univoco sulla Email
CREATE UNIQUE INDEX idx_email_unique ON Ricercatori(Email);

-- 16 -- SHOW INDEX: Visualizzare gli indici della tabella Ricercatori
SHOW INDEX FROM Ricercatori;

-- 17 -- Interrogazione con IS NULL: Ricercatori senza dipartimento
SELECT ID, Nome, Cognome, Codice
FROM Ricercatori
WHERE Codice IS NULL;

-- 18 -- Interrogazione con IS NOT NULL e calcolo SQR (radice quadrata dello stipendio)
SELECT Nome, Cognome, Stipendio, SQRT(Stipendio) AS RadiceStipendio
FROM Ricercatori
WHERE Codice IS NOT NULL;

-- 19 -- Query con espressioni e calcoli: Stipendio annuale e bonus
SELECT Nome, Cognome, 
    Stipendio AS StipendioMensile,
    Stipendio * 12 AS StipendioAnnuale,
    Stipendio * 12 * 0.15 AS Bonus
FROM Ricercatori;

-- 20 -- DISTINCT vs ALL: Confronto tra risultati distinti e tutti
SELECT DISTINCT Residenza FROM Ricercatori;
SELECT ALL Residenza FROM Ricercatori;

-- 21 -- Interrogazione parametrica: Ricercatori con stipendio maggiore di un valore
-- In MySQL si userebbero prepared statements o variabili
-- Imposta o aggiorna il valore di una chiave specifica (SET @stipendio_minimo).
-- Questa funzione memorizza un valore associato a una chiave,
-- sovrascrivendo eventuali valori precedenti se la chiave esiste già.
-- ================================================================================
-- Imposta una variabile @stipendio_minimo con un valore specifico
-- La variabile può essere utilizzata nelle query successive come parametro
-- ================================================================================
-- Documentazione: Concetto di Variabile come Chiave
-- ================================================================================
-- In SQL e nei contesti di database, una "chiave" può riferirsi a una variabile nei seguenti modi:
--
-- 1. PRIMARY KEY / FOREIGN KEY: Colonna/e che identificano univocamente i record
-- 2. VARIABILI DI SESSIONE: Variabili definite dall'utente che fungono da chiavi per memorizzare valori
--    Esempio: SET @mia_chiave = 'valore';
-- 3. PARAMETRI: Variabili passate a stored procedure/function che fungono da chiavi di ricerca
-- 4. CONCETTO DIZIONARIO/MAPPA: Nella programmazione, il nome della variabile funge da chiave per accedere al suo valore
--
-- Il contesto è importante:
-- - Nel design del database: Chiave = colonna/e identificatore
-- - In SQL procedurale: Una variabile può contenere un valore chiave usato per ricerche/join
-- - Nella configurazione: Il nome della variabile stessa è la chiave, il suo contenuto è il valore
-- ================================================================================
SET @stipendio_minimo = 2500;
SELECT Nome, Cognome, Stipendio
FROM Ricercatori
WHERE Stipendio > @stipendio_minimo;

-- 22 -- DELETE: Eliminare ricercatori con stipendio NULL
DELETE FROM Ricercatori
WHERE Stipendio IS NULL;

-- 23 -- ALTER TABLE con ON DELETE e ON UPDATE (aggiungere foreign key)
ALTER TABLE Ricercatori
ADD CONSTRAINT fk_dipartimento
FOREIGN KEY (Codice) REFERENCES Dipartimenti(Codice)
ON DELETE SET NULL
ON UPDATE CASCADE;

-- 24 -- DROP INDEX: Eliminare un indice
DROP INDEX idx_residenza ON Ricercatori;

-- 25 -- ALTER TABLE DROP: Rimuovere una colonna
ALTER TABLE Ricercatori
DROP COLUMN Email;

-- 26 -- DROP TABLE: Eliminare una tabella (esempio con tabella temporanea)
-- Crea una tabella temporanea TempRicercatori con la stessa struttura di Ricercatori
-- ma senza dati (WHERE 1=0 è sempre falso, quindi nessuna riga viene copiata)
CREATE TABLE TempRicercatori AS SELECT * FROM Ricercatori WHERE 1=0;
DROP TABLE TempRicercatori;

-- 27 -- Ricercatori che lavorano in dipartimenti con più di 2 ricercatori
SELECT Nome, Cognome, Codice
FROM Ricercatori
WHERE Codice IN (
    SELECT Codice 
    FROM Ricercatori 
    WHERE Codice IS NOT NULL
    GROUP BY Codice 
    HAVING COUNT(*) > 2
);

-- 28 -- Ricercatori con stipendio superiore alla media del proprio dipartimento
SELECT R1.Nome, R1.Cognome, R1.Stipendio, R1.Codice
FROM Ricercatori R1
WHERE R1.Stipendio > (
    SELECT AVG(R2.Stipendio)
    FROM Ricercatori R2
    WHERE R2.Codice = R1.Codice
);

-- 29 -- Dipartimenti che hanno almeno un ricercatore con stipendio massimo

-- Questa query trova i dipartimenti che hanno almeno un ricercatore con lo stipendio massimo assoluto.
-- 
-- Scomposizione:
-- 1. (SELECT MAX(Stipendio) FROM Ricercatori) → trova lo stipendio massimo tra TUTTI i ricercatori
-- 2. WHERE EXISTS (...) → verifica se esiste almeno un record che soddisfa le condizioni nella subquery
-- 3. SELECT 1 → restituisce semplicemente 1 se trova una corrispondenza (l'EXISTS controlla solo l'esistenza)
-- 4. WHERE R.Codice = D.Codice → collega i ricercatori al dipartimento corrente
-- 5. AND R.Stipendio = (MAX) → filtra solo i ricercatori con stipendio massimo assoluto
-- 6. SELECT DISTINCT D.Codice, D.Descrizione → restituisce i dipartimenti (DISTINCT evita duplicati)
--
-- Esempio: Se lo stipendio massimo è 5000€ e solo i ricercatori nei dipartimenti '01' e '03' 
-- guadagnano 5000€, la query restituirà solo questi due dipartimenti.
SELECT DISTINCT D.Codice, D.Descrizione
FROM Dipartimenti D
WHERE EXISTS (
    SELECT 1
    FROM Ricercatori R
    WHERE R.Codice = D.Codice
    AND R.Stipendio = (SELECT MAX(Stipendio) FROM Ricercatori)
);

-- 30 -- Ricercatori con stipendio maggiore di tutti i ricercatori del dipartimento '02'
SELECT Nome, Cognome, Stipendio
FROM Ricercatori
WHERE Stipendio > ALL (
    SELECT Stipendio 
    FROM Ricercatori 
    WHERE Codice = '02' AND Stipendio IS NOT NULL
);

-- 31 -- Ricercatori della stessa città del ricercatore con ID = 1
SELECT R1.Nome, R1.Cognome, R1.Residenza
FROM Ricercatori R1
WHERE R1.Residenza = (
    SELECT R2.Residenza 
    FROM Ricercatori R2 
    WHERE R2.ID = 1
)
AND R1.ID != 1;

-- 32 -- Dipartimenti senza ricercatori assegnati
SELECT Codice, Descrizione
FROM Dipartimenti
WHERE Codice NOT IN (
    SELECT DISTINCT Codice 
    FROM Ricercatori 
    WHERE Codice IS NOT NULL
);

-- 33 -- Ricercatori con stipendio nel top 3
SELECT Nome, Cognome, Stipendio
FROM Ricercatori R1
WHERE 3 > (
    SELECT COUNT(DISTINCT R2.Stipendio)
    FROM Ricercatori R2
    WHERE R2.Stipendio > R1.Stipendio
)
ORDER BY Stipendio DESC;

-- 34 -- Residenze con numero di ricercatori superiore alla media
SELECT Residenza, COUNT(*) AS NumeroRicercatori
FROM Ricercatori
GROUP BY Residenza
HAVING COUNT(*) > (
    SELECT AVG(ContaRicercatori)
    FROM (
        SELECT COUNT(*) AS ContaRicercatori
        FROM Ricercatori
        GROUP BY Residenza
    ) AS SubQuery
);

-- 35 -- Ricercatori che guadagnano più della media del dipartimento con stipendio medio più alto
SELECT Nome, Cognome, Stipendio
FROM Ricercatori
WHERE Stipendio > (
    SELECT MAX(MediaStipendio)
    FROM (
        SELECT AVG(Stipendio) AS MediaStipendio
        FROM Ricercatori
        WHERE Codice IS NOT NULL
        GROUP BY Codice
    ) AS MediaDipartimenti
);