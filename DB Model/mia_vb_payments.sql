/* ============================================================================
   MIA Victoriabank - platile instant prin cod QR de pe site
   (plan: Documents/plan-integrare-mia-victoriabank-2026-10-06.md)

   Separat de MIA maib (TWEB_MIA_QR_PAYMENTS), care ramane neatins.

   TWEB_MIA_VB_PAYMENT - cererea de plata: o comanda (DOCID), o suma, un token
                         public (adresa paginii de plata). Comanda exista deja
                         cand se creeaza cererea.
   TWEB_MIA_VB_QR      - codurile QR emise la banca pentru o cerere. Un cod
                         expira in cateva minute; clientul poate cere altul.

   PAYMENT.STATUS: New      - asteapta plata
                   Paid     - platita (suma = cea ceruta)
                   Mismatch - banca a confirmat alta suma decat cea ceruta;
                              comanda NU e marcata platita, se verifica manual
                   Cancelled
                   RefundRequested - WMS a cerut rambursarea; o face cronul site-ului
                   Refunded, RefundFailed
   QR.STATUS:      starea de la banca - Active, Paid, Expired, Cancelled,
                   Replaced, Inactive

   WEB_MIA_VB_PAYMENT_CREATE - creeaza cererea (suma = totalul documentului, TDB_DOCS.SUMA)
   WEB_MIA_VB_CREATE_LINK, WEB_MIA_VB_REQUEST_REFUND, WEB_MIA_VB_LINK_SMS -
                               pentru WMS: link de plata, rambursare, SMS
   WEB_MIA_VB_CONFIRM        - inregistreaza plata confirmata de banca; poate fi
                               apelata de mai multe ori pentru aceeasi plata
                               (pagina de plata, cron, webhook) - efectul e unul
   VW_WEB_MIA_PAYMENTS       - platile MIA confirmate din ambele banci, pentru
                               fiscalizare (@ECC_ONLINE) si WMS
   FN_DEAL_WEB_PAYMENT_METHOD - TWEB_TRANSACTION.PAYMENT_TYPE = 5 -> 'MIA QR'

   Script RE-RULABIL (6.10.2026). Rollback: mia_vb_payments_rollback.sql
   ============================================================================ */

SET TERM ^ ;

