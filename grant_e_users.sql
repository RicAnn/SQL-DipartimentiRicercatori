/*
================================================================================
  GUIDA DIDATTICA: GESTIONE UTENTI E PRIVILEGI IN SQL (MySQL)
================================================================================

In questa sezione impareremo come creare utenti, assegnare privilegi e gestire
gli accessi al database. Questi comandi sono fondamentali per la sicurezza.
*/

-- ============================================================================
-- 1. CREAZIONE DI UN NUOVO UTENTE
-- ============================================================================
-- SINTASSI GENERALE: CREATE USER 'nome_utente'@'host' IDENTIFIED BY 'password';
--
-- Spiegazione dettagliata:
--   CREATE USER     = Comando che crea un nuovo utente nel database
--   'nuovo_utente'  = Nome dell'utente che vogliamo creare (fra apici singoli)
--   @'localhost'    = Specifica da quale host l'utente può connettersi
--                     'localhost' = solo da questo computer
--                     '%'        = da qualunque computer
--   IDENTIFIED BY   = Specifica come autenticazione
--   'password'      = La password dell'utente (fra apici singoli)
--
CREATE USER 'nuovo_utente'@'localhost' IDENTIFIED BY 'password';

-- ============================================================================
-- 2. ASSEGNAZIONE DI PRIVILEGI ALL'UTENTE
-- ============================================================================
-- SINTASSI GENERALE: GRANT privilegi ON database.tabella TO 'utente'@'host';
--
-- Spiegazione dettagliata:
--   GRANT           = Comando per concedere privilegi
--   SELECT, INSERT, UPDATE = I privilegi specifici che concediamo:
--                     - SELECT   = permesso di leggere i dati
--                     - INSERT   = permesso di inserire nuovi dati
--                     - UPDATE   = permesso di modificare i dati esistenti
--   ON              = Specifica su cosa assegnare i privilegi
--   DipartimentiRicercatori.* = Il database 'DipartimentiRicercatori' 
--                               e l'asterisco '*' significa TUTTE le tabelle
--   TO 'nuovo_utente'@'localhost' = A quale utente assegnare questi privilegi
--
GRANT SELECT, INSERT, UPDATE ON DipartimentiRicercatori.* TO 'nuovo_utente'@'localhost';

-- ============================================================================
-- 3. REVOCA DI PRIVILEGI
-- ============================================================================
-- SINTASSI GENERALE: REVOKE privilegi ON database.tabella FROM 'utente'@'host';
--
-- Spiegazione dettagliata:
--   REVOKE          = Comando per togliere privilegi precedentemente concessi
--   INSERT          = Il privilegio che vogliamo togliere (solo questo)
--   ON              = Specifica su cosa revocare il privilegio
--   DipartimentiRicercatori.* = Dal database e da tutte le sue tabelle
--   FROM 'nuovo_utente'@'localhost' = Da quale utente togliere il privilegio
--
-- NOTA: Dopo questo comando, l'utente potrà ancora fare SELECT e UPDATE,
--       ma NON potrà più inserire nuovi dati (INSERT è revocato)
--
REVOKE INSERT ON DipartimentiRicercatori.* FROM 'nuovo_utente'@'localhost';

-- ============================================================================
-- 4. ELIMINAZIONE DELL'UTENTE
-- ============================================================================
-- SINTASSI GENERALE: DROP USER 'nome_utente'@'host';
--
-- Spiegazione dettagliata:
--   DROP USER       = Comando per eliminare completamente un utente
--   'nuovo_utente'@'localhost' = Specifica quale utente eliminare
--
-- ATTENZIONE: Questo comando rimuove l'utente dal sistema!
--             Tutti i privilegi verranno persi.
--
DROP USER 'nuovo_utente'@'localhost';

