/* 1 - Inner join senza match (con ordinamento decrescente) 
E' il prodotto cartesiano:
tutte le righe della prima tabella per tutte le righe della seconda */
SELECT * 
FROM Ricercatori INNER JOIN Dipartimenti ORDER BY Ricercatori.Codice DESC;

/* 2 - Per ogni riga di ricercatori, legge il valore nel campo 'codice' 
e lo cerca nella tabella Dipartimenti */
SELECT * 
FROM Ricercatori, Dipartimenti
WHERE Ricercatori.Codice = Dipartimenti.Codice;

/* 3 - ESEGUE la stessa query di sopra, ma con la inner join   */
SELECT *
FROM Ricercatori INNER JOIN Dipartimenti
ON Ricercatori.Codice = Dipartimenti.Codice ORDER BY Ricercatori.ID;

/* 4 - Inner join con ordinamento decrescente */
SELECT *
FROM Ricercatori INNER JOIN Dipartimenti
ON Ricercatori.Codice = Dipartimenti.Codice ORDER BY Ricercatori.ID DESC;

/* 5 - Left join: visualizza tutti i record dei ricercatori e, 
   se c'è corrispondenza, visualizza anche il record dei Dipartimenti collegato,
   altrimenti metterà NULL, se previsto  */
SELECT *
FROM Ricercatori LEFT JOIN Dipartimenti
ON Ricercatori.Codice = Dipartimenti.Codice ORDER BY Ricercatori.ID;

/* 6 - Right join  */
SELECT *
FROM Ricercatori RIGHT JOIN Dipartimenti
ON Ricercatori.Codice = Dipartimenti.Codice ORDER BY Ricercatori.ID;