/* --- 1. Tabele ------------------------------------------------------------ */
EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS (SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TWEB_MIA_VB_PAYMENT')) THEN
    EXECUTE STATEMENT
      'CREATE TABLE TWEB_MIA_VB_PAYMENT (
         PAYMENT_ID      BIGINT NOT NULL,
         TOKEN           VARCHAR(64) NOT NULL,
         DOCID           INTEGER NOT NULL,
         AMOUNT          DECIMAL(12,2) NOT NULL,
         STATUS          VARCHAR(20) DEFAULT ''New'' NOT NULL,
         SOURCE          VARCHAR(20) DEFAULT ''checkout'' NOT NULL,
         BRAND           VARCHAR(32) NOT NULL,
         PAY_REFERENCE   VARCHAR(120),
         TX_ID           VARCHAR(64),
         PAID_AMOUNT     DECIMAL(12,2),
         PAID_AT         TIMESTAMP,
         PAYER_NAME      VARCHAR(200),
         EMAIL           VARCHAR(120),
         LANG            VARCHAR(2),
         RECEIPT_SENT_AT TIMESTAMP,
         CREATED_AT      TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
         UPDATED_AT      TIMESTAMP,
         CREATED_BY      INTEGER,
         CONSTRAINT PK_TWEB_MIA_VB_PAYMENT PRIMARY KEY (PAYMENT_ID),
         CONSTRAINT UQ_TWEB_MIA_VB_PAYMENT_TOKEN UNIQUE (TOKEN)
       )';

  IF (NOT EXISTS (SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TWEB_MIA_VB_QR')) THEN
    EXECUTE STATEMENT
      'CREATE TABLE TWEB_MIA_VB_QR (
         QR_HEADER_UUID VARCHAR(36) NOT NULL,
         QR_EXT_UUID    VARCHAR(36),
         PAYMENT_ID     BIGINT NOT NULL,
         STATUS         VARCHAR(20) DEFAULT ''Active'' NOT NULL,
         QR_TEXT        VARCHAR(500),
         TX_ID          VARCHAR(64),
         EXPIRES_AT     TIMESTAMP,
         SIGNAL_DATA    VARCHAR(2000),
         CREATED_AT     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
         UPDATED_AT     TIMESTAMP,
         CONSTRAINT PK_TWEB_MIA_VB_QR PRIMARY KEY (QR_HEADER_UUID)
       )';
END^

COMMIT^

/* --- 2. Indecsi, cheie externa, generator --------------------------------- */
EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS (SELECT 1 FROM RDB$INDICES WHERE RDB$INDEX_NAME = 'IDX_TWEB_MIA_VB_PAYMENT_DOC')) THEN
    EXECUTE STATEMENT 'CREATE INDEX IDX_TWEB_MIA_VB_PAYMENT_DOC ON TWEB_MIA_VB_PAYMENT (DOCID)';

  IF (NOT EXISTS (SELECT 1 FROM RDB$INDICES WHERE RDB$INDEX_NAME = 'IDX_TWEB_MIA_VB_PAYMENT_TX')) THEN
    EXECUTE STATEMENT 'CREATE INDEX IDX_TWEB_MIA_VB_PAYMENT_TX ON TWEB_MIA_VB_PAYMENT (TX_ID)';

  IF (NOT EXISTS (SELECT 1 FROM RDB$INDICES WHERE RDB$INDEX_NAME = 'IDX_TWEB_MIA_VB_QR_EXT')) THEN
    EXECUTE STATEMENT 'CREATE INDEX IDX_TWEB_MIA_VB_QR_EXT ON TWEB_MIA_VB_QR (QR_EXT_UUID)';

  -- coada cronului de reconciliere: doar codurile inca active (index partial, Firebird 5)
  IF (NOT EXISTS (SELECT 1 FROM RDB$INDICES WHERE RDB$INDEX_NAME = 'IDX_TWEB_MIA_VB_QR_ACTIVE')) THEN
    EXECUTE STATEMENT
      'CREATE INDEX IDX_TWEB_MIA_VB_QR_ACTIVE ON TWEB_MIA_VB_QR (CREATED_AT) WHERE STATUS = ''Active''';

  IF (NOT EXISTS (SELECT 1 FROM RDB$RELATION_CONSTRAINTS WHERE RDB$CONSTRAINT_NAME = 'FK_TWEB_MIA_VB_QR_PAYMENT')) THEN
    EXECUTE STATEMENT
      'ALTER TABLE TWEB_MIA_VB_QR ADD CONSTRAINT FK_TWEB_MIA_VB_QR_PAYMENT
         FOREIGN KEY (PAYMENT_ID) REFERENCES TWEB_MIA_VB_PAYMENT (PAYMENT_ID)';

  IF (NOT EXISTS (SELECT 1 FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = 'SQ_TWEB_MIA_VB_PAYMENT_ID')) THEN
    EXECUTE STATEMENT 'CREATE SEQUENCE SQ_TWEB_MIA_VB_PAYMENT_ID';
END^

COMMIT^

/* --- 3. Crearea cererii de plata ------------------------------------------
   ERROR_CODE: NULL        - creata
               NO_DOC      - documentul nu exista sau e sters
               NOT_MDL     - documentul nu e in lei (MIA accepta doar MDL)
               NO_AMOUNT   - suma zero sau negativa
               ALREADY_PAID - documentul are deja o plata MIA confirmata
   A_AMOUNT NULL = totalul documentului, TDB_DOCS.SUMA - cifra pe care o arata
   WMS si pe care se emite bonul fiscal (GET_GOODS_FOR_RECEIPT imparte pe linii
   diferenta dintre total si suma liniilor). Job-ul de fiscalizare refuza bonul
   daca plata difera de acest total, deci plata trebuie sa fie egala cu el.
   Suma liniilor (SUM(SUMA) din TDB_JURNAL) ramine doar rezerva, cind totalul
   lipseste; la o comanda proaspat creata cele doua sint egale.                */
CREATE OR ALTER PROCEDURE WEB_MIA_VB_PAYMENT_CREATE (
    A_TOKEN   VARCHAR(64),
    A_DOCID   INTEGER,
    A_AMOUNT  DECIMAL(12,2),
    A_SOURCE  VARCHAR(20),
    A_BRAND   VARCHAR(32),
    A_EMAIL   VARCHAR(120),
    A_LANG    VARCHAR(2),
    A_USER_ID INTEGER)