-- ============================================================================
-- 5. APPLICAZIONE DELLE MODIFICHE AL SISTEMA
-- ============================================================================
-- SINTASSI: FLUSH PRIVILEGES;
--
-- Spiegazione dettagliata:
--   FLUSH PRIVILEGES = Comando che dice al server MySQL di ricaricare
--                      la tabella dei privilegi e applicare immediatamente
--                      tutte le modifiche che abbiamo fatto
--
-- IMPORTANTE: Dovrebbe essere eseguito dopo operazioni di grant/revoke
--             per garantire che le modifiche abbiano effetto immediato
--
FLUSH PRIVILEGES;   

-- Fine dello script;

-- ============================================================================
-- PARTE 2: CREAZIONE DI UN SECONDO UTENTE CON PRIVILEGI SPECIFICI
-- ============================================================================

-- Creazione di un secondo utente
CREATE USER 'secondo_utente'@'localhost' IDENTIFIED BY 'password2';

-- Assegnazione di privilegi specifici
GRANT SELECT ON DipartimentiRicercatori.Ricercatori TO 'secondo_utente'@'localhost';

-- ============================================================================
-- PARTE 3: UTILIZZO DEI RUOLI (ROLES) - CONCETTO AVANZATO
-- ============================================================================
/*
I RUOLI sono un concetto fondamentale nella sicurezza dei database.

COS'È UN RUOLO?
Un ruolo è un contenitore di privilegi che possiamo assegnare a più utenti
contemporaneamente. Invece di assegnare gli stessi privilegi a ogni utente
singolarmente, creiamo un ruolo una sola volta e lo assegniamo ai vari utenti.

VANTAGGI DEI RUOLI:
  1. Gestione semplificata: modificare un ruolo modifica i privilegi di tutti
     gli utenti che lo hanno
  2. Consistenza: riduce errori nell'assegnazione di privilegi
  3. Riusabilità: uno stesso ruolo può essere usato per molti utenti
  4. Manutenibilità: è più facile controllare chi ha accesso a cosa

ESEMPIO PRATICO:
Supponiamo di avere un dipartimento di ricerca con:
  - 10 ricercatori che devono leggere e scrivere sulla tabella Ricercatori
  - 5 manager che devono leggere tutto
  
Soluzione SENZA ruoli: assegnare privilegi 15 volte individualmente
Soluzione CON ruoli: creare un ruolo e assegnarlo ai 15 utenti
*/

-- ============================================================================
-- 3.1 CREAZIONE DI UN RUOLO
-- ============================================================================
-- SINTASSI GENERALE: CREATE ROLE 'nome_ruolo';
--
-- Spiegazione dettagliata:
--   CREATE ROLE     = Comando per creare un nuovo ruolo
--   'ruolo_ricercatore' = Nome del ruolo che stiamo creando
--
-- NOTA: Un ruolo appena creato è "vuoto", senza privilegi.
--       Nel passo successivo aggiungeremo i privilegi al ruolo.
--
CREATE ROLE 'ruolo_ricercatore';

-- ============================================================================
-- 3.2 ASSEGNAZIONE DI PRIVILEGI AL RUOLO
-- ============================================================================
-- SINTASSI GENERALE: GRANT privilegi ON database.tabella TO 'nome_ruolo';
--
-- Spiegazione dettagliata:
--   GRANT           = Comando per concedere privilegi
--   SELECT, INSERT  = I privilegi che vogliamo concedere:
--                     - SELECT = permesso di leggere i dati
--                     - INSERT = permesso di inserire nuovi dati
--   ON              = Specifica su cosa assegnare i privilegi
--   DipartimentiRicercatori.Ricercatori = Specificamente sulla tabella
--                                          'Ricercatori' del database
--   TO 'ruolo_ricercatore' = A quale ruolo assegnare questi privilegi
--
-- EFFETTO IMMEDIATO: Qualsiasi utente che ha questo ruolo avrà
--                    automaticamente questi privilegi
--
GRANT SELECT, INSERT ON DipartimentiRicercatori.Ricercatori TO 'ruolo_ricercatore';

