
/* query per visualizzare i proprietari con le rispettive case */
SELECT P.nome, P.cognome, C.via, C.mq   
FROM Proprietario P
JOIN Possiede PS ON P.ID = PS.proprietarioID
JOIN Casa C ON PS.casaID = C.ID;

/* query per visualizzare le case con i rispettivi proprietari */
SELECT C.via, C.mq, P.nome, P.cognome   
FROM Casa C
JOIN Possiede PS ON C.ID = PS.casaID
JOIN Proprietario P ON PS.proprietarioID = P.ID;

/* query per visualizzare i proprietari che possiedono piu' di una casa */
SELECT P.nome, P.cognome, COUNT(PS.casaID) AS NumeroCase    
FROM Proprietario P
JOIN Possiede PS ON P.ID = PS.proprietarioID
GROUP BY P.ID
HAVING COUNT(PS.casaID) > 1;

/* query per visualizzare le case con metratura superiore a 75 mq e i rispettivi proprietari */
SELECT C.via, C.mq, P.nome, P.cognome
FROM Casa C
JOIN Possiede PS ON C.ID = PS.casaID
JOIN Proprietario P ON PS.proprietarioID = P.ID
WHERE C.mq > 75;

/* query per visualizzare i proprietari che non possiedono case */
SELECT P.nome, P.cognome
FROM Proprietario P 
LEFT JOIN Possiede PS ON P.ID = PS.proprietarioID
WHERE PS.casaID IS NULL;

/* query per visualizzare le case che non hanno proprietari */
SELECT C.via, C.mq
FROM Casa C
LEFT JOIN Possiede PS ON C.ID = PS.casaID
WHERE PS.proprietarioID IS NULL;

/* query per contare il numero totale di case possedute da tutti i proprietari */
SELECT COUNT(*) AS NumeroTotaleCase
FROM Possiede;

/* query per calcolare la metratura media delle case possedute da ciascun proprietario */
SELECT P.nome, P.cognome, AVG(C.mq) AS MetraturaMedia
FROM Proprietario P
JOIN Possiede PS ON P.ID = PS.proprietarioID
JOIN Casa C ON PS.casaID = C.ID
GROUP BY P.ID;

/* query per visualizzare i proprietari ordinati per cognome e nome insieme al numero di case possedute */
SELECT P.nome, P.cognome, COUNT(PS.casaID) AS NumeroCase
FROM Proprietario P
LEFT JOIN Possiede PS ON P.ID = PS.proprietarioID
GROUP BY P.ID
ORDER BY P.cognome, P.nome;

/* query per visualizzare le case ordinate per via insieme al nome e cognome del proprietario */
SELECT C.via, C.mq, P.nome, P.cognome
FROM Casa C
LEFT JOIN Possiede PS ON C.ID = PS.casaID
LEFT JOIN Proprietario P ON PS.proprietarioID = P.ID
ORDER BY C.via;