RETURNS (
    PAYMENT_ID BIGINT,
    AMOUNT     DECIMAL(12,2),
    ERROR_CODE VARCHAR(20))
SQL SECURITY DEFINER
AS
DECLARE V_CURRENCYID INTEGER;
DECLARE V_DELETED TIMESTAMP;
DECLARE V_FOUND INTEGER;
DECLARE V_DOC_SUMA DECIMAL(15,2);
BEGIN
  PAYMENT_ID = NULL;
  AMOUNT     = NULL;
  ERROR_CODE = NULL;

  SELECT DOCID, CURRENCYID, DELETED_DATE, SUMA FROM TDB_DOCS
  WHERE DOCID = :A_DOCID
  INTO :V_FOUND, :V_CURRENCYID, :V_DELETED, :V_DOC_SUMA;

  IF (V_FOUND IS NULL OR V_DELETED IS NOT NULL) THEN
    ERROR_CODE = 'NO_DOC';
  ELSE IF (V_CURRENCYID IS DISTINCT FROM 498) THEN
    ERROR_CODE = 'NOT_MDL';
  ELSE IF (EXISTS (SELECT 1 FROM TWEB_MIA_VB_PAYMENT WHERE DOCID = :A_DOCID AND STATUS = 'Paid')) THEN
    ERROR_CODE = 'ALREADY_PAID';

  IF (ERROR_CODE IS NOT NULL) THEN
  BEGIN
    SUSPEND;
    EXIT;
  END

  AMOUNT = A_AMOUNT;
  IF (AMOUNT IS NULL AND COALESCE(V_DOC_SUMA, 0) > 0) THEN
    AMOUNT = CAST(V_DOC_SUMA AS DECIMAL(12,2));
  IF (AMOUNT IS NULL) THEN
    SELECT CAST(SUM(SUMA) AS DECIMAL(12,2)) FROM TDB_JURNAL WHERE DOCID = :A_DOCID INTO :AMOUNT;

  IF (COALESCE(AMOUNT, 0) <= 0) THEN
  BEGIN
    ERROR_CODE = 'NO_AMOUNT';
    SUSPEND;
    EXIT;
  END

  PAYMENT_ID = NEXT VALUE FOR SQ_TWEB_MIA_VB_PAYMENT_ID;
  INSERT INTO TWEB_MIA_VB_PAYMENT (PAYMENT_ID, TOKEN, DOCID, AMOUNT, SOURCE, BRAND, EMAIL, LANG, CREATED_BY)
  VALUES (:PAYMENT_ID, :A_TOKEN, :A_DOCID, :AMOUNT, COALESCE(:A_SOURCE, 'checkout'), :A_BRAND,
          NULLIF(TRIM(:A_EMAIL), ''), :A_LANG, :A_USER_ID);
  SUSPEND;
END^

/* --- 4. Confirmarea platii -------------------------------------------------
   Apelata cand banca arata codul QR platit. Sigura la apeluri repetate si
   simultane: randul cererii se blocheaza, iar un cod deja prelucrat iese cu
   ALREADY fara niciun efect.

   RESULT: PAID      - plata inregistrata acum; comanda marcata platita
           ALREADY   - acest cod QR a fost deja prelucrat
           DUPLICATE - cererea era deja platita prin alt cod QR: clientul a
                       platit de doua ori; de rambursat manual
           MISMATCH  - suma platita difera de cea ceruta
           NOT_FOUND - cod QR necunoscut
   WARNINGS: efectele secundare care nu au reusit (comentariu, analitica,
             Telegram). Nu anuleaza inregistrarea platii.                       */
CREATE OR ALTER PROCEDURE WEB_MIA_VB_CONFIRM (
    A_QR_HEADER_UUID VARCHAR(36),
    A_REFERENCE      VARCHAR(120),
    A_TX_ID          VARCHAR(64),
    A_AMOUNT         DECIMAL(12,2))
RETURNS (
    RESULT     VARCHAR(20),
    PAYMENT_ID BIGINT,
    DOCID      INTEGER,
    WARNINGS   VARCHAR(200))