-- ============================================================================
-- 3.3 ASSEGNAZIONE DEL RUOLO A UN UTENTE
-- ============================================================================
-- SINTASSI GENERALE: GRANT 'nome_ruolo' TO 'nome_utente'@'host';
--
-- Spiegazione dettagliata:
--   GRANT 'ruolo_ricercatore' = Assegna il ruolo (notare che il ruolo è fra apici)
--   TO 'secondo_utente'@'localhost' = A quale utente assegnare il ruolo
--
-- COSA ACCADE: L'utente 'secondo_utente' eredita TUTTI i privilegi del ruolo.
--              Se il ruolo ha SELECT e INSERT, anche l'utente li avrà.
--
-- ESEMPIO PRATICO:
--   Se abbiamo 5 ricercatori:
--   GRANT 'ruolo_ricercatore' TO 'ricercatore1'@'localhost';
--   GRANT 'ruolo_ricercatore' TO 'ricercatore2'@'localhost';
--   GRANT 'ruolo_ricercatore' TO 'ricercatore3'@'localhost';
--   GRANT 'ruolo_ricercatore' TO 'ricercatore4'@'localhost';
--   GRANT 'ruolo_ricercatore' TO 'ricercatore5'@'localhost';
--   
--   Così tutti e 5 hanno gli stessi privilegi con un solo ruolo!
--
GRANT 'ruolo_ricercatore' TO 'secondo_utente'@'localhost';

-- ============================================================================
-- 3.4 REVOCA DEL RUOLO DA UN UTENTE
-- ============================================================================
-- SINTASSI GENERALE: REVOKE 'nome_ruolo' FROM 'nome_utente'@'host';
--
-- Spiegazione dettagliata:
--   REVOKE 'ruolo_ricercatore' = Togliere il ruolo
--   FROM 'secondo_utente'@'localhost' = Da quale utente togliere il ruolo
--
-- EFFETTO: L'utente perde TUTTI i privilegi che aveva dal ruolo.
--          Se aveva altri privilegi diretti (non dal ruolo), li mantiene.
--
-- ESEMPIO PRATICO:
--   Se revoco il ruolo da un utente che sta lasciando il dipartimento di ricerca:
--   - Perde immediatamente SELECT e INSERT sulla tabella Ricercatori
--   - Ma manterrebbe altri privilegi diretti se glieli avevamo assegnati
--
REVOKE 'ruolo_ricercatore' FROM 'secondo_utente'@'localhost';

-- ============================================================================
-- 3.5 ELIMINAZIONE DEL SECONDO UTENTE
-- ============================================================================
-- SINTASSI GENERALE: DROP USER 'nome_utente'@'host';
--
-- Questo comando elimina completamente l'utente dal sistema MySQL.
--
DROP USER 'secondo_utente'@'localhost';

-- ============================================================================
-- 3.6 ELIMINAZIONE DEL RUOLO
-- ============================================================================
-- SINTASSI GENERALE: DROP ROLE 'nome_ruolo';
--
-- Spiegazione dettagliata:
--   DROP ROLE       = Comando per eliminare un ruolo
--   'ruolo_ricercatore' = Quale ruolo eliminiamo
--
-- ATTENZIONE IMPORTANTE:
--   Quando eliminiamo un ruolo, i privilegi del ruolo vengono rimossi
--   da TUTTI gli utenti che lo avevano. Ma gli utenti continuano a
--   esistere nel sistema, solo senza i privilegi del ruolo.
--
-- SCENARIO: Se eliminiamo 'ruolo_ricercatore':
--   - Tutti gli utenti che avevano questo ruolo lo perdono
--   - Gli utenti non vengono eliminati
--   - I privilegi diretti (non dal ruolo) rimangono intatti
--
DROP ROLE 'ruolo_ricercatore';




