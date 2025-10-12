/* Inner join senza match (con ordinamento decrescente) 
E' il prodotto cartesiano:
tutte le righe della prima tabella per tutte le righe della seconda */
SELECT *
FROM Ricercatori INNER JOIN Dipartimenti;

SELECT *
FROM Ricercatori LEFT JOIN Dipartimenti
ON Dipartimento = Codice;

SELECT *
FROM Dipartimenti RIGHT JOIN Ricercatori
ON Dipartimento = Codice;

SELECT *
FROM Ricercatori, Dipartimenti
WHERE Dipartimento = Codice;

/*ESEGUE la stessa query di sopra, ma con la inner join   */

SELECT *
FROM Ricercatori INNER JOIN Dipartimenti
ON Dipartimento = Codice;

/* Inner join con ordinamento decrescente */

SELECT *
FROM Ricercatori INNER JOIN Dipartimenti
ON Dipartimento = Codice ORDER BY Dipartimento DESC;