SQL SECURITY DEFINER
AS
DECLARE V_QR_TX VARCHAR(64);
DECLARE V_AMOUNT DECIMAL(12,2);
DECLARE V_STATUS VARCHAR(20);
DECLARE V_DTSC INTEGER;
DECLARE V_DELETED TIMESTAMP;
BEGIN
  RESULT     = 'NOT_FOUND';
  PAYMENT_ID = NULL;
  DOCID      = NULL;
  WARNINGS   = '';

  SELECT PAYMENT_ID, TX_ID FROM TWEB_MIA_VB_QR
  WHERE QR_HEADER_UUID = :A_QR_HEADER_UUID
  INTO :PAYMENT_ID, :V_QR_TX;

  IF (PAYMENT_ID IS NULL) THEN
  BEGIN
    SUSPEND;
    EXIT;
  END

  SELECT DOCID, AMOUNT, STATUS FROM TWEB_MIA_VB_PAYMENT
  WHERE PAYMENT_ID = :PAYMENT_ID
  WITH LOCK
  INTO :DOCID, :V_AMOUNT, :V_STATUS;

  -- recitit dupa blocare: alta confirmare a aceluiasi cod a putut termina intre timp
  SELECT TX_ID FROM TWEB_MIA_VB_QR WHERE QR_HEADER_UUID = :A_QR_HEADER_UUID INTO :V_QR_TX;
  IF (V_QR_TX IS NOT NULL) THEN
  BEGIN
    RESULT = 'ALREADY';
    SUSPEND;
    EXIT;
  END

  UPDATE TWEB_MIA_VB_QR
  SET STATUS = 'Paid', TX_ID = COALESCE(NULLIF(TRIM(:A_TX_ID), ''), '-'), UPDATED_AT = CURRENT_TIMESTAMP
  WHERE QR_HEADER_UUID = :A_QR_HEADER_UUID;

  IF (V_STATUS IN ('Paid', 'Refunded')) THEN
  BEGIN
    RESULT = 'DUPLICATE';
    BEGIN
      EXECUTE PROCEDURE SP_TELEGRAM_SEND('ERRORS',
        'MIA Victoriabank: a doua plata pentru comanda ' || :DOCID || ' (' || :A_AMOUNT || ' lei, tranzactia '
        || COALESCE(:A_TX_ID, '?') || '). Cererea era deja platita - de rambursat manual.',
        NULL, -1, :DOCID, 1);
    WHEN ANY DO
      WARNINGS = WARNINGS || 'telegram;';
    END
    SUSPEND;
    EXIT;
  END

  IF (A_AMOUNT IS NULL OR ABS(A_AMOUNT - V_AMOUNT) > 0.005) THEN
  BEGIN
    RESULT = 'MISMATCH';
    UPDATE TWEB_MIA_VB_PAYMENT
    SET STATUS = 'Mismatch', PAY_REFERENCE = :A_REFERENCE, TX_ID = :A_TX_ID,
        PAID_AMOUNT = :A_AMOUNT, PAID_AT = CURRENT_TIMESTAMP, UPDATED_AT = CURRENT_TIMESTAMP
    WHERE PAYMENT_ID = :PAYMENT_ID;
    BEGIN
      EXECUTE PROCEDURE SP_TELEGRAM_SEND('ERRORS',
        'MIA Victoriabank: comanda ' || :DOCID || ' - banca a confirmat ' || COALESCE(:A_AMOUNT, 0)
        || ' lei, dar suma ceruta era ' || :V_AMOUNT || ' lei (tranzactia ' || COALESCE(:A_TX_ID, '?')
        || '). Comanda NU a fost marcata platita.',
        NULL, -1, :DOCID, 1);
    WHEN ANY DO
      WARNINGS = WARNINGS || 'telegram;';
    END
    SUSPEND;
    EXIT;
  END

  RESULT = 'PAID';
  UPDATE TWEB_MIA_VB_PAYMENT
  SET STATUS = 'Paid', PAY_REFERENCE = :A_REFERENCE, TX_ID = :A_TX_ID,
      PAID_AMOUNT = :A_AMOUNT, PAID_AT = CURRENT_TIMESTAMP, UPDATED_AT = CURRENT_TIMESTAMP
  WHERE PAYMENT_ID = :PAYMENT_ID;

  SELECT DELETED_DATE FROM TDB_DOCS WHERE DOCID = :DOCID INTO :V_DELETED;

  -- Ca in celelalte proceduri ale site-ului: autorul modificarilor e utilizatorul WEB SITE.
  RDB$SET_CONTEXT('USER_SESSION', 'UserID', 9);

  BEGIN
    EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'MIA QR',
      'Plata MIA (Victoriabank) confirmata: ' || :A_AMOUNT || ' MDL, tranzactia ' || COALESCE(:A_TX_ID, '?'));
  WHEN ANY DO
    WARNINGS = WARNINGS || 'comment;';
  END

  BEGIN
    SELECT O_DTSC FROM WEB_SET_DOC_PAYMENT_ANALYTIC(:DOCID, 'PAY_QR_MIA') INTO :V_DTSC;
  WHEN ANY DO
    WARNINGS = WARNINGS || 'analytic;';
  END

  BEGIN
    IF (V_DELETED IS NULL) THEN
      EXECUTE PROCEDURE SP_TELEGRAM_SEND('WEB_ORDERS',
        'Comanda ' || :DOCID || ': plata MIA (Victoriabank) de ' || :A_AMOUNT || ' lei a fost confirmata.',
        NULL, -1, :DOCID, 0);
    ELSE
      EXECUTE PROCEDURE SP_TELEGRAM_SEND('ERRORS',
        'MIA Victoriabank: plata de ' || :A_AMOUNT || ' lei pentru comanda ' || :DOCID
        || ', care este stearsa (tranzactia ' || COALESCE(:A_TX_ID, '?') || '). De verificat si rambursat.',
        NULL, -1, :DOCID, 1);
  WHEN ANY DO
    WARNINGS = WARNINGS || 'telegram;';
  END

  SUSPEND;
END^

/* --- 5. Platile MIA confirmate, din ambele banci ---------------------------
   REF = identificatorul codului QR platit (unic intre banci).                 */
CREATE OR ALTER VIEW VW_WEB_MIA_PAYMENTS (BANK, REF, AMOUNT, DOCID, PAID_AT, TX_ID)
AS
  SELECT CAST('MAIB' AS VARCHAR(8)), CAST(TRIM(Q.QRID) AS VARCHAR(36)), CAST(Q.AMOUNT AS DECIMAL(12,2)),
         Q.DOCID, Q.UPDATED_AT, CAST(TRIM(Q.PAY_ID) AS VARCHAR(64))
  FROM TWEB_MIA_QR_PAYMENTS Q
  WHERE Q.STATUS = 'Paid'
  UNION ALL
  SELECT CAST('VB' AS VARCHAR(8)), Q.QR_HEADER_UUID, P.PAID_AMOUNT, P.DOCID, P.PAID_AT, P.TX_ID
  FROM TWEB_MIA_VB_PAYMENT P
  JOIN TWEB_MIA_VB_QR Q ON Q.PAYMENT_ID = P.PAYMENT_ID AND Q.TX_ID = P.TX_ID
  WHERE P.STATUS = 'Paid'
^

/* --- 6. Metoda de plata a comenzii din cos: codul 5 = MIA QR ---------------
   Restul functiei e neschimbat (vezi deals_web_order_info.sql).               */
CREATE OR ALTER FUNCTION FN_DEAL_WEB_PAYMENT_METHOD (
    A_SOURCE VARCHAR(16),
    A_TYPE   INTEGER)
RETURNS VARCHAR(60)
AS
BEGIN
  IF (A_TYPE IS NULL) THEN RETURN NULL;
  IF (A_SOURCE = 'ONECLICK') THEN
    RETURN DECODE(A_TYPE, 0, 'La primire', 1, 'Credit', 2, 'MIA QR', 'Cod ' || A_TYPE);
  RETURN DECODE(A_TYPE, 0, 'Credit', 1, 'Numerar la livrare', 2, 'Card la livrare',
                        3, 'Card online', 4, 'Cont spre plata', 5, 'MIA QR', 'Cod ' || A_TYPE);
END^

/* --- 7. Proceduri pentru WMS -----------------------------------------------
   WMS nu vorbeste cu banca. Cere, prin aceste proceduri, iar site-ul executa:
   pagina de plata emite codul QR cind clientul deschide linkul, iar cronul
   site-ului (php yii mia-vb/reconcile) face rambursarile si anuleaza la banca
   codurile cererilor inchise.                                                  */

/* Linkul de plata al unei comenzi: cererea deschisa existenta sau una noua.
   Daca totalul comenzii s-a schimbat de la cererea veche, aceea se inchide si
   se face alta, pe suma noua.
   ERROR_CODE: ca la WEB_MIA_VB_PAYMENT_CREATE; NULL = TOKEN e bun.            */
CREATE OR ALTER PROCEDURE WEB_MIA_VB_CREATE_LINK (
    A_DOCID   INTEGER,
    A_BRAND   VARCHAR(32),
    A_USER_ID INTEGER)
RETURNS (
    PAYMENT_ID BIGINT,
    TOKEN      VARCHAR(64),
    AMOUNT     DECIMAL(12,2),
    ERROR_CODE VARCHAR(20))
SQL SECURITY DEFINER
AS
DECLARE V_DOC_SUMA DECIMAL(15,2);
BEGIN
  PAYMENT_ID = NULL;
  TOKEN      = NULL;
  AMOUNT     = NULL;
  ERROR_CODE = NULL;

  SELECT SUMA FROM TDB_DOCS WHERE DOCID = :A_DOCID INTO :V_DOC_SUMA;

  SELECT FIRST 1 PAYMENT_ID, TOKEN, AMOUNT FROM TWEB_MIA_VB_PAYMENT
  WHERE DOCID = :A_DOCID AND STATUS = 'New'
  ORDER BY PAYMENT_ID DESC
  INTO :PAYMENT_ID, :TOKEN, :AMOUNT;

  IF (PAYMENT_ID IS NOT NULL) THEN
  BEGIN
    IF (COALESCE(V_DOC_SUMA, 0) <= 0 OR ABS(AMOUNT - V_DOC_SUMA) <= 0.005) THEN
    BEGIN
      SUSPEND;
      EXIT;
    END
    -- suma comenzii s-a schimbat: linkul vechi nu mai e bun
    UPDATE TWEB_MIA_VB_PAYMENT SET STATUS = 'Cancelled', UPDATED_AT = CURRENT_TIMESTAMP
    WHERE DOCID = :A_DOCID AND STATUS = 'New';
  END

  -- 48 de cifre hexa, litere mici (asa le accepta site-ul)
  TOKEN = LOWER(REPLACE(UUID_TO_CHAR(GEN_UUID()), '-', ''))
       || SUBSTRING(LOWER(REPLACE(UUID_TO_CHAR(GEN_UUID()), '-', '')) FROM 1 FOR 16);

  SELECT PAYMENT_ID, AMOUNT, ERROR_CODE
  FROM WEB_MIA_VB_PAYMENT_CREATE(:TOKEN, :A_DOCID, NULL, 'operator',
       COALESCE(NULLIF(TRIM(:A_BRAND), ''), 'fantastic'), NULL, 'ro', :A_USER_ID)
  INTO :PAYMENT_ID, :AMOUNT, :ERROR_CODE;

  IF (ERROR_CODE IS NOT NULL) THEN
    TOKEN = NULL;
  SUSPEND;
END^

/* Cererea de rambursare integrala a unei plati confirmate. Rambursarea o face
   cronul site-ului, in cel mult citeva minute: Refunded sau RefundFailed.
   ERROR_CODE: NULL = cerere inregistrata; NOT_FOUND; BAD_STATUS = plata nu e
   confirmata (sau e deja rambursata / in curs).                                */
CREATE OR ALTER PROCEDURE WEB_MIA_VB_REQUEST_REFUND (
    A_PAYMENT_ID BIGINT,
    A_USER_ID    INTEGER)
RETURNS (ERROR_CODE VARCHAR(20))
SQL SECURITY DEFINER
AS
DECLARE V_STATUS VARCHAR(20);
DECLARE V_DOCID INTEGER;
DECLARE V_TX VARCHAR(64);
DECLARE V_PAID DECIMAL(12,2);
BEGIN
  ERROR_CODE = NULL;

  SELECT STATUS, DOCID, TX_ID, PAID_AMOUNT FROM TWEB_MIA_VB_PAYMENT
  WHERE PAYMENT_ID = :A_PAYMENT_ID
  WITH LOCK
  INTO :V_STATUS, :V_DOCID, :V_TX, :V_PAID;

  IF (V_STATUS IS NULL) THEN
    ERROR_CODE = 'NOT_FOUND';
  ELSE IF (V_STATUS NOT IN ('Paid', 'Mismatch', 'RefundFailed') OR V_TX IS NULL) THEN
    ERROR_CODE = 'BAD_STATUS';

  IF (ERROR_CODE IS NULL) THEN
  BEGIN
    UPDATE TWEB_MIA_VB_PAYMENT SET STATUS = 'RefundRequested', UPDATED_AT = CURRENT_TIMESTAMP
    WHERE PAYMENT_ID = :A_PAYMENT_ID;
    BEGIN
      EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:V_DOCID, 'MIA QR',
        'Rambursare ceruta: ' || COALESCE(:V_PAID, 0) || ' MDL (utilizator ' || COALESCE(:A_USER_ID, 0) || ').');
    WHEN ANY DO
      BEGIN
      END
    END
  END
  SUSPEND;
END^

/* SMS cu linkul de plata. Telefonul: cel dat sau cel din comanda web.
   ERROR_CODE: NULL = pus in coada SMS; NO_PHONE.                               */
CREATE OR ALTER PROCEDURE WEB_MIA_VB_LINK_SMS (
    A_DOCID INTEGER,
    A_TEXT  VARCHAR(280),
    A_PHONE VARCHAR(64))
RETURNS (
    PHONE      VARCHAR(64),
    ERROR_CODE VARCHAR(20))
SQL SECURITY DEFINER
AS
BEGIN
  ERROR_CODE = NULL;
  PHONE = NULLIF(TRIM(A_PHONE), '');
  IF (PHONE IS NULL) THEN
    SELECT FIRST 1 NULLIF(TRIM(PHONES), '') FROM TWEB_TRANSACTION WHERE DOCID = :A_DOCID INTO :PHONE;

  IF (PHONE IS NULL) THEN
    ERROR_CODE = 'NO_PHONE';
  ELSE
    INSERT INTO SMS_MESSAGES (PHONE, SMS_TEXT, SOURCE_TABLE) VALUES (:PHONE, :A_TEXT, 4);
  SUSPEND;
END^

SET TERM ; ^

COMMIT;

/* --- 8. Drepturi ------------------------------------------------------------ */
GRANT SELECT, INSERT, UPDATE ON TWEB_MIA_VB_PAYMENT TO WEBUSER;
GRANT SELECT, INSERT, UPDATE ON TWEB_MIA_VB_QR TO WEBUSER;
GRANT EXECUTE ON PROCEDURE WEB_MIA_VB_PAYMENT_CREATE TO WEBUSER;
GRANT EXECUTE ON PROCEDURE WEB_MIA_VB_CONFIRM TO WEBUSER;

GRANT SELECT, UPDATE ON TWEB_MIA_VB_PAYMENT TO SWN;
GRANT SELECT ON TWEB_MIA_VB_QR TO SWN;
GRANT SELECT ON VW_WEB_MIA_PAYMENTS TO SWN;
GRANT EXECUTE ON PROCEDURE WEB_MIA_VB_PAYMENT_CREATE TO SWN;
GRANT EXECUTE ON PROCEDURE WEB_MIA_VB_CREATE_LINK TO SWN;
GRANT EXECUTE ON PROCEDURE WEB_MIA_VB_REQUEST_REFUND TO SWN;
GRANT EXECUTE ON PROCEDURE WEB_MIA_VB_LINK_SMS TO SWN;
COMMIT;

/* --- 9. Verificare ---------------------------------------------------------- */
SELECT TRIM(RDB$RELATION_NAME) AS OBJ FROM RDB$RELATIONS
WHERE RDB$RELATION_NAME IN ('TWEB_MIA_VB_PAYMENT', 'TWEB_MIA_VB_QR', 'VW_WEB_MIA_PAYMENTS')
UNION ALL
SELECT TRIM(RDB$PROCEDURE_NAME) FROM RDB$PROCEDURES
WHERE RDB$PROCEDURE_NAME IN ('WEB_MIA_VB_PAYMENT_CREATE', 'WEB_MIA_VB_CONFIRM',
                             'WEB_MIA_VB_CREATE_LINK', 'WEB_MIA_VB_REQUEST_REFUND', 'WEB_MIA_VB_LINK_SMS')
ORDER BY 1;

SELECT FN_DEAL_WEB_PAYMENT_METHOD('CART', 5) AS COD_5 FROM RDB$DATABASE;
